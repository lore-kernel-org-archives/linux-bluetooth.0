Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v3 06/18] Bluetooth: Define PHY flags in hdev and set 1M
 as default
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1530876944-17453-7-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Fri, 6 Jul 2018 22:56:52 +0200
Cc: linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <7642C481-01E5-430D-ACAC-CBB0FA47F595@holtmann.org>
References: <1530876944-17453-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1530876944-17453-7-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> 1M is mandatory to be supported by LE controllers and the same
> would be set in power on. This patch defines hdev flags for
> LE PHYs and set 1M to default.
> 
> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
> ---
> include/net/bluetooth/hci.h | 7 +++++++
> net/bluetooth/hci_core.c    | 4 ++++
> 2 files changed, 11 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 73e48be..1b5d79b 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -261,6 +261,13 @@ enum {
> 	HCI_FORCE_BREDR_SMP,
> 	HCI_FORCE_STATIC_ADDR,
> 
> +	HCI_LE_PHY_1M_TX,
> +	HCI_LE_PHY_1M_RX,
> +	HCI_LE_PHY_2M_TX,
> +	HCI_LE_PHY_2M_RX,
> +	HCI_LE_PHY_CODED_TX,
> +	HCI_LE_PHY_CODED_RX,
> +
> 	__HCI_NUM_FLAGS,
> };

so first of all, these are not yet defined as of patch 05/18 and I am not sure that using flags is the best choice here. You need to provide some reasoning why you did it this way.

Regards

Marcel

