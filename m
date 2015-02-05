Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [RFC 1/2] Bluetooth: Add led_off callback to manually turn off the LED before closing device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150204182856.43bd5644@tedd-test>
Date: Thu, 5 Feb 2015 00:50:21 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <433E37CA-C069-4948-AFE9-ED72036A5B9B@holtmann.org>
References: <20150204182856.43bd5644@tedd-test>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This callback allows a vendor to send the vendor specific command, for example
> turn off the LED, before cloing the hci interface.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 1 +
> net/bluetooth/hci_core.c         | 4 ++++
> 2 files changed, 5 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 52863c3..99a9ecd 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -377,6 +377,7 @@ struct hci_dev {
> 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
> 	void (*hw_error)(struct hci_dev *hdev, u8 code);
> 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
> +	int (*led_off)(struct hci_dev *hdev);
> };

so I actually wonder if this is not better called shutdown() and we ensure that it is always called before close() callback. The name led_off() seems to be pretty specific.

Regards

Marcel

