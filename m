Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Mar 2012 17:50:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [PATCH] Adapter: Fix Discovering state while Powering Off
Message-ID: <20120330145025.GA3545@x220.P-661HNU-F1>
References: <1333116892-31344-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333116892-31344-1-git-send-email-hemant.gupta@stericsson.com>
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
> index f8f46f8..76fbe31 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -289,6 +289,12 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode,
>  			return err;
>  
>  		adapter->off_requested = TRUE;
> +                /*
> +                 * Change the discovering state to FALSE, otherwise
> +                 * inquiry fails to start if BT is switched off and then on
> +                 * while inquiry is already active.
> +                 */
> +                adapter->discovering = FALSE;
>  
>  		goto done;
>  	}

Functionality wise the patch seems fine but you're not following the
coding style. We use tabs for indentation whereas your patch uses
spaces. Please fix and resend (and configure your editor so that such
mistakes do not happen again).

Johan
