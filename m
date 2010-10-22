Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Oct 2010 16:53:58 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/6] Bluetooth: Use LE buffers for LE traffic
Message-ID: <20101022185358.GD980@vigoh>
References: <1287406976-13463-1-git-send-email-ville.tervo@nokia.com>
 <1287406976-13463-4-git-send-email-ville.tervo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287406976-13463-4-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

* Ville Tervo <ville.tervo@nokia.com> [2010-10-18 16:02:53 +0300]:

> BLuetooth chips may have separate buffers for
> LE traffic. This patch add support to use LE
> buffers provided by the chip.
> 
> Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> ---
>  include/net/bluetooth/hci.h      |    2 +
>  include/net/bluetooth/hci_core.h |    5 +++
>  net/bluetooth/hci_conn.c         |    6 +++
>  net/bluetooth/hci_core.c         |   74 +++++++++++++++++++++++++++++++++++--
>  net/bluetooth/hci_event.c        |   40 +++++++++++++++++++-
>  5 files changed, 121 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 02055b9..b42edf0 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -189,6 +189,8 @@ enum {
>  
>  #define LMP_EV4		0x01
>  #define LMP_EV5		0x02
> +#define LMP_NO_BREDR	0x20

You are not using this one.

> +#define LMP_LE		0x40
>  
>  #define LMP_SNIFF_SUBR	0x02
>  #define LMP_EDR_ESCO_2M	0x20
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index fc2aaee..326d290 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -103,15 +103,19 @@ struct hci_dev {
>  	atomic_t	cmd_cnt;
>  	unsigned int	acl_cnt;
>  	unsigned int	sco_cnt;
> +	unsigned int	le_cnt;
>  
>  	unsigned int	acl_mtu;
>  	unsigned int	sco_mtu;
> +	unsigned int	le_mtu;
>  	unsigned int	acl_pkts;
>  	unsigned int	sco_pkts;
> +	unsigned int	le_pkts;
>  
>  	unsigned long	cmd_last_tx;
>  	unsigned long	acl_last_tx;
>  	unsigned long	sco_last_tx;
> +	unsigned long	le_last_tx;
>  
>  	struct workqueue_struct	*workqueue;
>  
> @@ -469,6 +473,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>  #define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)
>  #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
>  #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
> +#define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
>  
>  /* ----- HCI protocols ----- */
>  struct hci_proto {
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index c1eb8e0..c7309e4 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -324,6 +324,11 @@ int hci_conn_del(struct hci_conn *conn)
>  
>  		/* Unacked frames */
>  		hdev->acl_cnt += conn->sent;
> +	} else if (conn->type == LE_LINK) {
> +		if (hdev->le_pkts)
> +			hdev->le_cnt += conn->sent;
> +		else
> +			hdev->acl_cnt += conn->sent;
>  	} else {
>  		struct hci_conn *acl = conn->link;
>  		if (acl) {
> @@ -409,6 +414,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
>  			return NULL;
>  
>  		hci_le_connect(le);
> +		hci_conn_hold(le);
>  

This should be in 2/6, right?


-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
