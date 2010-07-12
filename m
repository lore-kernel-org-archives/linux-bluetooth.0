Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Jul 2010 14:04:55 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Show P-bit in the l2cap parser
Message-ID: <20100712170455.GB16225@jh-x301>
References: <1278953750-18646-1-git-send-email-gustavo@padovan.org>
 <1278953750-18646-2-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1278953750-18646-2-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Jul 12, 2010, Gustavo F. Padovan wrote:
> ---
>  parser/l2cap.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/parser/l2cap.c b/parser/l2cap.c
> index 174cd3a..ee869dc 100644
> --- a/parser/l2cap.c
> +++ b/parser/l2cap.c
> @@ -848,6 +848,8 @@ static void l2cap_parse(int level, struct frame *frm)
>  				printf(" ReqSeq %d", (ctrl & 0x3f00) >> 8);
>  				if (ctrl & 0x80)
>  					printf(" F-bit");
> +				if (ctrl & 0x10)
> +					printf(" P-bit");
>  				printf("\n");
>  			}
>  		}

This one is upstream now too. Thanks.

Johan
