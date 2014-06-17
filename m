Return-Path: <cyrus@holtmann.org>
From: Vikrampal <vikram.pal@samsung.com>
To: 'Andrei Emeltchenko' <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <014f01cf8a1f$6b1c74c0$41555e40$@samsung.com>
 <20140617114548.GB621@aemeltch-MOBL1>
In-reply-to: <20140617114548.GB621@aemeltch-MOBL1>
Subject: RE: Android AOSP source tree downloading fails
Date: Tue, 17 Jun 2014 18:11:29 +0530
Message-id: <015801cf8a29$8660b250$932216f0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>-----Original Message-----
>From: Andrei Emeltchenko [mailto:andrei.emeltchenko.news@gmail.com] 
>Sent: Tuesday, June 17, 2014 5:16 PM
>To: Vikrampal
>Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
>Subject: Re: Android AOSP source tree downloading fails
>
>Hi Vikram,
>
>On Tue, Jun 17, 2014 at 04:59:28PM +0530, Vikrampal wrote:
>> Hi,
>> 
>> I'm trying to download full Android AOSP source tree. I tried 2 methods:
>> 1) repo init -u https://code.google.com/p/aosp-bluez.platform-manifest 
>> -b kitkat
>>      repo sync
>> error: Exited sync due to fetch errors
>
>Which project it cannot fetch?
>
>Best regards
>Andrei Emeltchenko 

platform/packages/apps/PackageInstaller

Regards,
Vikram

>> 
>> 2) git clone https://code.google.com/p/aosp-bluez.platform-manifest
>> Warning: remote HEAD refers to nonexistent ref, unable to checkout
>> 
>> Both the above methods failed.
>> 
>> Please help me in downloading it. Thanks!
>>
>> Regards,
>> Vikram
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-bluetooth" in the body of a message to majordomo@vger.kernel.org 
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

