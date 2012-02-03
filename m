Return-Path: <cyrus@holtmann.org>
Message-ID: <1328228602.2062.21.camel@aeonflux>
Subject: Re: [PATCH v2 3/7] Bluetooth: Use the updated key structures for
 handling LTKs
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 02 Feb 2012 16:23:22 -0800
In-Reply-To: <1328227685-27245-4-git-send-email-vinicius.gomes@openbossa.org>
References: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1328227685-27245-4-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> This updates all the users of the older way, that was using the
> link_keys list to store the SMP keys, to use the new way.
> 
> This includes defining new types for the keys, we have a type for each
> combination of STK/LTK and Master/Slave.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |   11 +++--
>  net/bluetooth/hci_core.c         |   76 ++++++++++++++++---------------------
>  net/bluetooth/hci_event.c        |   11 ++++-
>  net/bluetooth/smp.c              |   38 +++++++++++-------
>  4 files changed, 71 insertions(+), 65 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index c998176..3f22f03 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -658,12 +658,13 @@ int hci_link_keys_clear(struct hci_dev *hdev);
>  struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
>  int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
>  			bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len);
> -struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
> -struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
> -					bdaddr_t *bdaddr, u8 type);
> +struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
> +int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
> +				int new_key, u8 authenticated, u8 tk[16],
> +				u8 enc_size, u16 ediv, u8 rand[8]);
> +struct smp_ltk *hci_find_ltk_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
> +								u8 addr_type);
>  int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr);
> -int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
> -			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16]);
>  int hci_smp_ltks_clear(struct hci_dev *hdev);
>  int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
>  
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index a28e637..ff519b5 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1222,41 +1222,35 @@ static int hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
>  	return 0;
>  }
>  
> -struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
> +struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
>  {
> -	struct link_key *k;
> -
> -	list_for_each_entry(k, &hdev->link_keys, list) {
> -		struct key_master_id *id;
> +	struct smp_ltk *k;
>  
> -		if (k->type != HCI_LK_SMP_LTK)
> +	list_for_each_entry(k, &hdev->long_term_keys, list) {
> +		if (k->ediv != ediv ||
> +				memcmp(rand, k->rand, sizeof(k->rand)))
>  			continue;
>  
> -		if (k->dlen != sizeof(*id))
> -			continue;
> -
> -		id = (void *) &k->data;
> -		if (id->ediv == ediv &&
> -				(memcmp(rand, id->rand, sizeof(id->rand)) == 0))
> -			return k;
> +		return k;
>  	}
>  
>  	return NULL;
>  }
>  EXPORT_SYMBOL(hci_find_ltk);
>  
> -struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
> -					bdaddr_t *bdaddr, u8 type)
> +struct smp_ltk *hci_find_ltk_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
> +								u8 addr_type)

minor nitpick with naming here. It should be find_ltk_by_addr. That way
it is consistent with similar calls in the Bluetooth subsystem.

Also in theory we might be better using "lookup" than "find", but you
can fix that one later one. Otherwise this looks fine.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


