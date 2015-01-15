Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Jan 2015 12:25:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Fix LE SMP channel source address and
 source address type
Message-ID: <20150115102520.GA9910@t440s.lan>
References: <1421278991-4169-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421278991-4169-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 14, 2015, Marcel Holtmann wrote:
> +	if (cid == L2CAP_CID_SMP) {
> +		/* If usage of static address is forced or if the devices
> +		 * does not have a public address, then listen on the static
> +		 * address.
> +		 *
> +		 * In case BR/EDR has been disabled on a dual-mode controller
> +		 * and a static address has been configued, then listen on
> +		 * the static address instead.
> +		 */
> +		if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ||
> +		    !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
> +		    (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
> +		     bacmp(&hdev->static_addr, BDADDR_ANY))) {
> +			bacpy(&chan->src, &hdev->static_addr);
> +			chan->src_type = BDADDR_LE_RANDOM;
> +		} else {
> +			bacpy(&chan->src, &hdev->bdaddr);
> +			chan->src_type = BDADDR_LE_PUBLIC;
> +		}

I think this can be simply substituted with:

	hci_copy_identity_address(hdev, &chan->src, &chan->src_type);

Johan
