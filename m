Return-Path: <jeffy.chen@rock-chips.com>
Message-ID: <596DDB63.6010206@rock-chips.com>
Date: Tue, 18 Jul 2017 17:56:51 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Oliver Neukum <oneukum@suse.com>,
 Marcel Holtmann <marcel@holtmann.org>
CC: briannorris@chromium.org, dianders@chromium.org,
 Johan Hedberg <johan.hedberg@gmail.com>,
 xiyou.wangcong@gmail.com, "Gustavo F. Padovan" <gustavo@padovan.org>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] Bluetooth: btusb: Fix memory leak in play_deferred
References: <1500343579-9831-1-git-send-email-jeffy.chen@rock-chips.com>    <6E21F79E-93AA-4461-BA6B-67715501714F@holtmann.org>   <1500363015.16072.5.camel@suse.com> <596DC200.1080006@rock-chips.com>  <1500367310.502.0.camel@suse.com> <596DD6AE.2030704@rock-chips.com> <1500370901.502.6.camel@suse.com>
In-Reply-To: <1500370901.502.6.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

On 07/18/2017 05:41 PM, Oliver Neukum wrote:
> Am Dienstag, den 18.07.2017, 17:36 +0800 schrieb jeffy:
>> Hi Oliver,
>>
>> On 07/18/2017 04:41 PM, Oliver Neukum wrote:
>>>
>>> Am Dienstag, den 18.07.2017, 16:08 +0800 schrieb jeffy:
>>>>
>>>>>
>>>>> I am afraid not. We cannot silently drop one part of a transmission.
>>>>> I am afraid that the correct algorithm, if we encounter an error at
>>>>> that stage, is to abort the operation and report an error.
>>>>>
>>>> so i should break the loop when error happens right?
>>>
>>> Yes
>> ok, i'll do that.
>>>
>>>
>>>>
>>>>
>>>> and i uploaded 2 version of patches, which one do you prefer to go on?
>>>
>>> Where to?
>> https://patchwork.kernel.org/patch/9847037
>> and
>> https://patchwork.kernel.org/patch/9846617
>
> I think that as soon as one URB fails, you should not even try
> to submit any other deferred URBs. You are taking one out from
> the middle of a sequence. That cannot be right.
ok, that make sense.

new patch sent :)
>
> 	Regards
> 		Oliver
>
>
>
>
