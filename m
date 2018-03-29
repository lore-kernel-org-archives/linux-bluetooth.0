Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANB6vTuaGyc1Jjok_TfKF7PU2ymviBFEd9y1V6nOT+TRw64zxQ@mail.gmail.com>
References: <CANB6vTuaGyc1Jjok_TfKF7PU2ymviBFEd9y1V6nOT+TRw64zxQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 29 Mar 2018 15:59:47 +0300
Message-ID: <CABBYNZ+qozuMQJuj5zqaF33rJLQLgNREZu6fToQCZ47zQZCMGQ@mail.gmail.com>
Subject: Re: BlueZ Peripheral & central Application
To: ken Clark <kenidevices@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ken,

On Thu, Mar 29, 2018 at 3:43 PM, ken Clark <kenidevices@gmail.com> wrote:
> We are attempting to create a BlueZ application for an embedded linux
> device that performs the following tasks:
>
> Advertises as a peripheral
> Declared a peripheral GATT database
> Accepts connections as a peripheral.
> Scans and connections to other peripherals as the central devices
>
> I've been working with the BlueZ code for a while now, and see all the
> pieces in various codebases, but I have failed in attempting to
> understand how the combine them.
>
> client/bluetoothclt  allows for setting advertising data
> It see options for declaring services & characteristics, but have no
> idea how and what order to use them in to successfully declare the
> gatt database.

I use something like the following on a daily basis:

> menu gatt
> register-service <uuid>
> register-characteristic <uuid> <permissions>
<repeat if there are more services>
> register-application
> back
> advertise on

If you have a second  controller you can use it as a central:

> select <address ctrl1>
> scan on
<wait until it show up, if it doesn't try setting transport filter
with scan.transport le>
> connect <address ctrl0>

> tools/btgatt-server allows for declaring the GATT Database and
> accepting connections as a peripheral.

btgatt-server is a standalone testing tool that will conflict with
bluetoothd, so better not to use if you do plan to use the D-Bus APIs.

>
> Can someone provide tips, examples or documentation on how to combine
> these functions into a single application.

bluetoothctl should have it all by now, if it doesn't then we need to
fix it so any feedback in this regard is welcome.

> Thanks
> Ken
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
