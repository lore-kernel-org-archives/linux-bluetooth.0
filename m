Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: how to set PSCAN mode in .conf?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAAJw_ZsCeWWoFvdm1Sid6xSDGawp8RaqP07TM1Q2CvSF8DxU=w@mail.gmail.com>
Date: Mon, 20 Oct 2014 17:59:40 +0200
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <8940108C-6C27-49E3-80C8-8983F32D6F55@holtmann.org>
References: <CAAJw_ZuK6SUy22R133CezsqoU4+dTzxmsipBAp7rCvYBo+zrxw@mail.gmail.com> <8BA7CD92-B061-41CE-BD43-7E1B7CD1DF6A@holtmann.org> <CAAJw_ZsCeWWoFvdm1Sid6xSDGawp8RaqP07TM1Q2CvSF8DxU=w@mail.gmail.com>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeff,

>>> latest bluez doesn't read hcid.conf, so how can I enable "pscan" in
>>> the conf file?
>>> 
>>> I know "hciconfig hci0 pscan" works, but I would still like to set
>>> that via the .conf file.
>> 
>> the mgmt interface has a connectable option and with BlueZ 5 that will be enabled by default for < 3.17 kernel. With >= 3.17 kernels the kernel automatically enables it based on our BR/EDR device list.
> 
> Marcel,
> 
> I'm on Linux 3.18-rc1, bluez git
> (a848ceb0721d9e405f9326441b1958e289c6e81f) and it's not enabling PSCAN
> by default. I have to manually enable it via "hciconfig hci0 pscan" or
> "bluetoothctl" (discoverable on).
> 
> Something broken? Or something I didn't configure properly?
> 
> I've tried two devices ...
> 
> T:  Bus=03 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#= 23 Spd=12   MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0a5c ProdID=21e6 Rev= 1.12
> S:  Manufacturer=Broadcom Corp
> S:  Product=BCM20702A0
> S:  SerialNumber=F4B7E2E95468
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0a12 ProdID=0001 Rev=31.64
> C:* #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=  0mA
> 
> 
> But on older bluez-5.21, the PSCAN and ISCAN are enabled automatically.

this is intentionally. Starting with BlueZ 5.23 and Linux 3.17, the Page Scan state is controlled by the kernel. If you have no devices paired / configured, then it will just disable Page Scan. If you do not know about devices, then there is also no point in allowing anybody to connect.

You can use the management command Add Device to add BR/EDR devices. If you add at least one device, then Page Scan will be enabled automatically by the kernel. If you want to be always connectable, then you can set the device manually connectable.

Using bluetoothctl does exactly the right thing. For being discoverable, you need to be connectable and discoverable. So Page Scan and Inquiry Scan enabled. However if you do not have any paired devices and turn discoverable back off, then both will be disabled.

Just try it. Pair with a device and see that Page Scan gets turn on magically.

Regards

Marcel

