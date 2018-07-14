Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v4 01/13] Bluetooth: Define default phys in hdev and set
 1M as default
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1531301495-14479-2-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Sat, 14 Jul 2018 18:47:41 +0200
Cc: linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <DF60112C-859A-4A2E-94EF-1BF6F7D879EC@holtmann.org>
References: <1531301495-14479-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1531301495-14479-2-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> 1M would be set as default and same would be set during power on
> if controller support SetDefaultPHY.
> 
> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
> ---
> include/net/bluetooth/hci.h      | 4 ++++
> include/net/bluetooth/hci_core.h | 3 +++
> net/bluetooth/hci_core.c         | 9 +++++----
> 3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 73e48be..664fe1e 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1514,6 +1514,10 @@ struct hci_cp_le_set_default_phy {
> 	__u8    rx_phys;
> } __packed;
> 
> +#define HCI_LE_SET_PHY_1M		0x01
> +#define HCI_LE_SET_PHY_2M		0x02
> +#define HCI_LE_SET_PHY_CODED		0x04
> +

scrap the _SET here since that make no sense to me. Just call out the PHY name.

Regards

Marcel

