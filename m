Return-Path: <cyrus@holtmann.org>
Message-ID: <1357672215.1806.32.camel@aeonflux>
Subject: Re: [PATCH BlueZ 1/2] unit: Add initial tests for sdp_extract_attr()
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 08 Jan 2013 11:10:15 -0800
In-Reply-To: <1357670608-19081-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357670608-19081-1-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> These tests do not use the full SDP PDU building code because they try
> to catch errors on SDP "extraction" code, which may not appear on a
> response PDU (but still cause hard to find bugs).
> ---
>  unit/test-sdp.c |   27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/unit/test-sdp.c b/unit/test-sdp.c
> index 315a5cd..61449aa 100644
> --- a/unit/test-sdp.c
> +++ b/unit/test-sdp.c
> @@ -754,6 +754,31 @@ static void test_sdp(gconstpointer data)
>  	g_free(test->pdu_list);
>  }
>  
> +static void test_sdp_extract_attr(void)
> +{
> +	const struct sdp_pdu pdus[] = {
> +		raw_pdu(SDP_DATA_NIL),
> +		raw_pdu(SDP_TEXT_STR8, 0x04, 'A', 'B', 'C', 'D'),
> +		raw_pdu(SDP_TEXT_STR16, 0x00, 0x04, 'A', 'B', 'C', 'D'),
> +		{ },
> +	};
> +	int i;
> +
> +	for (i = 0; pdus[i].valid; i++) {
> +		sdp_data_t *d;
> +		int size = 0;
> +
> +		if (g_test_verbose() == TRUE)
> +			g_print("dtd=0x%02x\n", *(char *) pdus[i].raw_data);
> +
> +		d = sdp_extract_attr(pdus[i].raw_data, pdus[i].raw_size, &size,
> +									NULL);
> +		g_assert(d != NULL);
> +		g_assert_cmpuint(size, ==, pdus[i].raw_size);
> +		sdp_data_free(d);
> +	}
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	g_test_init(&argc, &argv, NULL);
> @@ -2709,5 +2734,7 @@ int main(int argc, char *argv[])
>  			0x08, 0x09, 0x00, 0x01, 0x35, 0x03, 0x19, 0x11,
>  			0x06, 0x00));
>  
> +	g_test_add_func("/MISC/sdp_extract_attr", test_sdp_extract_attr);
> +

can we make this a bit more generic with a bit more details on what you
are testing.

Also having a separate test case for str8, str16 and also str32 of
course would be a good idea. Same for url8, url16 and url32. In addition
checking empty strings and really long strings is a good idea.
Especially long strings that match the max len size.

What I actually like to see is that we can specific element sequences in
raw and also what they are suppose to match. So we need to ensure that
we also extract the right string value and types. And not just the size.

Regards

Marcel


