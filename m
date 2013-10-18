Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 02/15] Bluetooth: Mgmt command for adding connection parameters
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <BA029FAA-265C-47A8-953F-95E6B504941B@holtmann.org>
Date: Fri, 18 Oct 2013 11:07:54 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <277F0893-63EA-4740-93EF-9558D02BE555@openbossa.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org> <1381965485-9159-3-git-send-email-andre.guedes@openbossa.org> <BA029FAA-265C-47A8-953F-95E6B504941B@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Oct 17, 2013, at 6:22 AM, Marcel Holtmann wrote:

> Hi Andre,
>=20
>> This patch introduces a new Mgmt command (MGMT_OP_ADD_CONN_PARAM) =
which
>> adds the connection parameters to controller's connection parameters
>> list. These parameters will be used by the kernel when it establishes =
a
>> connection with the given device.
>>=20
>> This patch also moves the 'auto_connect' enum from hci_core.h to
>> bluetooth.h since the will accessed used by userspace in order to
>> send the MGMT_OP_ADD_CONN_PARAM command.
>=20
> the comment about userspace makes no sense. And is not an argument to =
move the enum anywhere. Also if these are mgmt "modes" or "types" then =
they should be somewhere else and not in bluetooth.h.

Ok, so for now I'll leave these macros in hci_core.h.

