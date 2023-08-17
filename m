Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC547C5320E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 20:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354669AbjHQU0j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 16:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354894AbjHQU0b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 16:26:31 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86A6359C
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 13:26:28 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::a02d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RRc3N422qz49Pwb;
        Thu, 17 Aug 2023 23:26:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1692303985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ovbPd0j9jSrLLwOvqnbCFu57uirPy57e6jNx5BXICM=;
        b=PplNx4bBqeFq0eP5ywJhpnrTMZm6Ell2bQxUdxIMl3hv2lvx+DAuiKNn12VWjI9JOddmc5
        8XKv4D+KSnyvLkw6vh4cLcCsuaiiB0mSlsyL/kLxoVOX6fOPc2NS+QNk5U6AAzAUAb4M5i
        IT2O0H71wgy/zfgYEl60iIb01PbivGKr5y1B312Zp+aG0cw7a4vN5jynY/VI2L2DKIZdVJ
        vxRUGMmbxVSBIn1SGR2NyVGg28T4hdOutK0mBxfIudjXixOvmoyCL//xOW9zOWleADDa/w
        JMGsVV5JyvwgTEn0d9pLOH4B/ymj602Bwmq94YcoU7RrGP7Z59cFkn+cU0u+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1692303985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ovbPd0j9jSrLLwOvqnbCFu57uirPy57e6jNx5BXICM=;
        b=jhxkzAAJ1hyr/3H6P3NCXdCQTHyQ2+Kuo+/zf9DCr1qfterVlFnDOplVhKIi4UncXEYRH3
        skiOis+W41UTWPT9n5MfQcJLXuuv59TeHI6h1sx+R+lb3hx1EFsKgSYwElF+Vfw+7BmoGR
        hMawVEpUQUA4JhjF/cONzTxT0WP0lp0bBnLBP0XgFodEN/OwBHrJhllgWnvkzJxhSuNrTB
        WF6lgtKqi0p/YlupkTBxnjuueeME9IJ6ugFnu9EbVn2iYXWAwEkbaCkjUpKbMzvX4Cc6EL
        Yptc24W/rWICgqrcqxCs+9n0KZDeWxctg2llyUaLr34vfHpzgMHPmu7ktcQNWQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1692303985; a=rsa-sha256;
        cv=none;
        b=Ml2ZPEo3Zn1bv/Guw/hc1iiYHtW7IMPMLfkBOSYnvn1ur6y+Xlm5axnMcJ7UXrodf7Bj5V
        T6Jh3jFuABoJ7bUzJE1eSW+8nGqfNJ6m+th3KqoS70nSUn+F3ewyoaxOteZwGWexO3eUYC
        mc1y1UL5kt1C3VDziUWFS5kEmcEZsp56M+PfnnC1M40mFzDjw6HqtTQn2WzP46g9Jsm2s+
        Jgs1QfZA1T7R9xmmPnFqSwDFiPPDL0CFxp32SG6zq2yAb3IfoX0lr06n5XcNgnnymkb34b
        ytyEa5iJ6Vbl4+EDvXBhvqG/j4rjLmwUlPi1MpSpCiTwM9rHyLSe9JPDG5T/sQ==
Message-ID: <071e0fe0c5bfdba995edbd95db3cb6ea62010135.camel@iki.fi>
Subject: Re: [PATCH v3 1/1] Bluetooth: ISO: Use defer setup to separate PA
 sync and BIG sync
From:   Pauli Virtanen <pav@iki.fi>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 17 Aug 2023 23:26:23 +0300
In-Reply-To: <20230817064427.3647-2-iulia.tanasescu@nxp.com>
References: <20230817064427.3647-1-iulia.tanasescu@nxp.com>
         <20230817064427.3647-2-iulia.tanasescu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

