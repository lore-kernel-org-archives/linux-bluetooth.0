Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/bluetooth: Pass correct device type for bonding commands
Date: Wed, 19 Mar 2014 10:23:46 +0100
Message-ID: <10415511.qBrhnEROM1@leonov>
In-Reply-To: <1395155891-8745-1-git-send-email-szymon.janc@tieto.com>
References: <1395155891-8745-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 18 of March 2014 16:18:09 Szymon Janc wrote:
> For create_bond we fallback to BDEDR if device is not known. This can
> happen eg. with OOB. For cancel_bond and remove_bond we require device
> to be known.
> ---
>  android/bluetooth.c | 45 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 1becdfb..000f595 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -2697,13 +2697,18 @@ static void pair_device_complete(uint8_t status,
> uint16_t length, static void handle_create_bond_cmd(const void *buf,
> uint16_t len) {
>  	const struct hal_cmd_create_bond *cmd = buf;
> +	struct device *dev;
>  	uint8_t status;
>  	struct mgmt_cp_pair_device cp;
> 
>  	cp.io_cap = DEFAULT_IO_CAPABILITY;
> -	cp.addr.type = BDADDR_BREDR;
>  	android2bdaddr(cmd->bdaddr, &cp.addr.bdaddr);
> 
> +	dev = find_device(&cp.addr.bdaddr);
> +
> +	/* Fallback to BREDR if device is unknown eg. OOB */
> +	cp.addr.type = dev ? dev->bdaddr_type : BDADDR_BREDR;
> +
>  	if (mgmt_send(mgmt_if, MGMT_OP_PAIR_DEVICE, adapter.index, sizeof(cp),
>  				&cp, pair_device_complete, NULL, NULL) == 0) {
>  		status = HAL_STATUS_FAILED;
> @@ -2724,17 +2729,28 @@ static void handle_cancel_bond_cmd(const void *buf,
> uint16_t len) {
>  	const struct hal_cmd_cancel_bond *cmd = buf;
>  	struct mgmt_addr_info cp;
> +	struct device *dev;
>  	uint8_t status;
> 
> -	cp.type = BDADDR_BREDR;
>  	android2bdaddr(cmd->bdaddr, &cp.bdaddr);
> 
> +	dev = find_device(&cp.bdaddr);
> +	if (!dev) {
> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	cp.type = dev->bdaddr_type;
> +
>  	if (mgmt_reply(mgmt_if, MGMT_OP_CANCEL_PAIR_DEVICE, adapter.index,
> -					sizeof(cp), &cp, NULL, NULL, NULL) > 0)
> -		status = HAL_STATUS_SUCCESS;
> -	else
> +				sizeof(cp), &cp, NULL, NULL, NULL) == 0) {
>  		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	status = HAL_STATUS_SUCCESS;
> 
> +failed:
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CANCEL_BOND,
>  									status);
>  }
> @@ -2757,19 +2773,30 @@ static void handle_remove_bond_cmd(const void *buf,
> uint16_t len) {
>  	const struct hal_cmd_remove_bond *cmd = buf;
>  	struct mgmt_cp_unpair_device cp;
> +	struct device *dev;
>  	uint8_t status;
> 
>  	cp.disconnect = 1;
> -	cp.addr.type = BDADDR_BREDR;
>  	android2bdaddr(cmd->bdaddr, &cp.addr.bdaddr);
> 
> +	dev = find_device(&cp.addr.bdaddr);
> +	if (!dev) {
> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	cp.addr.type = dev->bdaddr_type;
> +
>  	if (mgmt_send(mgmt_if, MGMT_OP_UNPAIR_DEVICE, adapter.index,
>  				sizeof(cp), &cp, unpair_device_complete,
> -				NULL, NULL) > 0)
> -		status = HAL_STATUS_SUCCESS;
> -	else
> +				NULL, NULL) ==  0) {
>  		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	status = HAL_STATUS_SUCCESS;
> 
> +failed:
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_REMOVE_BOND,
>  									status);
>  }

This is not handling dual mode devices correctly. Please ignore for now.

-- 
BR
Szymon Janc
