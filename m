Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45CA5412.9070702@killesreiter.de>
Date: Wed, 07 Feb 2007 23:34:58 +0100
From: Gerhard Killesreiter <gerhard@killesreiter.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45C7C6DF.20106@killesreiter.de> <45C7FFD2.9080300@xmission.com>
	<45C83D70.9030900@killesreiter.de>
In-Reply-To: <45C83D70.9030900@killesreiter.de>
Content-Type: multipart/mixed; boundary="------------080501000708000709090506"
Subject: Re: [Bluez-users] headset /SCO / plugz
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080501000708000709090506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Gerhard Killesreiter wrote:
> Brad Midgley wrote:
>> Gerhard
>>
>>> 6) now what? a2dpd doesn't show up in my output choices in xmms, 
>>> "headset" shows up as a choice for the mixer device, but not the general 
>>> output device.
>> I have to type
>>  a2dpd
>>   or
>>  headset
>> freehand in the device choice in xmms. It's true it doesn't find it
>> automatically and we've tried to document that.
>>
> 
> Ok, tried that, but it still doesn't work.
> 
> Set to a2dpd and ran a2dpd:
> 
>   a2dpd
> A2DPD[392.542]: make_daemon_process: a2dpd [Feb  4 2007 12:12:52] 
> starting ...
> A2DPD[392.543]: init_uinput: (errno=2:No such file or directory)Cannot 
> open /dev/input/uinput


I got around this by doing:

modprobe uinput
chmod a+rw /dev/input/uinput

> A2DPD[392.543]: a2dpd_signal_init:
> A2DPD[392.545]: a2dpd_signal_init: (errno=2:No such file or 
> directory)Getting on DBUS

This still exists.

I've run this through strace and it seems that it looks for a file 
charset alias. But I am not sure how to interprete it, the strace output 
is attached.



> If I run aplay I get:
> 
> aplay -B 1000000 -D a2dpd 
> /usr/lib/openoffice/share/gallery/sounds/wallewal.wav
> ALSA lib pcm.c:2143:(snd_pcm_open_noupdate) Unknown PCM a2dpd
> aplay: main:550: audio open error: Datei oder Verzeichnis nicht gefunden

Which means "file not found".

Cheers,
	Gerhard

--------------080501000708000709090506
Content-Type: text/plain;
 name="outp.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="outp.txt"

