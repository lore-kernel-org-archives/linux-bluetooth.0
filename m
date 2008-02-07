Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1202409142.3491.60.camel@cookie.hadess.net>
References: <cc1649d10802051215j7f1d9406u6c4cda1b161c77de@mail.gmail.com>
	<1202251232.15090.147.camel@violet>
	<cc1649d10802071025s38dbe8dbuaeff21f05e45b49f@mail.gmail.com>
	<1202409142.3491.60.camel@cookie.hadess.net>
Date: Thu, 07 Feb 2008 19:54:15 +0100
Message-Id: <1202410455.15090.259.camel@violet>
Mime-Version: 1.0
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

Hi Bastien,

> >  I create a small test in C  bluez-sdp-tests.c
> >  Source code there: http://snapshot.bluecove.org/bluecove-gpl/bluez/test/
> > 
> >  If the SDP binary size is 258  bytes still works OK.
> >  But when I make it bigger call to sdp_gen_record_pdu will crash.
> 
> Works fine here, no errors from valgrind either. You might want to
> upgrade your bluez-libs...

a Fedora 8 with an older bluez-libs indeed crashes:

--- start testing SDP convenrsions ---
create SEQ of 126 elements
call sdp_attr_add
call sdp_gen_record_pdu
*** stack smashing detected ***: ./bluez-sdp-tests terminated
======= Backtrace: =========
/lib/libc.so.6(__fortify_fail+0x6c)[0xf2edf7c]
/lib/libc.so.6[0xf2edf08]
/usr/lib/libbluetooth.so.2(_savefpr_14+0x0)[0xffa28b4]
/usr/lib/libbluetooth.so.2[0xffa140c]
/usr/lib/libbluetooth.so.2[0xffa1440]
/usr/lib/libbluetooth.so.2(sdp_gen_record_pdu+0x7c)[0xff9d66c]
./bluez-sdp-tests[0x10001880]
./bluez-sdp-tests[0x100019b0]
/lib/libc.so.6[0xf1fe56c]
/lib/libc.so.6[0xf1fe73c]
======= Memory map: ========
00100000-00103000 r-xp 00100000 00:00 0          [vdso]
0f1e0000-0f35f000 r-xp 00000000 03:03 1081363    /lib/libc-2.7.so
0f35f000-0f36c000 ---p 0017f000 03:03 1081363    /lib/libc-2.7.so
0f36c000-0f370000 r--p 0018c000 03:03 1081363    /lib/libc-2.7.so
0f370000-0f371000 rw-p 00190000 03:03 1081363    /lib/libc-2.7.so
0f371000-0f374000 rw-p 0f371000 00:00 0 
0ff90000-0ffa9000 r-xp 00000000 03:03 2894543    /usr/lib/libbluetooth.so.2.9.0
0ffa9000-0ffb8000 ---p 00019000 03:03 2894543    /usr/lib/libbluetooth.so.2.9.0
0ffb8000-0ffba000 rw-p 00018000 03:03 2894543    /usr/lib/libbluetooth.so.2.9.0
0ffc0000-0ffe0000 r-xp 00000000 03:03 1081360    /lib/ld-2.7.so
0ffef000-0fff0000 r--p 0002f000 03:03 1081360    /lib/ld-2.7.so
0fff0000-0fff1000 rw-p 00030000 03:03 1081360    /lib/ld-2.7.so
10000000-10003000 r-xp 00000000 03:06 3604654    /home/holtmann/bluez-sdp-tests
10012000-10013000 rw-p 00002000 03:06 3604654    /home/holtmann/bluez-sdp-tests
10013000-10034000 rwxp 10013000 00:00 0          [heap]
30013000-30016000 rw-p 30013000 00:00 0 
7fa30000-7fa45000 rw-p 7ffeb000 00:00 0          [stack]
Aborted

However installing the bluez-libs-3.25 I don't see it anymore:

--- start testing SDP convenrsions ---
create SEQ of 126 elements
call sdp_attr_add
call sdp_gen_record_pdu
pdu.data_size 260
call sdp_extract_pdu
pdu scanned 260
OK
--- tests finished ---

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