>=20
>>=20
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/bluetooth.h |  6 ++++++
>> include/net/bluetooth/hci_core.h  |  6 +-----
>> include/net/bluetooth/mgmt.h      |  9 +++++++++
>> net/bluetooth/mgmt.c              | 35 =
+++++++++++++++++++++++++++++++++++
>> 4 files changed, 51 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/include/net/bluetooth/bluetooth.h =
b/include/net/bluetooth/bluetooth.h
>> index bf2ddff..8509520 100644
>> --- a/include/net/bluetooth/bluetooth.h
>> +++ b/include/net/bluetooth/bluetooth.h
>> @@ -354,4 +354,10 @@ void sco_exit(void);
>>=20
>> void bt_sock_reclassify_lock(struct sock *sk, int proto);
>>=20
>> +enum {
>> +	BT_AUTO_CONN_DISABLED,
>> +	BT_AUTO_CONN_ALWAYS,
>> +	BT_AUTO_CONN_LINK_LOSS,
>> +};
>> +
>> #endif /* __BLUETOOTH_H */
>> diff --git a/include/net/bluetooth/hci_core.h =
b/include/net/bluetooth/hci_core.h
>> index 5052bf0..98be273 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -376,11 +376,7 @@ struct hci_conn_param {
>> 	bdaddr_t addr;
>> 	u8 addr_type;
>>=20
>> -	enum {
>> -		HCI_AUTO_CONN_DISABLED,
>> -		HCI_AUTO_CONN_ALWAYS,
>> -		HCI_AUTO_CONN_LINK_LOSS,
>> -	} auto_connect;
>> +	u8 auto_connect;
>>=20
>> 	u16 min_conn_interval;
>> 	u16 max_conn_interval;
>> diff --git a/include/net/bluetooth/mgmt.h =
b/include/net/bluetooth/mgmt.h
>> index 518c5c8..ed689b5 100644
>> --- a/include/net/bluetooth/mgmt.h
>> +++ b/include/net/bluetooth/mgmt.h
>> @@ -369,6 +369,15 @@ struct mgmt_cp_set_scan_params {
>> } __packed;
>> #define MGMT_SET_SCAN_PARAMS_SIZE	4
>>=20
>> +#define MGMT_OP_ADD_CONN_PARAM		0x002D
>> +struct mgmt_cp_add_conn_param {
>> +	struct mgmt_addr_info addr;
>> +	__u8 auto_connect;
>> +	__le16 min_conn_interval;
>> +	__le16 max_conn_interval;
>> +} __packed;
>> +#define MGMT_ADD_CONN_PARAM_SIZE	(MGMT_ADDR_INFO_SIZE + 5)
>> +
>> #define MGMT_EV_CMD_COMPLETE		0x0001
>> struct mgmt_ev_cmd_complete {
>> 	__le16	opcode;
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index a727b47..5d1a2e8 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -79,6 +79,7 @@ static const u16 mgmt_commands[] =3D {
>> 	MGMT_OP_SET_BREDR,
>> 	MGMT_OP_SET_STATIC_ADDRESS,
>> 	MGMT_OP_SET_SCAN_PARAMS,
>> +	MGMT_OP_ADD_CONN_PARAM,
>> };
>=20
> So my 2nd patch wouldn't have been the mgmt command. I would have put =
all the cleanup and infrastructure changes in first. And I would have =
turned the connect() into the first user with a mode of "connect once" =
and default connection parameters.
>=20
> This clearly shows later on where all this magic handling comes into =
place. But in the end, the connect() call is just a connect once type of =
passive scanning. And maybe with learned connection slave interval =
values from advertising data during the scanning.

In v2, I'll put this patch after the infrastructure changes.

I didn't know we want to change connect() behavior. What is the issue we =
are trying address with this changing?

>=20
> The other problem that I have is that we can never update the =
parameters for a device. We need to remove them and re-add them. That is =
just not a good idea since we will almost certainly learn about updated =
values here. And maybe even change the mode of a device.

These connection parameters and auto connection policy is pretty much =
static values. We know ahead configuring the kernel what profiles the =
device supports. And the profiles the device supports don't dynamically =
change.

>=20
> In general just having one Update Connection Parameters call might be =
better. The kernel can happily just expire values from connection once =
or disabled by itself. So this needs a bit more discussion. Doing the =
mgmt interface last would allow to get all the other patches merged. =
Otherwise you are stuck on the mgmt part until we figure that out.

Sure we need more discussion on this. As I said, I'll move this mgmt =
command patches to the end of this patch set.

>=20
>> static const u16 mgmt_events[] =3D {
>> @@ -4025,6 +4026,39 @@ static int load_long_term_keys(struct sock =
*sk, struct hci_dev *hdev,
>> 	return err;
>> }
>>=20
>> +static int add_conn_param(struct sock *sk, struct hci_dev *hdev, =
void *cp_data,
>> +			  u16 len)
>> +{
>> +	struct mgmt_cp_add_conn_param *cp =3D cp_data;
>> +	u8 status;
>> +	u8 addr_type;
>> +
>> +	if (cp->addr.type =3D=3D BDADDR_BREDR)
>> +		return cmd_complete(sk, hdev->id, =
MGMT_OP_ADD_CONN_PARAM,
>> +				    MGMT_STATUS_NOT_SUPPORTED, NULL, 0);
>=20
> Instead of checking for BDADDR_BREDR it would be better to check for =
!bdaddr_type_is_le().
>=20
> I really want everybody to get into the habit to do proper input =
validation. Not the half backed thing. That is why mgmt-tester can catch =
these kind of things easily and repeatedly.

I'll replace this with !bdaddr_type_is_le().

>=20
>> +
>> +	status =3D mgmt_le_support(hdev);
>> +	if (status)
>> +		return cmd_complete(sk, hdev->id, =
MGMT_OP_ADD_CONN_PARAM,
>> +				    status, NULL, 0);
>> +
>> +	if (cp->addr.type =3D=3D BDADDR_LE_PUBLIC)
>> +		addr_type =3D ADDR_LE_DEV_PUBLIC;
>> +	else
>> +		addr_type =3D ADDR_LE_DEV_RANDOM;
>> +
>> +	if (hci_add_conn_param(hdev, &cp->addr.bdaddr, addr_type,
>> +			       cp->auto_connect,
>> +			       __le16_to_cpu(cp->min_conn_interval),
>> +			       __le16_to_cpu(cp->max_conn_interval)))
>> +		status =3D MGMT_STATUS_FAILED;
>> +	else
>> +		status =3D MGMT_STATUS_SUCCESS;
>> +
>> +	return cmd_complete(sk, hdev->id, MGMT_OP_ADD_CONN_PARAM, =
status,
>> +			    NULL, 0);
>> +}
>> +
>> static const struct mgmt_handler {
>> 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
>> 		     u16 data_len);
>> @@ -4076,6 +4110,7 @@ static const struct mgmt_handler {
>> 	{ set_bredr,              false, MGMT_SETTING_SIZE },
>> 	{ set_static_address,     false, MGMT_SET_STATIC_ADDRESS_SIZE },
>> 	{ set_scan_params,        false, MGMT_SET_SCAN_PARAMS_SIZE },
>> +	{ add_conn_param,         false, MGMT_ADD_CONN_PARAM_SIZE },
>> };
>>=20
>=20
> And btw. it is always plural "params". It is not single parameter.

I'll fix it.

Regards,

Andre
