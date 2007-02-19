Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45D9F9DC.1030606@yahoo.com.au>
Date: Mon, 19 Feb 2007 20:26:20 +0100
From: bluez.mexon@spamgourmet.com
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <45D9E0ED.8090700@yahoo.com.au> <1171907659.26567.29.camel@violet>
In-Reply-To: <1171907659.26567.29.camel@violet>
Subject: Re: [Bluez-devel] hid2hci fails: broken pipe
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

Marcel Holtmann - marcel@holtmann.org wrote:

>> aeon:~# hid2hci -1
>> Switching device 0a12:0001 to HID mode failed (Broken pipe)
>>
>> Can anyone suggest why this isn't working?  What pipe?  What's it
>> talking to a pipe for in the first place?
> 
> it doesn't mean that it actually failed to switch the adapter. It might
> have simply worked. The error messages from the USB subsystem are kinda
> strange, but somehow expected since the device will disconnect from the
> bus.

OK, maybe I've misunderstood something.  As I understand it, putting the
 dongle into HID mode should ask the dongle to pretend to be a USB hub
with a mouse (and/or keyboard) attached.  So if it works, the effect
should be that my mouse keeps working even when the bluetooth stack
isn't running.

If that's right, and I run hid2hci -1 as above, my mouse should
"disconnect" from X as a bluetooth mouse and then "reconnect" as a fake
USB mouse, and so I should find that my mouse continues working
(possibly after a short delay).  However, I should then find that if I
stop the bluetooth system, the mouse still works.  I would also expect
that lsusb would show a bluetooth mouse attached somehow.

In fact when I run hid2hci, the mouse still works, but when I stop
bluetooth the mouse stops working too.  This seems to me to be still in
HCI mode.  The fact that lsusb still reports:

Bus 002 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
Dongle (HCI mode)

...seems to back this up.  The mouse continues to not work until I both
bring up bluetooth again and run hidd by hand.

I can cope with this for a mouse, but I was hoping to follow up with a
keyboard, and for that it's really important that I'm able to enter
stuff into GRUB and the BIOS before the bluetooth stack is loaded.  I'm
hoping to experiment with the mouse first before I invest in a keyboard too.

So, two questions:

First, is there any way I can tell, really and for sure, whether the
dongle is in HCI or HID mode?

Second, I'm a little confused about how this "HID proxy" thing works
anyway.  How does the dongle remember which mouse and keyboard it's
paired with after the power is switched off?  Does it have a little bit
of flash on board that remembers the last paired device or something?
Or have I completely misunderstood what this feature is for?

Thanks,
Mat

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
