Return-Path: <cyrus@holtmann.org>
Date: Sat, 30 Jun 2012 14:53:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Neal Peacock <neal@coinfree.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: UTF8 to UTF-8  name patch for obexd
Message-ID: <20120630115312.GA9121@x220.P-661HNU-F1>
References: <4FEE2CDF.7030806@coinfree.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FEE2CDF.7030806@coinfree.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Neal,

On Fri, Jun 29, 2012, Neal Peacock wrote:
> Subject: [PATCH] Changed UTF name to standard
> 
> ---
>  gobex/gobex-header.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
> index 77dcc6e..56dd9b2 100644
> --- a/gobex/gobex-header.c
> +++ b/gobex/gobex-header.c
> @@ -187,7 +187,7 @@ GObexHeader *g_obex_header_decode(const void *data, gsize len,
>  		}
>  
>  		header->v.string = g_convert((const char *) ptr, hdr_len - 5,
> -						"UTF8", "UTF16BE",
> +						"UTF-8", "UTF-16BE",
>  						NULL, &str_len, &conv_err);
>  		if (header->v.string == NULL) {
>  			g_set_error(err, G_OBEX_ERROR,

The patch looks good and has been applied to obexd.git. Thanks.

Johan
