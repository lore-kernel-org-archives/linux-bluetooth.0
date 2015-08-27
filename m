Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 4/5] Bluetooth: hci_intel: Add intel_data_list
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440689946-13576-4-git-send-email-loic.poulain@intel.com>
Date: Thu, 27 Aug 2015 09:21:54 -0700
Cc: linux-bluetooth@vger.kernel.org, gaetan.prin@intel.com
Message-Id: <4C16D0EB-E539-4934-B26E-38166403217A@holtmann.org>
References: <1440689946-13576-1-git-send-email-loic.poulain@intel.com> <1440689946-13576-4-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> In the same way as a intel_data (hu) needs to access its corresponding
> intel_device (pdev). A intel_device may be required to access the
> intel_data. We need to maintain a list of current intel_data and
> protect it against concurrent access.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 32 ++++++++++++++++++++++++++++++++
> 1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index f855515..99f1307 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -75,11 +75,16 @@ static LIST_HEAD(intel_device_list);
> static DEFINE_SPINLOCK(intel_device_list_lock);
> 
> struct intel_data {
> +	struct list_head list;

this is the private data associated with the hci_uart. I am not turning this into a list.

> 	struct sk_buff *rx_skb;
> 	struct sk_buff_head txq;
> 	unsigned long flags;
> +	struct hci_uart *hu;
> };
> 
> +static LIST_HEAD(intel_data_list);
> +static DEFINE_MUTEX(intel_data_list_lock);
> +
> static u8 intel_convert_speed(unsigned int speed)
> {
> 	switch (speed) {
> @@ -130,6 +135,24 @@ static struct intel_device *intel_device_get(struct hci_uart *hu)
> 	return NULL;
> }
> 
> +static struct intel_data *intel_data_get(struct intel_device *idev)
> +{
> +	struct list_head *p;
> +
> +	list_for_each(p, &intel_data_list) {
> +		struct intel_data *intel = list_entry(p, struct intel_data,
> +						      list);
> +
> +		/* tty device and pdev device should share the same parent
> +		 * which is the UART port.
> +		 */
> +		if (intel->hu->tty->dev->parent == idev->pdev->dev.parent)
> +			return intel;
> +	}
> +
> +	return NULL;
> +}
> +

You really need to come up with something else. intel_data is not a list. It is private data for hci_uart.

> static int intel_wait_booting(struct hci_uart *hu)
> {
> 	struct intel_data *intel = hu->priv;
> @@ -194,6 +217,11 @@ static int intel_open(struct hci_uart *hu)
> 	skb_queue_head_init(&intel->txq);
> 
> 	hu->priv = intel;
> +	intel->hu = hu;
> +
> +	mutex_lock(&intel_data_list_lock);
> +	list_add_tail(&intel->list, &intel_data_list);
> +	mutex_unlock(&intel_data_list_lock);
> 
> 	if (!intel_set_power(hu, true))
> 		set_bit(STATE_BOOTING, &intel->flags);
> @@ -209,6 +237,10 @@ static int intel_close(struct hci_uart *hu)
> 
> 	intel_set_power(hu, false);
> 
> +	mutex_lock(&intel_data_list_lock);
> +	list_del(&intel->list);
> +	mutex_unlock(&intel_data_list_lock);
> +
> 	skb_queue_purge(&intel->txq);
> 	kfree_skb(intel->rx_skb);
> 	kfree(intel);

Regards

Marcel

