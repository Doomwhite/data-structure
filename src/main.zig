const std = @import("std");
const ArrayList = std.ArrayList;

pub fn main() !void {
    const a: [3]u8 = [_]u8{ 10, 20, 30 };
    std.log.info("a [3]u8", .{});
    std.log.info("{any}", .{a});
    std.log.info("{}", .{@TypeOf(a)});

    const b: *const [8]u8 = "10 20 30";
    std.log.info("b *const [8]u8", .{});
    std.log.info("{any}", .{b});
    std.log.info("{}", .{@TypeOf(b)});
    std.log.info("{}", .{@TypeOf(b.*)});

    const c: [*]const u8 = b;
    std.log.info("c [*]const u8", .{});
    std.log.info("{any}", .{c});
    std.log.info("{}", .{@TypeOf(c)});
    // src\main.zig:16:35: error: index syntax required for unknown-length pointer type '[*]const u8'
    // std.log.info("{}", .{@TypeOf(c.*)});

    const allocator = std.heap.page_allocator;
    const d = ArrayList(u8).init(allocator);
    std.log.info("d ArrayList(u8)", .{});
    std.log.info("{any}", .{d});
    std.log.info("{}", .{@TypeOf(d)});
    // src\main.zig:28:35: error: cannot dereference non-pointer type 'array_list.ArrayListAligned(u8,null)'
    // std.log.info("{}", .{@TypeOf(d.*)});

    const e: comptime_int = 1;
    std.log.info("e", .{});
    std.log.info("{any}", .{e});
    std.log.info("{}", .{@TypeOf(e)});
    // src\main.zig:35:35: error: cannot dereference non-pointer type 'comptime_int'
    // std.log.info("{}", .{@TypeOf(e.*)});
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
