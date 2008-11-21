Return-Path: <cyrus@holtmann.org>
Message-ID: <37367b3a0811210328i6820fbd6ufbb8a52f33b7dc70@mail.gmail.com>
Date: Fri, 21 Nov 2008 11:28:36 +0000
From: "Alan Carvalho de Assis" <acassis@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Unable to get on D-Bus
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I am tracing bluetoothd in order to find why it is not working. Please
see strace output at bottom.

First I started DBUS:

# dbus-daemon --system --print-address
unix:path=/var/run/dbus/system_bus_socket,guid=bd671c01bf0366c80869f10000014a47

Then tried to start bluetoothd:

# bluetoothd -nd
bluetoothd[1795]: Bluetooth daemon
bluetoothd[1795]: Enabling debug information
bluetoothd[1795]: parsing main.conf
bluetoothd[1795]: offmode=NoScan
bluetoothd[1795]: discovto=0
bluetoothd[1795]: pageto=8192
bluetoothd[1795]: name=%h-%d
bluetoothd[1795]: class=0x000100
bluetoothd[1795]: inqmode=0
bluetoothd[1795]: Unable to get on D-Bus

It appears strange, bluetoothd can't get D-BUS, strace showed it is
not trying to open /var/run/dbus/system_bus_socket!

I am going to test older bluez version.

Please, can you suggest to me some idea to fix this issue?

Best Regards,

Alan

