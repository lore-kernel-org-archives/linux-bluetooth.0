Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: David Wulliamoz <david@wulliamoz.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1142954863.7446.14.camel@xgl.compassion.local>
Mime-Version: 1.0
Subject: [Bluez-devel] Broadcom & Plantronic 590a "pulsar"
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
Date: Tue, 21 Mar 2006 16:27:42 +0100

Hello,

Just to let you know,


Using SCO audio:

I've succeed in using a broadcom usb-dongle with bt-sco driver.
I had to apply the patch (sco-mtu.patch). sound and voice are OK. Often
there is a "RFCOMM channel lost" 



Stereo (A2DP) Streaming: (no need to patch)
this command work "mpg123 --au - file.mp3 | ./a2play 00:0D:3C:30:32:AD"
but not "mpg123 --au - file.mp3 | sbc/sbcenc - | ./sbc/rcplay
00:0D:3C:30:32:AD -"

and neither with /dev/dsp (it might be not a bt, bt-sco issue, i'm not a
linux developper)



headset: Plantronic 590a
usb dongle: BT-2200Tp from Trust (Broadcom chip)
kernel: 2.6.14 (mandriva cooker with sco-mtu.patch)
Sip ua: twinkle


hciconfig:
Class: 0x3e0100
Service Classes: Networking, Rendering, Capturing
Device Class: Computer, Uncategorized
HCI Ver: 2.0 (0x3) HCI Rev: 0x2902 LMP Ver: 2.0 (0x3) LMP Subver: 0x4127
Manufacturer: Broadcom Corporation (15)








-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
