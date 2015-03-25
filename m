Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 7/7] Bluetooth: Update supported_flags for AD features
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427252582-24814-7-git-send-email-armansito@chromium.org>
Date: Wed, 25 Mar 2015 09:21:10 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4450BD63-777C-4903-88BB-3D1974971EC5@holtmann.org>
References: <1427252582-24814-1-git-send-email-armansito@chromium.org> <1427252582-24814-7-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch updates the "supported_flags" parameter returned from the
> "Read Advertising Features" command.
> 
> Signed-off-by: Arman Uguray <armansito@chromium.org>
> ---
> net/bluetooth/mgmt.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 8795037..a4a0d6b 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -6530,6 +6530,7 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
> 	size_t rp_len;
> 	int err;
> 	bool instance;
> +	u32 supported_flags;
> 
> 	BT_DBG("%s", hdev->name);
> 
> @@ -6550,7 +6551,13 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
> 		return -ENOMEM;
> 	}
> 
> -	rp->supported_flags = cpu_to_le32(0);
> +	supported_flags = MGMT_ADV_FLAG_CONNECTABLE;
> +	supported_flags |= MGMT_ADV_FLAG_DISCOV;
> +	supported_flags |= MGMT_ADV_FLAG_LIMITED_DISCOV;
> +	supported_flags |= MGMT_ADV_FLAG_MANAGED_FLAGS;
> +	supported_flags |= MGMT_ADV_FLAG_TX_POWER;
> +

	supported_flags = MGMT_foo |
			  MGMT_bar;

I would prefer we do it this way.

> +	rp->supported_flags = cpu_to_le32(supported_flags);
> 	rp->max_adv_data_len = HCI_MAX_AD_LENGTH;
> 	rp->max_scan_rsp_len = HCI_MAX_AD_LENGTH;
> 	rp->max_instances = 1;

Regards

Marcel

