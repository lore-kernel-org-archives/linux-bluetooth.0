Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Benjamin Eikel <benjamin@eikel.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200602191845.47384.benjamin@eikel.org>
Subject: [Bluez-users] Re: Sucessfully paired and used Broadcom BT-Dongle an BTH-100 Headset
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 19 Feb 2006 18:45:47 +0100

Hello Florian,

I thought Broadcom chipsets and SCO audio is not possible with BlueZ. I am 
using
a Belkin F8T008 USB dongle and a Logitech Mobile Pro Headset. I tried the 
patch
you posted here and in my hciconfig the SCO MTU value changed too:

hciconfig hci0 revision
hci0:   Type: USB
        BD Address: D0:DO:NG:LE:00:00 ACL MTU: 377:10 SCO MTU: 64:8
        Firmware 0.3 / 9

I connected the headset with 
btsco -v 00:HE:AD:SE:T0:00
btsco v0.41
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
Using interface hci0

But I could not send any sound to the headset. I tried it already some months
ago and it is not working as I expected. The BlueZ developers told me at that
time that Broadcom dongles are not supported.

When I play a file with xmms or aplay, I get the following output from btsco:

speaker volume: 11 mic volume: 8
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
speaker volume: 11 mic volume: 8
driver is not in use
disconnected SCO channel
recieved AT+VGS=11
Sending up speaker change 11


Maybe you can give me any hint how you achieved the sound output with that 
dongle.

Regards,
Benjamin Eikel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
