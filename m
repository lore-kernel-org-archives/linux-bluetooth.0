Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1333649382-16220-1-git-send-email-hemant.gupta@stericsson.com>
References: <1333649382-16220-1-git-send-email-hemant.gupta@stericsson.com>
Date: Tue, 10 Apr 2012 20:57:33 +0530
Message-ID: <CACj007nWobij7TKibumiz6MN3LP7U8nVRRLhYwEx5KcyJ1cz+w@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Fix packet type for ESCO Link
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemant.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Apr 5, 2012 at 11:39 PM, Hemant Gupta
<hemant.gupta@stericsson.com> wrote:
> This patch uses the corect packet type for ESCO Link.
> Without this patch esco packet types were anded with ~EDR_ESCO_MASK
> resulting in setting bits that are not supported by controller
> to 0 which means that corresponding EDR ESCO packet type is
> supported(EDR Packet types are inverted as per BT Spec) which might
> not be the case.
>
> For eg:
> Local Controller supports only 3-EV5, 2-EV5 and 3-EV3 of the EDR eSCO
> packet types and does not support 2-EV3 packet type. This would mean
> that while creating the esco_type in function
> hci_cc_read_local_features() the ESCO_2EV3 bit would not be set and
> all other EDR eSCO bits would be set resulting in
> hdev->esco_type =3D 0x0380
>
> Now in hci_conn_add() when the pkt_type is being calculated for eSCO
> Link, wrong calculation would take place as below:
>
> conn->pkt_type =3D hdev->esco_type & ~EDR_ESCO_MASK;
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x0380 & ~0x03C0 =3D 0x0380 & 0xFC3F
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x0000
> Since the EDR eSCO bits are inverted, this would indicate that all
> EDR eSCO packet types are supported, which is not correct as local
> controller is not supporting the 2-EV3 packet type.
>
> As per calculations of the patch
> conn->pkt_type =3D hdev->esco_type ^ EDR_ESCO_MASK;
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x0380 ^ 0x03C0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x0040
> which correctly indicates that packet type used excludes the 2-EV3
> packet type not supported by local controller.
>
Any comments on the updated patch with commit message.

> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> ---
> =A0net/bluetooth/hci_conn.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 947172b..1060fb6 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -396,7 +396,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, i=
nt type, bdaddr_t *dst)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conn->pkt_type =3D hdev->p=
kt_type & SCO_PTYPE_MASK;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case ESCO_LINK:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 conn->pkt_type =3D hdev->esco_type & ~EDR_E=
SCO_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 conn->pkt_type =3D hdev->esco_type ^ EDR_ES=
CO_MASK;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> --
> 1.7.0.4
>

--=20
Best Regards
Hemant Gupta
ST-Ericsson India
