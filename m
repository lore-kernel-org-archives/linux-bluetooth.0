Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 5/6] Bluetooth: Fix ignoring debug keys in mgmt_load_link_keys
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403604953-19539-5-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Jun 2014 12:33:58 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F49469DF-37EF-4DAA-BEF4-B71DDB4C380D@holtmann.org>
References: <1403604953-19539-1-git-send-email-johan.hedberg@gmail.com> <1403604953-19539-5-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If support for debug keys is not enabled we should simply ignore any
> debug keys fed to us from user space using the mgmt_load_link_keys
> command.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 634b44ddc9f9..49c9a4dbfd15 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2426,6 +2426,11 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
> 	for (i = 0; i < key_count; i++) {
> 		struct mgmt_link_key_info *key = &cp->keys[i];
> 
> +		/* Ignore debug keys if support is not enabled */
> +		if (key->type == HCI_LK_DEBUG_COMBINATION &&
> +		    !test_bit(HCI_KEEP_DEBUG_KEYS, &hdev->flags))
> +			continue;
> +

I would just always ignore debug keys. It makes no sense to allow loading them via userspace.

The Load Link Keys command is normally only ever used once. However Set Debug Keys might change during lifetime. Which means that debug keys you load here will be removed when we switch the mode back to no debug keys allowed. Then you would need to load all keys again. That sounds like really really complicated.

So my take is that we should always ignore debug keys loaded into the kernel. If you want a debug key, then pair with the device again. At least this way we know that a power cycle will always fix this, no matter what the setting of debug keys mode is.

Regards

Marcel

