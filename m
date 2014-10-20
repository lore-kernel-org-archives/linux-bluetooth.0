Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8BA7CD92-B061-41CE-BD43-7E1B7CD1DF6A@holtmann.org>
References: <CAAJw_ZuK6SUy22R133CezsqoU4+dTzxmsipBAp7rCvYBo+zrxw@mail.gmail.com>
	<8BA7CD92-B061-41CE-BD43-7E1B7CD1DF6A@holtmann.org>
Date: Mon, 20 Oct 2014 23:23:32 +0800
Message-ID: <CAAJw_ZsCeWWoFvdm1Sid6xSDGawp8RaqP07TM1Q2CvSF8DxU=w@mail.gmail.com>
Subject: Re: how to set PSCAN mode in .conf?
From: Jeff Chua <jeff.chua.linux@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 20, 2014 at 9:27 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jeff,
>
>> latest bluez doesn't read hcid.conf, so how can I enable "pscan" in
>> the conf file?
>>
>> I know "hciconfig hci0 pscan" works, but I would still like to set
>> that via the .conf file.
>
> the mgmt interface has a connectable option and with BlueZ 5 that will be enabled by default for < 3.17 kernel. With >= 3.17 kernels the kernel automatically enables it based on our BR/EDR device list.

Marcel,

I'm on Linux 3.18-rc1, bluez git
(a848ceb0721d9e405f9326441b1958e289c6e81f) and it's not enabling PSCAN
by default. I have to manually enable it via "hciconfig hci0 pscan" or
"bluetoothctl" (discoverable on).

Something broken? Or something I didn't configure properly?

I've tried two devices ...

T:  Bus=03 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#= 23 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=21e6 Rev= 1.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM20702A0
S:  SerialNumber=F4B7E2E95468

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a12 ProdID=0001 Rev=31.64
C:* #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=  0mA


But on older bluez-5.21, the PSCAN and ISCAN are enabled automatically.

Thanks,
Jeff
