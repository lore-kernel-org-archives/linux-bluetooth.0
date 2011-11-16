Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 6/6] Bluetooth: Support LE-Only discovery procedure
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1321080225.15441.417.camel@aeonflux>
Date: Wed, 16 Nov 2011 17:25:00 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A37EF08F-5B90-43F3-AA5B-BE0FD282E3D7@openbossa.org>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org> <1321051824-5216-7-git-send-email-andre.guedes@openbossa.org> <1321080225.15441.417.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Nov 12, 2011, at 3:43 AM, Marcel Holtmann wrote:

> Hi Andre,
>=20
>> This patch adds support for LE-Only discovery procedure through
>> management interface.
>>=20
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/hci.h      |    1 +
>> include/net/bluetooth/hci_core.h |    1 +
>> net/bluetooth/hci_event.c        |   25 ++++++++++++++++++++++---
>> net/bluetooth/mgmt.c             |   25 +++++++++++++++++++++++--
>> 4 files changed, 47 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/include/net/bluetooth/hci.h =
b/include/net/bluetooth/hci.h
>> index bd3cecd..ca09998 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -210,6 +210,7 @@ enum {
>>=20
>> #define LMP_EV4		0x01
>> #define LMP_EV5		0x02
>> +#define LMP_NO_BREDR	0x20
>> #define LMP_LE		0x40
>>=20
>> #define LMP_SNIFF_SUBR	0x02
>> diff --git a/include/net/bluetooth/hci_core.h =
b/include/net/bluetooth/hci_core.h
>> index 9da5b69..55b78ec 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -678,6 +678,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>> #define lmp_ssp_capable(dev)       ((dev)->features[6] & =
LMP_SIMPLE_PAIR)
>> #define lmp_no_flush_capable(dev)  ((dev)->features[6] & =
LMP_NO_FLUSH)
>> #define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
>> +#define lmp_bredr_capable(dev)     (!((dev)->features[4] & =
LMP_NO_BREDR))
>=20
> can you just split this into a separate patch first. We can just go
> ahead and merge it.
>=20
>> /* ----- Extended LMP capabilities ----- */
>> #define lmp_host_le_capable(dev)   ((dev)->extfeatures[0] & =
LMP_HOST_LE)
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index dcbbffe..037c7c0 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -954,24 +954,43 @@ static void hci_cc_le_set_scan_enable(struct =
hci_dev *hdev,
>>=20
>> 	BT_DBG("%s status 0x%x", hdev->name, status);
>>=20
>> -	if (status)
>> -		return;
>> -
>> 	cp =3D hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
>> 	if (!cp)
>> 		return;
>>=20
>> 	if (cp->enable =3D=3D 0x01) {
>> +		if (status) {
>> +			hci_dev_lock(hdev);
>> +			mgmt_start_discovery_failed(hdev, status);
>> +			hci_dev_unlock(hdev);
>> +			return;
>> +		}
>> +
>> 		set_bit(HCI_LE_SCAN, &hdev->hci_flags);
>>=20
>> 		del_timer(&hdev->adv_timer);
>>=20
>> 		hci_dev_lock(hdev);
>> +
>> +		mgmt_discovering(hdev, 1);
>> +
>> 		hci_adv_entries_clear(hdev);
>> +
>> 		hci_dev_unlock(hdev);
>> 	} else if (cp->enable =3D=3D 0x00) {
>> +		if (status) {
>> +			hci_dev_lock(hdev);
>> +			mgmt_stop_discovery_failed(hdev, status);
>> +			hci_dev_unlock(hdev);
>> +			return;
>> +		}
>> +
>> 		clear_bit(HCI_LE_SCAN, &hdev->hci_flags);
>>=20
>> +		hci_dev_lock(hdev);
>> +		mgmt_discovering(hdev, 0);
>> +		hci_dev_unlock(hdev);
>> +
>> 		mod_timer(&hdev->adv_timer, jiffies + =
ADV_CLEAR_TIMEOUT);
>> 	}
>> }
>=20
> This part looks fine to me.
>=20
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index b63a7d0..6ca6e5d 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -32,7 +32,16 @@
>> #define MGMT_VERSION	0
>> #define MGMT_REVISION	1
>>=20
>> -#define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
>> +/*
>> + * These LE scan and inquiry parameters were chosen according to LE =
General
>> + * Discovery Procedure specification.
>> + */
>> +#define LE_SCAN_TYPE 0x01
>> +#define LE_SCAN_WIN 0x12
>> +#define LE_SCAN_INT 0x12
>> +#define LE_SCAN_TIMEOUT_LE_ONLY 10240		/* =
TGAP(gen_disc_scan_min) */
>> +
>> +#define INQUIRY_LEN_BREDR 0x08			/* TGAP(100) */
>>=20
>> struct pending_cmd {
>> 	struct list_head list;
>> @@ -1669,7 +1678,16 @@ static int start_discovery(struct sock *sk, =
u16 index)
>> 		goto failed;
>> 	}
>>=20
>> -	err =3D hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
>> +	if (lmp_host_le_capable(hdev)) {
>> +		if (lmp_bredr_capable(hdev))
>> +			err =3D -ENOSYS;
>> +		else
>> +			err =3D hci_do_le_scan(hdev, LE_SCAN_TYPE, =
LE_SCAN_INT,
>> +					LE_SCAN_WIN, =
LE_SCAN_TIMEOUT_LE_ONLY);
>> +	} else {
>> +		err =3D hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
>> +	}
>> +
>> 	if (err < 0)
>> 		mgmt_pending_remove(cmd);
>>=20
>> @@ -1701,6 +1719,9 @@ static int stop_discovery(struct sock *sk, u16 =
index)
>> 	}
>>=20
>> 	err =3D hci_cancel_inquiry(hdev);
>> +	if (err =3D=3D -EPERM)
>> +		err =3D hci_cancel_le_scan(hdev);
>> +
>=20
> And here, I have a serious problem with how the code is done. I =
realize
> that from using hdev->flags this ends up this crappy, but this is not
> how I wanna see things done.
>=20
> What you are doing is this:
>=20
> - We call a complete unrelated function anyway
> - And if it fails with a specific error code then we call something
>  else instead
>=20
> I think it becomes pretty obvious now that we should just have had
> hdev->mgmt_flags that tell us with discovery procedure is running =
right
> now. And thus we know how to cancel it.

I'm not sure this will help us in case we have a interleaved discovery
running. My point is, even if we know what discovery procedure is =
running,
we need to know what the controller is doing right now (inquiring or le
scanning) so we can properly stop it, and, therefore, stop the ongoing
discovery procedure. IOW, telling us we have a interleaved discovery
running does not help us to decide the right function to call
(hci_cancel_inquiry or hci_cancel_le_scan).

So, I think we need to check the controller flags (HCI_INQUIRY and
HCI_LE_SCAN) in order to stop the ongoing discovery procedure properly.

BR,

Andre
