Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Feb 2008 03:52:33 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <926260.91408.qm@web8408.mail.in.yahoo.com>
Message-ID: <alpine.LNX.1.00.0802150310560.19485@nge2.ngu.pk>
References: <926260.91408.qm@web8408.mail.in.yahoo.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Headset not playing audio HELP PLEASE
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net



On Fri, 15 Feb 2008, pramod gurav wrote:

-> Connections:
-> When I press button on HS , I receive this on console(but no popup)
-> [root@localhost Pramod]# Authorization request for device 00:0F:DE:B1:02:42

There's nothing to popup, if you're using command line tools.

-> Now when I do
-> [root@localhost Pramod]# hcitool conn
-> Connections:
->         > ACL 00:0F:DE:B1:02:42 handle 11 state 1 lm SLAVE AUTH ENCRYPT SECURE

Seems OK.


-> Its fine till here I think
-> I am able record sound using
-> [Pramod@localhost ~]$ arecord -D bluetooth -f S16_LE today.raw
-> Recording WAVE 'today.raw' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
-> I am able to do it.
-> But when I Do 
-> [Pramod@localhost ~]$ aplay -D bluetooth -t raw -f S16_LE today.raw
-> Playing WAVE 'today.raw' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
-> I am not able hear anything
-> 
-> This is my hciconfig
-> [root@localhost Pramod]# /usr/local/sbin/hciconfig -a
-> hci0:   Type: USB
->         BD Address: 00:02:72:CE:5B:80 ACL MTU: 1017:8 SCO MTU: 64:0
->         UP RUNNING PSCAN ISCAN
->         RX bytes:5057856 acl:233 sco:99008 events:218 errors:0
->         TX bytes:4708 acl:165 sco:0 commands:102 errors:0
->         Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
->         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
->         Link policy: RSWITCH HOLD SNIFF PARK
->         Link mode: SLAVE ACCEPT
->         Name: 'BlueZ (0)'
->         Class: 0x080000
->         Service Classes: Capturing
->         Device Class: Miscellaneous,
->         HCI Ver: 2.0 (0x3) HCI Rev: 0x204d LMP Ver: 2.0 (0x3) LMP Subver: 0x4127
->         Manufacturer: Broadcom Corporation (15)
-> 
-> I see one difference in mine & yours at line number 2 end
-> SCO MTU: 64:0 ----------mine 
-> SCO 
-> MTU: 
-> 64:8 ----------yours

Most of the ones I saw searching Google show non-zero integer:non-zero 
integer. Maybe you have this issue (url probably wraps):

http://www.google.com/group/fa.linux.kernel/t/590996bd6dbef4ba/d140c5b36f2cc567%23d140c5b36f2cc567?

As someone on this group replied to it, maybe he can tell you more.

Also, this part is really odd, it seems to show nothing is even sent for the 
headset to play:

RX bytes:5057856 acl:233 sco:99008
TX bytes:4708 acl:165 sco:0   <------


-> Also my         Service Classes: Capturing
-> Is it OK??

I don't think it makes a difference here. Alot of people leave the default 
set. The numbers and what they mean to set that field I found from searching 
the web.


-> This is my hcidump when I was playing audio
-> [root@localhost Pramod]# /usr/local/sbin/hcidump -i hci0 --asci
-> HCI sniffer - Bluetooth packet analyzer ver 1.40
-> device: hci0 snap_len: 1028 filter: 0xffffffff
-> > SCO data: handle 1 flags 0x00 dlen 48
->     . . . . . . k . . . . . . . x . . . . .
->     . . . . _ . . . . . . . . . . . \ . . .
->     . . . . E . . .
-> > SCO data: handle 1 flags 0x00 dlen 48
->     k . . . n . l . . . ' . : . . . B . a .
->     . . 2 . p . . . . . . . u . " . \ . . .
->     . . . . z . . .
-> 
-> I tried variations in audio.conf, but no changes .
-> I need to try something else.

As far as what you posted, it looks fine. So I'm really not sure myself why 
it's not working. The only other thing I can think of is maybe in either the 
adapter or the headset, there is a compatibility problem. That is, one or the 
other (or both) may not work correctly with Linux/Bluez/the kernel driver 
code. It would help alot if you could get your hands on some other hardware to 
see. I suspect a problem with the adapter, because of this:

SCO MTU: 64:0

and

TX bytes:4708 acl:165 sco:0

I don't recall if you posted it...what does 'lsusb -v' show about your 
adapter?


-> One more thing If you dont mind. what is static struct usb_device_id blacklist_ids[]

This is a data structure of what looks like USB devices that have some sort of 
problems. Is your bluetooth adapter in there?


-> Hope to get some way through it.

I think I'm running out of suggestions :(


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
