Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] What's the best way to go about device detection?
From: Marcel Holtmann <marcel@holtmann.org>
To: Rob Raper <djrobx@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY14-F125F0uTDF1cy000524f0@hotmail.com>
References: <BAY14-F125F0uTDF1cy000524f0@hotmail.com>
Content-Type: text/plain
Message-Id: <1084813510.5833.23.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 17 May 2004 19:05:10 +0200

Hi Rob,

> I have two CSR based dongles (one D-Link DBt120 rev B3) and one Microsoft 
> dongle from their wireless keyboard & mouse pack.   They both operate pretty 
> much identically.   If I can obtain a 1.2 dongle that supports getting rssi 
> on a scan it's probably a better solution anyway.   Your hardware support 
> list shows all 1.1, however, do you know which dongles can support 1.2?

in general every CSR BlueCore02 based dongle with 8-Mbit flash can be
updated to Bluetooth 1.2 support with HCI 18.x firmware. This has to be
done by the module/dongle manufacturers.

Another Bluetooth 1.2 solution is the Zeevo ZV4002, but there is no
dongle available right now. I am using the Matsushita Bluetooth Module
which is based on that chip.

The third is Silicon Wave based and I expect that Anycom will sell their
dongles with Bluetooth 1.2 support very soon. The new BlueFRITZ! USB 2.0
is also SiW based and the prototype that I use already supports Inquiry
with RSSI.

> Also just FYI, the phones we're connecting to at the moment are Nokia 3650s.

Run a "hcitool info <bdaddr>" against your 3650 and see what features it
supports. Hopefully it has role switch support.

> The D-link that I do most of the testing on shows:
> 
> hci0:   Type: USB
>         BD Address: 00:0F:3D:0B:FB:45 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:3686 acl:0 sco:0 events:273 errors:0
>         TX bytes:2832 acl:0 sco:0 commands:205 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy:
>         Link mode: MASTER
>         Name: 'Embt'
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous,
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 
> 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)

You can also try "hciconfig hci0 revision" and you see some manufacturer
specific information.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
