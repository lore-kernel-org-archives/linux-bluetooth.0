Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334092777.16897.56.camel@aeonflux>
References: <1333649382-16220-1-git-send-email-hemant.gupta@stericsson.com>
	<CACj007nWobij7TKibumiz6MN3LP7U8nVRRLhYwEx5KcyJ1cz+w@mail.gmail.com>
	<1334092777.16897.56.camel@aeonflux>
Date: Wed, 11 Apr 2012 09:34:01 +0530
Message-ID: <CACj007nfbG7wu+uQfVwA9QrE+b1yFJc4LpOfVQRr1x20rSFn7g@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Fix packet type for ESCO Link
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemant.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Apr 11, 2012 at 2:49 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Hemant,
>
>> > This patch uses the corect packet type for ESCO Link.
>> > Without this patch esco packet types were anded with ~EDR_ESCO_MASK
>> > resulting in setting bits that are not supported by controller
>> > to 0 which means that corresponding EDR ESCO packet type is
>> > supported(EDR Packet types are inverted as per BT Spec) which might
>> > not be the case.
>> >
>> > For eg:
>> > Local Controller supports only 3-EV5, 2-EV5 and 3-EV3 of the EDR eSCO
>> > packet types and does not support 2-EV3 packet type. This would mean
>> > that while creating the esco_type in function
>> > hci_cc_read_local_features() the ESCO_2EV3 bit would not be set and
>> > all other EDR eSCO bits would be set resulting in
>> > hdev->esco_type =3D 0x0380
>> >
>> > Now in hci_conn_add() when the pkt_type is being calculated for eSCO
>> > Link, wrong calculation would take place as below:
>> >
>> > conn->pkt_type =3D hdev->esco_type & ~EDR_ESCO_MASK;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0x0380 & ~0x03C0 =3D 0x0380 & 0xFC3=
F
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x0000
>> > Since the EDR eSCO bits are inverted, this would indicate that all
>> > EDR eSCO packet types are supported, which is not correct as local
>> > controller is not supporting the 2-EV3 packet type.
>> >
>> > As per calculations of the patch
>> > conn->pkt_type =3D hdev->esco_type ^ EDR_ESCO_MASK;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0x0380 ^ 0x03C0
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x0040
>> > which correctly indicates that packet type used excludes the 2-EV3
>> > packet type not supported by local controller.
>> >
>> Any comments on the updated patch with commit message.
>
> for some strange reason, I have not seen v4 so far. However this message
> made it through.
>
>> > Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
>> > ---
>> > =A0net/bluetooth/hci_conn.c | =A0 =A02 +-
>> > =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
>
> You might need to resend it in case it never reached Johan and Gustavo
> either.
>
Thanks for letting me know that somehow v4 of patch never made to
mailing list :(
I have now sent the v4 patch keeping your ACK.
> Regards
>
> Marcel
>
>



--=20
Best Regards
Hemant Gupta
ST-Ericsson India
