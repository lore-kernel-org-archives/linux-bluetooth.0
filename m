Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Khaled" <khaled@ipbill.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] bluez and asterisk
Message-ID: <HCEOIFALKKLBLJPENPNOMEELCAAA.khaled@ipbill.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1131634617.25312.32.camel@blade>
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
Date: Thu, 10 Nov 2005 16:58:30 -0000

Hi Marcel and all,

Thanks for your replies Marcel. Unfortunately I cannot find anything on the
net about hcidump reporting no traffic - I am completely lost!

My hcdump shows:

HCI sniffer - Bluetooth packet analyzer ver 1.27
device: hci0 snap_len: 1028 filter: 0xffffffff

Running: sdptool search --bdaddr 00:0E:6D:34:BD:B1 0x111F, gives:

Class 0x111F
Searching for 0x111F on 00:0E:6D:34:BD:B1 ...
Service Name: Voice Gateway
Service RecHandle: 0x10005
Service Class ID List:
  "Handfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 13
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0100

Please see previous mails for more info about hciconfig -a, revision, etc
outputs.
How can I progress from this stage? Why is hcidump showing no traffic?

Kind Regards,

Khaled



-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net]On Behalf Of Marcel
Holtmann
Sent: 10 November 2005 14:57
To: bluez-users@lists.sourceforge.net
Subject: RE: [Bluez-users] bluez and asterisk


Hi Khaled,

> hcidump -X -V gives:
>
> HCI sniffer - Bluetooth packet analyzer ver 1.27
> device: hci0 snap_len: 1028 filter: 0xffffffff
> |
>
> And does not return to the root# prompt...
>
> What does this mean? Any ideas?

that you now need to do something. It works like tcpdump. No traffic, no
output at all.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email
______________________________________________________________________



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
