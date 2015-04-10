Return-Path: <cyrus@holtmann.org>
Message-ID: <55280525.7040902@ahsoftware.de>
Date: Fri, 10 Apr 2015 19:15:17 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetoothd: add option to automatically power on the
 first adapter found
References: <1428685062-2911-1-git-send-email-holler@ahsoftware.de> <97E0530A-49BA-4776-BF4E-DF500F28116E@holtmann.org>
In-Reply-To: <97E0530A-49BA-4776-BF4E-DF500F28116E@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Am 10.04.2015 um 19:10 schrieb Marcel Holtmann:
> Hi Alexander,
>
>> You want this option if you're using e.g. a bt-keyboard as the only
>> input device. Other solutions to power on an adapter at startup are
>> either unreliable or too complicated.
>>
>> E.g. I had a
>>
>> 	sleep 4
>> 	echo 'power on' | bluetoothctl
>>
>> in some startup-script. And with an update of bluez from 5.23 to
>> 5.29 Murphy visited me and I had a box without a usable keyboard
>> because those 4 second haven't been enough anymore.
>
> I think you better have a special script with something like wait-for-adapter or something similar instead of trying to force policy into the daemon.

Sorry, this won't happen and as I'm already used to have to patch big 
parts of any Linux system which should be usable I don't care much if 
this patch ends up in bluez. ;)

> We took the power on policy out of BlueZ 5 on purpose.

Nobody has to use the option which is by default off.

Thanks for the fast response.

Regards,

Alexander Holler
