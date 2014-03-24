Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2 3/4] Bluetooth: Add scan_rsp parameter to mgmt_device_found()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395650883-25577-3-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 24 Mar 2014 13:05:46 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5513FFE1-0934-4536-B1BC-819E30DC1144@holtmann.org>
References: <1395650883-25577-1-git-send-email-johan.hedberg@gmail.com> <1395650883-25577-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> In preparation for being able to merge ADV_IND/ADV_SCAN_IND and SCAN_RSP
> together into a single device found event add a second parameter to the
> mgmt_device_found function. For now all callers pass NULL as this
> parameters since we don't yet have caching of the last received
> advertising report.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  5 +++--
> net/bluetooth/hci_event.c        | 10 +++++-----
> net/bluetooth/mgmt.c             | 10 +++++++---
> 3 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 5f8bc05694ac..a1b8eab8a47d 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1264,8 +1264,9 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
> 				       u8 *randomizer192, u8 *hash256,
> 				       u8 *randomizer256, u8 status);
> void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> -		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name,
> -		       u8 ssp, u8 *eir, u16 eir_len);
> +		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name, u8
> +		       ssp, u8 *eir, u16 eir_len, u8 *scan_rsp,
> +		       u8 scan_rsp_len);
> void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len);
> void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 403c1d96331a..e7e9c1688402 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1797,7 +1797,7 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 		name_known = hci_inquiry_cache_update(hdev, &data, false, &ssp);
> 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
> 				  info->dev_class, 0, !name_known, ssp, NULL,
> -				  0);
> +				  0, NULL, 0);
> 	}
> 
> 	hci_dev_unlock(hdev);
> @@ -3068,7 +3068,7 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
> 							      false, &ssp);
> 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
> 					  info->dev_class, info->rssi,
> -					  !name_known, ssp, NULL, 0);
> +					  !name_known, ssp, NULL, 0, NULL, 0);
> 		}
> 	} else {
> 		struct inquiry_info_with_rssi *info = (void *) (skb->data + 1);
> @@ -3086,7 +3086,7 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
> 							      false, &ssp);
> 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
> 					  info->dev_class, info->rssi,
> -					  !name_known, ssp, NULL, 0);
> +					  !name_known, ssp, NULL, 0, NULL, 0);
> 		}
> 	}
> 
> @@ -3275,7 +3275,7 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
> 		eir_len = eir_get_length(info->data, sizeof(info->data));
> 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
> 				  info->dev_class, info->rssi, !name_known,
> -				  ssp, info->data, eir_len);
> +				  ssp, info->data, eir_len, NULL, 0);
> 	}
> 
> 	hci_dev_unlock(hdev);
> @@ -3952,7 +3952,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
> 	}
> 
> 	mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL, rssi, 0, 1,
> -			  data, len);
> +			  data, len, NULL, 0);
> }
> 
> static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index d2d4e0d5aed0..360822554e07 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5669,7 +5669,8 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
> 
> void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> 		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name, u8
> -		       ssp, u8 *eir, u16 eir_len)
> +		       ssp, u8 *eir, u16 eir_len, u8 *scan_rsp,
> +		       u8 scan_rsp_len)
> {
> 	char buf[512];
> 	struct mgmt_ev_device_found *ev = (void *) buf;
> @@ -5707,8 +5708,11 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> 		eir_len = eir_append_data(ev->eir, eir_len, EIR_CLASS_OF_DEV,
> 					  dev_class, 3);

        /* Leave 5 bytes for a potential CoD field */                            
        if (sizeof(*ev) + eir_len + 5 > sizeof(buf))                             
                return;       

doesn’t this check also need to be adjusted?

> 
> -	ev->eir_len = cpu_to_le16(eir_len);
> -	ev_size = sizeof(*ev) + eir_len;
> +	if (scan_rsp_len > 0)
> +		memcpy(ev->eir + eir_len, scan_rsp, scan_rsp_len);
> +
> +	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
> +	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
> 
> 	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
> }

Regards

Marcel

