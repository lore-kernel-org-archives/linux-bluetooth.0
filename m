Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 05/15] Bluetooth: Use connection parameters if any
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <06808003-600D-45E8-88FD-E8F766DCFBA4@holtmann.org>
Date: Fri, 18 Oct 2013 11:07:59 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AE990A9C-333E-4CE1-A979-6A5E4635687B@openbossa.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org> <1381965485-9159-6-git-send-email-andre.guedes@openbossa.org> <06808003-600D-45E8-88FD-E8F766DCFBA4@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Oct 17, 2013, at 6:27 AM, Marcel Holtmann wrote:

> Hi Andre,
>=20
>> This patch changes hci_create_le_conn() so it uses the connection
>> parameters specified by the user. If no parameters were configured,
>> we use the default values.
>>=20
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> net/bluetooth/hci_conn.c | 12 ++++++++++--
>> 1 file changed, 10 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index 4e72650..d64000e 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -548,6 +548,7 @@ static int hci_create_le_conn(struct hci_conn =
*conn)
>> 	struct hci_dev *hdev =3D conn->hdev;
>> 	struct hci_cp_le_create_conn cp;
>> 	struct hci_request req;
>> +	struct hci_conn_param *param;
>> 	int err;
>>=20
>> 	hci_req_init(&req, hdev);
>> @@ -558,11 +559,18 @@ static int hci_create_le_conn(struct hci_conn =
*conn)
>> 	bacpy(&cp.peer_addr, &conn->dst);
>> 	cp.peer_addr_type =3D conn->dst_type;
>> 	cp.own_address_type =3D conn->src_type;
>> -	cp.conn_interval_min =3D __constant_cpu_to_le16(0x0028);
>> -	cp.conn_interval_max =3D __constant_cpu_to_le16(0x0038);
>> 	cp.supervision_timeout =3D __constant_cpu_to_le16(0x002a);
>> 	cp.min_ce_len =3D __constant_cpu_to_le16(0x0000);
>> 	cp.max_ce_len =3D __constant_cpu_to_le16(0x0000);
>> +	param =3D hci_find_conn_param(hdev, &conn->dst, conn->dst_type);
>> +	if (param) {
>> +		cp.conn_interval_min =3D =
cpu_to_le16(param->min_conn_interval);
>> +		cp.conn_interval_max =3D =
cpu_to_le16(param->max_conn_interval);
>> +		hci_conn_param_put(param);
>> +	} else {
>> +		cp.conn_interval_min =3D __constant_cpu_to_le16(0x0028);
>> +		cp.conn_interval_max =3D __constant_cpu_to_le16(0x0038);
>> +	}
>> 	hci_req_add(&req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
>=20
> so this is part that I do not like at all. We already have the =
hci_conn connection object at this point. So why are these values not =
stored in there. In the end we are paying the price for code like this =
where we have to check if parameters exists, if they do apply them, if =
not use the defaults.

>=20
> I did change the code back from the check for public address and what =
own address type to use. Since it turned out that later on you actually =
need to what you where doing.
>=20
> And this is the same thing in the future. We actually want to know =
what connection parameters we current used. In case we have to update =
them or they change while the connection is on-going.

Sure, I'll save these parameters in hci_conn object.

Regards,

Andre=
