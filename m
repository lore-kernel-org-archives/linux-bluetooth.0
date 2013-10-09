Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E4E245F7-8EE6-4FE2-AC99-3246F1541C99@holtmann.org>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-2-git-send-email-Andrei.Emeltchenko.news@gmail.com> <E4E245F7-8EE6-4FE2-AC99-3246F1541C99@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 9 Oct 2013 19:55:01 -0300
Message-ID: <CAMOw1v4Vj9w6CceuaKH0xoNFq9_ps+11+MACqYzAmU+f6naOKg@mail.gmail.com>
Subject: Re: [PATCHv3 01/15] android: Supress missing initializers warnings
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 9, 2013 at 4:11 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andrei,
>
>> These types of warnings are disabled in BlueZ makeifiles
>>
>> main.c:67:2: warning: missing initializer [-Wmissing-field-initializers]
>> main.c:67:2: warning: (near initialization for 'options[1].short_name')
>>       [-Wmissing-field-initializers]
>> ---
>> android/Android.mk |    3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/android/Android.mk b/android/Android.mk
>> index ec820ac..5498b41 100644
>> --- a/android/Android.mk
>> +++ b/android/Android.mk
>> @@ -23,6 +23,9 @@ LOCAL_C_INCLUDES := \
>>
>> LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
>>
>> +# to suppress the "warning: missing initializer near initialization.." warning
>> +LOCAL_CFLAGS += -Wno-missing-field-initializers
>> +
>
> why are we doing this and not fixing the actual warning?

I guess because this is a stupid warning.

We do the same in autotools because otherwise we can't initialize
structs and rely on compiler setting the rest to 0. This is
particularly annoying on d-bus tables (see the exists and flags on the
end of the GDBusPropertyTable struct). I'm sure it's annoying in other
places, too.


Lucas De Marchi
