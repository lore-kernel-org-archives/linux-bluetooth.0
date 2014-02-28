Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BA9EB144-665E-4A51-81EF-EEEFAB18C822@holtmann.org>
References: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com>
	<1393494006-20363-4-git-send-email-marcin.kraglak@tieto.com>
	<BA9EB144-665E-4A51-81EF-EEEFAB18C822@holtmann.org>
Date: Fri, 28 Feb 2014 08:37:33 +0100
Message-ID: <CABD6X-Jkn4mVNMngjbRzKW-yNviBMg-z2=RDmajyQ4ZLY9iP3A@mail.gmail.com>
Subject: Re: [PATCHv2 3/8] shared/hfp: Add initial implementiation of
 processing commands
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 28 February 2014 08:05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Marcin,
>
>> ---
>> src/shared/hfp.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>> 1 file changed, 51 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
>> index e164dd6..cf54a8f 100644
>> --- a/src/shared/hfp.c
>> +++ b/src/shared/hfp.c
>> @@ -69,6 +69,11 @@ struct prefix_handler_data {
>>       hfp_result_func_t callback;
>> };
>>
>> +struct hfp_gw_result {
>> +     const char *data;
>> +     int offset;
>> +};
>> +
>> static void destroy_prefix_handler_data(void *data)
>> {
>>       struct prefix_handler_data *handler = data;
>> @@ -130,6 +135,46 @@ static void wakeup_writer(struct hfp_gw *hfp)
>>       hfp->writer_active = true;
>> }
>>
>> +static bool process_basic(struct hfp_gw *hfp, struct hfp_gw_result *result)
>> +{
>> +     return false;
>> +}
>> +
>> +static bool process_extended(struct hfp_gw *hfp, struct hfp_gw_result *result)
>> +{
>> +     return false;
>> +}
>> +
>> +static void skip_whitespace(struct hfp_gw_result *result)
>> +{
>> +     while (result->data[result->offset] == ' ')
>> +             result->offset++;
>> +}
>> +
>> +static bool call_prefix_handler(struct hfp_gw *hfp, const char *data)
>> +{
>> +     struct hfp_gw_result result;
>> +
>> +     result.offset = 0;
>> +     result.data = data;
>> +
>> +     skip_whitespace(&result);
>
> I would just do the skip leading whitespace here without bothering putting it into a separate function. There is really no point.

I use this function later, in getters, therefore I introduced it here
>
>> +
>> +     if (strlen(data + result.offset) < 3)
>> +             return false;
>> +
>> +     if (strncmp(data + result.offset, "AT", 2))
>> +             if (strncmp(data + result.offset, "at", 2))
>> +                     return false;
>> +
>> +     result.offset += 2;
>> +
>> +     if (data[result.offset] == '+')
>> +             return process_extended(hfp, &result);
>> +     else
>> +             return process_basic(hfp, &result);
>
> Please do not do this. I mentioned this before, this basic vs extended is pointless.
>
> Command matching should be either based on commands like "D" or "+BRSF" and not bother trying to treat the + any special. See how src/emulator.c in oFono registers all the handlers.

Ok, I'll fix it
>
> Regards
>
> Marcel
>
BR
Marcin
