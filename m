Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327959928.1955.172.camel@aeonflux>
References: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
	<1327531949-29463-7-git-send-email-andre.guedes@openbossa.org>
	<1327959928.1955.172.camel@aeonflux>
Date: Tue, 31 Jan 2012 10:45:15 -0300
Message-ID: <CACJA=fWSe3Sz6-jOqOp4k0qyGQVbZ_L0GOmKyhWZwbaij1ev1w@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] Bluetooth: Fix indentation
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jan 30, 2012 at 6:45 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andre,
>
> please fix the commit message to at least mention where.

Ok, I'll fix it.

>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> =A0net/bluetooth/mgmt.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 0a1fa4c..e7033c1 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -44,7 +44,7 @@
>> =A0#define LE_SCAN_INT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x12
>> =A0#define LE_SCAN_TIMEOUT_LE_ONLY =A0 =A0 =A0 =A0 =A0 =A0 =A010240 =A0 =
/* TGAP(gen_disc_scan_min) */
>>
>> -#define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
>> +#define INQUIRY_LEN_BREDR =A0 =A0 =A0 =A0 =A0 =A00x08 =A0 =A0/* TGAP(10=
0) */
>>
>> =A0#define SERVICE_CACHE_TIMEOUT (5 * 1000)
>>
>
> Otherwise this is fine.
>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
>
> Regards
>
> Marcel
>
>

Andre
