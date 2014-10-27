Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABD6X-+fR5tjmATzaiTfSORaubN=C8hPTLK3BALzsQsUjT4pXA@mail.gmail.com>
References: <1414418485-20786-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CABD6X-+fR5tjmATzaiTfSORaubN=C8hPTLK3BALzsQsUjT4pXA@mail.gmail.com>
Date: Mon, 27 Oct 2014 07:41:07 -0700
Message-ID: <CAHrH25RjgwrxrXgi02GD=EzxAakfibNHn8rBzYpFKysGE7BycA@mail.gmail.com>
Subject: Re: [RFC] gatt: Fix wrong function exit
From: Arman Uguray <armansito@chromium.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Mon, Oct 27, 2014 at 7:14 AM, Marcin Kraglak
<marcin.kraglak@tieto.com> wrote:
> Hi Andrei,
>
> On 27 October 2014 15:01, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
>> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>>
>> ---
>>  src/shared/gatt-helpers.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
>> index d751d5a..4f53de3 100644
>> --- a/src/shared/gatt-helpers.c
>> +++ b/src/shared/gatt-helpers.c
>> @@ -1029,7 +1029,7 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
>>                 data = new_read_included(cur_result);
>>                 if (!data) {
>>                         success = false;
>> -                       goto done;
>> +                       goto failed;
>>                 }
>>
>>                 read_included(data);
>> --
>> 1.9.1
> In fact exit here is wrong and should be goto failed.
> Anyway, I found that we call goto failed more times in this function
> than goto done, so maybe it is better to change labels like this:
> failed:
>     success = false;
>
> done:
>     if (op->callback)
>         op->callback(success, att_ecode, final_result, op->user_data);
>
> and set success = true before goto done;
>

Might actually be better leave the current structure as it is, except
initialize success = false at declaration. Then code would simply call
goto fail and not set success to false every time.

-Arman
