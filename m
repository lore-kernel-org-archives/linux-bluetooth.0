Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Apr 2010 18:56:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	gustavo@padovan.org
Subject: Re: [PATCH] Add new S-frame types to l2cap parser
Message-ID: <20100428155656.GC11157@jh-x301>
References: <1269972441-24242-1-git-send-email-jprvita@gmail.com>
 <1269975143-9951-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1269975143-9951-1-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 30, 2010, Gustavo F. Padovan wrote:
> ---
>  parser/l2cap.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/parser/l2cap.c b/parser/l2cap.c
> index 799d4b7..ad3b7ff 100644
> --- a/parser/l2cap.c
> +++ b/parser/l2cap.c
> @@ -352,8 +352,9 @@ static char *supervisory2str(uint8_t supervisory)
>  	case 0x01:
>  		return "Reject (REJ)";
>  	case 0x02:
> +		return "Receiver Not Ready (RNR)";
>  	case 0x03:
> -		return "Reserved Supervisory";
> +		return "Select Reject (SREJ)";
>  	default:
>  		return "Bad Supervisory";
>  	}

This one has now been pushed to the upstream bluez-hcidump tree. Thanks.

Johan
