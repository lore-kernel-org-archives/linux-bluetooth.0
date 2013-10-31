Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Oct 2013 10:48:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Szymon Janc <szymon.janc@tieto.com>
Subject: Re: [PATCH 08/14] android: Add support for handling remove bond
 command
Message-ID: <20131031084856.GE1271@x220.p-661hnu-f1>
References: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
 <1383188154-22905-9-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383188154-22905-9-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Oct 31, 2013, Szymon Janc wrote:
> ---
>  android/adapter.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/android/adapter.c b/android/adapter.c
> index 0f174a6..0a91149 100644
> --- a/android/adapter.c
> +++ b/android/adapter.c
> @@ -639,6 +639,26 @@ static bool cancel_bond(void *buf, uint16_t len)
>  				NULL) > 0;
>  }
>  
> +static bool remove_bond(void *buf, uint16_t len)
> +{
> +	struct hal_cmd_remove_bond *cmd = buf;
> +	struct mgmt_cp_unpair_device cp;
> +
> +	cp.disconnect = 1;
> +	cp.addr.type = BDADDR_BREDR;
> +	android2bdaddr(cmd->bdaddr, &cp.addr.bdaddr);
> +
> +	if (mgmt_send(adapter->mgmt, MGMT_OP_UNPAIR_DEVICE,
> +				adapter->index, sizeof(cp), &cp,
> +				NULL, NULL, NULL) == 0)
> +		return false;
> +
> +	send_bond_state_change(&cp.addr.bdaddr, HAL_STATUS_SUCCESS,
> +							HAL_BOND_STATE_NONE);

Wouldn't this state change make more sense to send in the mgmt command
complete callback?

Johan
