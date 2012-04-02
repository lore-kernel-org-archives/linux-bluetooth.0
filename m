Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1333168753.1870.261.camel@aeonflux>
References: <1333148706-11008-1-git-send-email-andre.guedes@openbossa.org>
	<1333168753.1870.261.camel@aeonflux>
Date: Mon, 2 Apr 2012 10:14:34 -0300
Message-ID: <CACJA=fUFdF9ZOcGdhggcfRRjaj-2i-Wnyw6w-6n=-eSNQgMgqA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Remove MGMT_ADDR_INVALID macro
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Mar 31, 2012 at 1:39 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andre,
>
>> This patch removes the MGMT_ADDR_INVALID macro. If the address type
>> isn't LE, we consider it is BR/EDR type.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> =A0include/net/bluetooth/hci_core.h | =A0 =A01 -
>> =A0net/bluetooth/mgmt.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 19 +++++----------=
----
>> =A02 files changed, 5 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hc=
i_core.h
>> index c8d5beb..c0b232c 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -967,7 +967,6 @@ void hci_sock_dev_event(struct hci_dev *hdev, int ev=
ent);
>> =A0#define MGMT_ADDR_BREDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x=
00
>> =A0#define MGMT_ADDR_LE_PUBLIC =A0 =A0 =A0 =A0 =A00x01
>> =A0#define MGMT_ADDR_LE_RANDOM =A0 =A0 =A0 =A0 =A00x02
>> -#define MGMT_ADDR_INVALID =A0 =A0 =A0 =A0 =A0 =A00xff
>>
>> =A0#define DISCOV_TYPE_BREDR =A0 =A0 =A0 =A0 =A0 =A0(BIT(MGMT_ADDR_BREDR=
))
>> =A0#define DISCOV_TYPE_LE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (B=
IT(MGMT_ADDR_LE_PUBLIC) | \
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index b4f7e32..c13ea5f 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -1635,20 +1635,13 @@ failed:
>>
>> =A0static u8 link_to_mgmt(u8 link_type, u8 addr_type)
>> =A0{
>> - =A0 =A0 switch (link_type) {
>> - =A0 =A0 case LE_LINK:
>> - =A0 =A0 =A0 =A0 =A0 =A0 switch (addr_type) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 case ADDR_LE_DEV_PUBLIC:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MGMT_ADDR_LE_PUBLIC;
>> - =A0 =A0 =A0 =A0 =A0 =A0 case ADDR_LE_DEV_RANDOM:
>> + =A0 =A0 if (link_type =3D=3D LE_LINK) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (addr_type =3D=3D ADDR_LE_DEV_RANDOM)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MGMT_ADDR_LE_RANDOM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MGMT_ADDR_INVALID;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 case ACL_LINK:
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MGMT_ADDR_LE_PUBLIC;
>> + =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MGMT_ADDR_BREDR;
>> - =A0 =A0 default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 return MGMT_ADDR_INVALID;
>> =A0 =A0 =A0 }
>> =A0}
>>
>
> and what is the reason to remove the nice switch statement here? I
> prefer a default label with a nice comment that we fallback to BR/EDR.

Ok, I'll change this and send a new version of this patch.

Thanks,

Andre
