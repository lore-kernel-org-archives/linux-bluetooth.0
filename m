Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [RFC 06/15] Bluetooth: Background scanning
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381965485-9159-7-git-send-email-andre.guedes@openbossa.org>
Date: Thu, 17 Oct 2013 11:31:26 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CA624B73-F848-407A-B7DB-10D564049EAF@holtmann.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org> <1381965485-9159-7-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds helpers to trigger and untrigger the background
> scanning. As long as the number of triggers are greater than zero,
> we keep the background scanning running. Once the number of triggers
> reaches zero, it is stopped.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h |  7 ++++
> net/bluetooth/hci_core.c         | 83 ++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 90 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 1e67da5..cb6458a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -288,6 +288,10 @@ struct hci_dev {
> 	__u8			scan_rsp_data[HCI_MAX_AD_LENGTH];
> 	__u8			scan_rsp_data_len;
> 
> +	/* This counter tracks the number of background scanning triggers
> +	 */
> +	atomic_t		background_scan_cnt;
> +
> 	int (*open)(struct hci_dev *hdev);
> 	int (*close)(struct hci_dev *hdev);
> 	int (*flush)(struct hci_dev *hdev);
> @@ -1191,4 +1195,7 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
> #define SCO_AIRMODE_CVSD       0x0000
> #define SCO_AIRMODE_TRANSP     0x0003
> 
> +int hci_trigger_background_scan(struct hci_dev *hdev);
> +int hci_untrigger_background_scan(struct hci_dev *hdev);
> +

instead of plastering the code with all these places it might be better to create a connection parameter hash that actually knows if it has any connection parameters stored that need require a passive scan now.

So instead of trigger and intriguer, the code that adds or removes the actual data from our hash can be the trigger itself. Since it knows better. And checking after disconnection or other cases becomes a lot simpler since you just check the hash if you should be connecting.

Regards

Marcel

