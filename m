Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330031665.3392.4.camel@aeonflux>
References: <1330031367-10614-1-git-send-email-andre.guedes@openbossa.org>
	<1330031665.3392.4.camel@aeonflux>
Date: Thu, 23 Feb 2012 18:23:51 -0300
Message-ID: <CACJA=fV20PXnZD1dO4ObDFHxtzcexhsjgVGYDxMgpnUrA=Y_+A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Check capabilities in BR/EDR and LE-Only discovery
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Feb 23, 2012 at 6:14 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andre,
>
>> This patch add an extra check for BR/EDR and LE-Only discovery.
>> This way, we are able to return error immediately if the discovery
>> type requested is not supported by the device.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> =A0net/bluetooth/mgmt.c | =A0 10 ++++++++--
>> =A01 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 93f2c13..de40918 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -2552,12 +2552,18 @@ static int start_discovery(struct sock *sk, u16 =
index,
>>
>> =A0 =A0 =A0 switch (hdev->discovery.type) {
>> =A0 =A0 =A0 case DISCOV_TYPE_BREDR:
>> - =A0 =A0 =A0 =A0 =A0 =A0 err =3D hci_do_inquiry(hdev, INQUIRY_LEN_BREDR=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (lmp_bredr_capable(hdev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D hci_do_inquiry(hdev, I=
NQUIRY_LEN_BREDR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOTSUPP;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> =A0 =A0 =A0 case DISCOV_TYPE_LE:
>> - =A0 =A0 =A0 =A0 =A0 =A0 err =3D hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCA=
N_INT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (lmp_host_le_capable(hdev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D hci_le_scan(hdev, LE_S=
CAN_TYPE, LE_SCAN_INT,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOTSUPP;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> =A0 =A0 =A0 case DISCOV_TYPE_INTERLEAVED:
>
> so what about interleaved. Should that actually suceed if LE is not
> enabled?

For interleaved, we already check this capabilities.

According to the discussion in "[PATCH] Don't set LE flags in
mgmt_start_discovery", if an interleaved Start Discovery command is
issued but the device is not dual mode, we perform a regular BR/EDR
or LE-only discovery (according to device capabilities) instead of
returning error.

BR,

Andre
