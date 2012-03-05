Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330903638.3392.141.camel@aeonflux>
References: <1326708715.3360.135.camel@pohly-mobl1.fritz.box> <1330903638.3392.141.camel@aeonflux>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 5 Mar 2012 17:06:18 -0300
Message-ID: <CAMOw1v5mcoDbBo_yotfci6o+zak+9OjhTKUm134zj2YGHGVssQ@mail.gmail.com>
Subject: Re: [PATCH] bluetooth.h: fix compile issue when using in C++
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Patrick Ohly <patrick.ohly@intel.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Mar 4, 2012 at 8:27 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Patrick,
>
>> The compiler error is:
>> =C2=A0/usr/include/bluetooth/bluetooth.h::131:9:=E2=80=82error:=E2=80=82=
invalid=E2=80=82conversion from=E2=80=82'void*'=E2=80=82to=E2=80=82'bt_get_=
le64(void*)::<anonymous=E2=80=82struct>*'
>> =C2=A0...
>>
>> The reason is that C++, in contrast to C, does not allow conversion of
>> void * to anything, and this code gets compiled as C++ when the app is
>> written in C++. The macro with the assignment itself is older, but only
>> recent Bluez starts to use it in inline functions, thus triggering the
>> problem.
>>
>> This patch keeps the "struct __attribute__((packed))" magic and merely
>> changes the typecast so that it works in C and C++. Like the existing
>> macro this patch relies on support for typeof.
>
> so I am applying this patch now, but I still have no idea what kind of
> stupid C++ compiler you are using. The section of this include is
> clearly marked as C code:
>
> #ifdef __cplusplus
> extern "C" {
> #endif

This only tells the compiler that this part has C linkage and not C++


Lucas De Marchi
