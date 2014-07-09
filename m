Return-Path: <cyrus@holtmann.org>
Message-ID: <53BD2BBD.1010105@ahsoftware.de>
Date: Wed, 09 Jul 2014 13:47:09 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Peng Chen <pengchen@qti.qualcomm.com>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 kumo@qca.qualcomm.com, taowang@qti.qualcomm.com
Subject: Re: [PATCH] Add a new PID/VID 0cf3/e005 for AR3012.
References: <1377853792-17589-1-git-send-email-pengchen@qca.qualcomm.com> <53A40687.80004@ahsoftware.de> <850D59CB-8032-4095-AB96-61920042DC55@holtmann.org> <53BB9E5F.9020101@ahsoftware.de> <D0167450-1E5D-49A1-8D49-6D6AC528C463@holtmann.org> <53BBCCA3.9040706@ahsoftware.de> <53BD1DF2.7060607@ahsoftware.de> <C918BC93-1EBD-4136-A4CC-DDEDE45AE441@holtmann.org> <53BD25AC.3000401@ahsoftware.de>
In-Reply-To: <53BD25AC.3000401@ahsoftware.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Am 09.07.2014 13:21, schrieb Alexander Holler:
> Am 09.07.2014 13:05, schrieb Marcel Holtmann:
>> Hi Alexander,
>>
>>>>>>>> which is wrong and disables the ath3k driver.
>>>>>>>
>>>>>>> I reverted the broken patch in bluetooth.git now and marked it for
>>>>>>> 3.15 stable.
>>>>>>
>>>>>> Must got missed, it's not in 3.15.4 nor in 3.15.5.
>>>>>>
>>>>>> As my solution was a revert too, I can offer a Tested-By, if such is
>>>>>> needed, at least in regard to the point that ath3k-dongles will work
>>>>>> again after reverting ca58e5.
>>>>>
>>>>> it is in net tree, but not in 3.16-rcX yet. Only after it got into
>>>>> Linus' tree it can be backported to stable tree.
>>>>
>>>> Ah, the funny maze of linux kernel repos. ;)
>>>
>>> That lead me to the idea to rename bluetooth-next to
>>> bluetooth-ubernext because that what be more appropriate if
>>> bluetooth-next ends up in net-next or linux-next or
>>> something-else-next. ;)
>>
>> it goes bluetooth-next -> linux-next
>>       `- wireless-next -> net-next -> linux
>
> Oh, so ubernext would be an understatement.
>
> That makes up for some interesting stats about timing.
>
> If I assume every one of those next repos do use just a 2 week testing
> period before forwarding patches, I end up with 2 + 2 + 2 + 2 weeks.
>
> And if every one of these trees do use one month, this would be 4 month
> until a patch ends up in mainline where it resides another 3 month until
> it reaches people.

And if we look at the patch about which revert we are currently talking 
about, it's more like 2 + 2 + 2 + 2 months + 3 months in mainline-rc, 
because the patch (see subject) was posted 2013-08-30 and became visible 
on 2014-06-08 (with 3.15).

Quiet interesting.

Regards,

Alexander Holler
