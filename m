Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <ACAC771F-74CD-40BF-BFB7-4CC92B588415@holtmann.org>
References: <1379323375-21540-1-git-send-email-luiz.dentz@gmail.com>
	<ACAC771F-74CD-40BF-BFB7-4CC92B588415@holtmann.org>
Date: Mon, 16 Sep 2013 17:43:07 +0300
Message-ID: <CABBYNZJ5uQ7a7TuEoG9pYy68QDgS0629AVNuBUFUpeE=rsg2KA@mail.gmail.com>
Subject: Re: [RFC SBC] build: Add configure option --disable-high-precision
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Sep 16, 2013 at 5:19 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> This enables high precision using 64 bits accumulators by default which
>> can be disabled with --disable-high-precision.
>> ---
>> configure.ac     | 8 ++++++++
>> sbc/sbc_tables.h | 2 --
>> 2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index c052616..5f994d1 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -58,4 +58,12 @@ if (test "${enable_tester}" != "no"); then
>> fi
>> AM_CONDITIONAL(TESTER, test "${enable_tester}" != "no")
>>
>> +AC_ARG_ENABLE(high-precision, AC_HELP_STRING([--disable-high-precision],
>> +                                     [disable high precision support]),
>> +                                     [enable_high_precision=${enableval}])
>> +if (test "${enable_high_precision}" != "no"); then
>> +     AC_DEFINE(SBC_HIGH_PRECISION, 1,
>> +             [Define to 1 to enable high precision build of SBC encoder])
>> +fi
>> +
>> AC_OUTPUT(Makefile sbc/sbc.pc)
>> diff --git a/sbc/sbc_tables.h b/sbc/sbc_tables.h
>> index 25e24e6..3fd80e1 100644
>> --- a/sbc/sbc_tables.h
>> +++ b/sbc/sbc_tables.h
>> @@ -136,8 +136,6 @@ static const int32_t synmatrix8[16][8] = {
>>         SN8(0xfb8e3130), SN8(0xf8275a10), SN8(0xfe70747c), SN8(0x06a6d988) }
>> };
>>
>> -/* Uncomment the following line to enable high precision build of SBC encoder */
>> -
>> /* #define SBC_HIGH_PRECISION */
>
> the comment with the define should also be removed.
>
> Is there any impact on using 64-bit integers compared to 32-bit integers. When would you use one or the other. I think this needs to be documented in README as well.

The use of 64-bit apparently makes the encoder 'better' in term of
dynamic range, but I will probably check with the tools that Siarhei
uses for testing the exact amount of 'better', the drawback is that
for 32-bits systems it might have an impact in performance so it is
good to keep --disable-high-precision and document it in the README as
you suggested.

Maybe this will be useful to kick start some unit tests for sbc as well.



-- 
Luiz Augusto von Dentz
