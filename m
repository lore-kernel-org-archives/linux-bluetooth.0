Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 11/15] Bluetooth: Update local RPA if necessary when connecting LE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393088805-28658-12-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 22 Feb 2014 10:12:48 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <B9C3C7DD-5E31-40D7-8EFB-0145C8D63612@holtmann.org>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com> <1393088805-28658-12-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we initiate LE connections we need to regenerate the local RPA in
> case it has expired. This patch adds the necessary code for doing this
> in the hci_create_le_conn function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_conn.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index bd66c52eff95..325b42afc61e 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -560,6 +560,9 @@ static int hci_create_le_conn(struct hci_conn *conn)
> 
> 	hci_req_init(&req, hdev);
> 
> +	if (test_and_clear_bit(HCI_RPA_EXPIRED, &hdev->dev_flags))
> +		hci_update_rpa(&req);
> +

and if privacy is not enabled, we should make sure the static address is the one that the controller currently knows about.

As explained in my other comment, this will make it long term a lot simpler. Maybe you want to introduce a helper for updating the random address. That why we just call it in certain places and it takes care of either writing a new RPA or it makes sure the static is set in case it differs.

Regards

Marcel

