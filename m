Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 09/12] Bluetooth: Add hci_le_conn_add()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1304701521-26459-10-git-send-email-andre.guedes@openbossa.org>
References: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
	 <1304701521-26459-10-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 May 2011 18:27:18 -0700
Message-ID: <1305163638.15916.168.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch implements a wrapper function to hci_conn_add() which
> takes the address type as argument. This patch also replaces
> hci_conn_add() calls by hci_le_conn_add() in LE related code.
> 
> hci_le_conn_add() was created to consider the destination address
> type when creating a new LE hci_conn.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_conn.c         |   14 +++++++++++++-
>  net/bluetooth/hci_event.c        |    5 +++--
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 5e64d3f..6dd7cad 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -427,6 +427,8 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle);
>  void hci_sco_setup(struct hci_conn *conn, __u8 status);
>  
>  struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst);
> +struct hci_conn *hci_le_conn_add(struct hci_dev *hdev, bdaddr_t *dst,
> +							__u8 addr_type);

the reason why we never split hci_conn_add is too keep it simple. So
better just add the dst_type there directly and only use it when LE_LINK
or we split this clearly in SCO, ACL and LE links. This way is just
half-baked.

Regards

Marcel


