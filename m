Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 15/15] Bluetooth: Auto connection and power off/on
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <2BA6ACEE-8390-48E0-883A-73738551FDDD@holtmann.org>
Date: Fri, 18 Oct 2013 11:08:23 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8891C54C-F2B0-400E-86F1-C869F54B991D@openbossa.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org> <1381965485-9159-16-git-send-email-andre.guedes@openbossa.org> <2BA6ACEE-8390-48E0-883A-73738551FDDD@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Oct 17, 2013, at 7:55 AM, Marcel Holtmann wrote:

> Hi Andre,
>=20
>> If hdev is closed (e.g. Mgmt power off command, RFKILL or controller =
is
>> reset), the established connections are dropped and no Disconnection
>> Complete Event is sent to host. This way, the background scan is not
>> triggered when devices configured with BT_AUTO_CONN_ALWAYS option
>> disconnect. To fix this issue, before dropping the LE connections, we
>> trigger the background scan for each connected device that requires
>> BT_AUTO_CONN_ALWAYS auto connection.
>>=20
>> Moreover, once the adapter is powered on, we should start the =
background
>> scan if we have triggers registered. This way, we keep the background
>> scan running after a power off and power on sequence.
>=20
> these are actually two independent patches.

I'll split this in two patches.

>=20
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> net/bluetooth/hci_conn.c | 35 +++++++++++++++++++++++++++++++++++
>> net/bluetooth/hci_core.c |  2 ++
>> 2 files changed, 37 insertions(+)
>>=20
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index 5caf13b..66823eb 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -954,6 +954,31 @@ timer:
>> 				   =
msecs_to_jiffies(hdev->idle_timeout));
>> }
>>=20
>> +static void le_conn_drop_fixup(struct hci_conn *conn)
>> +{
>> +	struct hci_dev *hdev =3D conn->hdev;
>> +	struct hci_conn_param *param;
>> +	int err;
>> +
>> +	param =3D hci_find_conn_param(hdev, &conn->dst, conn->dst_type);
>> +	if (!param)
>> +		return;
>> +
>> +	if (param->auto_connect !=3D BT_AUTO_CONN_ALWAYS)
>> +		goto done;
>> +
>> +	err =3D hci_trigger_background_scan(hdev);
>> +	if (err) {
>> +		BT_ERR("Failed to trigger background scanning: %d", =
err);
>> +		goto done;
>> +	}
>> +
>> +	param->bg_scan_triggered =3D true;
>> +
>> +done:
>> +	hci_conn_param_put(param);
>> +}
>> +
>> /* Drop all connection on the device */
>> void hci_conn_hash_flush(struct hci_dev *hdev)
>> {
>> @@ -963,6 +988,16 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
>> 	BT_DBG("hdev %s", hdev->name);
>>=20
>> 	list_for_each_entry_safe(c, n, &h->list, list) {
>> +		/* If this is a LE connection in connected state we =
should do
>> +		 * some fixup before dropping this connection. Since no
>> +		 * Disconnection Complete Event will be sent to the =
host, we
>> +		 * have to trigger the background scan in case this is a
>> +		 * BT_AUTO_CONN_ALWAYS device. This is handled by the =
le_conn_
>> +		 * drop_fixup() helper.
>> +		 */
>> +		if (c->type =3D=3D LE_LINK && c->state =3D=3D =
BT_CONNECTED)
>> +			le_conn_drop_fixup(c);
>> +
>> 		c->state =3D BT_CLOSED;
>=20
> I do not like this part. We already have the case where we need to =
re-enable advertising after a connection drops. So this should be in a =
common place. I do not want to hack this in into all kinds of places.

Ok, I'll follow the same approach we have for re-enable advertising.

Regards,

Andre=
