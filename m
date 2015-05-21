Return-Path: <cyrus@holtmann.org>
Message-ID: <555DE2BE.8000109@broadcom.com>
Date: Thu, 21 May 2015 15:50:54 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Frederic Danis <frederic.danis@linux.intel.com>
CC: <linux-bluetooth@vger.kernel.org>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: Re: [PATCH v6 4/5] Bluetooth: hci_uart: Update Broadcom UART setup
References: <1432136770-13328-1-git-send-email-frederic.danis@linux.intel.com> <1432136770-13328-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1432136770-13328-5-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/20/15 17:46, Frederic Danis wrote:
> Use btbcm helpers to perform controller setup.
> Perform host UART reset to init speed between btbcm_patchram() and
> btbcm_finalize(). This may be need because firmware loading may have
> reseted controller UART to init speed.
>
> Signed-off-by: Frederic Danis<frederic.danis@linux.intel.com>
> ---
>   drivers/bluetooth/hci_bcm.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 1ec0b4a..cede445 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -79,11 +79,28 @@ static int bcm_flush(struct hci_uart *hu)
>
>   static int bcm_setup(struct hci_uart *hu)
>   {
> +	char fw_name[64];
> +	int err;
> +
>   	BT_DBG("hu %p", hu);
>
>   	hu->hdev->set_bdaddr = btbcm_set_bdaddr;
>
> -	return btbcm_setup_patchram(hu->hdev);
> +	err = btbcm_initialize(hu->hdev, fw_name, sizeof(fw_name));
> +	if (err)
> +		return err;
> +
> +	err = btbcm_patchram(hu->hdev, fw_name);
> +	/* If there is no firmware (-ENOENT), discard the error and continue */

I guess -ENOENT means no firmware is required and not a 
request_firmware() failure. Not sure what is meant here.

Regards,
Arend

> +	if (err == -ENOENT)
> +		return 0;
> +
> +	if (hu->proto->init_speed)
> +		hci_uart_set_baudrate(hu, hu->proto->init_speed);
> +
> +	err = btbcm_finalize(hu->hdev);
> +
> +	return err;
>   }
>
>   static const struct h4_recv_pkt bcm_recv_pkts[] = {

