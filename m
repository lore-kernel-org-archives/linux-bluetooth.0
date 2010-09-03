Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Sep 2010 21:19:37 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix clean-local target
Message-ID: <20100903191937.GA29821@pengutronix.de>
References: <1283513613-6860-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1283513613-6860-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Waldemar,

On Fri, Sep 03, 2010 at 01:33:33PM +0200, Waldemar Rymarkiewicz wrote:
> The fix avoids failure of the second consequent call of 'make clean'.
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
> ---
>  Makefile.am |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 5684e99..2fa03e1 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -385,5 +385,5 @@ lib/bluetooth/%.h: lib/%.h
>  	$(AM_V_at)$(MKDIR_P) lib/bluetooth
>  	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
>  
> -clean-local: lib/bluetooth
> -	@$(RM) -r $<
> +clean-local:
> +	$(RM) -r lib/bluetooth
> \ No newline at end of file
Is the missing newline at eof on purpose?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
