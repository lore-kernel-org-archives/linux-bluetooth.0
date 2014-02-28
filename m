Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6C75B4EB-5878-4EFB-AEBD-E1FE7BC7B7BF@holtmann.org>
References: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com>
	<1393494006-20363-5-git-send-email-marcin.kraglak@tieto.com>
	<6C75B4EB-5878-4EFB-AEBD-E1FE7BC7B7BF@holtmann.org>
Date: Fri, 28 Feb 2014 08:46:15 +0100
Message-ID: <CABD6X-LTN=JCnUV00wfQCViGq3Wo-QwAF=XBj1=K81fZz8YAhQ@mail.gmail.com>
Subject: Re: [PATCHv2 4/8] shared/hfp: Add implementation of precessing commands
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 28 February 2014 08:13, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Marcin,
>
>> It will process both extended and basic commands.
>> ---
>> src/shared/hfp.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>> 1 file changed, 94 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
>> index cf54a8f..6a39a36 100644
>> --- a/src/shared/hfp.c
>> +++ b/src/shared/hfp.c
>> @@ -29,6 +29,7 @@
>> #include <unistd.h>
>> #include <string.h>
>> #include <stdarg.h>
>> +#include <ctype.h>
>>
>> #include "src/shared/util.h"
>> #include "src/shared/ringbuf.h"
>> @@ -135,14 +136,105 @@ static void wakeup_writer(struct hfp_gw *hfp)
>>       hfp->writer_active = true;
>> }
>>
>> +static enum hfp_cmd_type get_cmd_type(struct hfp_gw_result *result)
>> +{
>> +     if (result->data[result->offset] == '=') {
>> +             result->offset++;
>> +             if (result->data[result->offset] == '?') {
>> +                     result->offset++;
>> +                     return HFP_AT_TEST;
>> +             } else {
>> +                     return HFP_AT_SET;
>> +             }
>
> can we please keep the kernel coding style out of user space. And I hate it when both if parts use return.
>
>         if (blah) {
>                 xxxx
>                 return x;
>         }
>
>         return y.
>
>> +     } else if (result->data[result->offset] == '?') {
>
> And this else if is pointless as well. You are leaving the function in the first if part no matter what.
>
>> +             result->offset++;
>> +             return HFP_AT_READ;
>> +     } else {
>> +             return HFP_AT_COMMAND;
>> +     }
>
> Same here.
>
>> +}
>> +
>> static bool process_basic(struct hfp_gw *hfp, struct hfp_gw_result *result)
>> {
>> -     return false;
>> +     const char *prefix = result->data + result->offset;
>> +     struct prefix_handler_data *handler;
>> +     enum hfp_cmd_type type;
>> +     char lookup_prefix[4];
>> +     uint8_t pref_len = 0;
>> +     int i;
>> +
>> +     /* Check if first sign is character */
>> +     if (isalpha(prefix[pref_len])) {
>> +             /* Handle S-parameter prefix */
>> +             if (toupper(prefix[pref_len]) == 'S') {
>> +                     do {
>> +                             pref_len++;
>> +                     } while (isdigit(prefix[pref_len]));
>> +                     /*S-parameter must be followed with number*/
>> +                     if (pref_len == 1)
>> +                             pref_len--;
>
> Where is the S parameter stuff coming from? I did ask this before and never got an answer to it.

V.250 5.3.2 S-parameters. If it is not used in HFP I can remove it. It
was added just to be compatibile with V.250 spec.
>
> Regards
>
> Marcel
>
BR
Marcin
