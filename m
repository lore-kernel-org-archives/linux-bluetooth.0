Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC 3/4] Bluetooth: Move is_identity_address() to hci_core.h
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403725710-29750-4-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 25 Jun 2014 22:16:27 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8886F344-FB0A-407C-955F-C0DB2BE08647@holtmann.org>
References: <1403725710-29750-1-git-send-email-andre.guedes@openbossa.org> <1403725710-29750-4-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds the prefix hci_ to is_identity_address() helper and
> moves it to hci_core.h so it can be reused in other files.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h | 12 ++++++++++++
> net/bluetooth/hci_core.c         | 14 +-------------
> 2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 016d262..b6b1c86 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1164,6 +1164,18 @@ static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
> 	return false;
> }
> 
> +static inline bool hci_is_identity_address(bdaddr_t *addr, u8 addr_type)
> +{
> +	if (addr_type == ADDR_LE_DEV_PUBLIC)
> +		return true;
> +
> +	/* Check for Random Static address type */
> +	if ((addr->b[5] & 0xc0) == 0xc0)
> +		return true;
> +
> +	return false;
> +}
> +
> static inline struct smp_irk *hci_get_irk(struct hci_dev *hdev,
> 					  bdaddr_t *bdaddr, u8 addr_type)
> {
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 9852449..b8b901c 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3369,18 +3369,6 @@ static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
> 	return true;
> }
> 
> -static bool is_identity_address(bdaddr_t *addr, u8 addr_type)
> -{
> -	if (addr_type == ADDR_LE_DEV_PUBLIC)
> -		return true;
> -
> -	/* Check for Random Static address type */
> -	if ((addr->b[5] & 0xc0) == 0xc0)
> -		return true;
> -
> -	return false;
> -}
> -
> /* This function requires the caller holds hdev->lock */
> int hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
> 			u8 auto_connect, u16 conn_min_interval,
> @@ -3388,7 +3376,7 @@ int hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
> {
> 	struct hci_conn_params *params;
> 
> -	if (!is_identity_address(addr, addr_type))
> +	if (!hci_is_identity_address(addr, addr_type))
> 		return -EINVAL;

I do not really get the logic here. Why do we need to do this.

Regards

Marcel

