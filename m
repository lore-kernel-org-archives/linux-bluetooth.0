Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Jul 2010 14:04:26 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Show F-bit instead of Retransmission Disable
Message-ID: <20100712170426.GA16225@jh-x301>
References: <1278953750-18646-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1278953750-18646-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Jul 12, 2010, Gustavo F. Padovan wrote:
> "F-bit" make more sense for the Enhanced Retranstransmission mode.
> ---
>  parser/l2cap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/parser/l2cap.c b/parser/l2cap.c
> index ad3b7ff..174cd3a 100644
> --- a/parser/l2cap.c
> +++ b/parser/l2cap.c
> @@ -847,7 +847,7 @@ static void l2cap_parse(int level, struct frame *frm)
>  				}
>  				printf(" ReqSeq %d", (ctrl & 0x3f00) >> 8);
>  				if (ctrl & 0x80)
> -					printf(" Retransmission Disable");
> +					printf(" F-bit");
>  				printf("\n");
>  			}
>  		}

The patch is now upstream. Thanks.

Johan
