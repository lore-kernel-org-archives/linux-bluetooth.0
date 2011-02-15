Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Feb 2011 11:26:13 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] src: fix typo
Message-ID: <20110215142613.GB20583@jh-x301>
References: <1297719284-13410-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297719284-13410-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Feb 14, 2011, Gustavo F. Padovan wrote:
> ---
>  src/event.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/event.c b/src/event.c
> index 0659fd1..a415468 100644
> --- a/src/event.c
> +++ b/src/event.c
> @@ -731,7 +731,7 @@ void btd_event_le_set_scan_enable_complete(bdaddr_t *local, uint8_t status)
>  	}
>  
>  	if (status) {
> -		error("Can't enabled/disable LE scan");
> +		error("Can't enable/disable LE scan");
>  		return;
>  	}

Pushed upstream. Thanks.

Johan
