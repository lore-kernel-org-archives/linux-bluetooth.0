Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v5 03/15] Bluetooth: Check pending command in start_discovery()
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1318703467.15441.66.camel@aeonflux>
Date: Mon, 17 Oct 2011 09:59:32 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <96B919DD-A8EB-418D-AD94-8461EF214231@openbossa.org>
References: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org> <1317856847-28167-4-git-send-email-andre.guedes@openbossa.org> <1318703467.15441.66.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Oct 15, 2011, at 3:30 PM, Marcel Holtmann wrote:

> Hi Andre,
>=20
>> If discovery procedure is already running then EINPROGRESS command
>> status should be returned.
>>=20
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> net/bluetooth/mgmt.c |    6 ++++++
>> 1 files changed, 6 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index cc0c204..d8333e0 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -1622,6 +1622,12 @@ static int start_discovery(struct sock *sk, =
u16 index)
>>=20
>> 	hci_dev_lock_bh(hdev);
>>=20
>> +	if (mgmt_pending_find(MGMT_OP_START_DISCOVERY, index)) {
>> +		err =3D cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
>> +								=
EINPROGRESS);
>> +		goto failed;
>> +	}
>> +
>=20
> I still do not like this at all. There should be a flag that clearly
> identifies if we are doing a discovery right now or not.

Ok, I'll implement this discovery flag.

>=20
> We need a flag on per controller to know if currently a discovery is
> going on. And going through all controllers and all pending commands =
to
> figure this out seems not a good idea. Even with a low amount of =
pending
> commands, then mgmt_pending_find is an expensive operation.
>=20
>> 	cmd =3D mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, index, =
NULL, 0);
>> 	if (!cmd) {
>> 		err =3D -ENOMEM;
>=20
> The other question I have is why we have to duplicate the parameters
> when adding a command to the list. Why not keep a reference of the =
SKB?
>=20
> Regards
>=20
> Marcel
>=20

Thanks,

Andre=
