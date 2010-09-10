Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Sep 2010 15:20:41 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anderson Briglia <anderson.briglia@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: Implement LE Set Advertise Enable cmd
Message-ID: <20100910182041.GB19693@vigoh>
References: <1284131696-26117-1-git-send-email-anderson.briglia@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284131696-26117-1-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

* Anderson Briglia <anderson.briglia@openbossa.org> [2010-09-10 11:14:55 -0400]:

> This patch implements LE Set Advertise Enable command for dual mode and
> Low Energy hci controllers. It also adds new HCI flags in order to
> indicate the Advertising state for userland applications and kernel
> itself.
> 
> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> ---
>  include/net/bluetooth/hci.h |    7 +++++++
>  net/bluetooth/hci_event.c   |   27 +++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index bcbdd6d..a28e92b 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -76,6 +76,8 @@ enum {
>  	HCI_INQUIRY,
>  
>  	HCI_RAW,
> +
> +	HCI_LE_ADV,
>  };
>  
>  /* HCI ioctl defines */
> @@ -593,6 +595,11 @@ struct hci_rp_read_bd_addr {
>  	bdaddr_t bdaddr;
>  } __packed;
>  
> +/* --- HCI LE Commands --- */
> +#define HCI_OP_LE_SET_ADVERTISE_ENABLE	0x200a
> +	#define ADVERTISE_ENABLED	0x01
> +	#define ADVERTISE_DISABLED	0x00

Just make these LE_ADVERTISE_ENABLED and LE_ADVERTISE_DISABLED then we
should be fine with this patch.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
