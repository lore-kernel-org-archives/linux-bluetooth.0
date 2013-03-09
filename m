Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v2 3/6] Bluetooth: Remove timeout handling from hci_cancel_le_scan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1362783979-10142-4-git-send-email-andre.guedes@openbossa.org>
Date: Fri, 8 Mar 2013 17:28:17 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <112A7600-CE46-4467-B45E-38FC61B90920@holtmann.org>
References: <1362783979-10142-1-git-send-email-andre.guedes@openbossa.org> <1362783979-10142-4-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch moves the LE scanning timeout handling from hci_cancel_
> le_scan helper to stop_discovery.
> 
> Since we want discovery code handling LE scanning timeout, we should
> handle it in stop_discovery instead of hci_cancel_le_scan.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_core.c | 14 +++++---------
> net/bluetooth/mgmt.c     | 15 ++++++++++++---
> 2 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 59f583b..200ec5a 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1905,20 +1905,16 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
> 
> int hci_cancel_le_scan(struct hci_dev *hdev)
> {
> +	struct hci_cp_le_set_scan_enable cp;
> +
> 	BT_DBG("%s", hdev->name);
> 
> 	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
> 		return -EALREADY;
> 
> -	if (cancel_delayed_work(&hdev->le_scan_disable)) {
> -		struct hci_cp_le_set_scan_enable cp;
> -
> -		/* Send HCI command to disable LE Scan */
> -		memset(&cp, 0, sizeof(cp));
> -		hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> -	}
> -
> -	return 0;
> +	/* Send HCI command to disable LE Scan */
> +	memset(&cp, 0, sizeof(cp));
> +	return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> }

so we have HCI request framework now and we keep using hci_send_cmd without checking if it fails or succeeds. I don't really think so. This needs to be done as a HCI request as well.

If you want a convenience helper for a single command with a complete callback, then please add that one, but sending commands where the error is not handling from hci_event.c is not acceptable.

Regards

Marcel

