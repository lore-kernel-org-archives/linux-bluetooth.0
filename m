Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/2] Bluetooth: Introduce a new HCI_BREDR_ENABLED flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380705040-16300-2-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 2 Oct 2013 11:23:43 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6F59A8FC-14F1-4982-9A9A-66F4A022E0B1@holtmann.org>
References: <1380705040-16300-1-git-send-email-johan.hedberg@gmail.com> <1380705040-16300-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To allow treating dual-mode (BR/EDR/LE) controllers as single-mode ones
> (LE-only) we want to introduce a new HCI_BREDR_ENABLED flag to track
> whether BR/EDR is enabled or not (previously we simply looked at the
> feature bit with lmp_bredr_enabled).
> 
> This patch add the new flag and updates the relevant places to test
> against it instead of using lmp_bredr_enabled. The flag is by default
> enabled when registering an adapter and only cleared if necessary once
> the local features have been read during the HCI init procedure.
> 
> We cannot completely block BR/EDR usage in case user space uses raw HCI
> sockets but the patch tries to block this in places where possible, such
> as the various BR/EDR specific ioctls.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/hci_conn.c    |  3 +++
> net/bluetooth/hci_core.c    | 21 +++++++++++++++++++--
> net/bluetooth/mgmt.c        | 24 +++++++++++++-----------
> 4 files changed, 36 insertions(+), 13 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 7ede266..4fa08d7 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -122,6 +122,7 @@ enum {
> 	HCI_LINK_SECURITY,
> 	HCI_PERIODIC_INQ,
> 	HCI_FAST_CONNECTABLE,
> +	HCI_BREDR_ENABLED,
> };
> 
> /* A mask for the flags that are supposed to remain when a reset happens
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index d2380e0..514148b 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -581,6 +581,9 @@ static struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
> {
> 	struct hci_conn *acl;
> 
> +	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
> +		return ERR_PTR(-ENOTSUPP);
> +
> 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
> 	if (!acl) {
> 		acl = hci_conn_add(hdev, ACL_LINK, dst);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 7cbdd33..ed310e9 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -519,6 +519,8 @@ static void hci_init2_req(struct hci_request *req, unsigned long opt)
> 
> 	if (lmp_bredr_capable(hdev))
> 		bredr_setup(req);
> +	else
> +		clear_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
> 
> 	if (lmp_le_capable(hdev))
> 		le_setup(req);
> @@ -1034,6 +1036,11 @@ int hci_inquiry(void __user *arg)
> 		goto done;
> 	}
> 
> +	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
> +		err = -ENOTSUPP;
> +		goto done;
> +	}
> +
> 	hci_dev_lock(hdev);
> 	if (inquiry_cache_age(hdev) > INQUIRY_CACHE_AGE_MAX ||
> 	    inquiry_cache_empty(hdev) || ir.flags & IREQ_CACHE_FLUSH) {
> @@ -1101,7 +1108,7 @@ static u8 create_ad(struct hci_dev *hdev, u8 *ptr)
> 	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
> 		flags |= LE_AD_GENERAL;
> 
> -	if (!lmp_bredr_capable(hdev))
> +	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
> 		flags |= LE_AD_NO_BREDR;
> 
> 	if (lmp_le_br_capable(hdev))
> @@ -1493,6 +1500,11 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
> 		goto done;
> 	}
> 
> +	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
> +		err = -ENOTSUPP;
> +		goto done;
> +	}
> +

quick question, shouldn't these be EOPNOTSUPP.

Regards

Marcel

