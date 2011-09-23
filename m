Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4 13/14] Bluetooth: Support LE-Only discovery procedure
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1316523616.1937.97.camel@aeonflux>
Date: Fri, 23 Sep 2011 16:16:13 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5461DBB7-31A9-4972-B6B2-B7090BAF380D@openbossa.org>
References: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org> <1316468136-12472-14-git-send-email-andre.guedes@openbossa.org> <1316523616.1937.97.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sep 20, 2011, at 10:00 AM, Marcel Holtmann wrote:

> Hi Andre,
>=20
>> This patch adds support for LE-Only discovery procedure through
>> management interface.
>>=20
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> net/bluetooth/hci_event.c |   16 +++++++++++++---
>> net/bluetooth/mgmt.c      |   13 ++++++++++++-
>> 2 files changed, 25 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 5bbba54..0408c50 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -889,14 +889,16 @@ static void hci_cc_le_set_scan_enable(struct =
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
>> +			mgmt_discovery_complete(hdev->id, status);
>> +			return;
>> +		}
>> +
>> 		set_bit(HCI_LE_SCAN, &hdev->flags);
>>=20
>> 		mgmt_discovering(hdev->id, 1);
>> @@ -906,7 +908,15 @@ static void hci_cc_le_set_scan_enable(struct =
hci_dev *hdev,
>> 		hci_dev_lock(hdev);
>> 		hci_adv_entries_clear(hdev);
>> 		hci_dev_unlock(hdev);
>> +
>> +		if (mgmt_has_pending_stop_discov(hdev->id))
>> +			hci_cancel_le_scan(hdev);
>> 	} else if (cp->enable =3D=3D 0x00) {
>> +		mgmt_discovery_complete(hdev->id, status);
>> +
>> +		if (status)
>> +			return;
>> +
>> 		clear_bit(HCI_LE_SCAN, &hdev->flags);
>>=20
>> 		mgmt_discovering(hdev->id, 0);
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 1eee5cc..e869422 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -32,6 +32,14 @@
>> #define MGMT_VERSION	0
>> #define MGMT_REVISION	1
>>=20
>> +/*
>> + * These LE scan and inquiry parameters were chosen according to LE =
General
>> + * Discovery Procedure specification.
>> + */
>> +#define LE_SCAN_TYPE 0x01
>> +#define LE_SCAN_WIN 0x12
>> +#define LE_SCAN_INT 0x12
>> +#define LE_SCAN_TIMEOUT_LE_ONLY 10240 /* TGAP(gen_disc_scan_min) */
>=20
> And an extra empty line here to make clear these a independent values.

Ok, I'll do it.

>> #define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
>>=20
>> struct pending_cmd {
>> @@ -1637,7 +1645,8 @@ static int start_discovery(struct sock *sk, u16 =
index)
>> 	if (lmp_host_le_capable(hdev) && lmp_bredr_capable(hdev))
>> 		err =3D -ENOSYS;
>> 	else if (lmp_host_le_capable(hdev))
>> -		err =3D -ENOSYS;
>> +		err =3D hci_do_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
>> +					LE_SCAN_WIN, =
LE_SCAN_TIMEOUT_LE_ONLY);
>> 	else
>> 		err =3D hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
>>=20
>> @@ -1684,6 +1693,8 @@ static int stop_discovery(struct sock *sk, u16 =
index)
>>=20
>> 	if (test_bit(HCI_INQUIRY, &hdev->flags))
>> 		err =3D hci_cancel_inquiry(hdev);
>> +	else if (test_bit(HCI_LE_SCAN, &hdev->flags))
>> +		err =3D hci_cancel_le_scan(hdev);
>> 	else
>> 		err =3D 0;
>>=20
>=20
> I see where you wanna go with this now. I am a bit afraid of the code
> complexity with the discovery stop/start/complete etc. messages.
>=20
> This is all too much done differently for 3 different possible use
> cases. And I just think we need more general handling. For example:
>=20
> 	inquiry_started()
> 	inquiry_result()
> 	inquiry_completed()
> 	le_scan_started()
> 	le_scan_result()
> 	le_scan_completed()
>=20
> And based on the controller capabilities, the current states etc. a
> central place decides to send out which events at which time and to
> allow certain commands or not.
>=20
> If we do not centralize this, then I am afraid we duplicate this logic
> three times.

Not sure I get the idea right. Why would we repeat this logic three
times?

BTW, I don't see discovery logic too complex. We have, basically,
three main functions:

mgmt_start_discovery: based on device capabilities it initializes
the right discovery procedure.

mgmt_stop_discovery: based on the current device state it cancels
the ongoing discovery procedure.

mgmt_discovery_complete: once the discovery procedure is finished
(it doesn't matter if the discovery procedure was canceled by a
mgmt stop discovery command, a hci command failed or it finished
successfully) this function does the proper handling of mgmt
discovery pending commands and decides which event is sent to
userspace. So, we have the whole discovery procedure termination
logic centralized in this function.

BR,

Andre=
