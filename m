Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 May 2010 18:52:02 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Ron Shaffer <rshaffer@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: Synchronize SCO/eSCO connection
 requests to ACL state
Message-ID: <20100524215202.GA28028@vigoh>
References: <4BFAEB65.2060503@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BFAEB65.2060503@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ron,

* Ron Shaffer <rshaffer@codeaurora.org> [2010-05-24 16:11:01 -0500]:

> 
> Certain headsets such as the Motorola H350 will reject SCO and eSCO
> connection requests while the ACL is transitioning from sniff mode
> to active mode. Add synchronization so that SCO and eSCO connection
> requests will wait until the ACL has fully transitioned to active mode.
> 
> Signed-off-by: Ron Shaffer <rshaffer@codeaurora.org>
> ---
>  include/net/bluetooth/hci_core.h |   17 +++++++++--------
>  net/bluetooth/hci_conn.c         |   20 +++++++++++++++++++-
>  net/bluetooth/hci_event.c        |   26 ++++++++++++++++++++++++--
>  3 files changed, 52 insertions(+), 11 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e42f6ed..c4a37fc 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1,6 +1,6 @@
> -/* 
> +/*
>     BlueZ - Bluetooth protocol stack for Linux
> -   Copyright (C) 2000-2001 Qualcomm Incorporated
> +   Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
>  
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>  
> @@ -12,13 +12,13 @@
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
>     IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES 
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN 
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF 
> +   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
> +   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> +   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
>     OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
>  
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, 
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS 
> +   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> +   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
>     SOFTWARE IS DISCLAIMED.
>  */
>  
> @@ -250,6 +250,7 @@ enum {
>  	HCI_CONN_ENCRYPT_PEND,
>  	HCI_CONN_RSWITCH_PEND,
>  	HCI_CONN_MODE_CHANGE_PEND,
> +	HCI_CONN_SCO_PEND,
>  };
>  
>  static inline void hci_conn_hash_init(struct hci_dev *hdev)
> @@ -380,7 +381,7 @@ static inline void __hci_dev_put(struct hci_dev *d)
>  }
>  
>  static inline void hci_dev_put(struct hci_dev *d)
> -{ 
> +{
>  	__hci_dev_put(d);
>  	module_put(d->owner);
>  }
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index b10e3cd..5c4e3c1 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1,6 +1,6 @@
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
> -   Copyright (C) 2000-2001 Qualcomm Incorporated
> +   Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
>  
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>  
> @@ -117,9 +117,18 @@ void hci_add_sco(struct hci_conn *conn, __u16 handle)
>  {
>  	struct hci_dev *hdev = conn->hdev;
>  	struct hci_cp_add_sco cp;
> +	struct hci_conn *acl = conn->link;
>  
>  	BT_DBG("%p", conn);
>  
> +	if (acl->mode == HCI_CM_SNIFF &&
> +		test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl->pend)) {

Wrong indentation here. Add a extra tab for test_bit.

> +		set_bit(HCI_CONN_SCO_PEND, &conn->pend);
> +		return;
> +	}
> +
> +	clear_bit(HCI_CONN_SCO_PEND, &conn->pend);


You already clear the bit on hci_mode_change_evt with
test_and_clear_bit. No need to clear it again here.
The same happens for hci_setup_sync().

> +
>  	conn->state = BT_CONNECT;
>  	conn->out = 1;
>  
> @@ -135,9 +144,18 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
>  {
>  	struct hci_dev *hdev = conn->hdev;
>  	struct hci_cp_setup_sync_conn cp;
> +	struct hci_conn *acl = conn->link;
>  
>  	BT_DBG("%p", conn);
>  
> +	if (acl->mode == HCI_CM_SNIFF &&
> +		test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl->pend)) {

Wrong indentation here too.

> +		set_bit(HCI_CONN_SCO_PEND, &conn->pend);
> +		return;
> +	}
> +
> +	clear_bit(HCI_CONN_SCO_PEND, &conn->pend);
> +
>  	conn->state = BT_CONNECT;
>  	conn->out = 1;
>  
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 6c57fc7..22fb095 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1,6 +1,6 @@
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
> -   Copyright (C) 2000-2001 Qualcomm Incorporated
> +   Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
>  
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>  
> @@ -615,6 +615,7 @@ static void hci_cs_add_sco(struct hci_dev *hdev, __u8 status)
>  	acl = hci_conn_hash_lookup_handle(hdev, handle);
>  	if (acl && (sco = acl->link)) {
>  		sco->state = BT_CLOSED;
> +		clear_bit(HCI_CONN_SCO_PEND, &sco->pend);
>  
>  		hci_proto_connect_cfm(sco, status);
>  		hci_conn_del(sco);
> @@ -760,6 +761,7 @@ static void hci_cs_setup_sync_conn(struct hci_dev *hdev, __u8 status)
>  	acl = hci_conn_hash_lookup_handle(hdev, handle);
>  	if (acl && (sco = acl->link)) {
>  		sco->state = BT_CLOSED;
> +		clear_bit(HCI_CONN_SCO_PEND, &sco->pend);
>  
>  		hci_proto_connect_cfm(sco, status);
>  		hci_conn_del(sco);
> @@ -795,6 +797,7 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
>  {
>  	struct hci_cp_exit_sniff_mode *cp;
>  	struct hci_conn *conn;
> +	struct hci_conn *sco;
>  
>  	BT_DBG("%s status 0x%x", hdev->name, status);
>  
> @@ -808,9 +811,18 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
>  	hci_dev_lock(hdev);
>  
>  	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
> -	if (conn)
> +	if (conn) {
>  		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
>  
> +		sco = conn->link;
> +		if (sco) {
> +			if (test_and_clear_bit(HCI_CONN_SCO_PEND, &sco->pend)) {

Wouldn't be better 'if (sco && test_and_clear_bit(...' ?

> +				hci_proto_connect_cfm(sco, status);
> +				hci_conn_del(sco);
> +			}
> +		}
> +	}
> +
>  	hci_dev_unlock(hdev);
>  }
>  
> @@ -1463,6 +1475,7 @@ static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb
>  {
>  	struct hci_ev_mode_change *ev = (void *) skb->data;
>  	struct hci_conn *conn;
> +	struct hci_conn *sco;
>  
>  	BT_DBG("%s status %d", hdev->name, ev->status);
>  
> @@ -1478,6 +1491,15 @@ static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb
>  				conn->power_save = 1;
>  			else
>  				conn->power_save = 0;
> +		} else {
> +			sco = conn->link;
> +			if (sco && test_and_clear_bit(HCI_CONN_SCO_PEND,
> +					&sco->pend)) {
> +				if (lmp_esco_capable(hdev))
> +					hci_setup_sync(sco, conn->handle);
> +				else
> +					hci_add_sco(sco, conn->handle);
> +			}
>  		}
>  	}
>  
> -- 
> 1.7.0.2
> 
> -- 
> Ron Shaffer
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gustavo F. Padovan
http://padovan.org
