Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH] Bluetooth: Add conn type to identify addr type with SMP
 over BR/EDR
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1476448183-8630-1-git-send-email-jiangbo.wu@intel.com>
Date: Fri, 14 Oct 2016 14:39:26 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <46A11791-AE7E-4064-94EC-D824C875FB37@holtmann.org>
References: <1476448183-8630-1-git-send-email-jiangbo.wu@intel.com>
To: jiangbo.wu@intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jiangbo,

> SMP over BR/EDR distributes keys when encryption key changed. It should
> use correct address type with link.
> 
> Signed-off-by: Jiangbo Wu <jiangbo.wu@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  8 +++++---
> net/bluetooth/mgmt.c             | 14 ++++++++------
> net/bluetooth/smp.c              | 10 +++++-----
> 3 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index f00bf66..caa8254 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1509,9 +1509,11 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len);
> void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
> bool mgmt_powering_down(struct hci_dev *hdev);
> -void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent);
> -void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent);
> -void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
> +void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 link_type,
> +		  bool persistent);
> +void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, u8 link_type,
> +		  bool persistent);
> +void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk, u8 link_type,
> 		   bool persistent);
> void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
> 			 u8 bdaddr_type, u8 store_hint, u16 min_interval,
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 19b8a5e..2b12b72 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -6757,7 +6757,8 @@ static u8 mgmt_ltk_type(struct smp_ltk *ltk)
> 	return MGMT_LTK_UNAUTHENTICATED;
> }
> 
> -void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
> +void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 link_type,
> +		  bool persistent)
> {
> 	struct mgmt_ev_new_long_term_key ev;
> 
> @@ -6781,7 +6782,7 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
> 		ev.store_hint = persistent;
> 
> 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
> -	ev.key.addr.type = link_to_bdaddr(LE_LINK, key->bdaddr_type);
> +	ev.key.addr.type = link_to_bdaddr(link_type, key->bdaddr_type);

what am I missing here. LTK, IRK and CRSK are only valid for LE links. So even if they are transported over BR/EDR, they are meant for the LE link and not BR/EDR link.

Regards

Marcel

