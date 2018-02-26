Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] shared/btp: Fix return type in btp_send
Date: Mon, 26 Feb 2018 14:00:46 +0100
Message-ID: <7414598.jPndJ80TbF@ix>
In-Reply-To: <20180223134010.20312-1-szymon.janc@codecoup.pl>
References: <20180223134010.20312-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday, 23 February 2018 14:40:09 CET Szymon Janc wrote:
> This function returns bool.
> ---
>  src/shared/btp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/shared/btp.c b/src/shared/btp.c
> index 77622671c..555dabc39 100644
> --- a/src/shared/btp.c
> +++ b/src/shared/btp.c
> @@ -297,7 +297,7 @@ bool btp_send(struct btp *btp, uint8_t service, uint8_t
> opcode, uint8_t index, len = sizeof(*hdr) + length;
>  	hdr = l_malloc(len);
>  	if (!hdr)
> -		return NULL;
> +		return false;
> 
>  	hdr->service = service;
>  	hdr->opcode = opcode;

Applied.

-- 
pozdrawiam
Szymon Janc


