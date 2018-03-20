Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180320112749.GB21933@arthur-bzh>
References: <20180320112749.GB21933@arthur-bzh>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 20 Mar 2018 13:48:36 +0200
Message-ID: <CABBYNZJOmBZjPQitmnGbRe_Hi0BbcHKq_AF39bXNCvzGXO6TLg@mail.gmail.com>
Subject: Re: issue since bluez 48 with ios pairing only
To: Arthur LAMBERT <lambertarthur22@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arthur,

On Tue, Mar 20, 2018 at 1:27 PM, Arthur LAMBERT
<lambertarthur22@gmail.com> wrote:
> We used bluez in a firmware on a device used as peripheral with custom services and characteristics.
> We are able to connect to this device with ios/android mobile app application and homemade linux client
>
> We have an issue since bluez 48 and also on bluez 49 concerning pairing process with IOS.
>
> After the pairing process, a pop up appears on IOS :
>
> <<<<
> Bluetooth Pairing Request
> "XXXX" would like to pair with your Iphone
>
> Cancel       Pair
>>>>>
>
> Before bluez 48, we did not see this pop up. Users have to click on Pair button to finish
> the pairing process; Then in IOS side, a Disconnect trigger in code is no more able
> to disconnect properly the device.

Id expect a dialog to always be shown when pairing, are you sure this
was not some update on iOS side? I don't recall any change in this
regard since a long time, or perhaps this is because of agent
capabilities? What paring agent capabilities are you using? The
sentence about the Disconnect I could not comprehend, is iOS unable to
disconnect after pairing?

> Are we doing something wrong to get this issue on bluez 48 ?
>
> Current way to init our hci device :
>
> btmgmt -i hci0 power off
> btmgmt -i hci0 le on
> btmgmt -i hci0 connectable on
> btmgmt -i hci0 bredr off
> btmgmt -i hci0 name XXXX
> btmgmt -i hci0 advertising on
> btmgmt -i hci0 power on
>
> # btmgmt -i hci0 info
> hci0:   Primary controller
> addr XX:XX:XX:XX:XX:XX version 6 manufacturer 15 class 0x000000
> supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr hs le advertising secure-conn debug-keys privacy static-addr
> current settings: powered connectable bondable le advertising secure-conn
> name TESTBENCH-V2
> short name
>
> I tried to play with other settings with btmgmt without be able to fix our issue.

If you running with bluetoothd you should be using bluetoothctl
instead of btmgmt, and in case you are not using bluetoothd then the
BlueZ version don't really matter and what you should check is the
kernels changes.

-- 
Luiz Augusto von Dentz
