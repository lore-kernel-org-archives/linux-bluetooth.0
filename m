Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Feb 2012 13:06:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH hcidump 1/2] L2CAP: add OBEX support
Message-ID: <20120217110627.GB16018@x220>
References: <1329472135-14123-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329472135-14123-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Feb 17, 2012, Luiz Augusto von Dentz wrote:
> ---
>  parser/l2cap.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/parser/l2cap.c b/parser/l2cap.c
> index 696456a..fba530a 100644
> --- a/parser/l2cap.c
> +++ b/parser/l2cap.c
> @@ -1090,6 +1090,14 @@ static void l2cap_parse(int level, struct frame *frm)
>  					raw_dump(level + 1, frm);
>  				break;
>  
> +			case SDP_UUID_OBEX:
> +				if (!p_filter(FILT_OBEX))
> +					obex_dump(level, frm);
> +				else
> +					raw_dump(level + 1, frm);
> +				break;
> +
> +
>  			default:

One unnecessary empty line above. Other than that the patches looked
fine so they're now (with the above fix) pushed upstream.

Johan
