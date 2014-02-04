Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Feb 2014 13:53:49 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] unit/avctp: Add connection establishment dummy tests
Message-ID: <20140204115347.GL2930@aemeltch-MOBL1>
References: <1391430198-26823-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391430198-26823-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Feb 03, 2014 at 02:23:18PM +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

ping

> 
> Add some tests checking that L2CAP connection is established, so they
> are basically dummy tests.
> ---
>  unit/test-avctp.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/unit/test-avctp.c b/unit/test-avctp.c
> index 041e0c0..c0d16a4 100644
> --- a/unit/test-avctp.c
> +++ b/unit/test-avctp.c
> @@ -220,10 +220,8 @@ static struct context *create_context(uint16_t version, gconstpointer data)
>  	return context;
>  }
>  
> -static void execute_context(struct context *context)
> +static void destroy_context(struct context *context)
>  {
> -	g_main_loop_run(context->main_loop);
> -
>  	if (context->source > 0)
>  		g_source_remove(context->source);
>  
> @@ -235,6 +233,13 @@ static void execute_context(struct context *context)
>  	g_free(context);
>  }
>  
> +static void execute_context(struct context *context)
> +{
> +	g_main_loop_run(context->main_loop);
> +
> +	destroy_context(context);
> +}
> +
>  static void test_client(gconstpointer data)
>  {
>  	struct context *context = create_context(0x0100, data);
> @@ -253,6 +258,13 @@ static void test_server(gconstpointer data)
>  	execute_context(context);
>  }
>  
> +static void test_dummy(gconstpointer data)
> +{
> +	struct context *context = create_context(0x0100, data);
> +
> +	destroy_context(context);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	g_test_init(&argc, &argv, NULL);
> @@ -260,6 +272,18 @@ int main(int argc, char *argv[])
>  	if (g_test_verbose())
>  		__btd_log_init("*", 0);
>  
> +	/* Connection Channel Management tests */
> +
> +	/*
> +	 * Tests are checking that IUT is able to request establishing
> +	 * channels, since we already have connection through socketpair
> +	 * the tests are dummy.
> +	 */
> +	define_test("/TP/CCM/BV-01-C", test_dummy, raw_pdu(0x00));
> +	define_test("/TP/CCM/BV-02-C", test_dummy, raw_pdu(0x00));
> +	define_test("/TP/CCM/BV-03-C", test_dummy, raw_pdu(0x00));
> +	define_test("/TP/CCM/BV-04-C", test_dummy, raw_pdu(0x00));
> +
>  	define_test("/TP/NFR/BV-01-C", test_client,
>  				raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x00, 0x00));
>  
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
