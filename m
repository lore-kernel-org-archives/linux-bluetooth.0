Return-Path: <cyrus@holtmann.org>
Message-ID: <1359256529.16748.24.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Fix link security setting when powering
 on
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 27 Jan 2013 04:15:29 +0100
In-Reply-To: <1359239630-3579-1-git-send-email-johan.hedberg@gmail.com>
References: <1359239630-3579-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If a controller is powered on while the HCI_AUTO_OFF flag is set the
> link security setting (HCI_LINK_SECURITY) might not be in sync with the
> actual state of the controller (HCI_AUTH). This patch fixes the issue by
> checking for inequality between the intended and actual settings and
> sends a HCI_Write_Auth_Enable command if necessary.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index fbc8edf..f6ef8ff 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3096,6 +3096,13 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
>  					     sizeof(cp), &cp);
>  		}
>  
> +		if (test_bit(HCI_LINK_SECURITY, &hdev->dev_flags) !=
> +		    test_bit(HCI_AUTH, &hdev->flags)) {
> +			u8 val = test_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
> +			hci_send_cmd(hdev, HCI_OP_WRITE_AUTH_ENABLE,
> +				     sizeof(val), &val);
> +		}

why not actually just test for the value and store its result, then
compare and then use the value. Testing HCI_LINK_SECURITY twice seems a
bit too much.

Regards

Marcel


