Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 03/12] Bluetooth: Protect 'adv_entries' with a RW lock
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1304701521-26459-4-git-send-email-andre.guedes@openbossa.org>
References: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
	 <1304701521-26459-4-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 May 2011 18:24:34 -0700
Message-ID: <1305163474.15916.166.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds a RW lock to protect concurrent operations on
> adv_entries list.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |   21 +++++++++++++++++----
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 65135f8..2ceeadf 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -188,6 +188,7 @@ struct hci_dev {
>  	struct list_head	remote_oob_data;
>  
>  	struct list_head	adv_entries;
> +	rwlock_t		adv_entries_lock;

we might wanna consider just using spinlocks and not rwlocks. Also can
you please look into using RCU.

Regards

Marcel


