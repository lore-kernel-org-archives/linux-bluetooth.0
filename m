Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <FBA29747-DEFB-4420-9010-A01792933120@holtmann.org>
References: <1393619636-23762-1-git-send-email-marcin.kraglak@tieto.com>
	<1393619636-23762-3-git-send-email-marcin.kraglak@tieto.com>
	<FBA29747-DEFB-4420-9010-A01792933120@holtmann.org>
Date: Sat, 1 Mar 2014 06:31:05 +0100
Message-ID: <CABD6X-LMR+1TE7XO7tGdzKkrmithaRsOOrv4Hx2C7k4wJzxnOw@mail.gmail.com>
Subject: Re: [PATCHv3 3/6] shared/hfp: Add get_number implementation
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 1 March 2014 04:27, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Marcin,
>
>> User can call this function with hfp_gw_result, which will
>> be passed to prefix handler.
>> ---
>> src/shared/hfp.c | 33 +++++++++++++++++++++++++++++++++
>> src/shared/hfp.h |  2 ++
>> 2 files changed, 35 insertions(+)
>>
>> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
>> index 8feaf16..d168ac4 100644
>> --- a/src/shared/hfp.c
>> +++ b/src/shared/hfp.c
>> @@ -218,6 +218,39 @@ done:
>>       return true;
>> }
>>
>> +static void next_field(struct hfp_gw_result *result)
>> +{
>> +     if (result->data[result->offset] == ',')
>> +             result->offset++;
>> +}
>> +
>> +bool hfp_gw_result_get_number(struct hfp_gw_result *result, int *val)
>> +{
>> +     int temp = 0;
>> +     int i;
>
>         int i, tmp = 0;
>
>> +
>> +     skip_whitespace(result);
>> +
>> +     i = result->offset;
>> +
>> +     while (result->data[i] >= '0' && result->data[i] <= '9') {
>> +             temp *= 10;
>> +             temp += result->data[i++] - '0';
>
>         tmp = (tmp * 10) + (result->data[i++] - '0';
>
> This should be the cheaper operation since tmp does not need be reevaluated twice.
>
> Are we going to support negative number? I do not even remember if they are valid in AT commands. Has been too long. Might also go straight to unsigned int *val in that case.
>
> Regards
>
> Marcel
>

ok, I'll change it to be cheaper,

In spec V.250 stays:

"Decimal numeric constants shall consist of a sequence of one or more
of the characters "0"
(IA5 3/0) through "9" (IA5 3/9), inclusive."

and

"No spaces, hyphens, periods, commas, parentheses, or other generally-
accepted numeric formatting characters are permitted in numeric constants;"

co i suppose that it shuouldn't be accepted

I'll send next version

BR
Marcin
