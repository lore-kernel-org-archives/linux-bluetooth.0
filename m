Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] USB/Bluetooth dongle doesn't work in hub
References: <qszekj3j47n.fsf@timepilot.gpcc.itd.umich.edu>
	<1099959115.29330.40.camel@pegasus>
From: Scott W Gifford <gifford@umich.edu>
In-Reply-To: <1099959115.29330.40.camel@pegasus> (Marcel Holtmann's message
 of "Tue, 09 Nov 2004 01:11:55 +0100")
Message-ID: <qszzn1rhnmh.fsf@timepilot.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 08 Nov 2004 19:28:22 -0500

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Scott,
>
>> I'm trying to connect a USB/Bluetooth dongle to my laptop running
>> Fedora Core 2 with a Linux 2.6.8-1.521 kernel, and these bluez RPMs
>> installed:
>> 
>>     bluez-bluefw-1.0-2, bluez-libs-2.5-2.1, bluez-libs-devel-2.5-2.1,
>>     bluez-pin-0.23-1, bluez-utils-2.4-3, bluez-sdp-devel-1.5-2.1,
>>     bluez-hcidump-1.5-4, bluez-sdp-1.5-2.1, bluez-pan-1.1-4
>
> these packages are a way out of data.

Ah, OK; they're the ones supplied by Fedora.  I'll try newer ones from
the Bluez Web site.

[...]

>>     Nov  8 18:29:24 localhost kernel: hci_usb_intr_rx_submit: hci0 intr rx submit failed urb 1f48cf94 err -28
>>     Nov  8 18:29:24 localhost hcid[23855]: Can't init device hci0. Input/output error(5)
>> 
>> I get the same effect plugging in to the hub on my base station, my
>> keyboard, or a Belkin hub I just purchased.
>
> This looks like an USB problem to me. Update your kernel to the latest
> Bitkeeper snapshot and try again.

OK.

[...]

>> I've appended full logs of what happens on a working direct connection
>> and a failed connection through a hub, with the Belkin adapter; the
>> results with the AmbiCom are similar.
>
> What kind of dongles are these (hciconfig -a)?

hci0 is the Belkin and hci1 is the AmbiCom.

hci0:   Type: USB
        BD Address: 00:0A:3A:56:48:B9 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:765 acl:0 sco:0 events:51 errors:0
        TX bytes:560 acl:0 sco:0 commands:38 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'gifford-0'
        Class: 0x120104
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP
        Subver: 0x33c
        Manufacturer: Cambridge Silicon Radio (10)
 
hci1:   Type: USB
        BD Address: 08:00:17:12:AE:C5 ACL MTU: 339:4  SCO MTU: 60:9
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:143 acl:0 sco:0 events:16 errors:0
        TX bytes:305 acl:0 sco:0 commands:15 errors:0
        Features: 0xff 0x3a 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'gifford-1'
        Class: 0x120104
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.1 (0x1) HCI Rev: 0x178 LMP Ver: 1.1 (0x1) LMP
        Subver: 0x178
        Manufacturer: RTX Telecom A/S (21)
 
----ScottG.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
