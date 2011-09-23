Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4 08/14] Bluetooth: Prepare for full support discovery procedures
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1316522621.1937.86.camel@aeonflux>
Date: Fri, 23 Sep 2011 16:14:06 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <53C5B380-9072-44C5-A2E4-E8AFBE437F8A@openbossa.org>
References: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org> <1316468136-12472-9-git-send-email-andre.guedes@openbossa.org> <1316522621.1937.86.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sep 20, 2011, at 9:43 AM, Marcel Holtmann wrote:

> Hi Andre,
>=20
>> This patch prepares start_discovery() to support LE-Only and =
BR/EDR/LE
>> discovery procedures (BR/EDR is already supported).
>>=20
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/hci.h      |    1 +
>> include/net/bluetooth/hci_core.h |    1 +
>> net/bluetooth/mgmt.c             |   10 +++++++++-
>> 3 files changed, 11 insertions(+), 1 deletions(-)
>>=20
>> diff --git a/include/net/bluetooth/hci.h =
b/include/net/bluetooth/hci.h
>> index aaf79af..1e11e7f 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -202,6 +202,7 @@ enum {
>>=20
>> #define LMP_EV4		0x01
>> #define LMP_EV5		0x02
>> +#define LMP_NO_BREDR	0x20
>> #define LMP_LE		0x40
>>=20
>> #define LMP_SNIFF_SUBR	0x02
>> diff --git a/include/net/bluetooth/hci_core.h =
b/include/net/bluetooth/hci_core.h
>> index 36e15cc..e0c9790 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -613,6 +613,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>> #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
>> #define lmp_ssp_capable(dev)       ((dev)->features[6] & =
LMP_SIMPLE_PAIR)
>> #define lmp_no_flush_capable(dev)  ((dev)->features[6] & =
LMP_NO_FLUSH)
>> +#define lmp_bredr_capable(dev)     (!((dev)->features[4] & =
LMP_NO_BREDR))
>> #define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
>>=20
>> /* ----- Extended LMP capabilities ----- */
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 58cf33a..3a0815b 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -32,6 +32,8 @@
>> #define MGMT_VERSION	0
>> #define MGMT_REVISION	1
>>=20
>> +#define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
>> +
>> struct pending_cmd {
>> 	struct list_head list;
>> 	__u16 opcode;
>> @@ -1632,7 +1634,13 @@ static int start_discovery(struct sock *sk, =
u16 index)
>> 		goto failed;
>> 	}
>>=20
>> -	err =3D hci_do_inquiry(hdev, 0x08);
>> +	if (lmp_host_le_capable(hdev) && lmp_bredr_capable(hdev))
>> +		err =3D -ENOSYS;
>> +	else if (lmp_host_le_capable(hdev))
>> +		err =3D -ENOSYS;
>> +	else
>> +		err =3D hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
>> +
>=20
> this if statement is ugly. I think you want something like this:
>=20
> 	if (lmp_host_le_capable()) {
> 		if (lmp_bredr_capable()) {
> 		} else {
> 		}
> 	} else
> 		hci_do_inquiry()

Ok, I'll change this.

Andre=
