Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix extra PropertyChanged signal sent after
 DeviceRemoved
From: Marcel Holtmann <marcel@holtmann.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <f9d4bd30909221431p33970fe8weab8c440b3d35edf@mail.gmail.com>
References: <f9d4bd30909221431p33970fe8weab8c440b3d35edf@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 22 Sep 2009 14:54:30 -0700
Message-Id: <1253656470.2931.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

> for paired devices, there is an extra PropertyChanged signal sent
> after DeviceRemoved:
> 
> signal sender=:1.78 -> dest=(null destination) serial=145
> path=/org/bluez/24533/hci0; interface=org.bluez.Adapter;
> member=PropertyChanged
>    string "Devices"
>    variant       array [
>       ]
> signal sender=:1.78 -> dest=(null destination) serial=146
> path=/org/bluez/24533/hci0; interface=org.bluez.Adapter;
> member=DeviceRemoved
>    object path "/org/bluez/24533/hci0/dev_00_1F_00_CE_BE_AF"
> signal sender=:1.78 -> dest=(null destination) serial=147
> path=/org/bluez/24533/hci0/dev_00_1F_00_CE_BE_AF;
> interface=org.bluez.Device; member=PropertyChanged
>    string "Paired"
>    variant       boolean false
> 
> 
> The patch to fix this issue is in my branch devel:
> 
> git://git.infradead.org/users/cktakahasi/bluez.git devel

patch has been applied. Thanks.

> I removed  "textfile_caseget()" call before call "textfile_casedel()",
> let me know if you wanna keep this check, I can revert this minor
> change.

I can't remember why it is there. Johan might know and we can revert it
then later if I missed the reason.

Regards

Marcel


