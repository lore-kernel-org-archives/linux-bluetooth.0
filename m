Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 1/2] Bluetooth: Don't call shutdown when leaving user channel
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432219601-3663-1-git-send-email-loic.poulain@intel.com>
Date: Sat, 6 Jun 2015 20:51:24 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <535AEF68-9F42-4E60-8E83-FB185F296060@holtmann.org>
References: <1432219601-3663-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Don't interfere with the user channel exclusive access.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> net/bluetooth/hci_core.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 476709b..5120fea 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1557,7 +1557,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> {
> 	BT_DBG("%s %p", hdev->name, hdev);
> 
> -	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
> +	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
> +	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {

this will conflict with the extra check we added that the device is actually HCI_UP.

> 		/* Execute vendor specific shutdown routine */
> 		if (hdev->shutdown)
> 			hdev->shutdown(hdev);

Regards

Marcel

