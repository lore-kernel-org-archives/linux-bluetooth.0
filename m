Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B5DEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 14:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjF1OuM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 10:50:12 -0400
Received: from lahtoruutu.iki.fi ([185.185.170.37]:54956 "EHLO
        lahtoruutu.iki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjF1Otf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 10:49:35 -0400
Received: from [192.168.1.195] (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Qrkxm6b2yz49Q1x;
        Wed, 28 Jun 2023 17:49:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1687963773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svlKAnSeeuwN/o2D7eOOTPWtFKfZ89WFr0/2zVc935o=;
        b=PMfO0kTuOx/fVY4/cBfoX/DoRlqcpT05j4PM99Yc8SFPfcWST7QJRfLLSVnNj5UU/Gm7/E
        bpGyNhrpx6v7rySoigKshfcWl4t3ZOyb3U0N6EN2TxNLpVIJAwjEUovjiavx1LtSZYJ93s
        oTr/xy7uyiUwO5jL7Z//siC5QzvgX/ZLu2tmBr2md1NypLYGzxub9oKKbOZpKrBE57Pp8e
        aeOnnS484K0etQgmgArcDTc4Tr86X+GpiTHrPg4eskjASpShYgj4tyxgQJ7fuCXm7opahs
        dl7Yez3YJK4nb436yhO9A1ah7hxyM3LsHFMR0NYk3U1HdsxFBy2LFTi9TwB/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1687963773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svlKAnSeeuwN/o2D7eOOTPWtFKfZ89WFr0/2zVc935o=;
        b=R3t3oWHZjU1Oc4aFqr/Eni2btjgOihnje7ybgDUWQIBemwJ8Pstav7j4XMESFm0P+cSkRH
        XQpNvP4wMbKuJbrGRh6XNj8SCuVdPpCWgmehnWj05tGG64NwmYeOjeHfSgzWoP0f0p3v94
        S2ND0y/7u+TNwZULWaNvyvZxuHDXRMDKMM16SQZfVSczVaKU3aOxHGlpbX+Rchiu2b38Fz
        oR6yzk1RGH5VbuqQWzkWalwxkmBiacGLLnSk1aUKLlm+rYpiToYzFmRQMnAWftVdx9XmHB
        AahPjThTbi47hkrrXUdhmKgO6sX0WDZ+JX76+PDPPw9md7M+RGD4XbEViO2s6w==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1687963773; a=rsa-sha256;
        cv=none;
        b=Mk/sjng2d9QorUpGdIlJlHtO+R8oxyIyziQsXw8ja/U8lJTdwIdKdCx4wKXESf/QKkMWx2
        7xW19wl82vP36ecDcDuyk2LZaiBZWi07XGjdjr99vHfRLF+chOBnr0HuBKVGLAalXXwBdH
        vZ87dKnMFFIgvXns1ivy0FmR/LAXKnU+H8UCCU5hOqgxpCUE53OQx9a7zts+YFtqhoceip
        2vElPq5JAoApcO2XJDIrYs0Q4s2x4TbpQNgFr51Yy/BEiGluhqNJoOXekhDxjNBcstQy6Q
        6ba8MxaUASowUWLMqKiaUQD2rkODUEEe3Q3EIQT9r2yijWfT++1YOuct4ntKBA==
Message-ID: <0cdefb7f9c3b44ba999a4117dde9a1ac43bb1c42.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: hci_conn: Consolidate code for aborting
 connections
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Wed, 28 Jun 2023 17:49:32 +0300
In-Reply-To: <20230627215301.2648840-1-luiz.dentz@gmail.com>
References: <20230627215301.2648840-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

ti, 2023-06-27 kello 14:53 -0700, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This consolidates code for aborting connections using
> hci_cmd_sync_queue so it is synchronized with other threads, but
> because of the fact that some commands may block the cmd_sync_queue
> while waiting specific events this attempt to cancel those requests by
> using hci_cmd_sync_cancel.
>=20
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   2 +-
>  net/bluetooth/hci_conn.c         | 160 +++++++------------------------
>  net/bluetooth/hci_sync.c         |  20 ++--
>  net/bluetooth/mgmt.c             |  15 +--
>  4 files changed, 48 insertions(+), 149 deletions(-)
>=20
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 05a9b3ab3f56..094ca3aca15e 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -741,6 +741,7 @@ struct hci_conn {
>  	unsigned long	flags;
> =20
>  	enum conn_reasons conn_reason;
> +	__u8		abort_reason;
> =20
>  	__u32		clock;
>  	__u16		clock_accuracy;
> @@ -760,7 +761,6 @@ struct hci_conn {
>  	struct delayed_work auto_accept_work;
>  	struct delayed_work idle_work;
>  	struct delayed_work le_conn_timeout;
> -	struct work_struct  le_scan_cleanup;
> =20
>  	struct device	dev;
>  	struct dentry	*debugfs;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 47e7aa4d63a9..88f18f375684 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -178,57 +178,6 @@ static void hci_conn_cleanup(struct hci_conn *conn)
>  	hci_conn_put(conn);
>  }
> =20
> -static void le_scan_cleanup(struct work_struct *work)
> -{
> -	struct hci_conn *conn =3D container_of(work, struct hci_conn,
> -					     le_scan_cleanup);
> -	struct hci_dev *hdev =3D conn->hdev;
> -	struct hci_conn *c =3D NULL;
> -
> -	BT_DBG("%s hcon %p", hdev->name, conn);
> -
> -	hci_dev_lock(hdev);
> -
> -	/* Check that the hci_conn is still around */
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
> -		if (c =3D=3D conn)
> -			break;
> -	}
> -	rcu_read_unlock();
> -
> -	if (c =3D=3D conn) {
> -		hci_connect_le_scan_cleanup(conn, 0x00);
> -		hci_conn_cleanup(conn);
> -	}
> -
> -	hci_dev_unlock(hdev);
> -	hci_dev_put(hdev);
> -	hci_conn_put(conn);
> -}
> -
> -static void hci_connect_le_scan_remove(struct hci_conn *conn)
> -{
> -	BT_DBG("%s hcon %p", conn->hdev->name, conn);
> -
> -	/* We can't call hci_conn_del/hci_conn_cleanup here since that
> -	 * could deadlock with another hci_conn_del() call that's holding
> -	 * hci_dev_lock and doing cancel_delayed_work_sync(&conn->disc_work).
> -	 * Instead, grab temporary extra references to the hci_dev and
> -	 * hci_conn and perform the necessary cleanup in a separate work
> -	 * callback.
> -	 */
> -
> -	hci_dev_hold(conn->hdev);
> -	hci_conn_get(conn);
> -
> -	/* Even though we hold a reference to the hdev, many other
> -	 * things might get cleaned up meanwhile, including the hdev's
> -	 * own workqueue, so we can't use that for scheduling.
> -	 */
> -	schedule_work(&conn->le_scan_cleanup);
> -}
> -
>  static void hci_acl_create_connection(struct hci_conn *conn)
>  {
>  	struct hci_dev *hdev =3D conn->hdev;
> @@ -679,13 +628,6 @@ static void hci_conn_timeout(struct work_struct *wor=
k)
>  	if (refcnt > 0)
>  		return;
> =20
> -	/* LE connections in scanning state need special handling */
> -	if (conn->state =3D=3D BT_CONNECT && conn->type =3D=3D LE_LINK &&
> -	    test_bit(HCI_CONN_SCANNING, &conn->flags)) {
> -		hci_connect_le_scan_remove(conn);
> -		return;
> -	}
> -
>  	hci_abort_conn(conn, hci_proto_disconn_ind(conn));
>  }
> =20
> @@ -1066,7 +1008,6 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev,=
 int type, bdaddr_t *dst,
>  	INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
>  	INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
>  	INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
> -	INIT_WORK(&conn->le_scan_cleanup, le_scan_cleanup);
> =20
>  	atomic_set(&conn->refcnt, 0);
> =20
> @@ -2888,81 +2829,46 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
>  	return phys;
>  }
> =20
> -int hci_abort_conn(struct hci_conn *conn, u8 reason)
> +static int abort_conn_sync(struct hci_dev *hdev, void *data)
>  {
> -	int r =3D 0;
> +	struct hci_conn *conn;
> +	u16 handle =3D PTR_ERR(data);
> =20
> -	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
> +	conn =3D hci_conn_hash_lookup_handle(hdev, handle);
> +	if (!conn)
>  		return 0;
> =20
> -	switch (conn->state) {
> -	case BT_CONNECTED:
> -	case BT_CONFIG:
> -		if (conn->type =3D=3D AMP_LINK) {
> -			struct hci_cp_disconn_phy_link cp;
> +	return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
> +}
> =20
> -			cp.phy_handle =3D HCI_PHY_HANDLE(conn->handle);
> -			cp.reason =3D reason;
> -			r =3D hci_send_cmd(conn->hdev, HCI_OP_DISCONN_PHY_LINK,
> -					 sizeof(cp), &cp);
> -		} else {
> -			struct hci_cp_disconnect dc;
> +int hci_abort_conn(struct hci_conn *conn, u8 reason)
> +{
> +	struct hci_dev *hdev =3D conn->hdev;
> =20
> -			dc.handle =3D cpu_to_le16(conn->handle);
> -			dc.reason =3D reason;
> -			r =3D hci_send_cmd(conn->hdev, HCI_OP_DISCONNECT,
> -					 sizeof(dc), &dc);
> +	/* If abort_reason has already been set it means the connection is
> +	 * already being aborted so don't attempt to overwrite it.
> +	 */
> +	if (conn->abort_reason)
> +		return 0;
> +
> +	bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, reason)=
;
> +
> +	conn->abort_reason =3D reason;
> +
> +	/* If the connection is pending check the command opcode since that
> +	 * might be blocking on hci_cmd_sync_work while waiting its respective
> +	 * event so we need to hci_cmd_sync_cancel to cancel it.
> +	 */
> +	if (conn->state =3D=3D BT_CONNECT && hdev->req_status =3D=3D HCI_REQ_PE=
ND) {
> +		switch (hci_skb_event(hdev->sent_cmd)) {
> +		case HCI_EV_LE_CONN_COMPLETE:
> +		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
> +		case HCI_EVT_LE_CIS_ESTABLISHED:
> +			hci_cmd_sync_cancel(hdev, -ECANCELED);
> +			break;

Can this also accidentally cancel connection attempt for a different
conn?

Eg. start Create CIS conn1, then queue LE Connect conn2, then conn1
starts waiting for the events, then hci_conn_abort conn2, then here
conn1 gets canceled with error.

>  		}
> -
> -		conn->state =3D BT_DISCONN;
> -
> -		break;
> -	case BT_CONNECT:
> -		if (conn->type =3D=3D LE_LINK) {
> -			if (test_bit(HCI_CONN_SCANNING, &conn->flags))
> -				break;
> -			r =3D hci_send_cmd(conn->hdev,
> -					 HCI_OP_LE_CREATE_CONN_CANCEL, 0, NULL);
> -		} else if (conn->type =3D=3D ACL_LINK) {
> -			if (conn->hdev->hci_ver < BLUETOOTH_VER_1_2)
> -				break;
> -			r =3D hci_send_cmd(conn->hdev,
> -					 HCI_OP_CREATE_CONN_CANCEL,
> -					 6, &conn->dst);
> -		}
> -		break;
> -	case BT_CONNECT2:
> -		if (conn->type =3D=3D ACL_LINK) {
> -			struct hci_cp_reject_conn_req rej;
> -
> -			bacpy(&rej.bdaddr, &conn->dst);
> -			rej.reason =3D reason;
> -
> -			r =3D hci_send_cmd(conn->hdev,
> -					 HCI_OP_REJECT_CONN_REQ,
> -					 sizeof(rej), &rej);
> -		} else if (conn->type =3D=3D SCO_LINK || conn->type =3D=3D ESCO_LINK) =
{
> -			struct hci_cp_reject_sync_conn_req rej;
> -
> -			bacpy(&rej.bdaddr, &conn->dst);
> -
> -			/* SCO rejection has its own limited set of
> -			 * allowed error values (0x0D-0x0F) which isn't
> -			 * compatible with most values passed to this
> -			 * function. To be safe hard-code one of the
> -			 * values that's suitable for SCO.
> -			 */
> -			rej.reason =3D HCI_ERROR_REJ_LIMITED_RESOURCES;
> -
> -			r =3D hci_send_cmd(conn->hdev,
> -					 HCI_OP_REJECT_SYNC_CONN_REQ,
> -					 sizeof(rej), &rej);
> -		}
> -		break;
> -	default:
> -		conn->state =3D BT_CLOSED;
> -		break;
>  	}
> =20
> -	return r;
> +	return hci_cmd_sync_queue(hdev, abort_conn_sync, ERR_PTR(conn->handle),
> +				  NULL);
>  }
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index afb8e970e62c..ef8297d04a8c 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5271,10 +5271,13 @@ static int hci_disconnect_sync(struct hci_dev *hd=
ev, struct hci_conn *conn,
>  }
> =20
>  static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
> -				      struct hci_conn *conn)
> +				      struct hci_conn *conn, u8 reason)
>  {
> +	/* Return reason if scanning since the connection shall probably be
> +	 * cleanup directly.
> +	 */
>  	if (test_bit(HCI_CONN_SCANNING, &conn->flags))
> -		return 0;
> +		return reason;
> =20
>  	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
>  		return 0;
> @@ -5283,10 +5286,11 @@ static int hci_le_connect_cancel_sync(struct hci_=
dev *hdev,
>  				     0, NULL, HCI_CMD_TIMEOUT);
>  }
> =20
> -static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn=
 *conn)
