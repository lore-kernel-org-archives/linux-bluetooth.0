Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 6/8] Bluetooth: Make min interval for connection information configurable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1399555935-702-7-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Thu, 8 May 2014 08:27:43 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B58AFB5D-E47F-4FCF-810E-64DACBFC5BAB@holtmann.org>
References: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com> <1399555935-702-7-git-send-email-andrzej.kaczmarek@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> This patch adds debugfs entry to configure minimum interval between
> refreshing data using Get Connection Information request. Default value
> is 2000ms.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
> include/net/bluetooth/hci_core.h | 3 +++
> net/bluetooth/hci_core.c         | 4 ++++
> net/bluetooth/mgmt.c             | 5 ++---
> 3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 8d7d48b..a1eb022 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -145,6 +145,8 @@ struct oob_data {
> /* Default LE RPA expiry time, 15 minutes */
> #define HCI_DEFAULT_RPA_TIMEOUT		(15 * 60)
> 
> +#define DEFAULT_CONN_INFO_INTERVAL	2000
> +
> struct amp_assoc {
> 	__u16	len;
> 	__u16	offset;
> @@ -200,6 +202,7 @@ struct hci_dev {
> 	__u16		le_conn_min_interval;
> 	__u16		le_conn_max_interval;
> 	__u16		discov_interleaved_timeout;
> +	__u16		conn_info_interval;
> 	__u8		ssp_debug_mode;

the name should be either conn_info_max_age or conn_info_lifetime. It is not an interval since we are not the ones doing the polling.

Regards

Marcel

