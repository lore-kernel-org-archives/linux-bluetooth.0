Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem of data loss with a particular dongle
	brand
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <8c9e090512161013h6782f187k@mail.gmail.com>
References: <8c9e090512161013h6782f187k@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1137721674.17336.151.camel@localhost>
Mime-Version: 1.0
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
Date: Fri, 20 Jan 2006 02:47:54 +0100

Hi Elvis,

unfortunately the original messages did make it to the list.

> I suffered a problem with data loss in RFCOMM connections, but I
> managed to discover that it just happens when a cheapo dongle I have
> is in the *receiving* side. I have 2 exactly equal dongles and both
> cause the same problem.
> 
> It happens when the sender sends a big buffer at once (> 1500 bytes).
> If the server makes repeated cals to send() with around 500 bytes
> each, the problem does not happen.  Perhaps the hardware is flawed
> and/or perhaps Bluez is not handling this dongle correctly.
> When both sides are "good" BT interfaces, (either Bluez or
> smartphone), problem does not happen also.
> 
> I am attaching the hcidump -X sessions of communication with the
> problem (bad dongle and good BT interface sides), as well the Python
> scripts that are my guinea pigs for these tests.
> 
> root@dosmtc17:/bkpz # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:11:67:04:D2:32 ACL MTU: 678:8  SCO MTU: 48:10
>         UP RUNNING PSCAN ISCAN
>         RX bytes:3610 acl:17 sco:0 events:190 errors:0
>         TX bytes:59930 acl:129 sco:0 commands:25 errors:0
>         Features: 0xff 0xff 0x8d 0x78 0x08 0x18 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'dosmtc17-0'
>         Class: 0x100100
>         Service Classes: Object Transfer
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x1ae LMP Ver: 1.2 (0x2) LMP Subver: 0x1ae
>         Manufacturer: Integrated System Solution Corp. (57)

I actually never really found the reason why the ISSC dongles are so
damn crappy. Maybe their USB interface is broken. Try to load the
hci_usb driver with isoc=0 to disable the SCO support and its ISOC
transfers.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
