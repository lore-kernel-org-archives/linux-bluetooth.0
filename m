Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAAngNMZn-XqrmOjErhkUqfSKqg2WhdfgDCs-DtZkAyNtBX7XRg@mail.gmail.com>
References: <cover.1344952391.git.jesse.sung@canonical.com>
	<CAAngNMZn-XqrmOjErhkUqfSKqg2WhdfgDCs-DtZkAyNtBX7XRg@mail.gmail.com>
Date: Wed, 15 Aug 2012 09:14:10 +0800
Message-ID: <CAH10aOgwzxB-bKMrcb0cTgAd_2VZcGAC_0pCKw4r7Hz5DUdy_w@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/2] broadcom patchram firmware loader
From: Jesse Sung <jesse.sung@canonical.com>
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao,

Thanks for your reply. I'll send these patches again and make them inline.

Regards,
Jesse

2012/8/15 Joao Paulo Rechi Vita <jprvita@openbossa.org>:
> Hello Jesse,
>
> On Tue, Aug 14, 2012 at 11:24 AM, Jesse Sung <jesse.sung@canonical.com> wrote:
>>
>> There is a user space firmware loading tool which can be found at
>> http://article.gmane.org/gmane.linux.bluez.kernel/17932
>>
>> This tool requires hci device to do the firmware loading, but this
>> may cause some race condition between patchram tool and bluetoothd
>> or something that also works on hci interface.
>>
>> Also it needs some hooks to make firmware loads after bootup, s3,
>> s4, rfkill, and device hotplug events. Implement this loader in kernel
>> module would make things more easier.
>>
>>
>> Wen-chien Jesse Sung (2):
>>   Implement broadcom patchram firmware loader
>>   Cache firmware images for later use
>>
>
> Can you please re-send the patches inline? This way it's easier for
> people to comment on the mailing list and there is increased chance it
> gets merged sooner. 'git send-email' is the best way to do that.
>
> Thanks.
>
> --
> João Paulo Rechi Vita
> Openbossa Labs - INdT
