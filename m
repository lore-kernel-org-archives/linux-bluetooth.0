Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8940108C-6C27-49E3-80C8-8983F32D6F55@holtmann.org>
References: <CAAJw_ZuK6SUy22R133CezsqoU4+dTzxmsipBAp7rCvYBo+zrxw@mail.gmail.com>
	<8BA7CD92-B061-41CE-BD43-7E1B7CD1DF6A@holtmann.org>
	<CAAJw_ZsCeWWoFvdm1Sid6xSDGawp8RaqP07TM1Q2CvSF8DxU=w@mail.gmail.com>
	<8940108C-6C27-49E3-80C8-8983F32D6F55@holtmann.org>
Date: Tue, 21 Oct 2014 01:40:46 +0800
Message-ID: <CAAJw_ZvrynW0W6fE21ieG+KUwWr_g7-9kDonKYT3ZoEi3Nntiw@mail.gmail.com>
Subject: Re: how to set PSCAN mode in .conf?
From: Jeff Chua <jeff.chua.linux@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 20, 2014 at 11:59 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:

>> But on older bluez-5.21, the PSCAN and ISCAN are enabled automatically.
>
> this is intentionally. Starting with BlueZ 5.23 and Linux 3.17, the Page =
Scan state is controlled by the kernel. If you have no devices paired / con=
figured, then it will just disable Page Scan. If you do not know about devi=
ces, then there is also no point in allowing anybody to connect.

> You can use the management command Add Device to add BR/EDR devices. If y=
ou add at least one device, then Page Scan will be enabled automatically by=
 the kernel. If you want to be always connectable, then you can set the dev=
ice manually connectable.
>
> Using bluetoothctl does exactly the right thing. For being discoverable, =
you need to be connectable and discoverable. So Page Scan and Inquiry Scan =
enabled. However if you do not have any paired devices and turn discoverabl=
e back off, then both will be disabled.
>
> Just try it. Pair with a device and see that Page Scan gets turn on magic=
ally.

Marcel,

Excellent info that would have taken me a long time to find out!
Thanks for sharing!

I tried  ...

# btmgmt add-device -t BR/EDR -a 1 F4:B7:E2:E9:54:68
hci0:   Type: BR/EDR  Bus: USB
        BD Address: F4:B7:E2:E9:54:68  ACL MTU: 1021:8  SCO MTU: 64:1
        UP RUNNING PSCAN

I don't know what the actions are supposed to do, but "-a 1" works.

Next I tried "connectable" but "info" still didn't show the
connectable and hciconfig didn't show ISCAN.

# btmgmt connectable F4:B7:E2:E9:54:68
hci0 Set Connectable complete, settings: powered bondable ssp br/edr le
# btmgmt info
hci0:   addr F4:B7:E2:E9:54:68 version 6 manufacturer 15 class 0x000000
        supported settings: powered connectable fast-connectable
discoverable bondable link-security ssp br/edr hs le advertising
debug-keys privacy configuration
        current settings: powered bondable ssp br/edr le

But if I use bluetoothctl "discoverable on", ISCAN showed up on hciconfig.

And one last thing ... if I put btmgmt in a script and run it right up
hciconfig hci0 up, the command would not work. A minimum of "sleep 1"
is required.

So, what's the best way to set the device to be always discoverable?
And I need this because the "server" needs to be discoverable by the
Intermec scanners. The scanner would scan a "server barcode" to
connect to the server. And this was the default behavior on
bluez-5.21.


Thanks,
Jeff.
