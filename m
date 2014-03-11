Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] unit/test-hfp: Add ability to pass custom result handler to test
Date: Tue, 11 Mar 2014 21:10:37 +0100
Message-ID: <4202421.hBjjtnLv2I@athlon>
In-Reply-To: <1394493034-2417-1-git-send-email-szymon.janc@gmail.com>
References: <1394493034-2417-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 11 March 2014 00:10:28 Szymon Janc wrote:
> ---
>  unit/test-hfp.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/unit/test-hfp.c b/unit/test-hfp.c
> index 5218a2b..adc600b 100644
> --- a/unit/test-hfp.c
> +++ b/unit/test-hfp.c
> @@ -51,6 +51,7 @@ struct test_pdu {
>  struct test_data {
>  	char *test_name;
>  	struct test_pdu *pdu_list;
> +	hfp_result_func_t result_func;
>  };
> 
>  #define data(args...) ((const unsigned char[]) { args })
> @@ -83,7 +84,7 @@ struct test_data {
>  		.fragmented = true,				\
>  	}
> 
> -#define define_test(name, function, args...)				\
> +#define define_test(name, function, result_function, args...)		\
>  	do {								\
>  		const struct test_pdu pdus[] = {			\
>  			args, { }					\
> @@ -91,6 +92,7 @@ struct test_data {
>  		static struct test_data data;				\
>  		data.test_name = g_strdup(name);			\
>  		data.pdu_list = g_malloc(sizeof(pdus));			\
> +		data.result_func = result_function;			\
>  		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
>  		g_test_add_data_func(name, &data, function);		\
>  	} while (0)
> @@ -252,9 +254,11 @@ static void test_register(gconstpointer data)
>  	ret = hfp_gw_set_close_on_unref(context->hfp, true);
>  	g_assert(ret);
> 
> -	ret = hfp_gw_register(context->hfp, prefix_handler, (char *)pdu->data,
> -								context, NULL);
> -	g_assert(ret);
> +	if (context->data->result_func) {
> +		ret = hfp_gw_register(context->hfp, context->data->result_func,
> +					(char *)pdu->data, context, NULL);
> +		g_assert(ret);
> +	}
> 
>  	pdu = &context->data->pdu_list[context->pdu_offset++];
> 
> @@ -302,42 +306,42 @@ int main(int argc, char *argv[])
>  {
>  	g_test_init(&argc, &argv, NULL);
> 
> -	define_test("/hfp/test_init", test_init, data_end());
> -	define_test("/hfp/test_cmd_handler_1", test_command_handler,
> +	define_test("/hfp/test_init", test_init, NULL, data_end());
> +	define_test("/hfp/test_cmd_handler_1", test_command_handler, NULL,
>  			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F', '\r'),
>  			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F'),
>  			data_end());
> -	define_test("/hfp/test_cmd_handler_2", test_command_handler,
> +	define_test("/hfp/test_cmd_handler_2", test_command_handler, NULL,
>  			raw_pdu('A', 'T', 'D', '1', '2', '3', '4', '\r'),
>  			raw_pdu('A', 'T', 'D', '1', '2', '3', '4'),
>  			data_end());
> -	define_test("/hfp/test_register_1", test_register,
> +	define_test("/hfp/test_register_1", test_register, prefix_handler,
>  			raw_pdu('+', 'B', 'R', 'S', 'F', '\0'),
>  			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F', '\r'),
>  			type_pdu(HFP_GW_CMD_TYPE_COMMAND, 0),
>  			data_end());
> -	define_test("/hfp/test_register_2", test_register,
> +	define_test("/hfp/test_register_2", test_register, prefix_handler,
>  			raw_pdu('+', 'B', 'R', 'S', 'F', '\0'),
>  			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F', '=', '\r'),
>  			type_pdu(HFP_GW_CMD_TYPE_SET, 0),
>  			data_end());
> -	define_test("/hfp/test_register_3", test_register,
> +	define_test("/hfp/test_register_3", test_register, prefix_handler,
>  			raw_pdu('+', 'B', 'R', 'S', 'F', '\0'),
>  			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F', '?', '\r'),
>  			type_pdu(HFP_GW_CMD_TYPE_READ, 0),
>  			data_end());
> -	define_test("/hfp/test_register_4", test_register,
> +	define_test("/hfp/test_register_4", test_register, prefix_handler,
>  			raw_pdu('+', 'B', 'R', 'S', 'F', '\0'),
>  			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F', '=', '?',
>  									'\r'),
>  			type_pdu(HFP_GW_CMD_TYPE_TEST, 0),
>  			data_end());
> -	define_test("/hfp/test_register_5", test_register,
> +	define_test("/hfp/test_register_5", test_register, prefix_handler,
>  			raw_pdu('D', '\0'),
>  			raw_pdu('A', 'T', 'D', '1', '2', '3', '4', '5', '\r'),
>  			type_pdu(HFP_GW_CMD_TYPE_SET, 0),
>  			data_end());
> -	define_test("/hfp/test_fragmented_1", test_fragmented,
> +	define_test("/hfp/test_fragmented_1", test_fragmented, NULL,
>  			frg_pdu('A'), frg_pdu('T'), frg_pdu('+'), frg_pdu('B'),
>  			frg_pdu('R'), frg_pdu('S'), frg_pdu('F'), frg_pdu('\r'),
>  			data_end());

This is now upstream.

-- 
Szymon K. Janc
szymon.janc@gmail.com
