Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E6E2219B-6B0E-435F-AA12-4194885D0691@holtmann.org>
References: <1393835812-24238-1-git-send-email-marcin.kraglak@tieto.com>
	<1393835812-24238-7-git-send-email-marcin.kraglak@tieto.com>
	<E6E2219B-6B0E-435F-AA12-4194885D0691@holtmann.org>
Date: Tue, 4 Mar 2014 08:16:04 +0100
Message-ID: <CABD6X-+-pUjd36JQ_wb+LKQWimB4_TwL+aqk7koZkiLz_k5FaA@mail.gmail.com>
Subject: Re: [PATCH 7/7] Add /hfp/test_hfp_gw_register_3 and /hfp/test_hfp_gw_register_4
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 3 March 2014 16:23, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Marcin,
>
>> unit/test-hfp.c | 31 +++++++++++++++++++++++++++++++
>> 1 file changed, 31 insertions(+)
>>
>> diff --git a/unit/test-hfp.c b/unit/test-hfp.c
>> index 5e4fc11..64ecc60 100644
>> --- a/unit/test-hfp.c
>> +++ b/unit/test-hfp.c
>> @@ -266,6 +266,33 @@ static const struct test_data test_register_2 = {
>>       .prefix = prefix_brsf
>> };
>>
>> +static const char atbrsf_read[] = {'A', 'T', '+', 'B', 'R', 'S', 'F', '?',
>> +                                                                     '\r'};
>> +
>
>         = "AT+BRSF?\r";
>
>> +static const struct test_data test_register_3 = {
>> +     .command_cb = cmd_handler,
>> +     .server_send = atbrsf_read,
>> +     .data_len = sizeof(atbrsf_read),
>> +     .expected_rsp = err_rsp,
>> +     .expected_rsp_len = sizeof(err_rsp),
>> +     .result_cb = prefix_handler,
>> +     .expected_cmd_type = HFP_GW_CMD_TYPE_READ,
>> +     .prefix = prefix_brsf
>> +};
>> +
>> +static const char prefix_d[] = "D";
>
> I wonder why here it is acceptable and above you are making the huge effort to give every character separately.
>
> Regards
>
> Marcel
>

I thought it will be more readable if raw data passed to socket will
be declared as array, not string. Prefixes are passed as strings,
because they are used in hfp_gw_register()  Anyway Luiz suggested to
use common framework for this test like raw_pdu(args...) ,
define_test(name, function, args...), (it is used in test-avctp and
test-avrcp). Will it look better for you?

BR
Marcin
