Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6903600.aZEQEVyvJm@uw000953>
References: <1400689082-12662-1-git-send-email-andrzej.kaczmarek@tieto.com> <6903600.aZEQEVyvJm@uw000953>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Thu, 22 May 2014 09:59:31 +0200
Message-ID: <CAF3PWx1aM87OtE6v03616MTJ8ZrtmLvWTgyBr-bbKqg712oMYA@mail.gmail.com>
Subject: Re: [PATCH] android: Include headers from libhardware as system headers
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 22 May 2014 09:32, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Andrzej,
>
> On Wednesday 21 of May 2014 18:18:02 Andrzej Kaczmarek wrote:
>> Including hardware/audio.h in Android build produces sign-compare
>> warning due to nested include of cutils/bitops.h. Since we cannot avoid
>> this warning in sane way unless it's fixed in AOSP tree, we can make
>> GCC think this is a system header and suppress warnings.
>>
>> This patch changes the way headers from libhardware are added to
>> search path from LOCAL_C_INCLUDES to explicit "-isystem" option added
>> to LOCAL_CFLAGS.
>> ---
>>  android/Android.mk | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/android/Android.mk b/android/Android.mk
>> index 4235a7c..d3d94ed 100644
>> --- a/android/Android.mk
>> +++ b/android/Android.mk
>> @@ -121,12 +121,12 @@ LOCAL_SRC_FILES := \
>
> I'd rather fix this in AOSP instead of hacking this in our build system.

I agree, I pushed patch for this already:
https://android-review.googlesource.com/95341

BR,
Andrzej
