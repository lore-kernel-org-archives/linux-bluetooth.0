Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Feb 2014 13:12:04 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] unit/avctp: Use pre-defined values instead of magic
 numbers
Message-ID: <20140211111202.GC8980@aemeltch-MOBL1>
References: <1391614102-21639-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391614102-21639-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Wed, Feb 05, 2014 at 05:28:21PM +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  unit/test-avctp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/unit/test-avctp.c b/unit/test-avctp.c
> index 581f88c..9d94ae0 100644
> --- a/unit/test-avctp.c
> +++ b/unit/test-avctp.c
> @@ -277,8 +277,8 @@ static void test_client(gconstpointer data)
>  {
>  	struct context *context = create_context(0x0100, data);
>  
> -	avctp_send_vendordep_req(context->session, 0, 0, NULL, 0,
> -						handler_response, context);
> +	avctp_send_vendordep_req(context->session, AVC_CTYPE_CONTROL, 0, NULL,
> +						0, handler_response, context);
>  
>  	execute_context(context);
>  }
> @@ -290,8 +290,8 @@ static void test_server(gconstpointer data)
>  	if (g_str_equal(context->data->test_name, "/TP/NFR/BV-03-C")) {
>  		int ret;
>  
> -		ret = avctp_register_pdu_handler(context->session, 0x00,
> -								handler, NULL);
> +		ret = avctp_register_pdu_handler(context->session,
> +					AVC_OP_VENDORDEP, handler, NULL);
>  		DBG("ret %d", ret);
>  		g_assert_cmpint(ret, !=, 0);
>  	}
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
