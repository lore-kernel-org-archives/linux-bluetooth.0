Return-Path: <cyrus@holtmann.org>
Message-ID: <cc1649d10802071303i7517c3d1id683a6b1edf227bc@mail.gmail.com>
Date: Thu, 7 Feb 2008 16:03:23 -0500
From: "Vlad Skarzhevskyy" <skarzhevskyy@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <cc1649d10802071257r1d65d622sffa0e9a21883d9b@mail.gmail.com>
MIME-Version: 1.0
References: <cc1649d10802051215j7f1d9406u6c4cda1b161c77de@mail.gmail.com>
	<1202251232.15090.147.camel@violet>
	<cc1649d10802071025s38dbe8dbuaeff21f05e45b49f@mail.gmail.com>
	<1202410007.15090.255.camel@violet>
	<cc1649d10802071257r1d65d622sffa0e9a21883d9b@mail.gmail.com>
Subject: Re: [Bluez-devel] sdp_extract_pdu *** stack smashing detected ***
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Just to make it clear  this is the versions.

[root@tor bluez-libs-tests]# gcc --version
gcc (GCC) 4.1.2 20070925 (Red Hat 4.1.2-27)

[root@tor bluez-libs-tests]# uname -a
Linux torv 2.6.21-6.fc7xen #1 SMP Mon Nov 19 07:14:27 EST 2007 i686
i686 i386 GNU/Linux

[root@tor bluez-libs-tests]# ldd ./target/bluez-tests
        linux-gate.so.1 =>  (0x00762000)
        libbluetooth.so.2 => /usr/lib/libbluetooth.so.2 (0x00233000)
        libc.so.6 => /lib/i686/nosegneg/libc.so.6 (0x002b1000)

[root@tor bluez-libs-tests]# file /usr/lib/libbluetooth.so.2
/usr/lib/libbluetooth.so.2: symbolic link to `libbluetooth.so.2.9.4'


[root@tor bluez-libs-tests]# file /usr/lib/libbluetooth.so.2.9.4
/usr/lib/libbluetooth.so.2.9.4: ELF 32-bit LSB shared object, Intel
80386, version 1 (SYSV), not stripped

-- 
Vlad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