to, 2023-08-17 kello 09:44 +0300, Iulia Tanasescu kirjoitti:
> This commit implements defer setup support for the Broadcast Sink
> scenario: By setting defer setup on a broadcast socket before calling
> listen, the user is able to trigger the PA sync and BIG sync procedures
> separately.
>=20
> This is useful if the user first wants to synchronize to the periodic
> advertising transmitted by a Broadcast Source, and trigger the BIG sync
> procedure later on.
>=20
> If defer setup is set, once a PA sync established event arrives, a new
> hcon is created and notified to the ISO layer. A child socket associated
> with the PA sync connection will be added to the accept queue of the
> listening socket.
>=20
> Once the accept call returns the fd for the PA sync child socket, the
> user should call read on that fd. This will trigger the BIG create sync
> procedure, and the PA sync socket will become a listening socket itself.
>=20
> When the BIG sync established event is notified to the ISO layer, the
> bis connections will be added to the accept queue of the PA sync parent.
> The user should call accept on the PA sync socket to get the final bis
> connections.
>=20
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  include/net/bluetooth/hci_core.h |  30 +++++-
>  net/bluetooth/hci_conn.c         |  13 ++-
>  net/bluetooth/hci_event.c        |  41 +++++++-
>  net/bluetooth/hci_sync.c         |  15 +++
>  net/bluetooth/iso.c              | 160 ++++++++++++++++++++++++-------
>  5 files changed, 218 insertions(+), 41 deletions(-)
>=20
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index c53d74236e3a..6fb055e3c595 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -978,6 +978,8 @@ enum {
>  	HCI_CONN_CREATE_CIS,
>  	HCI_CONN_BIG_SYNC,
>  	HCI_CONN_BIG_SYNC_FAILED,
> +	HCI_CONN_PA_SYNC,
> +	HCI_CONN_PA_SYNC_FAILED,
>  };
> =20
>  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> @@ -1300,7 +1302,7 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_big_any_dst(struct hci_dev *
>  		if (c->type !=3D ISO_LINK)
>  			continue;
> =20
> -		if (handle =3D=3D c->iso_qos.bcast.big) {
> +		if (handle !=3D BT_ISO_QOS_BIG_UNSET && handle =3D=3D c->iso_qos.bcast=
.big) {
>  			rcu_read_unlock();
>  			return c;
>  		}
> @@ -1311,6 +1313,29 @@ static inline struct hci_conn *hci_conn_hash_looku=
p_big_any_dst(struct hci_dev *
>  	return NULL;
>  }
> =20
> +static inline struct hci_conn *
> +hci_conn_hash_lookup_pa_sync(struct hci_dev *hdev, __u8 big)
> +{
> +	struct hci_conn_hash *h =3D &hdev->conn_hash;
> +	struct hci_conn  *c;
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(c, &h->list, list) {
> +		if (c->type !=3D ISO_LINK ||
> +			!test_bit(HCI_CONN_PA_SYNC, &c->flags))
> +			continue;
> +
> +		if (c->iso_qos.bcast.big =3D=3D big) {
> +			rcu_read_unlock();
> +			return c;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return NULL;
> +}
> +
>  static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev=
 *hdev,
>  							__u8 type, __u16 state)
>  {
> @@ -1435,7 +1460,8 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hd=
ev, bdaddr_t *dst,
>  				 __u8 data_len, __u8 *data);
>  int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_typ=
e,
>  		       __u8 sid, struct bt_iso_qos *qos);
> -int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
> +int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
> +			   struct bt_iso_qos *qos,
>  			   __u16 sync_handle, __u8 num_bis, __u8 bis[]);
>  int hci_conn_check_link_mode(struct hci_conn *conn);
>  int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 95339623883c..8b0c8e631324 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -734,6 +734,7 @@ struct iso_list_data {
>  	};
>  	int count;
>  	bool big_term;
> +	bool pa_sync_term;
>  	bool big_sync_term;
>  };
> =20
> @@ -807,7 +808,10 @@ static int big_terminate_sync(struct hci_dev *hdev, =
void *data)
>  	if (d->big_sync_term)
>  		hci_le_big_terminate_sync(hdev, d->big);
> =20
> -	return hci_le_pa_terminate_sync(hdev, d->sync_handle);
> +	if (d->pa_sync_term)
> +		return hci_le_pa_terminate_sync(hdev, d->sync_handle);
> +
> +	return 0;
>  }
> =20
>  static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci=
_conn *conn)
> @@ -823,6 +827,7 @@ static int hci_le_big_terminate(struct hci_dev *hdev,=
 u8 big, struct hci_conn *c
> =20
>  	d->big =3D big;
>  	d->sync_handle =3D conn->sync_handle;
> +	d->pa_sync_term =3D test_and_clear_bit(HCI_CONN_PA_SYNC, &conn->flags);
>  	d->big_sync_term =3D test_and_clear_bit(HCI_CONN_BIG_SYNC, &conn->flags=
);
> =20
>  	ret =3D hci_cmd_sync_queue(hdev, big_terminate_sync, d,
> @@ -2099,7 +2104,8 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdaddr=
_t *dst, __u8 dst_type,
>  	return hci_cmd_sync_queue(hdev, create_pa_sync, cp, create_pa_complete)=
;
>  }
> =20
> -int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
> +int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
> +			   struct bt_iso_qos *qos,
>  			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
>  {
>  	struct _packed {
> @@ -2115,6 +2121,9 @@ int hci_le_big_create_sync(struct hci_dev *hdev, st=
ruct bt_iso_qos *qos,
>  	if (err)
>  		return err;
> =20
> +	if (hcon)
> +		hcon->iso_qos.bcast.big =3D qos->bcast.big;
> +
>  	memset(&pdu, 0, sizeof(pdu));
>  	pdu.cp.handle =3D qos->bcast.big;
>  	pdu.cp.sync_handle =3D cpu_to_le16(sync_handle);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 559b6080706c..b4b72070f5f6 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6581,20 +6581,39 @@ static void hci_le_pa_sync_estabilished_evt(struc=
t hci_dev *hdev, void *data,
>  	struct hci_ev_le_pa_sync_established *ev =3D data;
>  	int mask =3D hdev->link_mode;
>  	__u8 flags =3D 0;
> +	struct hci_conn *bis;
> =20
>  	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
> =20
> -	if (ev->status)
> -		return;
> -
>  	hci_dev_lock(hdev);
> =20
>  	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
> =20
>  	mask |=3D hci_proto_connect_ind(hdev, &ev->bdaddr, ISO_LINK, &flags);
> -	if (!(mask & HCI_LM_ACCEPT))
> +	if (!(mask & HCI_LM_ACCEPT)) {
>  		hci_le_pa_term_sync(hdev, ev->handle);
> +		goto unlock;
> +	}
> +
> +	if (!(flags & HCI_PROTO_DEFER))
> +		goto unlock;
> +
> +	/* Add connection to indicate the PA sync event */
> +	bis =3D hci_conn_add(hdev, ISO_LINK, BDADDR_ANY,
> +			   HCI_ROLE_SLAVE);
> =20
> +	if (!bis)
> +		goto unlock;
> +
> +	if (ev->status)
> +		set_bit(HCI_CONN_PA_SYNC_FAILED, &bis->flags);
> +	else
> +		set_bit(HCI_CONN_PA_SYNC, &bis->flags);
> +
> +	/* Notify connection to iso layer */
> +	hci_connect_cfm(bis, ev->status);
> +
> +unlock:
>  	hci_dev_unlock(hdev);
>  }
> =20
> @@ -7045,6 +7064,7 @@ static void hci_le_big_sync_established_evt(struct =
hci_dev *hdev, void *data,
>  {
>  	struct hci_evt_le_big_sync_estabilished *ev =3D data;
>  	struct hci_conn *bis;
> +	struct hci_conn *pa_sync;
>  	int i;
> =20
>  	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
> @@ -7055,6 +7075,15 @@ static void hci_le_big_sync_established_evt(struct=
 hci_dev *hdev, void *data,
> =20
>  	hci_dev_lock(hdev);
> =20
> +	if (!ev->status) {
> +		pa_sync =3D hci_conn_hash_lookup_pa_sync(hdev, ev->handle);
> +		if (pa_sync)
> +			/* Also mark the BIG sync established event on the
> +			 * associated PA sync hcon
> +			 */
> +			set_bit(HCI_CONN_BIG_SYNC, &pa_sync->flags);
> +	}
> +
>  	for (i =3D 0; i < ev->num_bis; i++) {
>  		u16 handle =3D le16_to_cpu(ev->bis[i]);
>  		__le32 interval;
> @@ -7068,6 +7097,10 @@ static void hci_le_big_sync_established_evt(struct=
 hci_dev *hdev, void *data,
>  			bis->handle =3D handle;
>  		}
> =20
> +		if (ev->status !=3D 0x42)
> +			/* Mark PA sync as established */
> +			set_bit(HCI_CONN_PA_SYNC, &bis->flags);
> +
>  		bis->iso_qos.bcast.big =3D ev->handle;
>  		memset(&interval, 0, sizeof(interval));
>  		memcpy(&interval, ev->latency, sizeof(ev->latency));
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index d10a0f36b947..0cb780817198 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5384,6 +5384,21 @@ int hci_abort_conn_sync(struct hci_dev *hdev, stru=
ct hci_conn *conn, u8 reason)
>  		err =3D hci_reject_conn_sync(hdev, conn, reason);
>  		break;
>  	case BT_OPEN:
> +		hci_dev_lock(hdev);
> +
> +		/* Cleanup bis or pa sync connections */
> +		if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags) ||
> +		    test_and_clear_bit(HCI_CONN_PA_SYNC_FAILED, &conn->flags)) {
> +			hci_conn_failed(conn, reason);
> +		} else if (test_bit(HCI_CONN_PA_SYNC, &conn->flags) ||
> +			   test_bit(HCI_CONN_BIG_SYNC, &conn->flags)) {
> +			conn->state =3D BT_CLOSED;
> +			hci_disconn_cfm(conn, reason);
> +			hci_conn_del(conn);
> +		}
> +
> +		hci_dev_unlock(hdev);
> +		return 0;

Note the hci_disconnect_all_sync changes in 45c37c4e9c9aab5b=C2=A0now
require the conn is deleted in all cases, the above probably results to
busy loop if non-ISO broadcast conn is in BT_OPEN when controller is
supended.

>  	case BT_BOUND:
>  		hci_dev_lock(hdev);
>  		hci_conn_failed(conn, reason);
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 6b66d6a88b9a..9879f2349d48 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -51,6 +51,7 @@ static void iso_sock_kill(struct sock *sk);
>  /* iso_pinfo flags values */
>  enum {
>  	BT_SK_BIG_SYNC,
> +	BT_SK_PA_SYNC,
>  };
> =20
>  struct iso_pinfo {
> @@ -75,6 +76,8 @@ static struct bt_iso_qos default_qos;
> =20
>  static bool check_ucast_qos(struct bt_iso_qos *qos);
>  static bool check_bcast_qos(struct bt_iso_qos *qos);
> +static bool iso_match_sid(struct sock *sk, void *data);
> +static void iso_sock_disconn(struct sock *sk);
> =20
>  /* ---- ISO timers ---- */
>  #define ISO_CONN_TIMEOUT	(HZ * 40)
> @@ -598,6 +601,15 @@ static void iso_sock_cleanup_listen(struct sock *par=
ent)
>  		iso_sock_kill(sk);
>  	}
> =20
> +	/* If listening socket stands for a PA sync connection,
> +	 * properly disconnect the hcon and socket.
> +	 */
> +	if (iso_pi(parent)->conn && iso_pi(parent)->conn->hcon &&
> +	    test_bit(HCI_CONN_PA_SYNC, &iso_pi(parent)->conn->hcon->flags)) {
> +		iso_sock_disconn(parent);
> +		return;
> +	}
> +
>  	parent->sk_state  =3D BT_CLOSED;
>  	sock_set_flag(parent, SOCK_ZAPPED);
>  }
> @@ -619,6 +631,16 @@ static void iso_sock_kill(struct sock *sk)
>  	sock_put(sk);
>  }
> =20
> +static void iso_sock_disconn(struct sock *sk)
> +{
> +	sk->sk_state =3D BT_DISCONN;
> +	iso_sock_set_timer(sk, ISO_DISCONN_TIMEOUT);
> +	iso_conn_lock(iso_pi(sk)->conn);
> +	hci_conn_drop(iso_pi(sk)->conn->hcon);
> +	iso_pi(sk)->conn->hcon =3D NULL;
> +	iso_conn_unlock(iso_pi(sk)->conn);
> +}
> +
>  static void __iso_sock_close(struct sock *sk)
>  {
>  	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
> @@ -631,20 +653,19 @@ static void __iso_sock_close(struct sock *sk)
>  	case BT_CONNECT:
>  	case BT_CONNECTED:
>  	case BT_CONFIG:
> -		if (iso_pi(sk)->conn->hcon) {
> -			sk->sk_state =3D BT_DISCONN;
> -			iso_sock_set_timer(sk, ISO_DISCONN_TIMEOUT);
> -			iso_conn_lock(iso_pi(sk)->conn);
> -			hci_conn_drop(iso_pi(sk)->conn->hcon);
> -			iso_pi(sk)->conn->hcon =3D NULL;
> -			iso_conn_unlock(iso_pi(sk)->conn);
> -		} else {
> +		if (iso_pi(sk)->conn->hcon)
> +			iso_sock_disconn(sk);
> +		else
>  			iso_chan_del(sk, ECONNRESET);
> -		}
>  		break;
> =20
>  	case BT_CONNECT2:
> -		iso_chan_del(sk, ECONNRESET);
> +		if (iso_pi(sk)->conn->hcon &&
> +		    (test_bit(HCI_CONN_PA_SYNC, &iso_pi(sk)->conn->hcon->flags) ||
> +		    test_bit(HCI_CONN_PA_SYNC_FAILED, &iso_pi(sk)->conn->hcon->flags))=
)
> +			iso_sock_disconn(sk);
> +		else
> +			iso_chan_del(sk, ECONNRESET);
>  		break;
>  	case BT_DISCONN:
>  		iso_chan_del(sk, ECONNRESET);
> @@ -1139,6 +1160,29 @@ static void iso_conn_defer_accept(struct hci_conn =
*conn)
>  	hci_send_cmd(hdev, HCI_OP_LE_ACCEPT_CIS, sizeof(cp), &cp);
>  }
> =20
> +static void iso_conn_big_sync(struct sock *sk)
> +{
> +	int err;
> +	struct hci_dev *hdev;
> +
> +	hdev =3D hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
> +			     iso_pi(sk)->src_type);
> +
> +	if (!hdev)
> +		return;
> +
> +	if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
> +		err =3D hci_le_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
> +					     &iso_pi(sk)->qos,
> +					     iso_pi(sk)->sync_handle,
> +					     iso_pi(sk)->bc_num_bis,
> +					     iso_pi(sk)->bc_bis);
> +		if (err)
> +			bt_dev_err(hdev, "hci_le_big_create_sync: %d",
> +				   err);
> +	}
> +}
> +
>  static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  			    size_t len, int flags)
>  {
> @@ -1151,8 +1195,15 @@ static int iso_sock_recvmsg(struct socket *sock, s=
truct msghdr *msg,
>  		lock_sock(sk);
>  		switch (sk->sk_state) {
>  		case BT_CONNECT2:
> -			iso_conn_defer_accept(pi->conn->hcon);
> -			sk->sk_state =3D BT_CONFIG;
> +			if (pi->conn->hcon &&
> +			    test_bit(HCI_CONN_PA_SYNC, &pi->conn->hcon->flags)) {
> +				iso_conn_big_sync(sk);
> +				sk->sk_state =3D BT_LISTEN;
> +				set_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
> +			} else {
> +				iso_conn_defer_accept(pi->conn->hcon);
> +				sk->sk_state =3D BT_CONFIG;
> +			}
>  			release_sock(sk);
>  			return 0;
>  		case BT_CONNECT:
> @@ -1513,11 +1564,17 @@ static bool iso_match_big(struct sock *sk, void *=
data)
>  	return ev->handle =3D=3D iso_pi(sk)->qos.bcast.big;
>  }
> =20
> +static bool iso_match_pa_sync_flag(struct sock *sk, void *data)
> +{
> +	return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
> +}
> +
>  static void iso_conn_ready(struct iso_conn *conn)
>  {
> -	struct sock *parent;
> +	struct sock *parent =3D NULL;
>  	struct sock *sk =3D conn->sk;
> -	struct hci_ev_le_big_sync_estabilished *ev;
> +	struct hci_ev_le_big_sync_estabilished *ev =3D NULL;
> +	struct hci_ev_le_pa_sync_established *ev2 =3D NULL;
>  	struct hci_conn *hcon;
> =20
>  	BT_DBG("conn %p", conn);
> @@ -1529,15 +1586,32 @@ static void iso_conn_ready(struct iso_conn *conn)
>  		if (!hcon)
>  			return;
> =20
> -		ev =3D hci_recv_event_data(hcon->hdev,
> -					 HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
> -		if (ev)
> +		if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags) ||
> +		    test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
> +			ev =3D hci_recv_event_data(hcon->hdev,
> +						 HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
> +
> +			/* Get reference to PA sync parent socket, if it exists */
>  			parent =3D iso_get_sock_listen(&hcon->src,
>  						     &hcon->dst,
> -						     iso_match_big, ev);
> -		else
> +						     iso_match_pa_sync_flag, NULL);
> +			if (!parent && ev)
> +				parent =3D iso_get_sock_listen(&hcon->src,
> +							     &hcon->dst,
> +							     iso_match_big, ev);
> +		} else if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags) ||
> +				test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->flags)) {
> +			ev2 =3D hci_recv_event_data(hcon->hdev,
> +						  HCI_EV_LE_PA_SYNC_ESTABLISHED);
> +			if (ev2)
> +				parent =3D iso_get_sock_listen(&hcon->src,
> +							     &hcon->dst,
> +							     iso_match_sid, ev2);
> +		}
> +
> +		if (!parent)
>  			parent =3D iso_get_sock_listen(&hcon->src,
> -						     BDADDR_ANY, NULL, NULL);
> +							BDADDR_ANY, NULL, NULL);
> =20
>  		if (!parent)
>  			return;
> @@ -1554,11 +1628,17 @@ static void iso_conn_ready(struct iso_conn *conn)
>  		iso_sock_init(sk, parent);
> =20
>  		bacpy(&iso_pi(sk)->src, &hcon->src);
> -		iso_pi(sk)->src_type =3D hcon->src_type;
> +
> +		/* Convert from HCI to three-value type */
> +		if (hcon->src_type =3D=3D ADDR_LE_DEV_PUBLIC)
> +			iso_pi(sk)->src_type =3D BDADDR_LE_PUBLIC;
> +		else
> +			iso_pi(sk)->src_type =3D BDADDR_LE_RANDOM;
> =20
>  		/* If hcon has no destination address (BDADDR_ANY) it means it
> -		 * was created by HCI_EV_LE_BIG_SYNC_ESTABILISHED so we need to
> -		 * initialize using the parent socket destination address.
> +		 * was created by HCI_EV_LE_BIG_SYNC_ESTABILISHED or
> +		 * HCI_EV_LE_PA_SYNC_ESTABLISHED so we need to initialize using
> +		 * the parent socket destination address.
>  		 */
>  		if (!bacmp(&hcon->dst, BDADDR_ANY)) {
>  			bacpy(&hcon->dst, &iso_pi(parent)->dst);
> @@ -1566,13 +1646,21 @@ static void iso_conn_ready(struct iso_conn *conn)
>  			hcon->sync_handle =3D iso_pi(parent)->sync_handle;
>  		}
> =20
> +		if (ev2 && !ev2->status) {
> +			iso_pi(sk)->sync_handle =3D iso_pi(parent)->sync_handle;
> +			iso_pi(sk)->qos =3D iso_pi(parent)->qos;
> +			iso_pi(sk)->bc_num_bis =3D iso_pi(parent)->bc_num_bis;
> +			memcpy(iso_pi(sk)->bc_bis, iso_pi(parent)->bc_bis, ISO_MAX_NUM_BIS);
> +		}
> +
>  		bacpy(&iso_pi(sk)->dst, &hcon->dst);
>  		iso_pi(sk)->dst_type =3D hcon->dst_type;
> =20
>  		hci_conn_hold(hcon);
>  		iso_chan_add(conn, sk, parent);
> =20
> -		if (ev && ((struct hci_evt_le_big_sync_estabilished *)ev)->status) {
> +		if ((ev && ((struct hci_evt_le_big_sync_estabilished *)ev)->status) ||
> +		    (ev2 && ev2->status)) {
>  			/* Trigger error signal on child socket */
>  			sk->sk_err =3D ECONNREFUSED;
>  			sk->sk_error_report(sk);
> @@ -1630,7 +1718,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t =
*bdaddr, __u8 *flags)
>  	if (ev1) {
>  		sk =3D iso_get_sock_listen(&hdev->bdaddr, bdaddr, iso_match_sid,
>  					 ev1);
> -		if (sk)
> +		if (sk && !ev1->status)
>  			iso_pi(sk)->sync_handle =3D le16_to_cpu(ev1->handle);
> =20
>  		goto done;
> @@ -1638,16 +1726,21 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_=
t *bdaddr, __u8 *flags)
> =20
>  	ev2 =3D hci_recv_event_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT);
>  	if (ev2) {
> +		/* Try to get PA sync listening socket, if it exists */
>  		sk =3D iso_get_sock_listen(&hdev->bdaddr, bdaddr,
> -					 iso_match_sync_handle, ev2);
> +						iso_match_pa_sync_flag, NULL);
> +		if (!sk)
> +			sk =3D iso_get_sock_listen(&hdev->bdaddr, bdaddr,
> +						 iso_match_sync_handle, ev2);
>  		if (sk) {
>  			int err;
> =20
>  			if (ev2->num_bis < iso_pi(sk)->bc_num_bis)
>  				iso_pi(sk)->bc_num_bis =3D ev2->num_bis;
> =20
> -			if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
> -				err =3D hci_le_big_create_sync(hdev,
> +			if (!test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
> +			    !test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
> +				err =3D hci_le_big_create_sync(hdev, NULL,
>  							     &iso_pi(sk)->qos,
>  							     iso_pi(sk)->sync_handle,
>  							     iso_pi(sk)->bc_num_bis,
> @@ -1699,12 +1792,13 @@ static void iso_connect_cfm(struct hci_conn *hcon=
, __u8 status)
> =20
>  	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
> =20
> -	/* Similar to the success case, if HCI_CONN_BIG_SYNC_FAILED is set,
> -	 * queue the failed bis connection into the accept queue of the
> -	 * listening socket and wake up userspace, to inform the user about
> -	 * the BIG sync failed event.
> +	/* Similar to the success case, if HCI_CONN_BIG_SYNC_FAILED or
> +	 * HCI_CONN_PA_SYNC_FAILED is set, queue the failed connection
> +	 * into the accept queue of the listening socket and wake up
> +	 * userspace, to inform the user about the event.
>  	 */
> -	if (!status || test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
> +	if (!status || test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags) ||
> +	    test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->flags)) {
>  		struct iso_conn *conn;
> =20
>  		conn =3D iso_conn_add(hcon);

--=20
Pauli Virtanen
