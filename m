Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fredrik Noring <noring@nocrew.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1126981781.14893.27.camel@yeti>
Mime-Version: 1.0
Subject: [Bluez-devel] hcid crashes with "buffer overflow detected" when pairing
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 17 Sep 2005 20:29:41 +0200

Hi,

I'm trying out the following packages on Fedora Core 4, x86_64:

    bluez-pin-0.24-2
    bluez-libs-2.20-1
    bluez-utils-2.20-1
    dbus-0.33-3

Unfortunately hcid crashes with "buffer overflow detected" when pairing.
Is this a known problem?

Marcel, I'm happy you decided on moving to ASCII based storage. Is there
any documentation on this? Perhaps I can update the man pages if I can
get this working.

Thanks,
Fredrik

# hcid -n
hcid[17889]: Bluetooth HCI daemon
hcid[17889]: Starting security manager 0
hcid[17889]: pin_code_request (sba=00:10:DC:E9:EF:20, dba=00:0E:07:D5:1B:39)
*** buffer overflow detected ***: hcid: processing events terminated
======= Backtrace: =========
/lib64/libc.so.6(__chk_fail+0x2f)[0x2aaaaaf19b6f]
hcid: processing events[0x55555555cdae]
/usr/lib64/libdbus-1.so.1[0x2aaaaabd3037]
/usr/lib64/libdbus-1.so.1(dbus_connection_dispatch+0x1b9)[0x2aaaaabd74e3]
hcid: processing events[0x55555555c9e8]
hcid: processing events[0x55555555c514]
hcid: processing events(main+0x440)[0x5555555582fc]
/lib64/libc.so.6(__libc_start_main+0xef)[0x2aaaaae593cf]
hcid: processing events[0x555555557539]
======= Memory map: ========
2aaaaaaab000-2aaaaaac5000 r-xp 00000000 09:00 2538489                    /lib64/ld-2.3.5.so
2aaaaaac5000-2aaaaaac6000 rw-p 2aaaaaac5000 00:00 0
2aaaaaae0000-2aaaaaae1000 rw-p 2aaaaaae0000 00:00 0
2aaaaabc4000-2aaaaabc5000 r--p 00019000 09:00 2538489                    /lib64/ld-2.3.5.so
2aaaaabc5000-2aaaaabc6000 rw-p 0001a000 09:00 2538489                    /lib64/ld-2.3.5.so
2aaaaabc6000-2aaaaac25000 r-xp 00000000 09:00 1800977                    /usr/lib64/libdbus-1.so.1.0.0
2aaaaac25000-2aaaaad25000 ---p 0005f000 09:00 1800977                    /usr/lib64/libdbus-1.so.1.0.0
2aaaaad25000-2aaaaad2c000 rw-p 0005f000 09:00 1800977                    /usr/lib64/libdbus-1.so.1.0.0
2aaaaad2c000-2aaaaad3c000 r-xp 00000000 09:00 1795784                    /usr/lib64/libbluetooth.so.1.0.20
2aaaaad3c000-2aaaaae3b000 ---p 00010000 09:00 1795784                    /usr/lib64/libbluetooth.so.1.0.20
2aaaaae3b000-2aaaaae3d000 rw-p 0000f000 09:00 1795784                    /usr/lib64/libbluetooth.so.1.0.20
2aaaaae3d000-2aaaaaf6a000 r-xp 00000000 09:00 2538576                    /lib64/libc-2.3.5.so
2aaaaaf6a000-2aaaab069000 ---p 0012d000 09:00 2538576                    /lib64/libc-2.3.5.so
2aaaab069000-2aaaab06d000 r--p 0012c000 09:00 2538576                    /lib64/libc-2.3.5.so
2aaaab06d000-2aaaab06f000 rw-p 00130000 09:00 2538576                    /lib64/libc-2.3.5.so
2aaaab06f000-2aaaab074000 rw-p 2aaaab06f000 00:00 0
2aaaab074000-2aaaab088000 r-xp 00000000 09:00 2538723                    /lib64/libnsl-2.3.5.so
2aaaab088000-2aaaab187000 ---p 00014000 09:00 2538723                    /lib64/libnsl-2.3.5.so
2aaaab187000-2aaaab188000 r--p 00013000 09:00 2538723                    /lib64/libnsl-2.3.5.so
2aaaab188000-2aaaab189000 rw-p 00014000 09:00 2538723                    /lib64/libnsl-2.3.5.so
2aaaab189000-2aaaab18c000 rw-p 2aaaab189000 00:00 0
2aaaab18c000-2aaaab199000 r-xp 00000000 09:00 2540351                    /lib64/libgcc_s-4.0.1-20050727.so.1
2aaaab199000-2aaaab298000 ---p 0000d000 09:00 2540351                    /lib64/libgcc_s-4.0.1-20050727.so.1
2aaaab298000-2aaaab299000 rw-p 0000c000 09:00 2540351                    /lib64/libgcc_s-4.0.1-20050727.so.1
555555554000-555555561000 r-xp 00000000 09:00 1798444                    /usr/sbin/hcid
555555660000-555555661000 rw-p 0000c000 09:00 1798444                    /usr/sbin/hcid
555555661000-555555682000 rw-p 555555661000 00:00 0                      [heap]
7fffffc92000-7fffffca7000 rw-p 7fffffc92000 00:00 0                      [stack]
ffffffffff600000-ffffffffffe00000 ---p 00000000 00:00 0                  [vdso]
Avbruten (SIGABRT)




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