execve("/usr/bin/a2dpd", ["a2dpd"], [/* 23 vars */]) = 0
uname({sys="Linux", node="theo-dhcp-42", ...}) = 0
brk(0)                                  = 0x805b000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f44000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/home/killes/.local/lib/tls/i686/sse2/cmov/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/killes/.local/lib/tls/i686/sse2/cmov", 0xbfa11358) = -1 ENOENT (No such file or directory)
open("/home/killes/.local/lib/tls/i686/sse2/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/killes/.local/lib/tls/i686/sse2", 0xbfa11358) = -1 ENOENT (No such file or directory)
open("/home/killes/.local/lib/tls/i686/cmov/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/killes/.local/lib/tls/i686/cmov", 0xbfa11358) = -1 ENOENT (No such file or directory)
open("/home/killes/.local/lib/tls/i686/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/killes/.local/lib/tls/i686", 0xbfa11358) = -1 ENOENT (No such file or directory)
open("/home/killes/.local/lib/tls/sse2/cmov/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/killes/.local/lib/tls/sse2/cmov", 0xbfa11358) = -1 ENOENT (No such file or directory)
open("/home/killes/.local/lib/tls/sse2/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/killes/.local/lib/tls/sse2", 0xbfa11358) = -1 ENOENT (No such file or directory)
open("/home/killes/.local/lib/tls/cmov/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/killes/.local/lib/tls/cmov", 0xbfa11358) = -1 ENOENT (No such file or directory)
open("/home/killes/.local/lib/tls/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/killes/.local/lib/tls", 0xbfa11358) = -1 ENOENT (No such file or directory)
open("/home/killes/.local/lib/i686/sse2/cmov/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/killes/.local/lib/i686/sse2/cmov", 0xbfa11358) = -1 ENOENT (No such file or directory)
open("/home/killes/.local/lib/i686/sse2/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/killes/.local/lib/i686/sse2", 0xbfa11358) = -1 ENOENT (No such file or directory)
open("/home/killes/.local/lib/i686/cmov/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/killes/.local/lib/i686/cmov", 0xbfa11358) = -1 ENOENT (No such file or directory)
open("/home/killes/.local/lib/i686/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/killes/.local/lib/i686", 0xbfa11358) = -1 ENOENT (No such file or directory)
open("/home/killes/.local/lib/sse2/cmov/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/killes/.local/lib/sse2/cmov", 0xbfa11358) = -1 ENOENT (No such file or directory)
open("/home/killes/.local/lib/sse2/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/killes/.local/lib/sse2", 0xbfa11358) = -1 ENOENT (No such file or directory)
open("/home/killes/.local/lib/cmov/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/killes/.local/lib/cmov", 0xbfa11358) = -1 ENOENT (No such file or directory)
open("/home/killes/.local/lib/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/killes/.local/lib", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=109366, ...}) = 0
mmap2(NULL, 109366, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f29000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libgthread-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \21\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=14028, ...}) = 0
mmap2(NULL, 12892, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7f25000
mmap2(0xb7f28000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3) = 0xb7f28000
close(3)                                = 0
open("/home/killes/.local/lib/libgobject-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libgobject-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300i\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=237156, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f24000
mmap2(NULL, 237380, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7eea000
mmap2(0xb7f23000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x39) = 0xb7f23000
close(3)                                = 0
open("/home/killes/.local/lib/libdbus-glib-1.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libdbus-glib-1.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0j\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=106760, ...}) = 0
mmap2(NULL, 109888, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7ecf000
mmap2(0xb7ee9000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x19) = 0xb7ee9000
close(3)                                = 0
open("/home/killes/.local/lib/libdbus-1.so.3", O_RDONLY) = -1 ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libdbus-1.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220K\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=203740, ...}) = 0
mmap2(NULL, 203036, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7e9d000
mmap2(0xb7ece000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x31) = 0xb7ece000
close(3)                                = 0
open("/home/killes/.local/lib/libglib-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libglib-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\322\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=596608, ...}) = 0
mmap2(NULL, 596204, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7e0b000
mmap2(0xb7e9c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x91) = 0xb7e9c000
close(3)                                = 0
open("/home/killes/.local/lib/libasound.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\371\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=784036, ...}) = 0
mmap2(NULL, 787060, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7d4a000
mmap2(0xb7e06000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xbb) = 0xb7e06000
close(3)                                = 0
open("/home/killes/.local/lib/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libm.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`3\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=145136, ...}) = 0
mmap2(NULL, 147584, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7d25000
mmap2(0xb7d48000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22) = 0xb7d48000
close(3)                                = 0
open("/home/killes/.local/lib/libdl.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libdl.so.2", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\f\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=9592, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7d24000
mmap2(NULL, 12404, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7d20000
mmap2(0xb7d22000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb7d22000
close(3)                                = 0
open("/home/killes/.local/lib/liba2dpdcommon.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/liba2dpdcommon.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P\26\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=23090, ...}) = 0
mmap2(NULL, 19988, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7d1b000
mmap2(0xb7d1f000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3) = 0xb7d1f000
close(3)                                = 0
open("/home/killes/.local/lib/libsbc.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libsbc.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\5\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=21519, ...}) = 0
mmap2(NULL, 21116, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7d15000
mmap2(0xb7d1a000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4) = 0xb7d1a000
close(3)                                = 0
open("/home/killes/.local/lib/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360G\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=85010, ...}) = 0
mmap2(NULL, 70104, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7d03000
mmap2(0xb7d11000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd) = 0xb7d11000
mmap2(0xb7d13000, 4568, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7d13000
close(3)                                = 0
open("/home/killes/.local/lib/librt.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/librt.so.1", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\35\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=26516, ...}) = 0
mmap2(NULL, 29264, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7cfb000
mmap2(0xb7d01000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x5) = 0xb7d01000
close(3)                                = 0
open("/home/killes/.local/lib/libbluetooth.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libbluetooth.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360=\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=70360, ...}) = 0
mmap2(NULL, 69280, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7cea000
mmap2(0xb7cfa000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x10) = 0xb7cfa000
close(3)                                = 0
open("/home/killes/.local/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240O\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=1241580, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7ce9000
mmap2(NULL, 1251484, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7bb7000
mmap2(0xb7cdf000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x127) = 0xb7cdf000
mmap2(0xb7ce6000, 10396, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7ce6000
close(3)                                = 0
open("/home/killes/.local/lib/libnsl.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libnsl.so.1", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p5\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=76548, ...}) = 0
mmap2(NULL, 87808, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7ba1000
mmap2(0xb7bb3000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11) = 0xb7bb3000
mmap2(0xb7bb5000, 5888, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7bb5000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7ba0000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7b9f000
mprotect(0xb7cdf000, 20480, PROT_READ)  = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7b9f6c0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb7f29000, 109366)              = 0
set_tid_address(0xb7b9f708)             = 29773
rt_sigaction(SIGRTMIN, {0xb7d07450, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0xb7d073c0, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
uname({sys="Linux", node="theo-dhcp-42", ...}) = 0
sched_get_priority_max(SCHED_FIFO)      = 99
brk(0)                                  = 0x805b000
brk(0x807c000)                          = 0x807c000
open("/home/killes/.a2dprc", O_RDONLY)  = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
read(3, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
close(3)                                = 0
munmap(0xb7f43000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
read(3, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
close(3)                                = 0
munmap(0xb7f43000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
read(3, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
close(3)                                = 0
munmap(0xb7f43000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
read(3, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
close(3)                                = 0
munmap(0xb7f43000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
read(3, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
close(3)                                = 0
munmap(0xb7f43000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
read(3, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
close(3)                                = 0
munmap(0xb7f43000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
read(3, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
close(3)                                = 0
munmap(0xb7f43000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
read(3, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f43000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
read(3, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
close(3)                                = 0
munmap(0xb7f43000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
read(3, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
close(3)                                = 0
munmap(0xb7f43000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
read(3, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
close(3)                                = 0
munmap(0xb7f43000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
read(3, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
close(3)                                = 0
munmap(0xb7f43000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
read(3, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
close(3)                                = 0
munmap(0xb7f43000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
read(3, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f43000, 4096)                = 0
clock_getres(CLOCK_REALTIME, {0, 4000250}) = 0
rt_sigaction(SIGCHLD, {SIG_IGN}, NULL, 8) = 0
gettimeofday({1170887207, 676371}, NULL) = 0
fstat64(1, {st_mode=S_IFREG|0644, st_size=19341, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
write(1, "A2DPD[207.676]: make_daemon_proc"..., 79A2DPD[207.676]: make_daemon_process: a2dpd [Feb  4 2007 12:12:52] starting ...
) = 79
open("/tmp/a2dp.pid", O_RDWR|O_CREAT|O_EXCL, 0644) = -1 EEXIST (File exists)
open("/tmp/a2dp.pid", O_RDWR)           = 3
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fstat64(3, {st_mode=S_IFREG|0644, st_size=6, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f42000
_llseek(3, 0, [0], SEEK_CUR)            = 0
read(3, "29749\n", 4096)                = 6
fcntl64(3, F_SETLK, {type=F_WRLCK, whence=SEEK_SET, start=0, len=0}) = 0
unlink("/tmp/a2dp.pid")                 = 0
close(3)                                = 0
munmap(0xb7f42000, 4096)                = 0
unlink("/tmp/a2dp.pid")                 = -1 ENOENT (No such file or directory)
open("/tmp/a2dp.pid", O_RDWR|O_CREAT|O_EXCL, 0644) = 3
fcntl64(3, F_SETLK, {type=F_WRLCK, whence=SEEK_SET, start=0, len=0}) = 0
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f42000
_llseek(3, 0, [0], SEEK_CUR)            = 0
write(3, "29773\n", 6)                  = 6
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
open("/dev/input/uinput", O_WRONLY)     = 4
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1116) = 1116
ioctl(4, UI_SET_EVBIT, 0x1)             = 0
ioctl(4, UI_SET_KEYBIT, 0)              = 0
ioctl(4, UI_SET_KEYBIT, 0x1)            = 0
ioctl(4, UI_SET_KEYBIT, 0x2)            = 0
ioctl(4, UI_SET_KEYBIT, 0x3)            = 0
ioctl(4, UI_SET_KEYBIT, 0x4)            = 0
ioctl(4, UI_SET_KEYBIT, 0x5)            = 0
ioctl(4, UI_SET_KEYBIT, 0x6)            = 0
ioctl(4, UI_SET_KEYBIT, 0x7)            = 0
ioctl(4, UI_SET_KEYBIT, 0x8)            = 0
ioctl(4, UI_SET_KEYBIT, 0x9)            = 0
ioctl(4, UI_SET_KEYBIT, 0xa)            = 0
ioctl(4, UI_SET_KEYBIT, 0xb)            = 0
ioctl(4, UI_SET_KEYBIT, 0xc)            = 0
ioctl(4, UI_SET_KEYBIT, 0xd)            = 0
ioctl(4, UI_SET_KEYBIT, 0xe)            = 0
ioctl(4, UI_SET_KEYBIT, 0xf)            = 0
ioctl(4, UI_SET_KEYBIT, 0x10)           = 0
ioctl(4, UI_SET_KEYBIT, 0x11)           = 0
ioctl(4, UI_SET_KEYBIT, 0x12)           = 0
ioctl(4, UI_SET_KEYBIT, 0x13)           = 0
ioctl(4, UI_SET_KEYBIT, 0x14)           = 0
ioctl(4, UI_SET_KEYBIT, 0x15)           = 0
ioctl(4, UI_SET_KEYBIT, 0x16)           = 0
ioctl(4, UI_SET_KEYBIT, 0x17)           = 0
ioctl(4, UI_SET_KEYBIT, 0x18)           = 0
ioctl(4, UI_SET_KEYBIT, 0x19)           = 0
ioctl(4, UI_SET_KEYBIT, 0x1a)           = 0
ioctl(4, UI_SET_KEYBIT, 0x1b)           = 0
ioctl(4, UI_SET_KEYBIT, 0x1c)           = 0
ioctl(4, UI_SET_KEYBIT, 0x1d)           = 0
ioctl(4, UI_SET_KEYBIT, 0x1e)           = 0
ioctl(4, UI_SET_KEYBIT, 0x1f)           = 0
ioctl(4, UI_SET_KEYBIT, 0x20)           = 0
ioctl(4, UI_SET_KEYBIT, 0x21)           = 0
ioctl(4, UI_SET_KEYBIT, 0x22)           = 0
ioctl(4, UI_SET_KEYBIT, 0x23)           = 0
ioctl(4, UI_SET_KEYBIT, 0x24)           = 0
ioctl(4, UI_SET_KEYBIT, 0x25)           = 0
ioctl(4, UI_SET_KEYBIT, 0x26)           = 0
ioctl(4, UI_SET_KEYBIT, 0x27)           = 0
ioctl(4, UI_SET_KEYBIT, 0x28)           = 0
ioctl(4, UI_SET_KEYBIT, 0x29)           = 0
ioctl(4, UI_SET_KEYBIT, 0x2a)           = 0
ioctl(4, UI_SET_KEYBIT, 0x2b)           = 0
ioctl(4, UI_SET_KEYBIT, 0x2c)           = 0
ioctl(4, UI_SET_KEYBIT, 0x2d)           = 0
ioctl(4, UI_SET_KEYBIT, 0x2e)           = 0
ioctl(4, UI_SET_KEYBIT, 0x2f)           = 0
ioctl(4, UI_SET_KEYBIT, 0x30)           = 0
ioctl(4, UI_SET_KEYBIT, 0x31)           = 0
ioctl(4, UI_SET_KEYBIT, 0x32)           = 0
ioctl(4, UI_SET_KEYBIT, 0x33)           = 0
ioctl(4, UI_SET_KEYBIT, 0x34)           = 0
ioctl(4, UI_SET_KEYBIT, 0x35)           = 0
ioctl(4, UI_SET_KEYBIT, 0x36)           = 0
ioctl(4, UI_SET_KEYBIT, 0x37)           = 0
ioctl(4, UI_SET_KEYBIT, 0x38)           = 0
ioctl(4, UI_SET_KEYBIT, 0x39)           = 0
ioctl(4, UI_SET_KEYBIT, 0x3a)           = 0
ioctl(4, UI_SET_KEYBIT, 0x3b)           = 0
ioctl(4, UI_SET_KEYBIT, 0x3c)           = 0
ioctl(4, UI_SET_KEYBIT, 0x3d)           = 0
ioctl(4, UI_SET_KEYBIT, 0x3e)           = 0
ioctl(4, UI_SET_KEYBIT, 0x3f)           = 0
ioctl(4, UI_SET_KEYBIT, 0x40)           = 0
ioctl(4, UI_SET_KEYBIT, 0x41)           = 0
ioctl(4, UI_SET_KEYBIT, 0x42)           = 0
ioctl(4, UI_SET_KEYBIT, 0x43)           = 0
ioctl(4, UI_SET_KEYBIT, 0x44)           = 0
ioctl(4, UI_SET_KEYBIT, 0x45)           = 0
ioctl(4, UI_SET_KEYBIT, 0x46)           = 0
ioctl(4, UI_SET_KEYBIT, 0x47)           = 0
ioctl(4, UI_SET_KEYBIT, 0x48)           = 0
ioctl(4, UI_SET_KEYBIT, 0x49)           = 0
ioctl(4, UI_SET_KEYBIT, 0x4a)           = 0
ioctl(4, UI_SET_KEYBIT, 0x4b)           = 0
ioctl(4, UI_SET_KEYBIT, 0x4c)           = 0
ioctl(4, UI_SET_KEYBIT, 0x4d)           = 0
ioctl(4, UI_SET_KEYBIT, 0x4e)           = 0
ioctl(4, UI_SET_KEYBIT, 0x4f)           = 0
ioctl(4, UI_SET_KEYBIT, 0x50)           = 0
ioctl(4, UI_SET_KEYBIT, 0x51)           = 0
ioctl(4, UI_SET_KEYBIT, 0x52)           = 0
ioctl(4, UI_SET_KEYBIT, 0x53)           = 0
ioctl(4, UI_SET_KEYBIT, 0x54)           = 0
ioctl(4, UI_SET_KEYBIT, 0x55)           = 0
ioctl(4, UI_SET_KEYBIT, 0x56)           = 0
ioctl(4, UI_SET_KEYBIT, 0x57)           = 0
ioctl(4, UI_SET_KEYBIT, 0x58)           = 0
ioctl(4, UI_SET_KEYBIT, 0x59)           = 0
ioctl(4, UI_SET_KEYBIT, 0x5a)           = 0
ioctl(4, UI_SET_KEYBIT, 0x5b)           = 0
ioctl(4, UI_SET_KEYBIT, 0x5c)           = 0
ioctl(4, UI_SET_KEYBIT, 0x5d)           = 0
ioctl(4, UI_SET_KEYBIT, 0x5e)           = 0
ioctl(4, UI_SET_KEYBIT, 0x5f)           = 0
ioctl(4, UI_SET_KEYBIT, 0x60)           = 0
ioctl(4, UI_SET_KEYBIT, 0x61)           = 0
ioctl(4, UI_SET_KEYBIT, 0x62)           = 0
ioctl(4, UI_SET_KEYBIT, 0x63)           = 0
ioctl(4, UI_SET_KEYBIT, 0x64)           = 0
ioctl(4, UI_SET_KEYBIT, 0x65)           = 0
ioctl(4, UI_SET_KEYBIT, 0x66)           = 0
ioctl(4, UI_SET_KEYBIT, 0x67)           = 0
ioctl(4, UI_SET_KEYBIT, 0x68)           = 0
ioctl(4, UI_SET_KEYBIT, 0x69)           = 0
ioctl(4, UI_SET_KEYBIT, 0x6a)           = 0
ioctl(4, UI_SET_KEYBIT, 0x6b)           = 0
ioctl(4, UI_SET_KEYBIT, 0x6c)           = 0
ioctl(4, UI_SET_KEYBIT, 0x6d)           = 0
ioctl(4, UI_SET_KEYBIT, 0x6e)           = 0
ioctl(4, UI_SET_KEYBIT, 0x6f)           = 0
ioctl(4, UI_SET_KEYBIT, 0x70)           = 0
ioctl(4, UI_SET_KEYBIT, 0x71)           = 0
ioctl(4, UI_SET_KEYBIT, 0x72)           = 0
ioctl(4, UI_SET_KEYBIT, 0x73)           = 0
ioctl(4, UI_SET_KEYBIT, 0x74)           = 0
ioctl(4, UI_SET_KEYBIT, 0x75)           = 0
ioctl(4, UI_SET_KEYBIT, 0x76)           = 0
ioctl(4, UI_SET_KEYBIT, 0x77)           = 0
ioctl(4, UI_SET_KEYBIT, 0x78)           = 0
ioctl(4, UI_SET_KEYBIT, 0x79)           = 0
ioctl(4, UI_SET_KEYBIT, 0x7a)           = 0
ioctl(4, UI_SET_KEYBIT, 0x7b)           = 0
ioctl(4, UI_SET_KEYBIT, 0x7c)           = 0
ioctl(4, UI_SET_KEYBIT, 0x7d)           = 0
ioctl(4, UI_SET_KEYBIT, 0x7e)           = 0
ioctl(4, UI_SET_KEYBIT, 0x7f)           = 0
ioctl(4, UI_SET_KEYBIT, 0x80)           = 0
ioctl(4, UI_SET_KEYBIT, 0x81)           = 0
ioctl(4, UI_SET_KEYBIT, 0x82)           = 0
ioctl(4, UI_SET_KEYBIT, 0x83)           = 0
ioctl(4, UI_SET_KEYBIT, 0x84)           = 0
ioctl(4, UI_SET_KEYBIT, 0x85)           = 0
ioctl(4, UI_SET_KEYBIT, 0x86)           = 0
ioctl(4, UI_SET_KEYBIT, 0x87)           = 0
ioctl(4, UI_SET_KEYBIT, 0x88)           = 0
ioctl(4, UI_SET_KEYBIT, 0x89)           = 0
ioctl(4, UI_SET_KEYBIT, 0x8a)           = 0
ioctl(4, UI_SET_KEYBIT, 0x8b)           = 0
ioctl(4, UI_SET_KEYBIT, 0x8c)           = 0
ioctl(4, UI_SET_KEYBIT, 0x8d)           = 0
ioctl(4, UI_SET_KEYBIT, 0x8e)           = 0
ioctl(4, UI_SET_KEYBIT, 0x8f)           = 0
ioctl(4, UI_SET_KEYBIT, 0x90)           = 0
ioctl(4, UI_SET_KEYBIT, 0x91)           = 0
ioctl(4, UI_SET_KEYBIT, 0x92)           = 0
ioctl(4, UI_SET_KEYBIT, 0x93)           = 0
ioctl(4, UI_SET_KEYBIT, 0x94)           = 0
ioctl(4, UI_SET_KEYBIT, 0x95)           = 0
ioctl(4, UI_SET_KEYBIT, 0x96)           = 0
ioctl(4, UI_SET_KEYBIT, 0x97)           = 0
ioctl(4, UI_SET_KEYBIT, 0x98)           = 0
ioctl(4, UI_SET_KEYBIT, 0x99)           = 0
ioctl(4, UI_SET_KEYBIT, 0x9a)           = 0
ioctl(4, UI_SET_KEYBIT, 0x9b)           = 0
ioctl(4, UI_SET_KEYBIT, 0x9c)           = 0
ioctl(4, UI_SET_KEYBIT, 0x9d)           = 0
ioctl(4, UI_SET_KEYBIT, 0x9e)           = 0
ioctl(4, UI_SET_KEYBIT, 0x9f)           = 0
ioctl(4, UI_SET_KEYBIT, 0xa0)           = 0
ioctl(4, UI_SET_KEYBIT, 0xa1)           = 0
ioctl(4, UI_SET_KEYBIT, 0xa2)           = 0
ioctl(4, UI_SET_KEYBIT, 0xa3)           = 0
ioctl(4, UI_SET_KEYBIT, 0xa4)           = 0
ioctl(4, UI_SET_KEYBIT, 0xa5)           = 0
ioctl(4, UI_SET_KEYBIT, 0xa6)           = 0
ioctl(4, UI_SET_KEYBIT, 0xa7)           = 0
ioctl(4, UI_SET_KEYBIT, 0xa8)           = 0
ioctl(4, UI_SET_KEYBIT, 0xa9)           = 0
ioctl(4, UI_SET_KEYBIT, 0xaa)           = 0
ioctl(4, UI_SET_KEYBIT, 0xab)           = 0
ioctl(4, UI_SET_KEYBIT, 0xac)           = 0
ioctl(4, UI_SET_KEYBIT, 0xad)           = 0
ioctl(4, UI_SET_KEYBIT, 0xae)           = 0
ioctl(4, UI_SET_KEYBIT, 0xaf)           = 0
ioctl(4, UI_SET_KEYBIT, 0xb0)           = 0
ioctl(4, UI_SET_KEYBIT, 0xb1)           = 0
ioctl(4, UI_SET_KEYBIT, 0xb2)           = 0
ioctl(4, UI_SET_KEYBIT, 0xb3)           = 0
ioctl(4, UI_SET_KEYBIT, 0xb4)           = 0
ioctl(4, UI_SET_KEYBIT, 0xb5)           = 0
ioctl(4, UI_SET_KEYBIT, 0xb6)           = 0
ioctl(4, UI_SET_KEYBIT, 0xb7)           = 0
ioctl(4, UI_SET_KEYBIT, 0xb8)           = 0
ioctl(4, UI_SET_KEYBIT, 0xb9)           = 0
ioctl(4, UI_SET_KEYBIT, 0xba)           = 0
ioctl(4, UI_SET_KEYBIT, 0xbb)           = 0
ioctl(4, UI_SET_KEYBIT, 0xbc)           = 0
ioctl(4, UI_SET_KEYBIT, 0xbd)           = 0
ioctl(4, UI_SET_KEYBIT, 0xbe)           = 0
ioctl(4, UI_SET_KEYBIT, 0xbf)           = 0
ioctl(4, UI_SET_KEYBIT, 0xc0)           = 0
ioctl(4, UI_SET_KEYBIT, 0xc1)           = 0
ioctl(4, UI_SET_KEYBIT, 0xc2)           = 0
ioctl(4, UI_SET_KEYBIT, 0xc3)           = 0
ioctl(4, UI_SET_KEYBIT, 0xc4)           = 0
ioctl(4, UI_SET_KEYBIT, 0xc5)           = 0
ioctl(4, UI_SET_KEYBIT, 0xc6)           = 0
ioctl(4, UI_SET_KEYBIT, 0xc7)           = 0
ioctl(4, UI_SET_KEYBIT, 0xc8)           = 0
ioctl(4, UI_SET_KEYBIT, 0xc9)           = 0
ioctl(4, UI_SET_KEYBIT, 0xca)           = 0
ioctl(4, UI_SET_KEYBIT, 0xcb)           = 0
ioctl(4, UI_SET_KEYBIT, 0xcc)           = 0
ioctl(4, UI_SET_KEYBIT, 0xcd)           = 0
ioctl(4, UI_SET_KEYBIT, 0xce)           = 0
ioctl(4, UI_SET_KEYBIT, 0xcf)           = 0
ioctl(4, UI_SET_KEYBIT, 0xd0)           = 0
ioctl(4, UI_SET_KEYBIT, 0xd1)           = 0
ioctl(4, UI_SET_KEYBIT, 0xd2)           = 0
ioctl(4, UI_SET_KEYBIT, 0xd3)           = 0
ioctl(4, UI_SET_KEYBIT, 0xd4)           = 0
ioctl(4, UI_SET_KEYBIT, 0xd5)           = 0
ioctl(4, UI_SET_KEYBIT, 0xd6)           = 0
ioctl(4, UI_SET_KEYBIT, 0xd7)           = 0
ioctl(4, UI_SET_KEYBIT, 0xd8)           = 0
ioctl(4, UI_SET_KEYBIT, 0xd9)           = 0
ioctl(4, UI_SET_KEYBIT, 0xda)           = 0
ioctl(4, UI_SET_KEYBIT, 0xdb)           = 0
ioctl(4, UI_SET_KEYBIT, 0xdc)           = 0
ioctl(4, UI_SET_KEYBIT, 0xdd)           = 0
ioctl(4, UI_SET_KEYBIT, 0xde)           = 0
ioctl(4, UI_SET_KEYBIT, 0xdf)           = 0
ioctl(4, UI_SET_KEYBIT, 0xe0)           = 0
ioctl(4, UI_SET_KEYBIT, 0xe1)           = 0
ioctl(4, UI_SET_KEYBIT, 0xe2)           = 0
ioctl(4, UI_SET_KEYBIT, 0xe3)           = 0
ioctl(4, UI_SET_KEYBIT, 0xe4)           = 0
ioctl(4, UI_SET_KEYBIT, 0xe5)           = 0
ioctl(4, UI_SET_KEYBIT, 0xe6)           = 0
ioctl(4, UI_SET_KEYBIT, 0xe7)           = 0
ioctl(4, UI_SET_KEYBIT, 0xe8)           = 0
ioctl(4, UI_SET_KEYBIT, 0xe9)           = 0
ioctl(4, UI_SET_KEYBIT, 0xea)           = 0
ioctl(4, UI_SET_KEYBIT, 0xeb)           = 0
ioctl(4, UI_SET_KEYBIT, 0xec)           = 0
ioctl(4, UI_SET_KEYBIT, 0xed)           = 0
ioctl(4, UI_SET_KEYBIT, 0xee)           = 0
ioctl(4, UI_SET_KEYBIT, 0xef)           = 0
ioctl(4, UI_SET_KEYBIT, 0xf0)           = 0
ioctl(4, UI_SET_KEYBIT, 0xf1)           = 0
ioctl(4, UI_SET_KEYBIT, 0xf2)           = 0
ioctl(4, UI_SET_KEYBIT, 0xf3)           = 0
ioctl(4, UI_SET_KEYBIT, 0xf4)           = 0
ioctl(4, UI_SET_KEYBIT, 0xf5)           = 0
ioctl(4, UI_SET_KEYBIT, 0xf6)           = 0
ioctl(4, UI_SET_KEYBIT, 0xf7)           = 0
ioctl(4, UI_SET_KEYBIT, 0xf8)           = 0
ioctl(4, UI_SET_KEYBIT, 0xf9)           = 0
ioctl(4, UI_SET_KEYBIT, 0xfa)           = 0
ioctl(4, UI_SET_KEYBIT, 0xfb)           = 0
ioctl(4, UI_SET_KEYBIT, 0xfc)           = 0
ioctl(4, UI_SET_KEYBIT, 0xfd)           = 0
ioctl(4, UI_SET_KEYBIT, 0xfe)           = 0
ioctl(4, UI_SET_KEYBIT, 0xff)           = 0
ioctl(4, UI_SET_KEYBIT, 0x100)          = 0
ioctl(4, UI_SET_KEYBIT, 0x101)          = 0
ioctl(4, UI_SET_KEYBIT, 0x102)          = 0
ioctl(4, UI_SET_KEYBIT, 0x103)          = 0
ioctl(4, UI_SET_KEYBIT, 0x104)          = 0
ioctl(4, UI_SET_KEYBIT, 0x105)          = 0
ioctl(4, UI_SET_KEYBIT, 0x106)          = 0
ioctl(4, UI_SET_KEYBIT, 0x107)          = 0
ioctl(4, UI_SET_KEYBIT, 0x108)          = 0
ioctl(4, UI_SET_KEYBIT, 0x109)          = 0
ioctl(4, UI_SET_KEYBIT, 0x10a)          = 0
ioctl(4, UI_SET_KEYBIT, 0x10b)          = 0
ioctl(4, UI_SET_KEYBIT, 0x10c)          = 0
ioctl(4, UI_SET_KEYBIT, 0x10d)          = 0
ioctl(4, UI_SET_KEYBIT, 0x10e)          = 0
ioctl(4, UI_SET_KEYBIT, 0x10f)          = 0
ioctl(4, UI_SET_KEYBIT, 0x110)          = 0
ioctl(4, UI_SET_KEYBIT, 0x111)          = 0
ioctl(4, UI_SET_KEYBIT, 0x112)          = 0
ioctl(4, UI_SET_KEYBIT, 0x113)          = 0
ioctl(4, UI_SET_KEYBIT, 0x114)          = 0
ioctl(4, UI_SET_KEYBIT, 0x115)          = 0
ioctl(4, UI_SET_KEYBIT, 0x116)          = 0
ioctl(4, UI_SET_KEYBIT, 0x117)          = 0
ioctl(4, UI_SET_KEYBIT, 0x118)          = 0
ioctl(4, UI_SET_KEYBIT, 0x119)          = 0
ioctl(4, UI_SET_KEYBIT, 0x11a)          = 0
ioctl(4, UI_SET_KEYBIT, 0x11b)          = 0
ioctl(4, UI_SET_KEYBIT, 0x11c)          = 0
ioctl(4, UI_SET_KEYBIT, 0x11d)          = 0
ioctl(4, UI_SET_KEYBIT, 0x11e)          = 0
ioctl(4, UI_SET_KEYBIT, 0x11f)          = 0
ioctl(4, UI_SET_KEYBIT, 0x120)          = 0
ioctl(4, UI_SET_KEYBIT, 0x121)          = 0
ioctl(4, UI_SET_KEYBIT, 0x122)          = 0
ioctl(4, UI_SET_KEYBIT, 0x123)          = 0
ioctl(4, UI_SET_KEYBIT, 0x124)          = 0
ioctl(4, UI_SET_KEYBIT, 0x125)          = 0
ioctl(4, UI_SET_KEYBIT, 0x126)          = 0
ioctl(4, UI_SET_KEYBIT, 0x127)          = 0
ioctl(4, UI_SET_KEYBIT, 0x128)          = 0
ioctl(4, UI_SET_KEYBIT, 0x129)          = 0
ioctl(4, UI_SET_KEYBIT, 0x12a)          = 0
ioctl(4, UI_SET_KEYBIT, 0x12b)          = 0
ioctl(4, UI_SET_KEYBIT, 0x12c)          = 0
ioctl(4, UI_SET_KEYBIT, 0x12d)          = 0
ioctl(4, UI_SET_KEYBIT, 0x12e)          = 0
ioctl(4, UI_SET_KEYBIT, 0x12f)          = 0
ioctl(4, UI_SET_KEYBIT, 0x130)          = 0
ioctl(4, UI_SET_KEYBIT, 0x131)          = 0
ioctl(4, UI_SET_KEYBIT, 0x132)          = 0
ioctl(4, UI_SET_KEYBIT, 0x133)          = 0
ioctl(4, UI_SET_KEYBIT, 0x134)          = 0
ioctl(4, UI_SET_KEYBIT, 0x135)          = 0
ioctl(4, UI_SET_KEYBIT, 0x136)          = 0
ioctl(4, UI_SET_KEYBIT, 0x137)          = 0
ioctl(4, UI_SET_KEYBIT, 0x138)          = 0
ioctl(4, UI_SET_KEYBIT, 0x139)          = 0
ioctl(4, UI_SET_KEYBIT, 0x13a)          = 0
ioctl(4, UI_SET_KEYBIT, 0x13b)          = 0
ioctl(4, UI_SET_KEYBIT, 0x13c)          = 0
ioctl(4, UI_SET_KEYBIT, 0x13d)          = 0
ioctl(4, UI_SET_KEYBIT, 0x13e)          = 0
ioctl(4, UI_SET_KEYBIT, 0x13f)          = 0
ioctl(4, UI_SET_KEYBIT, 0x140)          = 0
ioctl(4, UI_SET_KEYBIT, 0x141)          = 0
ioctl(4, UI_SET_KEYBIT, 0x142)          = 0
ioctl(4, UI_SET_KEYBIT, 0x143)          = 0
ioctl(4, UI_SET_KEYBIT, 0x144)          = 0
ioctl(4, UI_SET_KEYBIT, 0x145)          = 0
ioctl(4, UI_SET_KEYBIT, 0x146)          = 0
ioctl(4, UI_SET_KEYBIT, 0x147)          = 0
ioctl(4, UI_SET_KEYBIT, 0x148)          = 0
ioctl(4, UI_SET_KEYBIT, 0x149)          = 0
ioctl(4, UI_SET_KEYBIT, 0x14a)          = 0
ioctl(4, UI_SET_KEYBIT, 0x14b)          = 0
ioctl(4, UI_SET_KEYBIT, 0x14c)          = 0
ioctl(4, UI_SET_KEYBIT, 0x14d)          = 0
ioctl(4, UI_SET_KEYBIT, 0x14e)          = 0
ioctl(4, UI_SET_KEYBIT, 0x14f)          = 0
ioctl(4, UI_SET_KEYBIT, 0x150)          = 0
ioctl(4, UI_SET_KEYBIT, 0x151)          = 0
ioctl(4, UI_SET_KEYBIT, 0x152)          = 0
ioctl(4, UI_SET_KEYBIT, 0x153)          = 0
ioctl(4, UI_SET_KEYBIT, 0x154)          = 0
ioctl(4, UI_SET_KEYBIT, 0x155)          = 0
ioctl(4, UI_SET_KEYBIT, 0x156)          = 0
ioctl(4, UI_SET_KEYBIT, 0x157)          = 0
ioctl(4, UI_SET_KEYBIT, 0x158)          = 0
ioctl(4, UI_SET_KEYBIT, 0x159)          = 0
ioctl(4, UI_SET_KEYBIT, 0x15a)          = 0
ioctl(4, UI_SET_KEYBIT, 0x15b)          = 0
ioctl(4, UI_SET_KEYBIT, 0x15c)          = 0
ioctl(4, UI_SET_KEYBIT, 0x15d)          = 0
ioctl(4, UI_SET_KEYBIT, 0x15e)          = 0
ioctl(4, UI_SET_KEYBIT, 0x15f)          = 0
ioctl(4, UI_SET_KEYBIT, 0x160)          = 0
ioctl(4, UI_SET_KEYBIT, 0x161)          = 0
ioctl(4, UI_SET_KEYBIT, 0x162)          = 0
ioctl(4, UI_SET_KEYBIT, 0x163)          = 0
ioctl(4, UI_SET_KEYBIT, 0x164)          = 0
ioctl(4, UI_SET_KEYBIT, 0x165)          = 0
ioctl(4, UI_SET_KEYBIT, 0x166)          = 0
ioctl(4, UI_SET_KEYBIT, 0x167)          = 0
ioctl(4, UI_SET_KEYBIT, 0x168)          = 0
ioctl(4, UI_SET_KEYBIT, 0x169)          = 0
ioctl(4, UI_SET_KEYBIT, 0x16a)          = 0
ioctl(4, UI_SET_KEYBIT, 0x16b)          = 0
ioctl(4, UI_SET_KEYBIT, 0x16c)          = 0
ioctl(4, UI_SET_KEYBIT, 0x16d)          = 0
ioctl(4, UI_SET_KEYBIT, 0x16e)          = 0
ioctl(4, UI_SET_KEYBIT, 0x16f)          = 0
ioctl(4, UI_SET_KEYBIT, 0x170)          = 0
ioctl(4, UI_SET_KEYBIT, 0x171)          = 0
ioctl(4, UI_SET_KEYBIT, 0x172)          = 0
ioctl(4, UI_SET_KEYBIT, 0x173)          = 0
ioctl(4, UI_SET_KEYBIT, 0x174)          = 0
ioctl(4, UI_SET_KEYBIT, 0x175)          = 0
ioctl(4, UI_SET_KEYBIT, 0x176)          = 0
ioctl(4, UI_SET_KEYBIT, 0x177)          = 0
ioctl(4, UI_SET_KEYBIT, 0x178)          = 0
ioctl(4, UI_SET_KEYBIT, 0x179)          = 0
ioctl(4, UI_SET_KEYBIT, 0x17a)          = 0
ioctl(4, UI_SET_KEYBIT, 0x17b)          = 0
ioctl(4, UI_SET_KEYBIT, 0x17c)          = 0
ioctl(4, UI_SET_KEYBIT, 0x17d)          = 0
ioctl(4, UI_SET_KEYBIT, 0x17e)          = 0
ioctl(4, UI_SET_KEYBIT, 0x17f)          = 0
ioctl(4, UI_SET_KEYBIT, 0x180)          = 0
ioctl(4, UI_SET_KEYBIT, 0x181)          = 0
ioctl(4, UI_SET_KEYBIT, 0x182)          = 0
ioctl(4, UI_SET_KEYBIT, 0x183)          = 0
ioctl(4, UI_SET_KEYBIT, 0x184)          = 0
ioctl(4, UI_SET_KEYBIT, 0x185)          = 0
ioctl(4, UI_SET_KEYBIT, 0x186)          = 0
ioctl(4, UI_SET_KEYBIT, 0x187)          = 0
ioctl(4, UI_SET_KEYBIT, 0x188)          = 0
ioctl(4, UI_SET_KEYBIT, 0x189)          = 0
ioctl(4, UI_SET_KEYBIT, 0x18a)          = 0
ioctl(4, UI_SET_KEYBIT, 0x18b)          = 0
ioctl(4, UI_SET_KEYBIT, 0x18c)          = 0
ioctl(4, UI_SET_KEYBIT, 0x18d)          = 0
ioctl(4, UI_SET_KEYBIT, 0x18e)          = 0
ioctl(4, UI_SET_KEYBIT, 0x18f)          = 0
ioctl(4, UI_SET_KEYBIT, 0x190)          = 0
ioctl(4, UI_SET_KEYBIT, 0x191)          = 0
ioctl(4, UI_SET_KEYBIT, 0x192)          = 0
ioctl(4, UI_SET_KEYBIT, 0x193)          = 0
ioctl(4, UI_SET_KEYBIT, 0x194)          = 0
ioctl(4, UI_SET_KEYBIT, 0x195)          = 0
ioctl(4, UI_SET_KEYBIT, 0x196)          = 0
ioctl(4, UI_SET_KEYBIT, 0x197)          = 0
ioctl(4, UI_SET_KEYBIT, 0x198)          = 0
ioctl(4, UI_SET_KEYBIT, 0x199)          = 0
ioctl(4, UI_SET_KEYBIT, 0x19a)          = 0
ioctl(4, UI_SET_KEYBIT, 0x19b)          = 0
ioctl(4, UI_SET_KEYBIT, 0x19c)          = 0
ioctl(4, UI_SET_KEYBIT, 0x19d)          = 0
ioctl(4, UI_SET_KEYBIT, 0x19e)          = 0
ioctl(4, UI_SET_KEYBIT, 0x19f)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1a0)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1a1)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1a2)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1a3)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1a4)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1a5)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1a6)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1a7)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1a8)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1a9)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1aa)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1ab)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1ac)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1ad)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1ae)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1af)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1b0)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1b1)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1b2)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1b3)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1b4)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1b5)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1b6)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1b7)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1b8)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1b9)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1ba)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1bb)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1bc)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1bd)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1be)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1bf)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1c0)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1c1)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1c2)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1c3)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1c4)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1c5)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1c6)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1c7)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1c8)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1c9)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1ca)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1cb)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1cc)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1cd)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1ce)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1cf)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1d0)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1d1)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1d2)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1d3)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1d4)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1d5)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1d6)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1d7)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1d8)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1d9)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1da)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1db)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1dc)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1dd)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1de)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1df)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1e0)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1e1)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1e2)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1e3)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1e4)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1e5)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1e6)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1e7)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1e8)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1e9)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1ea)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1eb)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1ec)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1ed)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1ee)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1ef)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1f0)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1f1)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1f2)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1f3)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1f4)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1f5)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1f6)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1f7)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1f8)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1f9)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1fa)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1fb)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1fc)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1fd)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1fe)          = 0
ioctl(4, UI_SET_KEYBIT, 0x1ff)          = 0
ioctl(4, UI_DEV_CREATE, 0x1ff)          = 0
rt_sigaction(SIGINT, {0x804c3e0, [INT], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0x804c3e0, [TERM], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGUSR1, {SIG_IGN}, {SIG_DFL}, 8) = 0
gettimeofday({1170887207, 758065}, NULL) = 0
write(1, "A2DPD[207.758]: a2dpd_signal_ini"..., 72A2DPD[207.758]: a2dpd_signal_init: (errno=2:No such file or directory)
) = 72
sched_getparam(29773, { 0 })            = 0
sched_getscheduler(29773)               = 0 (SCHED_OTHER)
sched_get_priority_min(SCHED_OTHER)     = 0
sched_get_priority_max(SCHED_OTHER)     = 0
sched_get_priority_max(SCHED_OTHER)     = 0
gettimeofday({1170887207, 758753}, NULL) = 0
open("/usr/lib/charset.alias", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/locale.alias", O_RDONLY|O_LARGEFILE) = 5
fstat64(5, {st_mode=S_IFREG|0644, st_size=2582, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f41000
read(5, "# Locale name alias data base.\n#"..., 4096) = 2582
read(5, "", 4096)                       = 0
close(5)                                = 0
munmap(0xb7f41000, 4096)                = 0
pipe([5, 6])                            = 0
gettimeofday({1170887207, 761047}, NULL) = 0
write(1, "A2DPD[207.761]: a2dpd_signal_ini"..., 87A2DPD[207.761]: a2dpd_signal_init: (errno=2:No such file or directory)Getting on DBUS
) = 87
socket(PF_FILE, SOCK_STREAM, 0)         = 7
connect(7, {sa_family=AF_FILE, path="/var/run/dbus/system_bus_socket"}, 33) = 0
fcntl64(7, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(7, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
fcntl64(7, F_GETFD)                     = 0
fcntl64(7, F_SETFD, FD_CLOEXEC)         = 0
getuid32()                              = 1000
rt_sigaction(SIGPIPE, {SIG_IGN}, {SIG_DFL}, 8) = 0
poll([{fd=7, events=POLLOUT, revents=POLLOUT}], 1, 0) = 1
write(7, "\0", 1)                       = 1
write(7, "AUTH EXTERNAL 31303030\r\n", 24) = 24
poll([{fd=7, events=POLLIN, revents=POLLIN}], 1, -1) = 1
read(7, "OK c9bb6bb10aa41853fe15380045c66"..., 2048) = 37
poll([{fd=7, events=POLLOUT, revents=POLLOUT}], 1, -1) = 1
write(7, "BEGIN\r\n", 7)                = 7
poll([{fd=7, events=POLLIN|POLLOUT, revents=POLLOUT}], 1, -1) = 1
writev(7, [{"l\1\0\1\0\0\0\0\1\0\0\0n\0\0\0\1\1o\0\25\0\0\0/org/fre"..., 128}, {"", 0}], 2) = 128
gettimeofday({1170887207, 765230}, NULL) = 0
poll([{fd=7, events=POLLIN, revents=POLLIN}], 1, 25000) = 1
read(7, "l\2\1\1\n\0\0\0\1\0\0\0=\0\0\0\6\1s\0\5\0\0\0:1.34\0\0"..., 2048) = 260
read(7, 0x8062f40, 2048)                = -1 EAGAIN (Resource temporarily unavailable)
fstat64(7, {st_mode=S_IFSOCK|0777, st_size=0, ...}) = 0
fcntl64(7, F_GETFL)                     = 0x802 (flags O_RDWR|O_NONBLOCK)
mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3e000
mprotect(0xb7f3e000, 4096, PROT_NONE)   = 0
clone(child_stack=0xb7f414c4, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, parent_tidptr=0xb7f41bf8, {entry_number:6, base_addr:0xb7f41bb0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, child_tidptr=0xb7f41bf8) = 29776
gettimeofday({1170887207, 766358}, NULL) = 0
write(1, "A2DPD[207.766]: a2dpd_signal_ini"..., 38A2DPD[207.766]: a2dpd_signal_init: OK
) = 38
socket(PF_FILE, SOCK_STREAM, 0)         = 8
connect(8, {sa_family=AF_FILE, path="/var/run/sdp"}, 110) = 0
gettimeofday({1170887207, 766804}, NULL) = 0
write(1, "A2DPD[207.766]: add_avrtg: \n", 28A2DPD[207.766]: add_avrtg: 
) = 28
send(8, "u\0\0\0H\0005E\t\0\0015\3\31\21\f\t\0\0045\0205\6\31\1"..., 77, 0) = 77
select(9, [8], NULL, NULL, {20, 0})     = 1 (in [8], left {20, 0})
recv(8, "v\0\0\0\4\0\1\0\0", 65535, 0)  = 9
gettimeofday({1170887207, 767765}, NULL) = 0
write(1, "A2DPD[207.767]: add_a2source: \n", 31A2DPD[207.767]: add_a2source: 
) = 31
send(8, "u\0\1\0F\0005C\t\0\0015\3\31\21\n\t\0\0045\0205\6\31\1"..., 75, 0) = 75
select(9, [8], NULL, NULL, {20, 0})     = 1 (in [8], left {20, 0})
recv(8, "v\0\1\0\4\0\1\0\1", 65535, 0)  = 9
socket(PF_FILE, SOCK_STREAM, 0)         = 9
setsockopt(9, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
bind(9, {sa_family=AF_FILE, path=@/tmp/a2dpd}, 13) = 0
listen(9, 0)                            = 0
socketpair(PF_FILE, SOCK_STREAM, 0, [10, 11]) = 0
gettimeofday({1170887207, 768902}, NULL) = 0
write(1, "A2DPD[207.768]: a2dpd_signal_set"..., 65A2DPD[207.768]: a2dpd_signal_set_socket: Signal socket set to 10
) = 65
open("/home/killes/.a2dprc", O_RDONLY)  = 12
fstat64(12, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3d000
read(12, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
close(12)                               = 0
munmap(0xb7f3d000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 12
fstat64(12, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3d000
read(12, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
close(12)                               = 0
munmap(0xb7f3d000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 12
fstat64(12, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3d000
read(12, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
close(12)                               = 0
munmap(0xb7f3d000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 12
fstat64(12, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3d000
read(12, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
close(12)                               = 0
munmap(0xb7f3d000, 4096)                = 0
open("/home/killes/.a2dprc", O_RDONLY)  = 12
fstat64(12, {st_mode=S_IFREG|0644, st_size=2639, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3d000
read(12, "[a2dpd]\n#\n# Rate\n# use 32000 if "..., 4096) = 2639
read(12, "", 4096)                      = 0
close(12)                               = 0
munmap(0xb7f3d000, 4096)                = 0
mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3a000
mprotect(0xb7f3a000, 4096, PROT_NONE)   = 0
clone(child_stack=0xb7f3d4c4, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, parent_tidptr=0xb7f3dbf8, {entry_number:6, base_addr:0xb7f3dbb0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, child_tidptr=0xb7f3dbf8) = 29777
mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f36000
mprotect(0xb7f36000, 4096, PROT_NONE)   = 0
clone(child_stack=0xb7f394c4, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, parent_tidptr=0xb7f39bf8, {entry_number:6, base_addr:0xb7f39bb0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, child_tidptr=0xb7f39bf8) = 29778
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, A2DPD[207.774]: a2dpd_thread_handler: Registering object path: /com/access/a2dpd
A2DPD[207.774]: a2dpd_thread_handler: Acquiring service: com.access.a2dpd
A2DPD[207.776]: a2dpd_thread_handler: Running ...
A2DPD[207.776]: a2dpd_signal_state: Disconnected 
NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, NULL)          = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP}], 1, 0) = 0
nanosleep({0, 10000000}, 0)             = ? ERESTART_RESTARTBLOCK (To be restarted)
--- SIGTERM (Terminated) @ 0 (0) ---
socket(PF_FILE, SOCK_STREAM, 0)         = 14
connect(14, {sa_family=AF_FILE, path=@/tmp/a2dpd}, 13) = 0
shutdown(14, 2 /* send and receive */)  = 0
close(14)                               = 0
sigreturn()                             = ? (mask now [])
shutdown(9, 2 /* send and receive */)   = 0
close(9)                                = 0
tgkill(29773, 29778, SIGUSR1)           = 0
tgkill(29773, 29777, SIGUSR1)           = 0
futex(0xb7f3dbf8, FUTEX_WAIT, 29777, NULL) = 0
futex(0xb7f39bf8, FUTEX_WAIT, 29778, NULL) = 0
gettimeofday({1170887211, 782481}, NULL) = 0
write(1, "A2DPD[211.782]: a2dpd_signal_set"..., 99A2DPD[211.782]: a2dpd_signal_set_socket: (errno=4:Interrupted system call)Signal socket set to -1
) = 99
shutdown(11, 2 /* send and receive */)  = 0
close(11)                               = 0
shutdown(10, 2 /* send and receive */)  = 0
close(10)                               = 0
close(8)                                = 0
gettimeofday({1170887211, 782990}, NULL) = 0
write(1, "A2DPD[211.782]: a2dpd_signal_kil"..., 36A2DPD[211.782]: a2dpd_signal_kill: 
) = 36
write(6, "A", 1)                        = 1
gettimeofday({1170887211, 783226}, NULL) = 0
write(1, "A2DPD[211.783]: a2dpd_signal_kil"..., 43A2DPD[211.783]: a2dpd_signal_kill: joining
) = 43
futex(0xb7f41bf8, FUTEX_WAIT, 29776, NULLA2DPD[211.783]: a2dpd_thread_handler: Closing ...
) = 0
gettimeofday({1170887211, 783604}, NULL) = 0
write(1, "A2DPD[211.783]: a2dpd_signal_kil"..., 38A2DPD[211.783]: a2dpd_signal_kill: OK
) = 38
ioctl(4, UI_DEV_DESTROY or USBDEVFS_BULK, 0xbfa11b38) = 0
close(4)                                = 0
munmap(0xb7f42000, 4096)                = 0
munmap(0xb7f43000, 4096)                = 0
exit_group(0)                           = ?
Process 29773 detached

--------------080501000708000709090506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------080501000708000709090506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------080501000708000709090506--