> +static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn=
 *conn,
> +				   u8 reason)
>  {
>  	if (conn->type =3D=3D LE_LINK)
> -		return hci_le_connect_cancel_sync(hdev, conn);
> +		return hci_le_connect_cancel_sync(hdev, conn, reason);
> =20
>  	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
>  		return 0;
> @@ -5339,9 +5343,11 @@ int hci_abort_conn_sync(struct hci_dev *hdev, stru=
ct hci_conn *conn, u8 reason)
>  	case BT_CONFIG:
>  		return hci_disconnect_sync(hdev, conn, reason);
>  	case BT_CONNECT:
> -		err =3D hci_connect_cancel_sync(hdev, conn);
> +		err =3D hci_connect_cancel_sync(hdev, conn, reason);
>  		/* Cleanup hci_conn object if it cannot be cancelled as it
> -		 * likelly means the controller and host stack are out of sync.
> +		 * likelly means the controller and host stack are out of sync
> +		 * or in case of LE it was still scanning so it can be cleanup
> +		 * safely.
>  		 */
>  		if (err) {
>  			hci_dev_lock(hdev);
> @@ -6255,7 +6261,7 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, s=
truct hci_conn *conn)
> =20
>  done:
>  	if (err =3D=3D -ETIMEDOUT)
> -		hci_le_connect_cancel_sync(hdev, conn);
> +		hci_le_connect_cancel_sync(hdev, conn, 0x00);
> =20
>  	/* Re-enable advertising after the connection attempt is finished. */
>  	hci_resume_advertising_sync(hdev);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 0f5ba618ceb1..3156bc27088e 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3586,18 +3586,6 @@ static int pair_device(struct sock *sk, struct hci=
_dev *hdev, void *data,
>  	return err;
>  }
> =20
> -static int abort_conn_sync(struct hci_dev *hdev, void *data)
> -{
> -	struct hci_conn *conn;
> -	u16 handle =3D PTR_ERR(data);
> -
> -	conn =3D hci_conn_hash_lookup_handle(hdev, handle);
> -	if (!conn)
> -		return 0;
> -
> -	return hci_abort_conn_sync(hdev, conn, HCI_ERROR_REMOTE_USER_TERM);
> -}
> -
>  static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, voi=
d *data,
>  			      u16 len)
>  {
> @@ -3648,8 +3636,7 @@ static int cancel_pair_device(struct sock *sk, stru=
ct hci_dev *hdev, void *data,
>  					      le_addr_type(addr->type));
> =20
>  	if (conn->conn_reason =3D=3D CONN_REASON_PAIR_DEVICE)
> -		hci_cmd_sync_queue(hdev, abort_conn_sync, ERR_PTR(conn->handle),
> -				   NULL);
> +		hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
> =20
>  unlock:
>  	hci_dev_unlock(hdev);

