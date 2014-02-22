Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 12/15] Bluetooth: Update local RPA if necessary before enabling advertising
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393088805-28658-13-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 22 Feb 2014 10:17:02 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <DD706203-5727-4CDF-A5A3-4A02CE19E4ED@holtmann.org>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com> <1393088805-28658-13-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we enable advertising we need to regenerate the local RPA in case
> it has expired. This patch adds the necessary code for doing this in the
> enable_advertising function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 248f116e3d08..e3d8371a2493 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -842,6 +842,9 @@ static void enable_advertising(struct hci_request *req)
> 	struct hci_cp_le_set_adv_param cp;
> 	u8 enable = 0x01;
> 
> +	if (test_and_clear_bit(HCI_RPA_EXPIRED, &hdev->dev_flags))
> +		hci_update_rpa(req);
> +

same comment as the others. Lets also take the static address into account and make sure it up-to-date.

Regards

Marcel

