Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2063314.tMJNTMrmhB@uw000953>
References: <1406882733-6064-1-git-send-email-lukasz.rymanowski@tieto.com>
	<2063314.tMJNTMrmhB@uw000953>
Date: Fri, 1 Aug 2014 15:32:13 +0200
Message-ID: <CAMudyAu+V=yrMzUJk98HeMfC7Mq5x0tSPxBgDzOc6O4VKV=VRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] android/gatt: Make usage of kernel auto connect feat.
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 1 August 2014 15:19, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Łukasz,
>
> On Friday 01 of August 2014 10:45:27 Lukasz Rymanowski wrote:
>> Following patches add support to BfA to use kernel auto connect list
>> when mgmt interface is 1.7 or highier.
>>
>> Tested on PC with latest kernel.
>>
>> v2: Fix in Patch 5/6. Forgot one if check
>>
>> Lukasz Rymanowski (6):
>>   android/bluetooth: Add flag for kernel connection control
>>   android/bluetooth: Add API to add device to auto connect list
>>   android/bluetooth: Add API to remove device from auto connect list
>>   android/gatt: Refactor trigger connection function.
>>   android/gatt: Use kernel auto connect feature if possible
>>   android/bluetooth: Clear auto connect list on startup
>>
>>  android/bluetooth.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  android/bluetooth.h | 10 ++++++
>>  android/gatt.c      | 70 ++++++++++++++++++++++++++++++---------
>>  android/main.c      |  4 +++
>>  4 files changed, 163 insertions(+), 15 deletions(-)
>>
>
> This looks all good to me but it doesn't apply:
>
> Applying: android/bluetooth: Add flag for kernel connection control
> /home/janccszy/devel/bluez_korg/.git/rebase-apply/patch:45: new blank line at EOF.
> +
> fatal: 1 line adds whitespace errors.
>
> Please fix whitespace issues and resend.
>

Fixed in V3.

> --
> Best regards,
> Szymon Janc

BR
Lukasz
