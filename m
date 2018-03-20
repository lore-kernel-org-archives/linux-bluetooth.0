Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOVXOEb9kzkYQP1YF5QMS2DBN=FWL0-PkENne8dOVcvbLFta2w@mail.gmail.com>
References: <20180320112749.GB21933@arthur-bzh> <CAOVXOEb9kzkYQP1YF5QMS2DBN=FWL0-PkENne8dOVcvbLFta2w@mail.gmail.com>
From: Michael Simon <michael.simon.at@gmail.com>
Date: Tue, 20 Mar 2018 12:53:53 +0100
Message-ID: <CAOVXOEaF4Y6+Yc17q8dACG1VZi4=KoB-RxKz7DAVR0AP-CtjOw@mail.gmail.com>
Subject: Re: issue since bluez 48 with ios pairing only
To: Arthur LAMBERT <lambertarthur22@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arthur,

we had the same issue, it was related to the new "Bluetooth LE Battery
service", when we built bluez without this module the problem was
gone.
I think the problem is that iPhones are advertising the battery
service but require pairing for it and this module tries to read the
services values as soon as the iPhone is connected.

Regards,
Michael

2018-03-20 12:53 GMT+01:00 Michael Simon <michael.simon.at@gmail.com>:
> Hi Arthur,
>
> we had the same issue, it was related to the new "Bluetooth LE Battery
> service", when we built bluez without this module the problem was gone.
> I think the problem is that iPhones are advertising the battery service but
> require pairing for it and this module tries to read the services values as
> soon as the iPhone is connected.
>
> Regards,
> Michael
>
>
> 2018-03-20 12:27 GMT+01:00 Arthur LAMBERT <lambertarthur22@gmail.com>:
>>
>> We used bluez in a firmware on a device used as peripheral with custom
>> services and characteristics.
>> We are able to connect to this device with ios/android mobile app
>> application and homemade linux client
>>
>> We have an issue since bluez 48 and also on bluez 49 concerning pairing
>> process with IOS.
>>
>> After the pairing process, a pop up appears on IOS :
>>
>> <<<<
>> Bluetooth Pairing Request
>> "XXXX" would like to pair with your Iphone
>>
>> Cancel       Pair
>> >>>>
>>
>> Before bluez 48, we did not see this pop up. Users have to click on Pair
>> button to finish
>> the pairing process; Then in IOS side, a Disconnect trigger in code is no
>> more able
>> to disconnect properly the device.
>>
>> Are we doing something wrong to get this issue on bluez 48 ?
>>
>> Current way to init our hci device :
>>
>> btmgmt -i hci0 power off
>> btmgmt -i hci0 le on
>> btmgmt -i hci0 connectable on
>> btmgmt -i hci0 bredr off
>> btmgmt -i hci0 name XXXX
>> btmgmt -i hci0 advertising on
>> btmgmt -i hci0 power on
>>
>> # btmgmt -i hci0 info
>> hci0:   Primary controller
>> addr XX:XX:XX:XX:XX:XX version 6 manufacturer 15 class 0x000000
>> supported settings: powered connectable fast-connectable discoverable
>> bondable link-security ssp br/edr hs le advertising secure-conn debug-keys
>> privacy static-addr
>> current settings: powered connectable bondable le advertising secure-conn
>> name TESTBENCH-V2
>> short name
>>
>> I tried to play with other settings with btmgmt without be able to fix our
>> issue.
>>
>> Thanks,
>> Arthur.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
