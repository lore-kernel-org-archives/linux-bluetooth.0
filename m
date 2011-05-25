Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1306331393-21773-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1306331393-21773-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Date: Wed, 25 May 2011 22:53:16 +0300
Message-ID: <BANLkTinfBH8V+khbXTDcdhzUzVULVJXcdg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix auth_complete_evt for legacy units
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, May 25, 2011 at 4:49 PM, Waldemar Rymarkiewicz
<waldemar.rymarkiewicz@tieto.com> wrote:
> Legacy devices don't re-authenticate the link properly if a link key
> already exists.  Thus, don't update sec_level for this case even if
> hci_auth_complete_evt indicates success. Otherwise the sec_level will
> not reflect a real security on the link.
>
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_conn.c         |    2 ++
>  net/bluetooth/hci_event.c        |   12 ++++++++++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 6c994c0..1af6754 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -313,6 +313,7 @@ void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data);
>  /* ----- HCI Connections ----- */
>  enum {
>        HCI_CONN_AUTH_PEND,
> +       HCI_CONN_REAUTH_PEND,
>        HCI_CONN_ENCRYPT_PEND,
>        HCI_CONN_RSWITCH_PEND,
>        HCI_CONN_MODE_CHANGE_PEND,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 3163330..e675402 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -548,6 +548,8 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
>                cp.handle = cpu_to_le16(conn->handle);
>                hci_send_cmd(conn->hdev, HCI_OP_AUTH_REQUESTED,
>                                                        sizeof(cp), &cp);
> +               if (conn->key_type != 0xff)
> +                       set_bit(HCI_CONN_REAUTH_PEND, &conn->pend);
>        }
>
>        return 0;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index f13ddbf..8b31754 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1462,13 +1462,21 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
>        conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
>        if (conn) {
>                if (!ev->status) {
> -                       conn->link_mode |= HCI_LM_AUTH;
> -                       conn->sec_level = conn->pending_sec_level;
> +                       if (!(conn->ssp_mode > 0 && hdev->ssp_mode > 0) &&
> +                                       test_bit(HCI_CONN_REAUTH_PEND,
> +                                       &conn->pend)) {
> +                               BT_INFO("Re-authentication of legacy device" \
> +                                                       " is not possible.");
> +                       } else {
> +                               conn->link_mode |= HCI_LM_AUTH;
> +                               conn->sec_level = conn->pending_sec_level;
> +                       }
>                } else {
>                        mgmt_auth_failed(hdev->id, &conn->dst, ev->status);
>                }
>
>                clear_bit(HCI_CONN_AUTH_PEND, &conn->pend);
> +               clear_bit(HCI_CONN_REAUTH_PEND, &conn->pend);
>
>                if (conn->state == BT_CONFIG) {
>                        if (!ev->status && hdev->ssp_mode > 0 &&

Not really related to the problem, but it might be a good idea to have
a check for !conn to avoid that many nested statements.


-- 
Luiz Augusto von Dentz
Computer Engineer
