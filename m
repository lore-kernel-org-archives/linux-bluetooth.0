Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Jul 2011 17:26:10 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 09/16] Bluetooth: Prepare for full support discovery
 procedures
Message-ID: <20110713202610.GE23921@joana>
References: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
 <1310418719-12296-10-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310418719-12296-10-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andre Guedes <andre.guedes@openbossa.org> [2011-07-11 18:11:52 -0300]:

> This patch prepares start_discovery() to support LE-Only and BR/EDR/LE
> devices discovery procedures (BR/EDR devices are already supported).
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci.h      |    1 +
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/mgmt.c             |   37 ++++++++++++++++++++++++++++++++++++-
>  3 files changed, 38 insertions(+), 1 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index be30aab..653daec 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -202,6 +202,7 @@ enum {
>  
>  #define LMP_EV4		0x01
>  #define LMP_EV5		0x02
> +#define LMP_NO_BREDR	0x20
>  #define LMP_LE		0x40
>  
>  #define LMP_SNIFF_SUBR	0x02
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 1ff59f2..fc75c61 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -597,6 +597,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>  #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
>  #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
>  #define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
> +#define lmp_no_bredr_capable(dev)  ((dev)->features[4] & LMP_NO_BREDR)

It's more logic call this lmp_bredr_capable() regardless what the bit really
means.

	Gustavo
