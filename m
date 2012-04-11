Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACj007krmYyNtOdwjOb3JPyP7yLgEpsceo02JXm4Wrn+pNyQDg@mail.gmail.com>
References: <1334116936-16171-1-git-send-email-hemant.gupta@stericsson.com>
	<CACj007krmYyNtOdwjOb3JPyP7yLgEpsceo02JXm4Wrn+pNyQDg@mail.gmail.com>
Date: Wed, 11 Apr 2012 18:58:03 -0500
Message-ID: <CAB7rCTiTVC2do6ttmGz_uMDn-M79Q+B00fsfDUtH+psqcJ85SA@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Fix packet type for ESCO Link
From: Mike <puffy.taco@gmail.com>
To: Hemant Gupta <hemantgupta.ste@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, gustavo@padovan.org,
	linux-bluetooth@vger.kernel.org, Hemant Gupta <hemant.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 10, 2012 at 11:13 PM, Hemant Gupta
<hemantgupta.ste@gmail.com> wrote:
> Hi Marcel, Johan, Gustavo,
>
> On Wed, Apr 11, 2012 at 9:32 AM, Hemant Gupta
> <hemant.gupta@stericsson.com> wrote:
>> This patch uses the corect packet type for ESCO Link.
>> Without this patch esco packet types were anded with ~EDR_ESCO_MASK
>> resulting in setting bits that are not supported by controller
>> to 0 which means that corresponding EDR ESCO packet type is
>> supported(EDR Packet types are inverted as per BT Spec) which might
>> not be the case.
>>
>> For eg:
>> Local Controller supports only 3-EV5, 2-EV5 and 3-EV3 of the EDR eSCO
>> packet types and does not support 2-EV3 packet type. This would mean
>> that while creating the esco_type in function
>> hci_cc_read_local_features() the ESCO_2EV3 bit would not be set and
>> all other EDR eSCO bits would be set resulting in
>> hdev->esco_type =3D 0x0380
>>
>> Now in hci_conn_add() when the pkt_type is being calculated for eSCO
>> Link, wrong calculation would take place as below:
>>
>> conn->pkt_type =3D hdev->esco_type & ~EDR_ESCO_MASK;
>> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x0380 & ~0x03C0 =3D 0x0380 & 0xFC3F
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x0000
>> Since the EDR eSCO bits are inverted, this would indicate that all
>> EDR eSCO packet types are supported, which is not correct as local
>> controller is not supporting the 2-EV3 packet type.
>>
>> As per calculations of the patch
>> conn->pkt_type =3D hdev->esco_type ^ EDR_ESCO_MASK;
>> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x0380 ^ 0x03C0
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x0040
>> which correctly indicates that packet type used excludes the 2-EV3
>> packet type not supported by local controller.
>>
>> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
>> Acked-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> =A0net/bluetooth/hci_conn.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index 947172b..1060fb6 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -396,7 +396,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, =
int type, bdaddr_t *dst)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conn->pkt_type =3D hdev->=
pkt_type & SCO_PTYPE_MASK;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> =A0 =A0 =A0 =A0case ESCO_LINK:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 conn->pkt_type =3D hdev->esco_type & ~EDR_=
ESCO_MASK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 conn->pkt_type =3D hdev->esco_type ^ EDR_E=
SCO_MASK;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> =A0 =A0 =A0 =A0}
>>
>> --
>> 1.7.0.4
>>
>
> Resending the patch with Marcel's ACK, because I am not sure if it
> made to the mailing list again or not.

While this is better, it does not appear complete based on my
analysis.  The spec reads as such:

The Packet_Type parameter is a bit mask specifying the syn-
chronous packet types that are allowed on the link and shall be met. The
reserved bits in the Packet_Type field shall be set to one. If all
bits are set in
the packet type field then all packets types shall be allowed.

So, in addition to this problem, the code does not set the reserved
bits to 1.  I think that packet_type should be set to 0xFFC0 by
default, and then explicitly enable data rates as appropriate.  In
this case, the code would then be:

conn->pkt_type =3D 0xFFC0; // before the switch statement
conn->pkt_type ^=3D hdev->esco_type & EDR_ESCO_MASK; // in place of
proposed change above

This would also need to be corrected for the other case statements.

Does this make sense?

Mike
