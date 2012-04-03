Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Apr 2012 13:41:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [PATCH v1] Adapter: Fix Discovering state while Powering Off
Message-ID: <20120403104114.GB23054@x220>
References: <1333126569-1606-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333126569-1606-1-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Fri, Mar 30, 2012, Hemant Gupta wrote:
> This patch fixes the adater discovering state while powering off.
> Without this fix, BlueZ sends incorrect discovering state to upper
> layers while switching off.
> ---
>  src/adapter.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index f8f46f8..eb9745f 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -289,6 +289,12 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode,
>  			return err;
>  
>  		adapter->off_requested = TRUE;
> +		/*
> +		 * Change the discovering state to FALSE, otherwise
> +		 * inquiry fails to start if BT is switched off and then on
> +		 * while inquiry is already active.
> +		 */
> +		adapter->discovering = FALSE;
>  
>  		goto done;
>  	}

Wouldn't the right place to do this be in btd_adapter_stop()? (after
sending the Discovering signal). Actually, wouldn't the right thing be
to call adapter_set_discovering() in btd_adapter_stop?

Johan
