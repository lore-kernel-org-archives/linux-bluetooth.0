Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Nov 2013 13:40:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH v4 1/4] android: Update bond state on incoming bonding
Message-ID: <20131115114039.GA9847@x220.p-661hnu-f1>
References: <1384453825-19241-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1384453825-19241-2-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384453825-19241-2-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Nov 14, 2013, Lukasz Rymanowski wrote:
> +static void send_remote_device_name_prop(const bdaddr_t *bdaddr, char *name)
> +{
> +	struct hal_ev_remote_device_props *ev;
> +	uint8_t buf[BASELEN_REMOTE_DEV_PROP + strlen(name)];
> +
> +	ev =  (void *) buf;

Minor white space issue here (two spaces instead of one after =.

> @@ -1865,12 +1933,18 @@ static bool cancel_bond(void *buf, uint16_t len)
>  {
>  	struct hal_cmd_cancel_bond *cmd = buf;
>  	struct mgmt_addr_info cp;
> +	bool result;
>  
>  	cp.type = BDADDR_BREDR;
>  	android2bdaddr(cmd->bdaddr, &cp.bdaddr);
>  
> -	return mgmt_reply(mgmt_if, MGMT_OP_CANCEL_PAIR_DEVICE, adapter.index,
> +	result = mgmt_reply(mgmt_if, MGMT_OP_CANCEL_PAIR_DEVICE, adapter.index,
>  					sizeof(cp), &cp, NULL, NULL, NULL) > 0;
> +	if (result)
> +		set_device_bond_state(&cp.bdaddr, HAL_STATUS_SUCCESS,
> +							HAL_BOND_STATE_NONE);

Would it not make sense to use the mgmt command complete callback for
sending HAL_BOND_STATE_NONE? (right now you're just passing NULL for
it). Actually, sending this command will generate a command complete to
our pair_device command with a "canceled" status. So aren't we sending
redundant HAL_BOND_STATE_NONE here?

Johan
