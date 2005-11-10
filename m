Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] bluez and asterisk
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <HCEOIFALKKLBLJPENPNOMEELCAAA.khaled@ipbill.com>
References: <HCEOIFALKKLBLJPENPNOMEELCAAA.khaled@ipbill.com>
Content-Type: text/plain
Message-Id: <1131643489.25312.40.camel@blade>
Mime-Version: 1.0
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
Date: Thu, 10 Nov 2005 18:24:49 +0100

Hi Khaled,

> Thanks for your replies Marcel. Unfortunately I cannot find anything on the
> net about hcidump reporting no traffic - I am completely lost!
> 
> My hcdump shows:
> 
> HCI sniffer - Bluetooth packet analyzer ver 1.27
> device: hci0 snap_len: 1028 filter: 0xffffffff
> 
> Running: sdptool search --bdaddr 00:0E:6D:34:BD:B1 0x111F, gives:
> 
> Class 0x111F
> Searching for 0x111F on 00:0E:6D:34:BD:B1 ...
> Service Name: Voice Gateway
> Service RecHandle: 0x10005
> Service Class ID List:
>   "Handfree Audio Gateway" (0x111f)
>   "Generic Audio" (0x1203)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 13
> Language Base Attr List:
>   code_ISO639: 0x656e
>   encoding:    0x6a
>   base_offset: 0x100
> Profile Descriptor List:
>   "Handsfree" (0x111e)
>     Version: 0x0100
> 
> Please see previous mails for more info about hciconfig -a, revision, etc
> outputs.
> How can I progress from this stage? Why is hcidump showing no traffic?

I am pretty sure that the PIN helper has a problem. So get hcidump
running and look at your log files.

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
