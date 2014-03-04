Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 7/7] Add /hfp/test_hfp_gw_register_3 and /hfp/test_hfp_gw_register_4
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABD6X-+-pUjd36JQ_wb+LKQWimB4_TwL+aqk7koZkiLz_k5FaA@mail.gmail.com>
Date: Tue, 4 Mar 2014 00:51:35 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <40496779-C0F9-45CC-8C2A-ECF72151C758@holtmann.org>
References: <1393835812-24238-1-git-send-email-marcin.kraglak@tieto.com> <1393835812-24238-7-git-send-email-marcin.kraglak@tieto.com> <E6E2219B-6B0E-435F-AA12-4194885D0691@holtmann.org> <CABD6X-+-pUjd36JQ_wb+LKQWimB4_TwL+aqk7koZkiLz_k5FaA@mail.gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

>>> unit/test-hfp.c | 31 +++++++++++++++++++++++++++++++
>>> 1 file changed, 31 insertions(+)
>>> 
>>> diff --git a/unit/test-hfp.c b/unit/test-hfp.c
>>> index 5e4fc11..64ecc60 100644
>>> --- a/unit/test-hfp.c
>>> +++ b/unit/test-hfp.c
>>> @@ -266,6 +266,33 @@ static const struct test_data test_register_2 = {
>>>      .prefix = prefix_brsf
>>> };
>>> 
>>> +static const char atbrsf_read[] = {'A', 'T', '+', 'B', 'R', 'S', 'F', '?',
>>> +                                                                     '\r'};
>>> +
>> 
>>        = "AT+BRSF?\r";
>> 
>>> +static const struct test_data test_register_3 = {
>>> +     .command_cb = cmd_handler,
>>> +     .server_send = atbrsf_read,
>>> +     .data_len = sizeof(atbrsf_read),
>>> +     .expected_rsp = err_rsp,
>>> +     .expected_rsp_len = sizeof(err_rsp),
>>> +     .result_cb = prefix_handler,
>>> +     .expected_cmd_type = HFP_GW_CMD_TYPE_READ,
>>> +     .prefix = prefix_brsf
>>> +};
>>> +
>>> +static const char prefix_d[] = "D";
>> 
>> I wonder why here it is acceptable and above you are making the huge effort to give every character separately.
> 
> I thought it will be more readable if raw data passed to socket will
> be declared as array, not string. Prefixes are passed as strings,
> because they are used in hfp_gw_register()  Anyway Luiz suggested to
> use common framework for this test like raw_pdu(args...) ,
> define_test(name, function, args...), (it is used in test-avctp and
> test-avrcp). Will it look better for you?

besides the ending \0, what is actually the difference? It is just wasted effort to put in strings in array from. Just call strlen() instead of sizeof() and you have what you need.

The raw_pdu approach might actually work nicely. Since what you really want is to send an AT command and get the right response back from the gateway. In that sense it is similar to what we do for SDP and AVRCP. Of course you need to have also a preamble for the whole SLC setup. And in addition you want to test the stream handling by for example sending an AT command one byte at a time.

Regards

Marcel

