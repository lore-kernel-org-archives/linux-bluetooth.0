Return-Path: <cyrus@holtmann.org>
From: Hemant GUPTA <hemant.gupta@stericsson.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Naresh-kumar GUPTA <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Date: Fri, 30 Mar 2012 16:58:17 +0200
Subject: RE: [PATCH] Adapter: Fix Discovering state while Powering Off
Message-ID: <AA50405D3B026C488CB3DB0AADE695402006491509@EXDCVYMBSTM005.EQ1STM.local>
References: <1333116892-31344-1-git-send-email-hemant.gupta@stericsson.com>
 <20120330145025.GA3545@x220.P-661HNU-F1>
In-Reply-To: <20120330145025.GA3545@x220.P-661HNU-F1>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

-----Original Message-----
From: Johan Hedberg [mailto:johan.hedberg@gmail.com] 
Sent: Friday, March 30, 2012 8:20 PM
To: Hemant GUPTA
Cc: linux-bluetooth@vger.kernel.org; Naresh-kumar GUPTA; Hemant Gupta
Subject: Re: [PATCH] Adapter: Fix Discovering state while Powering Off

Hi Hemant,

On Fri, Mar 30, 2012, Hemant Gupta wrote:
> This patch fixes the adater discovering state while powering off.
> Without this fix, BlueZ sends incorrect discovering state to upper 
> layers while switching off.
> ---
>  src/adapter.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c index f8f46f8..76fbe31 
> 100644
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

Functionality wise the patch seems fine but you're not following the coding style. We use tabs for indentation whereas your patch uses spaces. Please fix and resend (and configure your editor so that such mistakes do not happen again).

Thanks for the comments, I have fixed the coding style in the new patch, please have a look.

Johan

BR
Hemant
