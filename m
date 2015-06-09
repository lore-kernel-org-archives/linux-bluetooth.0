Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv2 2/2] Bluetooth: Reorder HCI user channel socket release
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433766521-2645-1-git-send-email-loic.poulain@intel.com>
Date: Tue, 9 Jun 2015 09:32:41 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AE181B35-192B-4B13-BDC5-EF447EFF912F@holtmann.org>
References: <1433766521-2645-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> The hci close method needs to know if we are in user channel context.
> Only add the index to mgmt once close is performed.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: Rebase on d24d81444f8 (HCI_UP test)
> net/bluetooth/hci_core.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index f6c9909..573711c 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1553,6 +1553,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> 	BT_DBG("%s %p", hdev->name, hdev);
> 
> 	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
> +	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> 	    test_bit(HCI_UP, &hdev->flags)) {
> 		/* Execute vendor specific shutdown routine */
> 		if (hdev->shutdown)

are you sure that this is the correct commit message. It sounds like you copied the one from patch 1/2.

Regards

Marcel

