Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Andre Guedes <andre.guedes@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v2 7/9] Bluetooth: Add 'eir_len' param to
 mgmt_device_found()
Date: Sun, 27 Nov 2011 06:37:34 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B02641647C@DNCE02.ent.ti.com>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
 <1322265226-6404-8-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1322265226-6404-8-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Andre,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Andre Guedes
> Sent: Saturday, November 26, 2011 1:54 AM
> To: linux-bluetooth@vger.kernel.org
> Subject: [PATCH v2 7/9] Bluetooth: Add 'eir_len' param to
> mgmt_device_found()
> 
> This patch adds a new parameter to mgmt_device_found() to inform
> the length of 'eir' pointer.
> 
> EIR data from LE advertising report event doesn't have a fixed length
> as EIR data from extended inquiry result event does. We needed to
> change mgmt_device_found() so it copies 'eir_len' bytes instead of
> HCI_MAX_EIR_LENGTH.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |    3 ++-
>  net/bluetooth/hci_event.c        |    9 +++++----
>  net/bluetooth/mgmt.c             |    8 ++++++--
>  3 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h
> b/include/net/bluetooth/hci_core.h
> index db137ca..a4ac427 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -951,7 +951,8 @@ int mgmt_set_local_name_complete(struct hci_dev
> *hdev, u8 *name, u8 status);
>  int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8
> *hash,
>  						u8 *randomizer, u8 status);
>  int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8
> link_type,
> -				u8 addr_type, u8 *dev_class, s8 rssi, u8 *eir);
> +					u8 addr_type, u8 *dev_class, s8 rssi,
> +					u8 *eir,  u8 eir_len);
>  int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8
> *name);
>  int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status);
>  int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index ea09c11..865fdf6 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1460,7 +1460,7 @@ static inline void hci_inquiry_result_evt(struct
> hci_dev *hdev, struct sk_buff *
>  		data.ssp_mode		= 0x00;
>  		hci_inquiry_cache_update(hdev, &data);
>  		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
> -						info->dev_class, 0, NULL);
> +						info->dev_class, 0, NULL, 0);
>  	}
> 
>  	hci_dev_unlock(hdev);
> @@ -2474,7 +2474,7 @@ static inline void
> hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
>  			hci_inquiry_cache_update(hdev, &data);
>  			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK,
> 0x00,
>  						info->dev_class, info->rssi,
> -						NULL);
> +						NULL, 0);
>  		}
>  	} else {
>  		struct inquiry_info_with_rssi *info = (void *) (skb->data +
> 1);
> @@ -2491,7 +2491,7 @@ static inline void
> hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
>  			hci_inquiry_cache_update(hdev, &data);
>  			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK,
> 0x00,
>  						info->dev_class, info->rssi,
> -						NULL);
> +						NULL, 0);
>  		}
>  	}
> 
> @@ -2633,7 +2633,8 @@ static inline void
> hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
>  		data.ssp_mode		= 0x01;
>  		hci_inquiry_cache_update(hdev, &data);
>  		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
> -				info->dev_class, info->rssi, info->data);
> +					info->dev_class, info->rssi,
> +					info->data, sizeof(info->data));
>  	}
> 
>  	hci_dev_unlock(hdev);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index c06a05c..6a74955 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2590,10 +2590,14 @@ int
> mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
>  }
> 
>  int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8
> link_type,
> -				u8 addr_type, u8 *dev_class, s8 rssi, u8 *eir)
> +					u8 addr_type, u8 *dev_class, s8 rssi,
> +					u8 *eir, u8 eir_len)
>  {
>  	struct mgmt_ev_device_found ev;
> 
> +	if (eir_len > sizeof(ev.eir))
> +		return -EINVAL;
> +
>  	memset(&ev, 0, sizeof(ev));
> 
>  	bacpy(&ev.addr.bdaddr, bdaddr);
> @@ -2601,7 +2605,7 @@ int mgmt_device_found(struct hci_dev *hdev,
> bdaddr_t *bdaddr, u8 link_type,
>  	ev.rssi = rssi;
> 
>  	if (eir)
> -		memcpy(ev.eir, eir, sizeof(ev.eir));
> +		memcpy(ev.eir, eir, eir_len);
> 
>  	if (dev_class)
>  		memcpy(ev.dev_class, dev_class, sizeof(ev.dev_class));
> --
> 1.7.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Why do we really need this ? The GAP Spec clearly defines a fixed advertising size of 31 octets (Vol3, Part C, Section 11). Instead of reporting how much we got (may be other than 31 if the peer device does not conform to the spec as required), we should make sure that BlueZ will always report 31 octets, and make sure that the device found event always sends a buffer of 31 octets.

Thanks,
Chen Ganir

