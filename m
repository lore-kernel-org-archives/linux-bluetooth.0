Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Feb 2011 17:03:57 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use proper timer for hci command timout
Message-ID: <20110210190357.GC2173@joana>
References: <1297067207-7735-1-git-send-email-ville.tervo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297067207-7735-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

* Ville Tervo <ville.tervo@nokia.com> [2011-02-07 10:26:47 +0200]:

> Use proper timer instead of hci command flow control to timeout
> failed hci commands. Otherwise stack ends up sending commands
> when flow control is used to block new commands.
> 
> 2010-09-01 18:29:41.592132 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>     bdaddr 00:16:CF:E1:C7:D7 mode 2 clkoffset 0x0000
> 2010-09-01 18:29:41.592681 > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 0
> 2010-09-01 18:29:51.022033 < HCI Command: Remote Name Request Cancel (0x01|0x001a) plen 6
>     bdaddr 00:16:CF:E1:C7:D7
> 
> Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> ---
>  include/net/bluetooth/hci.h      |    3 +++
>  include/net/bluetooth/hci_core.h |   12 +++++++++++-
>  net/bluetooth/hci_core.c         |   21 +++++++++++++++------
>  net/bluetooth/hci_event.c        |    6 ++++++
>  4 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 4bee030..e3f0c7d 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -119,6 +119,7 @@ enum {
>  #define HCI_PAIRING_TIMEOUT	(60000)	/* 60 seconds */
>  #define HCI_IDLE_TIMEOUT	(6000)	/* 6 seconds */
>  #define HCI_INIT_TIMEOUT	(10000)	/* 10 seconds */
> +#define HCI_CMD_TIMEOUT		(1000)	/* 1 secs */

Just to be keep it similar to the other defines change the comment to "1
second"

>  
>  /* HCI data types */
>  #define HCI_COMMAND_PKT		0x01
> @@ -242,6 +243,8 @@ enum {
>  #define HCI_AT_GENERAL_BONDING_MITM	0x05
>  
>  /* -----  HCI Commands ---- */
> +#define HCI_OP_NOP			0x0000
> +
>  #define HCI_OP_INQUIRY			0x0401
>  struct hci_cp_inquiry {
>  	__u8     lap[3];
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 6163bff..42105f9 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -128,7 +128,6 @@ struct hci_dev {
>  	unsigned int	acl_pkts;
>  	unsigned int	sco_pkts;
>  
> -	unsigned long	cmd_last_tx;
>  	unsigned long	acl_last_tx;
>  	unsigned long	sco_last_tx;
>  
> @@ -138,6 +137,7 @@ struct hci_dev {
>  	struct work_struct	power_off;
>  	struct timer_list	off_timer;
>  
> +	struct timer_list	cmd_timer;
>  	struct tasklet_struct	cmd_task;
>  	struct tasklet_struct	rx_task;
>  	struct tasklet_struct	tx_task;
> @@ -417,6 +417,16 @@ static inline void hci_conn_put(struct hci_conn *conn)
>  	}
>  }
>  
> +static inline void hci_start_cmd_timer(struct timer_list *timer)
> +{
> +	mod_timer(timer, jiffies + msecs_to_jiffies(HCI_CMD_TIMEOUT));
> +}
> +
> +static inline void hci_stop_cmd_timer(struct timer_list *timer)
> +{
> +	del_timer(timer);
> +}

We don't really need this function. Just call del_timer directly.
Otherwise looks good. :-)


-- 
Gustavo F. Padovan
http://profusion.mobi
