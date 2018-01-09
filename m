Return-Path: <austinpmorton@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4BDCCBFF-0E03-4C57-B107-6F7C65B5E7A2@holtmann.org>
References: <CAPWKHJSraT_wG9FDtarTXQuWN=1pymf5dMbmwdgz8EQp_JPaMg@mail.gmail.com>
 <4BDCCBFF-0E03-4C57-B107-6F7C65B5E7A2@holtmann.org>
From: Austin Morton <austinpmorton@gmail.com>
Date: Tue, 9 Jan 2018 10:44:56 -0500
Message-ID: <CAPWKHJQeE6FCy9=O9__EUbc8+OJKauCFq45CqLqnxP1PVdO+LA@mail.gmail.com>
Subject: Re: [PATCH] sbc: fix endian detection on arm-none-eabi
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

HI Marcel,

Its definitely something that is missing from my toolchain, not that
there are simply some includes missing.
I am using gcc-arm-none-eabi on windows -
https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads
I have checked 4.9.3, 6.3.1, and 7.2.1 - all are missing the define.
grepping the entire toolchain install prefix shows nothing for "__BYTE_ORDE=
R"

I don't know what the rational is, but they appear to use single
underscore in the header defines.
They are defined in machine/_endian.h which then gets included by
machine/endian.h

on 4.9.3 machine/endian.h is only included by sys/param.h
on 6.3.1 and 7.2.1 it is included by both sys/types.h and sys/param.h

Additionally, the compiler itself has built in precompiler definitions
for the following:
#define __ORDER_BIG_ENDIAN__ 4321
#define __ORDER_LITTLE_ENDIAN__ 1234

and one of the following:
#define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
#define __BYTE_ORDER__ __ORDER_BIG_ENDIAN__

This is documented for GCC here:
https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html
I am not sure how universal those defines are, and its likely there
are compilers other than GCC that don't define them.
Because of this I opted to insert additional checks rather than
replace the existing ones so I wouldn't break any currently working
environments.

Austin

On Tue, Jan 9, 2018 at 10:28 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Austin,
>
>> The gcc-arm-none-eabi toolchain defines its byte order constants with a =
single
>> preceding underscore rather than two.
>> Additionally, the macros do not get defined unless <sys/param.h> is incl=
uded.
>>
>> Signed-off-by: Austin Morton <austinpmorton@gmail.com>
>> ---
>> sbc/sbc.c | 13 +++++++++----
>> 1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/sbc/sbc.c b/sbc/sbc.c
>> index 606f11c..d3f5948 100644
>> --- a/sbc/sbc.c
>> +++ b/sbc/sbc.c
>> @@ -35,6 +35,7 @@
>> #include <stdlib.h>
>> #include <stdbool.h>
>> #include <sys/types.h>
>> +#include <sys/param.h>
>> #include <limits.h>
>>
>> #include "sbc_math.h"
>> @@ -70,7 +71,8 @@
>> #define A2DP_ALLOCATION_SNR (1 << 1)
>> #define A2DP_ALLOCATION_LOUDNESS (1 << 0)
>>
>> -#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
>> +#if (defined(__BYTE_ORDER) && __BYTE_ORDER =3D=3D __LITTLE_ENDIAN) || \
>> + (defined(_BYTE_ORDER) && _BYTE_ORDER =3D=3D _LITTLE_ENDIAN)
>
> while we can surely do this, I wonder why we need it. BlueZ is pretty old=
 and has used the same ifdef for a long time. If this breaks in your toolch=
ain, then it breaks in a lot of cases. So is this really the right fix or a=
re we just missing some includes.
>
> Regards
>
> Marcel
>
