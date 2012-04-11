Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334116936-16171-1-git-send-email-hemant.gupta@stericsson.com>
References: <1334116936-16171-1-git-send-email-hemant.gupta@stericsson.com>
Date: Wed, 11 Apr 2012 09:43:31 +0530
Message-ID: <CACj007krmYyNtOdwjOb3JPyP7yLgEpsceo02JXm4Wrn+pNyQDg@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Fix packet type for ESCO Link
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, gustavo@padovan.org
Cc: linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemant.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Johan, Gustavo,

On Wed, Apr 11, 2012 at 9:32 AM, Hemant Gupta
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
> hdev->esco_type = 0x0380
>
> Now in hci_conn_add() when the pkt_type is being calculated for eSCO
> Link, wrong calculation would take place as below:
>
> conn->pkt_type = hdev->esco_type & ~EDR_ESCO_MASK;
>                = 0x0380 & ~0x03C0 = 0x0380 & 0xFC3F
>               = 0x0000
> Since the EDR eSCO bits are inverted, this would indicate that all
> EDR eSCO packet types are supported, which is not correct as local
> controller is not supporting the 2-EV3 packet type.
>
> As per calculations of the patch
> conn->pkt_type = hdev->esco_type ^ EDR_ESCO_MASK;
>                = 0x0380 ^ 0x03C0
>               = 0x0040
> which correctly indicates that packet type used excludes the 2-EV3
> packet type not supported by local controller.
>
> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_conn.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 947172b..1060fb6 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -396,7 +396,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
>                        conn->pkt_type = hdev->pkt_type & SCO_PTYPE_MASK;
>                break;
>        case ESCO_LINK:
> -               conn->pkt_type = hdev->esco_type & ~EDR_ESCO_MASK;
> +               conn->pkt_type = hdev->esco_type ^ EDR_ESCO_MASK;
>                break;
>        }
>
> --
> 1.7.0.4
>

Resending the patch with Marcel's ACK, because I am not sure if it
made to the mailing list again or not.

-- 
Best Regards
Hemant Gupta
ST-Ericsson India
