Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1333597594-21532-1-git-send-email-hemant.gupta@stericsson.com>
References: <1333597594-21532-1-git-send-email-hemant.gupta@stericsson.com>
Date: Thu, 5 Apr 2012 21:31:12 +0530
Message-ID: <CACj007nwsZumYtKkFcEu2jQa=f7dZJYJ=szXEMVhO0n5goRCjg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Fix packet type for ESCO Link
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemant.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Apr 5, 2012 at 9:16 AM, Hemant Gupta
<hemant.gupta@stericsson.com> wrote:
> This patch uses the corect packet type for ESCO Link.
> Without this patch esco packet types were anded with ~EDR_ESCO_MASK
> resulting in setting bits that are not supported by controller
> to 0 which means that corresponding EDR ESCO packet type is
> supported(EDR Packet types are inverted as per BT Spec) which might
> not be the case.
>
Any comments on this patch ?
> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
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



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
