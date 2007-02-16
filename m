Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45D4FB7F.6090301@unternet.org>
Date: Fri, 16 Feb 2007 01:31:59 +0100
From: Frank de Lange <bluez-f@unternet.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] sdpd in polling loop on disconnect
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Is there anyone else here who has seen sdpd run away in a tight poll()
loop when a connected device drops the connection? I can more or less
reliably get sdpd go mad poll()ing and hogging the CPU by walking out of
range, turning off Bluetooth on the (ngage) phone, sending crap to the
serial port service on the phone, etc.

An almost surefire way to get this behaviour to occur goes as follows:

(assumption: paired phone, serial port bound to /dev/rfcomm3)

cat /dev/rfcomm3 (phone wakes up and wants OK)
echo blah > /dev/rfcomm3 (ditto)
usually sdpd will now start eating the CPU. Attaching gdb does not show
much more than that it is looping in g_main_loop_run:

Program received signal SIGUSR2, User defined signal 2.
0x00e1a402 in __kernel_vsyscall ()
(gdb) bt
#0  0x00e1a402 in __kernel_vsyscall ()
#1  0x008c2cfb in poll () from /lib/libc.so.6
#2  0x0046b453 in ?? () from /lib/libglib-2.0.so.0
#3  0x0046b7c9 in g_main_loop_run () from /lib/libglib-2.0.so.0
#4  0x80001800 in main (argc=1, argv=Cannot access memory at address 0x7
) at main.c:147

It loops in g_main_context_check(), repeatedly calling
g_io_channel_get_buffer_condition() as if it still believes there is
some data left to be read. I will look further into this but I'd like to
hear whether I'm the only one with these problems...

I'm using fedora core development by the way...

Cheers//Frank

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
