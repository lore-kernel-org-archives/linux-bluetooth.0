Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: how to set PSCAN mode in .conf?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAAJw_ZvrynW0W6fE21ieG+KUwWr_g7-9kDonKYT3ZoEi3Nntiw@mail.gmail.com>
Date: Mon, 20 Oct 2014 20:03:44 +0200
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <07E0A5D2-1E7E-4D89-A8A8-F87E643882A0@holtmann.org>
References: <CAAJw_ZuK6SUy22R133CezsqoU4+dTzxmsipBAp7rCvYBo+zrxw@mail.gmail.com> <8BA7CD92-B061-41CE-BD43-7E1B7CD1DF6A@holtmann.org> <CAAJw_ZsCeWWoFvdm1Sid6xSDGawp8RaqP07TM1Q2CvSF8DxU=w@mail.gmail.com> <8940108C-6C27-49E3-80C8-8983F32D6F55@holtmann.org> <CAAJw_ZvrynW0W6fE21ieG+KUwWr_g7-9kDonKYT3ZoEi3Nntiw@mail.gmail.com>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeff,

>>> But on older bluez-5.21, the PSCAN and ISCAN are enabled automatically.
>> 
>> this is intentionally. Starting with BlueZ 5.23 and Linux 3.17, the Page Scan state is controlled by the kernel. If you have no devices paired / configured, then it will just disable Page Scan. If you do not know about devices, then there is also no point in allowing anybody to connect.
> 
>> You can use the management command Add Device to add BR/EDR devices. If you add at least one device, then Page Scan will be enabled automatically by the kernel. If you want to be always connectable, then you can set the device manually connectable.
>> 
>> Using bluetoothctl does exactly the right thing. For being discoverable, you need to be connectable and discoverable. So Page Scan and Inquiry Scan enabled. However if you do not have any paired devices and turn discoverable back off, then both will be disabled.
>> 
>> Just try it. Pair with a device and see that Page Scan gets turn on magically.
> 
> Marcel,
> 
> Excellent info that would have taken me a long time to find out!
> Thanks for sharing!
> 
> I tried  ...
> 
> # btmgmt add-device -t BR/EDR -a 1 F4:B7:E2:E9:54:68
> hci0:   Type: BR/EDR  Bus: USB
>        BD Address: F4:B7:E2:E9:54:68  ACL MTU: 1021:8  SCO MTU: 64:1
>        UP RUNNING PSCAN
> 
> I don't know what the actions are supposed to do, but "-a 1" works.

actually type should be 0 for BR/EDR public address. See doc/mgmt-api.txt for the details since btmgmt maps the management interface. In short action 1 means to allow incoming connections.

> Next I tried "connectable" but "info" still didn't show the
> connectable and hciconfig didn't show ISCAN.
> 
> # btmgmt connectable F4:B7:E2:E9:54:68
> hci0 Set Connectable complete, settings: powered bondable ssp br/edr le
> # btmgmt info
> hci0:   addr F4:B7:E2:E9:54:68 version 6 manufacturer 15 class 0x000000
>        supported settings: powered connectable fast-connectable
> discoverable bondable link-security ssp br/edr hs le advertising
> debug-keys privacy configuration
>        current settings: powered bondable ssp br/edr le

The syntax is connectable on/off. And it should reflect it. If not, then this might be a bug. Something for Johan to look into once he gets back from vacation. Or you fix it by yourself. But I am pretty sure it actually works if you use "on" as parameter.

> But if I use bluetoothctl "discoverable on", ISCAN showed up on hciconfig.

Yes, that is how it is suppose to work. The D-Bus version for discoverable (which bluetoothctl uses) will internally make sure to set connectable and discoverable. So PSCAN and ISCAN should be set.

> And one last thing ... if I put btmgmt in a script and run it right up
> hciconfig hci0 up, the command would not work. A minimum of "sleep 1"
> is required.
> 
> So, what's the best way to set the device to be always discoverable?
> And I need this because the "server" needs to be discoverable by the
> Intermec scanners. The scanner would scan a "server barcode" to
> connect to the server. And this was the default behavior on
> bluez-5.21.

Mixing btmgmt and hciconfig is not a good idea. hciconfig is for all style APIs and btmgmt is for new mgmt interfaces. For example bluetoothd only uses the mgmt interface. So my advice is to just run bluetoothd and then use the D-Bus command to make it discoverable. That will always work correctly and still is as you have seen by running bluetoothctl.

It is like this kernel -> mgmt -> bluetoothd -> D-Bus -> bluetoothctl. And you can replace bluetoothctl with a Python script or your own code.

Regards

Marcel

