Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v7 2/6] Bluetooth: btbcm: Add BCM4324B3 UART device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432805106-25719-3-git-send-email-frederic.danis@linux.intel.com>
Date: Sat, 6 Jun 2015 07:41:45 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <864DBDBC-BB22-41A3-9382-BF04C11094FA@holtmann.org>
References: <1432805106-25719-1-git-send-email-frederic.danis@linux.intel.com> <1432805106-25719-3-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Add "waiting for configuration" address.
> Add lmp_subver and firmware name for BCM4324B3 controller.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/btbcm.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index c7aec97..e90e6b8 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -33,6 +33,7 @@
> #define VERSION "0.1"
> 
> #define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
> +#define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
> 
> int btbcm_check_bdaddr(struct hci_dev *hdev)
> {
> @@ -56,10 +57,11 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
> 
> 	bda = (struct hci_rp_read_bd_addr *)skb->data;
> 
> -	/* The address 00:20:70:02:A0:00 indicates a BCM20702A0 controller
> -	 * with no configured address.
> +	/* Check if the address indicates a controller with no configured
> +	 * address.
> 	 */

I did like the comment that shows the address in human readable format. So I re-phrased this and mentioned both addresses. It is just a lot easier to grep for in case anybody ever wants to find this.

Regards

Marcel

