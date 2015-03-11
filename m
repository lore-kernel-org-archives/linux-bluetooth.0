Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Mar 2015 10:49:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Check for matching IRK when looking for
 paired LE devices
Message-ID: <20150311084904.GA11728@t440s.lan>
References: <1426063491-11398-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426063491-11398-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Mar 11, 2015, Johan Hedberg wrote:
> If we're given an RPA when checking whether we're paired or not, we
> should consult the local RPA storage whether there's a matching IRK.
> This we we ensure that hci_bdaddr_is_paired() gives the right result
> even when trying to pair a second time with the same device with an RPA.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 4eba9d6fc9a5..84df8f358415 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2519,6 +2519,7 @@ void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type)
>  bool hci_bdaddr_is_paired(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
>  {
>  	struct smp_ltk *k;
> +	struct smp_irk *irk;
>  	u8 addr_type;
>  
>  	if (type == BDADDR_BREDR) {
> @@ -2533,6 +2534,12 @@ bool hci_bdaddr_is_paired(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
>  	else
>  		addr_type = ADDR_LE_DEV_RANDOM;
>  
> +	irk = hci_get_irk(hdev, bdaddr, addr_type);
> +	if (irk) {
> +		bacpy(bdaddr, &irk->bdaddr);
> +		addr_type = irk->addr_type;
> +	}

Actually please ignore this one. We shouldn't be overwriting the data
that bdaddr points to as that may create unexpected behavior in the
caller.

Johan
