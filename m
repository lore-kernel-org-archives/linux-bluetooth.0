Return-Path: <jiangbo.wu@intel.com>
From: "Wu, Jiangbo" <jiangbo.wu@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: Add conn type to identify addr type with SMP
 over BR/EDR
Date: Fri, 14 Oct 2016 13:20:11 +0000
Message-ID: <ACB402E679F3454EAE433BF5E93F4EAA389960DF@shsmsx102.ccr.corp.intel.com>
References: <1476448183-8630-1-git-send-email-jiangbo.wu@intel.com>
 <46A11791-AE7E-4064-94EC-D824C875FB37@holtmann.org>
In-Reply-To: <46A11791-AE7E-4064-94EC-D824C875FB37@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

If pair a device that unpair firstly that remove encryption key, encryption=
 key event will be emitted. kernel will receive 'L2CAP_CID_SMP_BREDR' frame=
, and then it will use SMP to distribute key.  SMP would like to use LTK, I=
RK and CRSK to notify user. If it don't identify device by which conn type =
they are, only marks LE as the device type, while Bluetoothd will use this =
'addr' and 'addr type' to reply the comfirm to kernel. At the same time ker=
nel always uses them to lookup hci_conn in LE hashtable firstly, because ad=
dr type always marks as LE. Obviously it will failed with SMP over BR/EDR.

Actually, SPM is only for LE in SPEC, but kernel already support and use SM=
P over BR/EDR. if BR/EDR exchanges key with SMP, it will never reply pairin=
g response to remote, in other words it will be never paired, that is happe=
ned in our products.

Thanks
Jiangbo

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@v=
ger.kernel.org] On Behalf Of Marcel Holtmann
Sent: Friday, October 14, 2016 8:39 PM
To: Wu, Jiangbo <jiangbo.wu@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add conn type to identify addr type with SM=
P over BR/EDR

Hi Jiangbo,

> SMP over BR/EDR distributes keys when encryption key changed. It=20
> should use correct address type with link.
>=20
> Signed-off-by: Jiangbo Wu <jiangbo.wu@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  8 +++++---
> net/bluetooth/mgmt.c             | 14 ++++++++------
> net/bluetooth/smp.c              | 10 +++++-----
> 3 files changed, 18 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/net/bluetooth/hci_core.h=20
> b/include/net/bluetooth/hci_core.h
> index f00bf66..caa8254 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1509,9 +1509,11 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr=
_t *bdaddr, u8 link_type,
> 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len); void=20
> mgmt_discovering(struct hci_dev *hdev, u8 discovering); bool=20
> mgmt_powering_down(struct hci_dev *hdev); -void mgmt_new_ltk(struct=20
> hci_dev *hdev, struct smp_ltk *key, bool persistent); -void=20
> mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool=20
> persistent); -void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk=20
> *csrk,
> +void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 link_typ=
e,
> +		  bool persistent);
> +void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, u8 link_typ=
e,
> +		  bool persistent);
> +void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk, u8=20
> +link_type,
> 		   bool persistent);
> void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
> 			 u8 bdaddr_type, u8 store_hint, u16 min_interval, diff --git=20
> a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c index 19b8a5e..2b12b72=20
> 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -6757,7 +6757,8 @@ static u8 mgmt_ltk_type(struct smp_ltk *ltk)
> 	return MGMT_LTK_UNAUTHENTICATED;
> }
>=20
> -void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool=20
> persistent)
> +void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 link_typ=
e,
> +		  bool persistent)
> {
> 	struct mgmt_ev_new_long_term_key ev;
>=20
> @@ -6781,7 +6782,7 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_=
ltk *key, bool persistent)
> 		ev.store_hint =3D persistent;
>=20
> 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
> -	ev.key.addr.type =3D link_to_bdaddr(LE_LINK, key->bdaddr_type);
> +	ev.key.addr.type =3D link_to_bdaddr(link_type, key->bdaddr_type);

what am I missing here. LTK, IRK and CRSK are only valid for LE links. So e=
ven if they are transported over BR/EDR, they are meant for the LE link and=
 not BR/EDR link.

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" =
in the body of a message to majordomo@vger.kernel.org More majordomo info a=
t  http://vger.kernel.org/majordomo-info.html
