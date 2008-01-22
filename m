Return-Path: <cyrus@holtmann.org>
Message-Id: <CA0BDF04-D95A-4F2B-BA07-CED77F77928D@fugue.com>
From: Ted Lemon <mellon@fugue.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v915)
Date: Tue, 22 Jan 2008 12:32:19 -0700
Subject: [Bluez-devel] Packet ordering with multiple HID devices...
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

This December I broke my arm, and for the next month or so I have  
really restricted mobility, so I've been trying to set up a dual- 
keyboard system that allows me to type with my palms facing each  
other.   Unfortunately, I've run into a roadblock with the bluetooth  
stack on Linux, and I'm wondering if anybody can help me to hone in on  
the problem.

The problem is that when I type rapidly on both keyboards at the same  
time, there seems to be some sampling latency - as if there were a  
sample clock happening maybe every half-second, so that all events  
happening between ticks would come in at once.   And the sample clocks  
for the two keyboards are out of sync.   So I see two effects from this:

1. Unintended autorepeat.   This happens even on a single keyboard -  
if the tick happens between the key press and key release events, then  
the delay between these events is long enough to trigger autorepeat,  
so as you type normally you occasionally see a string of about eight  
of the same key, even though you only hit it momentarily.

2. misordering.   Because the sample clocks for the two keyboards are  
not in sync, if you type at faster than the clock rate, keys come in  
out of order, so that you might type "clock" and instead see "lcokc".

I can see three ways to cure this - either speed up the sample clock,  
or get rid of it - go completely asynchronous - or figure out some way  
to correctly interleave the data as it comes in, even though it's  
coming from two separate devices.   It seems to me like the right  
thing to do is get rid of the clock - keyboard events are not so  
frequent that it's really necessary to batch them up.

The problem is that I don't know where the batching is happening - is  
it on the keyboard, on the USB bluetooth device, in the bluetooth  
socket code, or in the HID layer.   Looking at the code for the HID  
layer, it's not obvious, but I'm not a Linux kernel wizard, so I may  
have missed it.

I don't think it's happening on the keyboards, because I don't have  
this problem on Mac OS X (I have a different problem!).   So that  
leaves the bluetooth adapter or the socket layer, or something I've  
missed.

Has anybody else seen this problem?   Any ideas on where I should  
look?   Patches?   :')


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
