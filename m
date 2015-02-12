Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 1/2] Bluetooth: Add shutdown callback before closing the device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150205114405.4500efd8@tedd-test>
Date: Thu, 12 Feb 2015 11:48:16 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <2D5EC1CF-888B-4BE6-8ED4-85C4AE0C8AF8@holtmann.org>
References: <20150205114405.4500efd8@tedd-test>
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
> net/bluetooth/hci_core.c         | 4 ++++
> 2 files changed, 5 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 52863c3..1d868b2 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -377,6 +377,7 @@ struct hci_dev {
> 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
> 	void (*hw_error)(struct hci_dev *hdev, u8 code);
> 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
> +	int (*shutdown)(struct hci_dev *hdev);

I think we should move the shutdown higher up. So after setup() should be a good place.

> };
> 
> #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 3322d3f..d151aef 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1591,6 +1591,10 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> {
> 	BT_DBG("%s %p", hdev->name, hdev);
> 
> +	/* allows vendors to send the command before close the device */
> +	if (!test_bit(HCI_UNREGISTER, &hdev->dev_flags) && hdev->shutdown)
> +		hdev->shutdown(hdev);
> +

	if (!test_bit()) {
		/* ..... */
		if (hdev->shutdown)
			hdev->shutdown(hdev);
	}

I know this is the same code, but I prefer to have the check for the function pointer provided a little bit close to the call so that it is really obvious.

Regards

Marcel

