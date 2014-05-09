Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2 1/6] Bluetooth: Store TX power level for connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1399664133-2892-2-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Fri, 9 May 2014 14:17:22 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FFAD6A25-BBCA-479C-8597-F8286668E412@holtmann.org>
References: <1399664133-2892-1-git-send-email-andrzej.kaczmarek@tieto.com> <1399664133-2892-2-git-send-email-andrzej.kaczmarek@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> This patch adds support to store local TX power level for connection
> when reply for HCI_Read_Transmit_Power_Level is received.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
> include/net/bluetooth/hci.h      | 11 +++++++++++
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_conn.c         |  1 +
> net/bluetooth/hci_event.c        | 29 +++++++++++++++++++++++++++++
> 4 files changed, 42 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index ad2ecc9..201a09a 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1054,6 +1054,17 @@ struct hci_cp_write_page_scan_activity {
> 	__le16   window;
> } __packed;
> 
> +#define HCI_OP_READ_TX_POWER_LEVEL	0x0c2d
> +struct hci_cp_read_tx_power_level {
> +	__le16   handle;
> +	__u8     type;
> +} __packed;
> +struct hci_rp_read_tx_power_level {
> +	__u8     status;
> +	__le16   handle;
> +	__s8     tx_power_level;
> +} __packed;

I applied this patch to bluetooth-next tree, but I replaced tx_power_level with tx_power to make it more consistent with what all the other tx_power structs and defines have.

Regards

Marcel

