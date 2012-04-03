Return-Path: <cyrus@holtmann.org>
From: Hemant GUPTA <hemant.gupta@stericsson.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Date: Tue, 3 Apr 2012 12:50:33 +0200
Subject: RE: [PATCH v1] Adapter: Fix Discovering state while Powering Off
Message-ID: <AA50405D3B026C488CB3DB0AADE6954020064F5D94@EXDCVYMBSTM005.EQ1STM.local>
References: <1333126569-1606-1-git-send-email-hemant.gupta@stericsson.com>
 <20120403104114.GB23054@x220>
In-Reply-To: <20120403104114.GB23054@x220>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

-----Original Message-----
From: Johan Hedberg [mailto:johan.hedberg@gmail.com] 
Sent: Tuesday, April 03, 2012 4:11 PM
To: Hemant GUPTA
Cc: linux-bluetooth@vger.kernel.org; Hemant Gupta
Subject: Re: [PATCH v1] Adapter: Fix Discovering state while Powering Off

Hi Hemant,

On Fri, Mar 30, 2012, Hemant Gupta wrote:
> This patch fixes the adater discovering state while powering off.
> Without this fix, BlueZ sends incorrect discovering state to upper 
> layers while switching off.
> ---
>  src/adapter.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c index f8f46f8..eb9745f 
> 100644
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

Wouldn't the right place to do this be in btd_adapter_stop()? (after sending the Discovering signal). Actually, wouldn't the right thing be to call adapter_set_discovering() in btd_adapter_stop?
Yes that looks like a good place. Regarding the call to adapter_set_discovering(), I had earlier thought of same, but seeing the code of adapter_set_discovering(), it will also set the out of range devices, and would emit device disappeared signal to upper layers, which might get wrong indication that some devices might have disappeared. So I thought that this would be anyways updated during the enxt time Inquiry is performed when BT is witched back on. What do you think about this ?

Johan

BR
Hemant
