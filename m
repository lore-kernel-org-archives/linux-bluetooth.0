Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_Oony+DPWh7R9kbXvj3=bOc=LgAeCaPqpqi4AE_sCusZg@mail.gmail.com>
References: <1343665491-16362-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1343665491-16362-3-git-send-email-lucas.demarchi@profusion.mobi> <CAJdJm_Oony+DPWh7R9kbXvj3=bOc=LgAeCaPqpqi4AE_sCusZg@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 30 Jul 2012 17:01:47 -0300
Message-ID: <CAMOw1v6yx6REGPWU-+4TBUqvgvhQdYheYr3LGf4=1q2ba0f-kw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] rfcomm: Fix typo in man page
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jul 30, 2012 at 1:59 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Lucas,
>
> On Mon, Jul 30, 2012 at 12:24 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> ---
>>  .gitignore     | 5 -----
>>  tools/rfcomm.1 | 2 +-
>>  2 files changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 38318cd..c9f293a 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -26,11 +26,6 @@ missing
>>  stamp-h1
>>  autom4te.cache
>>
>> -ylwrap
>> -lexer.c
>> -parser.h
>> -parser.c
>> -
>>  bluez.pc
>>  lib/bluetooth
>>  src/builtin.h
>
> The diff above is more appropriate for the previous patch.

Oops, wrong amend.

Thanks
Lucas De Marchi
