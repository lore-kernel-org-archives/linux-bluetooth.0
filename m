Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [BUG] unit/test-gatt failure uninitialized pointer(?)
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <2992e569-78e1-ea64-52b5-a2df11a6c948@message-id.googlemail.com>
 <CABBYNZ+90yuLCDhEskujMK0jbqAM=VoGQYj6AQqz=Np8wyEhnw@mail.gmail.com>
 <fa6ffb78-74c9-6797-5a69-c46948341b2a@message-id.googlemail.com>
 <a26a80a9-f727-785b-4baa-62a9dc83bf56@message-id.googlemail.com>
 <CABBYNZ+7_+6jxuazNgSo61+KprWD8dcyrkcapTA5HjDuCze7Pg@mail.gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
Message-ID: <55f07989-54e8-7e31-9a0c-536f1febf633@message-id.googlemail.com>
Date: Mon, 29 May 2017 14:10:43 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+7_+6jxuazNgSo61+KprWD8dcyrkcapTA5HjDuCze7Pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 29.05.2017 13:42, Luiz Augusto von Dentz wrote:
> unit/test-gatt -p  /robustness/unkown-request

This hangs for apparently infinite time, but does not crash. So you are probably right, that some previous test does
create a timeout handler which is triggered by this infinite wait and then crashes the test.

This test VMs are not slow, so it's not a performance problem. They just have limited connectivity.

I debugged this with strace and found the following difference:

Working:

13:55:57 write(1, "\33[1;39m/robustness/unkown-reques"..., 55/robustness/unkown-request - run
) = 55 <0.000053>
13:55:57 socketpair(AF_UNIX, SOCK_SEQPACKET|SOCK_CLOEXEC, 0, [5, 6]) = 0 <0.000051>
13:55:57 fstat(5, {st_dev=makedev(0, 9), st_ino=281430, st_mode=S_IFSOCK|0777, st_nlink=1, st_uid=10329, st_gid=100,
st_blksize=4096, st_blocks=0, st_size=0, st_atime=0, st_mtime=0, st_ctime=0}) = 0 <0.000049>
13:55:57 fcntl(5, F_GETFL)              = 0x2 (flags O_RDWR) <0.000049>
13:55:57 socket(AF_ALG, SOCK_SEQPACKET|SOCK_CLOEXEC, 0) = 7 <0.000048>
13:55:57 bind(7, {sa_family=AF_ALG,
sa_data="skcipher\0\0\0\0\0\0\0\0\0\0\0\0\0\0ecb(aes)\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"},
88) = 0 <0.000071>
13:55:57 open("/dev/urandom", O_RDONLY) = 8 <0.000054>
13:55:57 socket(AF_ALG, SOCK_SEQPACKET|SOCK_CLOEXEC, 0) = 9 <0.000062>
13:55:57 bind(9, {sa_family=AF_ALG,
sa_data="hash\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0cmac(aes)\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"},
88) = 0 <0.000061>
13:55:57 getsockopt(5, SOL_SOCKET, SO_DOMAIN, [1], [4]) = 0 <0.000052>
13:55:57 fstat(6, {st_dev=makedev(0, 9), st_ino=281431, st_mode=S_IFSOCK|0777, st_nlink=1, st_uid=10329, st_gid=100,
st_blksize=4096, st_blocks=0, st_size=0, st_atime=0, st_mtime=0, st_ctime=0}) = 0 <0.000049>
13:55:57 fcntl(6, F_GETFL)              = 0x2 (flags O_RDWR) <0.000050>

Not working:

11:54:59 write(1, "\33[1;39m/robustness/unkown-reques"..., 55/robustness/unkown-request - run
) = 55 <0.000354>
11:54:59 socketpair(AF_UNIX, SOCK_SEQPACKET|SOCK_CLOEXEC, 0, [5, 6]) = 0 <0.000224>
11:54:59 fstat(5, {st_dev=makedev(0, 9), st_ino=26139, st_mode=S_IFSOCK|0777, st_nlink=1, st_uid=399, st_gid=399,
st_blksize=4096, st_blocks=0, st_size=0, st_atime=0, st_mtime=0, st_ctime=0}) = 0 <0.000174>
11:54:59 fcntl(5, F_GETFL)              = 0x2 (flags O_RDWR) <0.000079>
11:54:59 socket(AF_ALG, SOCK_SEQPACKET|SOCK_CLOEXEC, 0) = -1 EAFNOSUPPORT (Address family not supported by protocol)
<0.000287>
11:54:59 getsockopt(5, SOL_SOCKET, SO_DOMAIN, [1], [4]) = 0 <0.000191>
11:54:59 fstat(6, {st_dev=makedev(0, 9), st_ino=26140, st_mode=S_IFSOCK|0777, st_nlink=1, st_uid=399, st_gid=399,
st_blksize=4096, st_blocks=0, st_size=0, st_atime=0, st_mtime=0, st_ctime=0}) = 0 <0.000062>
11:54:59 fcntl(6, F_GETFL)              = 0x2 (flags O_RDWR) <0.000223>
11:54:59 write(6, "\2\27\0", 3)         = 3 <0.000061>
11:54:59 poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}, {fd=6, events=POLLIN}], 4, -1) = 1
([{fd=5, revents=POLLIN}]) <0.000208>
11:54:59 read(5, "\2\27\0", 23)         = 3 <0.000062>
11:54:59 poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN|POLLOUT}, {fd=6, events=POLLIN}], 4,
-1) = 1 ([{fd=5, revents=POLLOUT}]) <0.000040>
11:54:59 writev(5, [{iov_base="\3\0\2", iov_len=3}], 1) = 3 <0.000060>
11:54:59 poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN|POLLOUT}, {fd=6, events=POLLIN}], 4,
-1) = 2 ([{fd=5, revents=POLLOUT}, {fd=6, revents=POLLIN}]) <0.000054>
11:54:59 read(6, "\3\0\2", 512)         = 3 <0.000035>
11:54:59 poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}, {fd=6, events=POLLIN}], 4, 0) = 0
(Timeout) <0.000198>
11:54:59 write(6, "\277\0", 2)          = 2 <0.000208>
11:54:59 poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}, {fd=6, events=POLLIN}], 4, -1) = 1
([{fd=5, revents=POLLIN}]) <0.000203>
11:54:59 read(5, "\277\0", 23)          = 2 <0.000197>
11:54:59 poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}, {fd=6, events=POLLIN}], 4, -1

So it seems the VM has no support for AF_ALG and thus the test hangs infinitely, the old timeout kicks in and crashes
the test.

It should probably be reproducible by unloading and blacklisting the af_alg module on your machine.

Best regards,

	Stefan
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
 public relations, for nature cannot be fooled." -- Richard Feynman
