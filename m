Return-Path: <cyrus@holtmann.org>
Message-ID: <52A07953.4030804@tieto.com>
Date: Thu, 05 Dec 2013 14:02:11 +0100
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/8] android: Fix turning BT off during pairing
References: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 12/05/2013 11:37 AM, Jakub Tyszkowski wrote:
> Not turning BT off in time due to actions queued in mgmt makes Android
> unstable and locks Bluetooth UI controlls. This patch fixes this issue
> by cancelling queued actions.
>
> ---
>   android/bluetooth.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 6174b1f..e67864a 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -1982,6 +1982,9 @@ static void pair_device_complete(uint8_t status, uint16_t length,
>
>   	DBG("status %u", status);
>
> +	/*Data used for bond cancelling can be freed now*/
> +	g_free(user_data);
> +
>   	/* On success bond state change will be send when new link key event
>   	 * is received */
>   	if (status == MGMT_STATUS_SUCCESS)
> @@ -1991,19 +1994,34 @@ static void pair_device_complete(uint8_t status, uint16_t length,
>   							HAL_BOND_STATE_NONE);
>   }
>
> +static void pair_device_cancelled(void *data)
> +{
> +	bdaddr_t *addr = data;
> +
> +	set_device_bond_state(addr, HAL_STATUS_FAILED, HAL_BOND_STATE_NONE);
> +
> +	g_free(data);
> +}
> +
>   static void handle_create_bond_cmd(const void *buf, uint16_t len)
>   {
>   	const struct hal_cmd_create_bond *cmd = buf;
>   	uint8_t status;
>   	struct mgmt_cp_pair_device cp;
> +	bdaddr_t *addr;
>
>   	cp.io_cap = DEFAULT_IO_CAPABILITY;
>   	cp.addr.type = BDADDR_BREDR;
>   	android2bdaddr(cmd->bdaddr, &cp.addr.bdaddr);
>
> +	addr = g_new(bdaddr_t, 1);
> +	bacpy(addr, &cp.addr.bdaddr);
> +
>   	if (mgmt_send(mgmt_if, MGMT_OP_PAIR_DEVICE, adapter.index, sizeof(cp),
> -				&cp, pair_device_complete, NULL, NULL) == 0) {
> +				&cp, pair_device_complete,
> +				addr, pair_device_cancelled) == 0) {
>   		status = HAL_STATUS_FAILED;
> +		g_free(addr);
>   		goto fail;
>   	}
>
> @@ -2253,6 +2271,8 @@ static void handle_disable_cmd(const void *buf, uint16_t len)
>   		goto failed;
>   	}
>
> +	mgmt_cancel_index(mgmt_if, adapter.index);
> +
>   	if (!set_mode(MGMT_OP_SET_POWERED, 0x00)) {
>   		status = HAL_STATUS_FAILED;
>   		goto failed;
>

Hi,

Please ignore this one patch as it makes user_data being freed twice.

BR,
Jakub Tyszkowski
