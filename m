Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4 05/14] Bluetooth: Create hci_do_inquiry()
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1316521868.1937.76.camel@aeonflux>
Date: Fri, 23 Sep 2011 16:13:33 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4AD06E0E-704B-42E6-980D-3720541D07AB@openbossa.org>
References: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org> <1316468136-12472-6-git-send-email-andre.guedes@openbossa.org> <1316521868.1937.76.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sep 20, 2011, at 9:31 AM, Marcel Holtmann wrote:

> Hi Andre,
>=20
>> This patch adds a function to hci_core to carry out inquiry.
>>=20
>> All inquiry code from start_discovery() were replaced by a
>> hci_do_inquiry() call.
>>=20
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/hci_core.h |    2 ++
>> net/bluetooth/hci_core.c         |   17 +++++++++++++++++
>> net/bluetooth/mgmt.c             |    9 +--------
>> 3 files changed, 20 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/include/net/bluetooth/hci_core.h =
b/include/net/bluetooth/hci_core.h
>> index df6fa85..b7c070b 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -914,4 +914,6 @@ void hci_le_start_enc(struct hci_conn *conn, =
__le16 ediv, __u8 rand[8],
>> void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
>> void hci_le_ltk_neg_reply(struct hci_conn *conn);
>>=20
>> +int hci_do_inquiry(struct hci_dev *hdev, u8 length);
>> +
>> #endif /* __HCI_CORE_H */
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 04bc31d..ebfd963 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -2405,3 +2405,20 @@ static void hci_cmd_task(unsigned long arg)
>> 		}
>> 	}
>> }
>> +
>> +int hci_do_inquiry(struct hci_dev *hdev, u8 length)
>> +{
>> +	u8 lap[3] =3D {0x33, 0x8b, 0x9e};
>=20
> { 0x33, ... 0x9e } with proper space please. Otherwise.
>=20
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Sure, I'll fix it.

Andre=
