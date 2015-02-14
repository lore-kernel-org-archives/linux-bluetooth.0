Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Add shutdown callback before closing the device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150213092050.6069a9b7@tedd-test>
Date: Sat, 14 Feb 2015 15:41:56 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <8898FDD2-50B1-43F5-8D26-F11265AED5E2@holtmann.org>
References: <20150213092050.6069a9b7@tedd-test>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This callback allows a vendor to send the vendor specific commands
> before cloing the hci interface.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 1 +
> net/bluetooth/hci_core.c         | 5 +++++
> 2 files changed, 6 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 52863c3..5f1ca33 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -373,6 +373,7 @@ struct hci_dev {
> 	int (*close)(struct hci_dev *hdev);
> 	int (*flush)(struct hci_dev *hdev);
> 	int (*setup)(struct hci_dev *hdev);
> +	int (*shutdown)(struct hci_dev *hdev);
> 	int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
> 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
> 	void (*hw_error)(struct hci_dev *hdev, u8 code);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 3322d3f..4611a04 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1591,6 +1591,11 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> {
> 	BT_DBG("%s %p", hdev->name, hdev);
> 
> +	if (!test_bit(HCI_UNREGISTER, &hdev->dev_flags)) {
> +		/* Execute vendor specific shutdown routine */
> +		if (hdev->shutdown)
> +			hdev->shutdown(hdev);
> +	}

you should have had an extra empty line here. I fixed that for you.

> 	cancel_delayed_work(&hdev->power_off);
> 
> 	hci_req_cancel(hdev, ENODEV);

Patch has been applied to bluetooth-next tree.

Regards

Marcel

