Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42029A2B.6020905@tootai.net>
From: administrator tootai <admin@tootai.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Connection issue with headset
References: <41FA06A5.3010904@tootai.net> <ctdn6n$sqs$1@sea.gmane.org> <41FE4744.5010804@tootai.net> <ctob73$ph0$1@sea.gmane.org> <4200D3B6.1050708@tootai.net> <ctqulk$ce4$1@sea.gmane.org> <420105F0.5030407@tootai.net> <cttbgv$knk$1@sea.gmane.org>
In-Reply-To: <cttbgv$knk$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Thu, 03 Feb 2005 22:39:55 +0100

Sebastian Roth a =E9crit :

> Hi Daniel,

Hi Sebastian

>
>
>>> are the other things build into the kernel or loaded? (bluetooth,
>>> hci_usb, l2cap, rfcomm, sco)
>>
>>
>> all in modules
>
> Have you really loaded all of them?
>
> Your posted output of dmesg:
> Bluetooth: L2CAP ver 2.6
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: RFCOMM ver 1.3
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM TTY layer initialized
> # where is SCO?
> snd-bt-sco revision 1.4 $
> snd-bt-sco: snd-bt-scod thread starting
>
> My output:
> Bluetooth: L2CAP ver 2.7
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: RFCOMM ver 1.5
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM TTY layer initialized
> Bluetooth: SCO (Voice Link) ver 0.4
> Bluetooth: SCO socket layer initialized
> snd-bt-sco revision 1.4 $
> snd-bt-sco: snd-bt-scod thread starting
>
>
> Btw. what kernel version do you use? Please update the kernel to
> 2.6.10-mh3 and the libs/utils to 2.15!!

2.6.10 (debian) + patch swsusp2 & bluez-utils 2.10-5 (debian sid)

>
>
>
> # sdptool search --bdaddr <bdaddr> 0x1108
> Class 0x1108
> Searching for 0x1108 on <bdaddr> ...
> Service Name: Headset
> Service RecHandle: 0x10000
> Service Class ID List:
>   "Headset" (0x1108)
>   "Generic Audio" (0x1203)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 1
> Profile Descriptor List:
>   "Headset" (0x1108)
>     Version: 0x0100
>
> What does this command show to you? Is the Channel the same when
> connecting with btsco?

#sdptool search --bdaddr 00:0b:2e:06:01:2e 0x1108
Class 0x1108
Searching for 0x1108 on 00:0B:2E:06:01:2E ...
Service Name: Headset
Service RecHandle: 0x20000
Service Class ID List:
  "Headset" (0x1108)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 6
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

nomade:/etc/waproamd/keys# btsco 00:0b:2e:06:01:2e
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 6 connected
speaker volume: 10 mic volume: 10

Many thanks for you help


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
