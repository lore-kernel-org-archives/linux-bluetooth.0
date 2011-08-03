Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Aug 2011 14:58:10 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Anderson Briglia <anderson.briglia@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/7] Bluetooth: Add RSSI Monitor commands
Message-ID: <20110803175810.GC28119@joana>
References: <y>
 <1312310109-27082-1-git-send-email-anderson.briglia@openbossa.org>
 <1312310109-27082-2-git-send-email-anderson.briglia@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312310109-27082-2-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Briglia,

* Anderson Briglia <anderson.briglia@openbossa.org> [2011-08-02 14:35:03 -0400]:

> This patch adds two new Management commands: Enable/Disable RSSI
> Monitor. This command is used to handle a list of monitors in order to
> monitor the RSSI value of a connection. It is useful on Proximity
> profile implementation.
> 
> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> ---
>  include/net/bluetooth/mgmt.h |   12 ++++++++++++
>  net/bluetooth/mgmt.c         |   22 ++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 5428fd3..ef3b636 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -211,6 +211,18 @@ struct mgmt_cp_unblock_device {
>  	bdaddr_t bdaddr;
>  } __packed;
>  
> +#define MGMT_OP_ENABLE_RSSI_MONITOR	0x001F
> +struct mgmt_cp_enable_rssi_monitor {
> +	bdaddr_t bdaddr;
> +	__s8 low_alert_trigger;
> +	__s8 high_alert_trigger;
> +} __packed;
> +
> +#define MGMT_OP_DISABLE_RSSI_MONITOR	0x0020
> +struct mgmt_cp_disable_rssi_monitor {
> +	bdaddr_t bdaddr;
> +} __packed;
> +

Make much more sense to me call this ADD/REMOVE. We add an rssi monitor to the
list and then remove it from the list. 

	Gustavo
