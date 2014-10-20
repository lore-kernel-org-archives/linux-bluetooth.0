Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: how to set PSCAN mode in .conf?
Date: Mon, 20 Oct 2014 20:49:01 +0200
Message-ID: <5460120.arhYbJZIVa@athlon>
In-Reply-To: <CAAJw_ZvrynW0W6fE21ieG+KUwWr_g7-9kDonKYT3ZoEi3Nntiw@mail.gmail.com>
References: <CAAJw_ZuK6SUy22R133CezsqoU4+dTzxmsipBAp7rCvYBo+zrxw@mail.gmail.com> <8940108C-6C27-49E3-80C8-8983F32D6F55@holtmann.org> <CAAJw_ZvrynW0W6fE21ieG+KUwWr_g7-9kDonKYT3ZoEi3Nntiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeff,

On Tuesday 21 October 2014 01:40:46 Jeff Chua wrote:
> On Mon, Oct 20, 2014 at 11:59 PM, Marcel Holtmann <marcel@holtmann.org> 
wrote:
> >> But on older bluez-5.21, the PSCAN and ISCAN are enabled automatically.
> > 
> > this is intentionally. Starting with BlueZ 5.23 and Linux 3.17, the Page
> > Scan state is controlled by the kernel. If you have no devices paired /
> > configured, then it will just disable Page Scan. If you do not know about
> > devices, then there is also no point in allowing anybody to connect.
> > 
> > You can use the management command Add Device to add BR/EDR devices. If
> > you add at least one device, then Page Scan will be enabled automatically
> > by the kernel. If you want to be always connectable, then you can set the
> > device manually connectable.
> > 
> > Using bluetoothctl does exactly the right thing. For being discoverable,
> > you need to be connectable and discoverable. So Page Scan and Inquiry
> > Scan enabled. However if you do not have any paired devices and turn
> > discoverable back off, then both will be disabled.
> > 
> > Just try it. Pair with a device and see that Page Scan gets turn on
> > magically.
> Marcel,
> 
> Excellent info that would have taken me a long time to find out!
> Thanks for sharing!
> 
> I tried  ...
> 
> # btmgmt add-device -t BR/EDR -a 1 F4:B7:E2:E9:54:68
> hci0:   Type: BR/EDR  Bus: USB
>         BD Address: F4:B7:E2:E9:54:68  ACL MTU: 1021:8  SCO MTU: 64:1
>         UP RUNNING PSCAN
> 
> I don't know what the actions are supposed to do, but "-a 1" works.
> 
> Next I tried "connectable" but "info" still didn't show the
> connectable and hciconfig didn't show ISCAN.
> 
> # btmgmt connectable F4:B7:E2:E9:54:68
> hci0 Set Connectable complete, settings: powered bondable ssp br/edr le

Proper syntax for this would be:
btmgmt -i hci0 connectable on

> # btmgmt info
> hci0:   addr F4:B7:E2:E9:54:68 version 6 manufacturer 15 class 0x000000
>         supported settings: powered connectable fast-connectable
> discoverable bondable link-security ssp br/edr hs le advertising
> debug-keys privacy configuration
>         current settings: powered bondable ssp br/edr le
> 
> But if I use bluetoothctl "discoverable on", ISCAN showed up on hciconfig.
> 
> And one last thing ... if I put btmgmt in a script and run it right up
> hciconfig hci0 up, the command would not work. A minimum of "sleep 1"
> is required.
> 
> So, what's the best way to set the device to be always discoverable?
> And I need this because the "server" needs to be discoverable by the
> Intermec scanners. The scanner would scan a "server barcode" to
> connect to the server. And this was the default behavior on
> bluez-5.21.
> 
> 
> Thanks,
> Jeff.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Szymon K. Janc
szymon.janc@gmail.com
