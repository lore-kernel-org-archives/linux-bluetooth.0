Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCHv3 01/15] android: Supress missing initializers warnings
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131010080657.GF23879@aemeltch-MOBL1>
Date: Thu, 10 Oct 2013 10:10:37 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <982246CD-1B58-457A-85C3-4EA584226E3C@holtmann.org>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-2-git-send-email-Andrei.Emeltchenko.news@gmail.com> <E4E245F7-8EE6-4FE2-AC99-3246F1541C99@holtmann.org> <20131010065825.GC23879@aemeltch-MOBL1> <7EFBFA1F-E02A-454D-B93E-1252D4288C87@holtmann.org> <20131010080657.GF23879@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>>>>> These types of warnings are disabled in BlueZ makeifiles
>>>>> 
>>>>> main.c:67:2: warning: missing initializer [-Wmissing-field-initializers]
>>>>> main.c:67:2: warning: (near initialization for 'options[1].short_name')
>>>>> 	[-Wmissing-field-initializers]
>>>>> ---
>>>>> android/Android.mk |    3 +++
>>>>> 1 file changed, 3 insertions(+)
>>>>> 
>>>>> diff --git a/android/Android.mk b/android/Android.mk
>>>>> index ec820ac..5498b41 100644
>>>>> --- a/android/Android.mk
>>>>> +++ b/android/Android.mk
>>>>> @@ -23,6 +23,9 @@ LOCAL_C_INCLUDES := \
>>>>> 
>>>>> LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
>>>>> 
>>>>> +# to suppress the "warning: missing initializer near initialization.." warning
>>>>> +LOCAL_CFLAGS += -Wno-missing-field-initializers
>>>>> +
>>>> 
>>>> why are we doing this and not fixing the actual warning?
>>>> 
>>> 
>>> Do you want me to initialize structures like
>>> 
>>> {NULL, NULL, NULL, ... }
>>> 
>>> this way it can be fixed.
>> 
>> that is ugly and gets really complicated in the code over time. So I prefer we do not do that.
>> 
>> Which structures does this affect. All of them?
> 
> You can just try following patch and see:
> 
> diff --git a/acinclude.m4 b/acinclude.m4
> index 5bfa29d..4d6a42c 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -15,7 +15,6 @@ AC_DEFUN([COMPILER_FLAGS], [
>        if (test "$USE_MAINTAINER_MODE" = "yes"); then
>                with_cflags="$with_cflags -Wall -Werror -Wextra"
>                with_cflags="$with_cflags -Wno-unused-parameter"
> -               with_cflags="$with_cflags -Wno-missing-field-initializers"
>                with_cflags="$with_cflags -Wdeclaration-after-statement"
>                with_cflags="$with_cflags -Wmissing-declarations"
>                with_cflags="$with_cflags -Wredundant-decls"

can we then have a global variable in Android.mk that lists all of our warning exceptions. Re-assigning them over and over again manually seems a rather bad idea.

Regards

Marcel

