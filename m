Return-Path: <cyrus@holtmann.org>
Message-ID: <1359171012.16748.8.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Rename hci_acl_disconn
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 26 Jan 2013 04:30:12 +0100
In-Reply-To: <1359148426-22271-2-git-send-email-andre.guedes@openbossa.org>
References: <1359148426-22271-1-git-send-email-andre.guedes@openbossa.org>
	 <1359148426-22271-2-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> As hci_acl_disconn function basically sends the HCI Disconnect Command
> and it is used to disconnect both ACL and LE links, renaming it to
> hci_disconnect is more suitable.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h | 2 +-
>  net/bluetooth/hci_conn.c         | 4 ++--
>  net/bluetooth/hci_core.c         | 2 +-
>  net/bluetooth/hci_event.c        | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index bcf8ffe..def944d 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -573,7 +573,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
>  	return NULL;
>  }
>  
> -void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
> +void hci_disconnect(struct hci_conn *conn, __u8 reason);
>  void hci_setup_sync(struct hci_conn *conn, __u16 handle);
>  void hci_sco_setup(struct hci_conn *conn, __u8 status);

a better name might be hci_conn_disconnect, but I do realize that
overlaps with the timeout callback. And we have not been really super
strict with the function name prefixes anyway.

Regards

Marcel


