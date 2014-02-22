Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 08/15] Bluetooth: Don't write static address when privacy is enabled
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393088805-28658-9-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 22 Feb 2014 10:03:15 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <7F302D57-1CB8-4D46-BCCF-A31C004F011B@holtmann.org>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com> <1393088805-28658-9-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If privacy is enabled we'll be using RPAs instead of the static address.
> Therefore, only write the static address to HCI when the HCI_PRIVACY
> flag is not set.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 145254f84975..21d059968c32 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -4609,7 +4609,8 @@ static int powered_update_hci(struct hci_dev *hdev)
> 
> 	if (lmp_le_capable(hdev)) {
> 		/* Set random address to static address if configured */
> -		if (bacmp(&hdev->static_addr, BDADDR_ANY))
> +		if (!test_bit(HCI_PRIVACY, &hdev->dev_flags) &&
> +		    bacmp(&hdev->static_addr, BDADDR_ANY))
> 			hci_req_add(&req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
> 				    &hdev->static_addr);

since we are changing to code to always write the random address before enabling scanning, before enabling advertising and before creating a connection, lets remove this support here completely.

If we are not using privacy and have a static address, lets write it before it gets used. I added tracing of the currently configured random address. So we always know when we have to update the address itself or not. That makes it a bit more error free and gives us less headaches to figure static vs RPA.

Regards

Marcel

