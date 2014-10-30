Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABD6X-LU8otVFRUiKoe-ppk2KGeQfym28VHFgdBEv22G-yuF-g@mail.gmail.com>
References: <1414624583-29236-1-git-send-email-lukasz.rymanowski@tieto.com>
	<CABD6X-LU8otVFRUiKoe-ppk2KGeQfym28VHFgdBEv22G-yuF-g@mail.gmail.com>
Date: Thu, 30 Oct 2014 16:09:55 +0100
Message-ID: <CAMudyAs4X9vmGmUYvp9TTj1_q7X7fqXS5+CH3GdDY8L=Y_rrXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] shared/hfp: Remove reduntant check
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin, Szymon,

On 30 October 2014 11:11, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> Hi Lukasz,
>
> On 30 October 2014 00:16, Lukasz Rymanowski <lukasz.rymanowski@tieto.com> wrote:
>> This check is not needed. Below memcmp check is sufficient
>> ---
>>  src/shared/hfp.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
>> index 22e9622..f5a812d 100644
>> --- a/src/shared/hfp.c
>> +++ b/src/shared/hfp.c
>> @@ -135,9 +135,6 @@ static bool match_handler_prefix(const void *a, const void *b)
>>         const struct cmd_handler *handler = a;
>>         const char *prefix = b;
>>
>> -       if (strlen(handler->prefix) != strlen(prefix))
>> -               return false;
>> -
>>         if (memcmp(handler->prefix, prefix, strlen(prefix)))
>>                 return false;
> it is incorrect in case prefix is sub-string of handler->prefix

strcmp will do the work here.

\Lukasz
>>
>> --
>> 1.8.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> BR
> Marcin
