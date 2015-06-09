Return-Path: <cyrus@holtmann.org>
From: "Poulain, Loic" <loic.poulain@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCHv2 2/2] Bluetooth: Reorder HCI user channel socket release
Date: Tue, 9 Jun 2015 09:37:22 +0000
Message-ID: <50C3158CF44D924791C15F1437EF2EC62ABC96A7@HASMSX105.ger.corp.intel.com>
References: <1433766521-2645-1-git-send-email-loic.poulain@intel.com>,<AE181B35-192B-4B13-BDC5-EF447EFF912F@holtmann.org>
In-Reply-To: <AE181B35-192B-4B13-BDC5-EF447EFF912F@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Oops, you're right.

Regards,
Loic
________________________________________
From: Marcel Holtmann [marcel@holtmann.org]
Sent: Tuesday, June 09, 2015 9:32 AM
To: Poulain, Loic
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 2/2] Bluetooth: Reorder HCI user channel socket release

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
>       BT_DBG("%s %p", hdev->name, hdev);
>
>       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
> +         !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
>           test_bit(HCI_UP, &hdev->flags)) {
>               /* Execute vendor specific shutdown routine */
>               if (hdev->shutdown)

are you sure that this is the correct commit message. It sounds like you copied the one from patch 1/2.

Regards

Marcel

