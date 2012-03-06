Return-Path: <cyrus@holtmann.org>
Date: Tue, 6 Mar 2012 20:07:30 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Add hci_cancel_le_scan() to hci_core
Message-ID: <20120306230730.GA8386@joana>
References: <1331074474-12868-1-git-send-email-andre.guedes@openbossa.org>
 <1331074474-12868-2-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331074474-12868-2-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2012-03-06 19:54:33 -0300]:

> This patch adds to hci_core the hci_cancel_le_scan function which
> should be used to cancel an ongoing LE scan.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |   21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 25cb0a1..0db2934 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1072,5 +1072,6 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 length);
>  int hci_cancel_inquiry(struct hci_dev *hdev);
>  int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
>  								int timeout);
> +int hci_cancel_le_scan(struct hci_dev *hdev);
>  
>  #endif /* __HCI_CORE_H */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 661d65f..0c2ceaa 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1672,6 +1672,27 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
>  	return 0;
>  }
>  
> +int hci_cancel_le_scan(struct hci_dev *hdev)
> +{
> +	bool canceled;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
> +		return -EPERM;

Are you sure about this -EPERM return error here? At a glance -EALREADY looks
better to me.

	Gustavo
