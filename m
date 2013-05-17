Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v7 7/8] Bluetooth: Fallback transparent SCO from T2 to T1
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1368725646-4593-8-git-send-email-frederic.dalleau@linux.intel.com>
Date: Fri, 17 May 2013 11:00:42 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <350D040A-D97F-4A7D-8BC2-CDA83C5FB4CF@holtmann.org>
References: <1368725646-4593-1-git-send-email-frederic.dalleau@linux.intel.com> <1368725646-4593-8-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> When initiating a transparent eSCO connection, make use of T2 settings at
> first try. T2 is the recommended settings from HFP 1.6 WideBand Speech. Upon
> connection failure, try T1 settings.
> T2 failure is detected if Synchronous Connection Complete event fails with
> error 0x0d. This error code has been found experimentally by sending a T2
> request to a T1 only SCO listener. It means "Connection Rejected due to
> Limited resource".
> To know which of T2 or T1 should be used, conn->fallback is used.  Bluez only
> attempt to reconnect twice. In the future, we will need more than 2 fallback
> possibilities. Thus, test conn->fallback as an alternative measure. We want to
> fallback only if conn->fallback is positive. Calling hci_setup_sync with
> conn->fallback == 0 is an initial connection attempt.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> include/net/bluetooth/hci_core.h |    1 +
> net/bluetooth/hci_conn.c         |   20 +++++++++++++++++---
> net/bluetooth/hci_event.c        |    3 ++-
> 3 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index b5996b3..c8b91d2 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -321,6 +321,7 @@ struct hci_conn {
> 	__u8		passkey_entered;
> 	__u16		disc_timeout;
> 	__u16		setting;
> +	__u8		fallback;
> 	unsigned long	flags;
> 
> 	__u8		remote_cap;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index cd7452e..8d71d73 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -31,6 +31,17 @@
> #include <net/bluetooth/a2mp.h>
> #include <net/bluetooth/smp.h>
> 
> +struct sco_param {
> +	u16 pkt_type;
> +	u16 max_latency;
> +	u8 next;
> +};
> +
> +static const struct sco_param sco_param_wideband[] = {
> +	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d, 1 },
> +	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008, 0 },
> +};
> +

so I would combine patch 7 and 8 into one and have a detailed commit explaining both section.

Also comment the entries in the table properly to list which is which setting. So others have an idea on what is going on.

Regards

Marcel