# strace bluetoothd -nd
execve("/usr/sbin/bluetoothd", ["bluetoothd", "-nd"], [/* 12 vars */]) = 0
brk(0)                                  = 0x2a030000
uname({sys="Linux", node="freescale", ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x4001c000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=6365, ...}) = 0
mmap2(NULL, 6365, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001d000
close(3)                                = 0
open("/usr/lib/libglib-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0`\340\0\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=2072788, ...}) = 0
mmap2(NULL, 806572, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x40025000
mprotect(0x400e2000, 28672, PROT_NONE)  = 0
mmap2(0x400e9000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xbc) = 0x400e9000
close(3)                                = 0
open("/usr/lib/libdbus-1.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\10H\0\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=718147, ...}) = 0
mmap2(NULL, 252104, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x400ea000
mprotect(0x4011f000, 32768, PROT_NONE)  = 0
mmap2(0x40127000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x35) = 0x40127000
close(3)                                = 0
open("/usr/lib/libbluetooth.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\334@\0\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=93389, ...}) = 0
mmap2(NULL, 110372, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x40128000
mprotect(0x4013a000, 32768, PROT_NONE)  = 0
mmap2(0x40142000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12) = 0x40142000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0X\n\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=14085, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x4001f000
mmap2(NULL, 41116, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x40143000
mprotect(0x40145000, 28672, PROT_NONE)  = 0
mmap2(0x4014c000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0x4014c000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\10C\1\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1346605, ...}) = 0
mmap2(NULL, 1134988, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0x4014e000
mprotect(0x40257000, 28672, PROT_NONE)  = 0
mmap2(0x4025e000, 12288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x108) = 0x4025e000
mmap2(0x40261000, 8588, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40261000
close(3)                                = 0
open("/lib/libgcc_s.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\320!\0\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=58792, ...}) = 0
mmap2(NULL, 74872, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x40264000
mprotect(0x4026f000, 28672, PROT_NONE)  = 0
mmap2(0x40276000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa) = 0x40276000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x40020000
syscall_983045(0x400201e0, 0x400201e0, 0x40024058, 0x400208b8, 0x40,
0x40024058, 0, 0xf0005, 0x6fffff40, 0x2a000034, 0x40024000,
0xbed41b6c, 0, 0xbed41890, 0x4001473c, 0x40001ff0, 0x20000010,
0x400201e0, 0xc2a4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) = 0
mprotect(0x4025e000, 8192, PROT_READ)   = 0
mprotect(0x4014c000, 4096, PROT_READ)   = 0
mprotect(0x2a000000, 159744, PROT_READ|PROT_WRITE) = 0
mprotect(0x2a000000, 159744, PROT_READ|PROT_EXEC) = 0
mprotect(0x40023000, 4096, PROT_READ)   = 0
munmap(0x4001d000, 6365)                = 0
brk(0)                                  = 0x2a030000
brk(0x2a051000)                         = 0x2a051000
uname({sys="Linux", node="freescale", ...}) = 0
gettimeofday({84905, 186849}, NULL)     = 0
umask(077)                              = 022
mq_notify(1, ptrace: umoven: Input/output error
{...})                     = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
SYS_283(0x3, 0x40261a2c, 0x6e, 0x10, 0x1) = -1 ENOENT (No such file or
directory)
close(3)                                = 0
gettimeofday({84905, 188751}, NULL)     = 0
open("/etc/localtime", O_RDONLY)        = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x4001d000
read(3, "TZif2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0\0\0\2\0\0"...,
4096) = 177
close(3)                                = 0
munmap(0x4001d000, 4096)                = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
getpid()                                = 1791
writev(2, [{"bluetoothd[1791]: Bluetooth daem"..., 34}, {"\n", 1}],
2bluetoothd[1791]: Bluetooth daemon
) = 35
mq_notify(1, ptrace: umoven: Input/output error
{...})                     = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
SYS_283(0x3, 0x40261a2c, 0x6e, 0x10, 0x1) = -1 ENOENT (No such file or
directory)
close(3)                                = 0
rt_sigaction(SIGTERM, {0x2a0098a0, [], SA_NOCLDSTOP|0x4000000}, NULL, 8) = 0
rt_sigaction(SIGINT, {0x2a0098a0, [], SA_NOCLDSTOP|0x4000000}, NULL, 8) = 0
rt_sigaction(SIGUSR2, {0x2a00989c, [], SA_NOCLDSTOP|0x4000000}, NULL, 8) = 0
rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 8) = 0
gettimeofday({84905, 195535}, NULL)     = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
writev(2, [{"bluetoothd[1791]: Enabling debug"..., 44}, {"\n", 1}],
2bluetoothd[1791]: Enabling debug information
) = 45
mq_notify(1, ptrace: umoven: Input/output error
{...})                     = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
SYS_283(0x3, 0x40261a2c, 0x6e, 0x10, 0x1) = -1 ENOENT (No such file or
directory)
close(3)                                = 0
mq_notify(31, ptrace: umoven: Input/output error
{...})                    = 3
SYS_294(0x3, 0, 0x2, 0xbed41c9c, 0x10)  = 0
mq_getsetattr(3, {mq_flags=O_DIRECT|O_LARGEFILE|O_NOATIME|0xfff80020,
mq_maxmsg=0, mq_msgsize=704677448, mq_curmsg=0}, ptrace: umoven:
Input/output error
{...}) = 0
open("/usr/etc/bluetooth/main.conf", O_RDONLY|O_LARGEFILE) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=912, ...}) = 0
read(4, "[General]\n\n# List of plugins tha"..., 4096) = 912
read(4, "", 4096)                       = 0
close(4)                                = 0
gettimeofday({84905, 202773}, NULL)     = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
writev(2, [{"bluetoothd[1791]: parsing main.c"..., 35}, {"\n", 1}],
2bluetoothd[1791]: parsing main.conf
) = 36
mq_notify(1, ptrace: umoven: Input/output error
{...})                     = 4
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
SYS_283(0x4, 0x40261a2c, 0x6e, 0x10, 0x1) = -1 ENOENT (No such file or
directory)
close(4)                                = 0
gettimeofday({84905, 205567}, NULL)     = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
writev(2, [{"bluetoothd[1791]: offmode=NoScan", 32}, {"\n", 1}],
2bluetoothd[1791]: offmode=NoScan
) = 33
mq_notify(1, ptrace: umoven: Input/output error
{...})                     = 4
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
SYS_283(0x4, 0x40261a2c, 0x6e, 0x10, 0x1) = -1 ENOENT (No such file or
directory)
close(4)                                = 0
gettimeofday({84905, 208422}, NULL)     = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
writev(2, [{"bluetoothd[1791]: discovto=0", 28}, {"\n", 1}],
2bluetoothd[1791]: discovto=0
) = 29
mq_notify(1, ptrace: umoven: Input/output error
{...})                     = 4
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
SYS_283(0x4, 0x40261a2c, 0x6e, 0x10, 0x1) = -1 ENOENT (No such file or
directory)
close(4)                                = 0
gettimeofday({84905, 211018}, NULL)     = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
writev(2, [{"bluetoothd[1791]: pageto=8192", 29}, {"\n", 1}],
2bluetoothd[1791]: pageto=8192
) = 30
mq_notify(1, ptrace: umoven: Input/output error
{...})                     = 4
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
SYS_283(0x4, 0x40261a2c, 0x6e, 0x10, 0x1) = -1 ENOENT (No such file or
directory)
close(4)                                = 0
gettimeofday({84905, 213550}, NULL)     = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
writev(2, [{"bluetoothd[1791]: name=%h-%d", 28}, {"\n", 1}],
2bluetoothd[1791]: name=%h-%d
) = 29
mq_notify(1, ptrace: umoven: Input/output error
{...})                     = 4
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
SYS_283(0x4, 0x40261a2c, 0x6e, 0x10, 0x1) = -1 ENOENT (No such file or
directory)
close(4)                                = 0
gettimeofday({84905, 216100}, NULL)     = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
writev(2, [{"bluetoothd[1791]: class=0x000100", 32}, {"\n", 1}],
2bluetoothd[1791]: class=0x000100
) = 33
mq_notify(1, ptrace: umoven: Input/output error
{...})                     = 4
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
SYS_283(0x4, 0x40261a2c, 0x6e, 0x10, 0x1) = -1 ENOENT (No such file or
directory)
close(4)                                = 0
gettimeofday({84905, 218784}, NULL)     = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
writev(2, [{"bluetoothd[1791]: inqmode=0", 27}, {"\n", 1}],
2bluetoothd[1791]: inqmode=0
) = 28
mq_notify(1, ptrace: umoven: Input/output error
{...})                     = 4
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
SYS_283(0x4, 0x40261a2c, 0x6e, 0x10, 0x1) = -1 ENOENT (No such file or
directory)
close(4)                                = 0
pipe([4, 5])                            = 0
fstat64(4, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
fcntl64(4, F_GETFL)                     = 0 (flags O_RDONLY)
mq_notify(1, ptrace: umoven: Input/output error
{...})                     = 6
SYS_283(0x6, 0xbed41a2e, 0x21, 0, 0x1f) = 0
fcntl64(6, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(6, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
fcntl64(6, F_GETFD)                     = 0
fcntl64(6, F_SETFD, FD_CLOEXEC)         = 0
getuid32()                              = 0
rt_sigaction(SIGPIPE, {SIG_IGN}, {SIG_IGN}, 8) = 0
poll([{fd=6, events=POLLOUT, revents=POLLOUT}], 1, 0) = 1
write(6, "\0", 1)                       = 1
write(6, "AUTH EXTERNAL 30\r\n", 18)    = 18
poll([{fd=6, events=POLLIN, revents=POLLIN}], 1, -1) = 1
read(6, "OK bd671c01bf0366c80869f10000014"..., 2048) = 37
poll([{fd=6, events=POLLOUT, revents=POLLOUT}], 1, -1) = 1
write(6, "BEGIN\r\n", 7)                = 7
poll([{fd=6, events=POLLIN|POLLOUT, revents=POLLOUT}], 1, -1) = 1
writev(6, [{"l\1\0\1\0\0\0\0\1\0\0\0n\0\0\0\1\1o\0\25\0\0\0/org/fre"...,
128}, {"", 0}], 2) = 128
gettimeofday({84905, 233252}, NULL)     = 0
poll([{fd=6, events=POLLIN, revents=POLLIN}], 1, 25000) = 1
read(6, "l\2\1\1\t\0\0\0\1\0\0\0=\0\0\0\6\1s\0\4\0\0\0:1.1\0\0\0"...,
2048) = 258
read(6, 0x2a033bd0, 2048)               = -1 EAGAIN (Resource
temporarily unavailable)
writev(6, [{"l\1\0\1\24\0\0\0\2\0\0\0\200\0\0\0\1\1o\0\25\0\0\0/org"...,
144}, {"\t\0\0\0org.bluez\0\0\0\4\0\0\0", 20}], 2) = 164
gettimeofday({84905, 236746}, NULL)     = 0
poll([{fd=6, events=POLLIN, revents=POLLIN}], 1, 25000) = 1
read(6, "l\3\1\1w\0\0\0\3\0\0\0m\0\0\0\6\1s\0\4\0\0\0:1.1\0\0\0"..., 2048) = 247
read(6, 0x2a033bd0, 2048)               = -1 EAGAIN (Resource
temporarily unavailable)
gettimeofday({84905, 238176}, NULL)     = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=177, ...}) = 0
writev(2, [{"bluetoothd[1791]: Unable to get "..., 40}, {"\n", 1}],
2bluetoothd[1791]: Unable to get on D-Bus
) = 41
mq_notify(1, ptrace: umoven: Input/output error
{...})                     = 7
fcntl64(7, F_SETFD, FD_CLOEXEC)         = 0
SYS_283(0x7, 0x40261a2c, 0x6e, 0x10, 0x1) = -1 ENOENT (No such file or
directory)
close(7)                                = 0
io_submit(0x1, 0x1, 0xfbad2088 <unfinished ... exit status 1>
Process 1791 detached
