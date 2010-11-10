Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1289401913-22982-3-git-send-email-johan.hedberg@gmail.com>
References: <1289401913-22982-1-git-send-email-johan.hedberg@gmail.com>
	<1289401913-22982-3-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 10 Nov 2010 23:11:06 +0200
Message-ID: <AANLkTi=oXJq7-ueN=LZEd21OACuOxagL=d1tbMddDSib@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: Automate remote name requests
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 10, 2010 at 5:11 PM,  <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@nokia.com>
>
> In Bluetooth there are no automatic updates of remote device names when
> they get changed on the remote side. Instead, it is a good idea to do a
> manual name request when a new connection gets created (for whatever
> reason) since at this point it is very cheap (no costly baseband
> connection creation needed just for the sake of the name request).
>
> So far userspace has been responsible for this extra name request but
> tighter control is needed in order not to flood Bluetooth controllers
> with two many commands during connection creation. It has been shown
> that some controllers simply fail to function correctly if they get too
> many (almost) simultaneous commands during connection creation. The
> simplest way to acheive better control of these commands is to move
> their sending completely to the kernel side.
>
> This patch inserts name requests into the sequence of events that the
> kernel performs during connection creation. It does this after the
> remote features have been successfully requested and before any pending
> authentication requests are performed. The code will work sub-optimally
> with userspace versions that still do the name requesting themselves (it
> shouldn't break anything though) so it is recommended to combine this
> with a userspace software version that doesn't have automated name
> requests.
>
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  net/bluetooth/hci_event.c |   74 ++++++++++++++++++++++++++++++++++----------
>  1 files changed, 57 insertions(+), 17 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 45569f2..cef970f 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -677,9 +677,8 @@ static void hci_cs_set_conn_encrypt(struct hci_dev *hdev, __u8 status)
>        hci_dev_unlock(hdev);
>  }
>
> -static int request_outgoing_auth(struct hci_dev *hdev, bdaddr_t *bdaddr)
> +static int outgoing_auth_needed(struct hci_dev *hdev, bdaddr_t *bdaddr)
>  {
> -       struct hci_cp_auth_requested cp;
>        struct hci_conn *conn;
>
>        conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
> @@ -698,15 +697,43 @@ static int request_outgoing_auth(struct hci_dev *hdev, bdaddr_t *bdaddr)
>                                        conn->sec_level != BT_SECURITY_HIGH)
>                return 0;
>
> -       cp.handle = __cpu_to_le16(conn->handle);
> -       hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED, sizeof(cp), &cp);
> -
>        return 1;
>  }
>
> +static int request_auth(struct hci_dev *hdev, bdaddr_t *bdaddr)
> +{
> +       struct hci_cp_auth_requested cp;
> +       struct hci_conn *conn;
> +
> +       conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
> +       if (!conn)
> +               return -ENOTCONN;
> +
> +       cp.handle = __cpu_to_le16(conn->handle);
> +       return hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED, sizeof(cp), &cp);
> +}
> +
>  static void hci_cs_remote_name_req(struct hci_dev *hdev, __u8 status)
>  {
> +       struct hci_cp_remote_name_req *cp;
> +
>        BT_DBG("%s status 0x%x", hdev->name, status);
> +
> +       /* If successful wait for the name req complete event before
> +        * checking for the need to do authentication */
> +       if (!status)
> +               return;
> +
> +       cp = hci_sent_cmd_data(hdev, HCI_OP_REMOTE_NAME_REQ);
> +       if (!cp)
> +               return;
> +
> +       hci_dev_lock(hdev);
> +
> +       if (outgoing_auth_needed(hdev, &cp->bdaddr))
> +               request_auth(hdev, &cp->bdaddr);
> +
> +       hci_dev_unlock(hdev);
>  }
>
>  static void hci_cs_read_remote_features(struct hci_dev *hdev, __u8 status)
> @@ -1117,9 +1144,18 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
>
>  static inline void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> +       struct hci_ev_remote_name *ev = (void *) skb->data;
> +
>        BT_DBG("%s", hdev->name);
>
>        hci_conn_check_pending(hdev);
> +
> +       hci_dev_lock(hdev);
> +
> +       if (outgoing_auth_needed(hdev, &ev->bdaddr))
> +               request_auth(hdev, &ev->bdaddr);
> +
> +       hci_dev_unlock(hdev);
>  }
>
>  static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
> @@ -1183,7 +1219,6 @@ static inline void hci_remote_features_evt(struct hci_dev *hdev, struct sk_buff
>  {
>        struct hci_ev_remote_features *ev = (void *) skb->data;
>        struct hci_conn *conn;
> -       int auth_requested;
>
>        BT_DBG("%s status %d", hdev->name, ev->status);
>
> @@ -1208,12 +1243,15 @@ static inline void hci_remote_features_evt(struct hci_dev *hdev, struct sk_buff
>                goto unlock;
>        }
>
> -       if (!ev->status)
> -               auth_requested = request_outgoing_auth(hdev, &conn->dst);
> -       else
> -               auth_requested = 0;
> +       if (!ev->status) {
> +               struct hci_cp_remote_name_req cp;
> +               memset(&cp, 0, sizeof(cp));
> +               bacpy(&cp.bdaddr, &conn->dst);
> +               cp.pscan_rep_mode = 0x02;
> +               hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
> +       }
>
> -       if (!auth_requested) {
> +       if (!outgoing_auth_needed(hdev, &conn->dst)) {
>                conn->state = BT_CONNECTED;
>                hci_proto_connect_cfm(conn, ev->status);
>                hci_conn_put(conn);
> @@ -1671,7 +1709,6 @@ static inline void hci_remote_ext_features_evt(struct hci_dev *hdev, struct sk_b
>  {
>        struct hci_ev_remote_ext_features *ev = (void *) skb->data;
>        struct hci_conn *conn;
> -       int auth_requested;
>
>        BT_DBG("%s", hdev->name);
>
> @@ -1693,12 +1730,15 @@ static inline void hci_remote_ext_features_evt(struct hci_dev *hdev, struct sk_b
>        if (conn->state != BT_CONFIG)
>                goto unlock;
>
> -       if (!ev->status)
> -               auth_requested = request_outgoing_auth(hdev, &conn->dst);
> -       else
> -               auth_requested = 0;
> +       if (!ev->status) {
> +               struct hci_cp_remote_name_req cp;
> +               memset(&cp, 0, sizeof(cp));
> +               bacpy(&cp.bdaddr, &conn->dst);
> +               cp.pscan_rep_mode = 0x02;
> +               hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
> +       }
>
> -       if (!auth_requested) {
> +       if (!outgoing_auth_needed(hdev, &conn->dst)) {
>                conn->state = BT_CONNECTED;
>                hci_proto_connect_cfm(conn, ev->status);
>                hci_conn_put(conn);
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Acked-by: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

-- 
Luiz Augusto von Dentz
Computer Engineer
