Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E9BC001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 16:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjHDQ2o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 12:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjHDQ2k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 12:28:40 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784F449FA
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 09:28:36 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::a01d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RHWNx1SJDz49Q6x;
        Fri,  4 Aug 2023 19:28:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691166513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pzv8fsBbcwCgI/4G0rc5WWE+xmExtb9oxo8qlBpSxX4=;
        b=QHlPvHMMGWrhxYE15tj9RFiWXrsRn2fA5UXbSp9SNDdI5fV8JTtDY9AMLWpL+04L6odyzr
        GN8eGWXUJn2I62eaTRy7FO2JOB2sWLlSgq/qx+Tosotr1oJn0tnYOmN3tBvcN61jO+DSPP
        WaaZTPQM0udw/qCEzvv97h0Wehzu3Xts0LbX6t1pbH3VW7VkReSG4w3mv+t6tuDvpvXf8l
        wVRmgYYEux2s9rq80xcEgUUQHPsEvI6skYZOdJZ5mkhRD4zGWGtzqRfXc9hYFRxQ3sCg5O
        eHVUspcKl74/4WqmxzZFSi5f3q0pCLaNgQs4uXncCXKopp5xIRBpKNMbA4lh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691166513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pzv8fsBbcwCgI/4G0rc5WWE+xmExtb9oxo8qlBpSxX4=;
        b=XKTavlZQj0jNWaRUOJIKktPfcIi1n2nfdK4U78XOrxpUxQEoIzUJbHV8JwTv/QLsP2dr+n
        1si7fif61Ft4U8zq+t7gBbHJepBbpXrjh3gloRI6R25OsfoM1YepxSyWsu+WJ+pBlkXon+
        YO4ULXRmkFmxkO3MwpcYH/ZUO+9H5+ohqSsLVBfTxRlBJ1p2VFE6K2HRTnJo1qNxQu6IhN
        PH8ilsK6bt1EvL2mYixsM1p7QMwMro956Ap0AWQfUeL2mAWgubAm3TBug/f1WPD4R7tR3h
        Sy8BnQa9NtuFNQPIDgyKB9M/qB0URqRA2ngU6gbOM5uniiXO1ZIrjE6lfR9jPQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691166513; a=rsa-sha256;
        cv=none;
        b=jNcrYkVPOVtr/juszZ7uVZtyj+hd2SHKIi5aT4f8W79iVsCz0oCyuHnofwIlpR7eauhTUC
        pUh+r9pbTeOkCWggKZC4yEHO6ty1trb935X+VsnaELIKV1CxGXGaT+r+M8vPD02IvW53ov
        3GRJGLlqTm9kl5+TgYX4HeNbOT3ok9gMtQ8p2S7Lst5BjwTF17KocOWcKwKO7PbGWr4u2z
        BhBW/6zW9zRS5SbPvvZ8pQgzxIpvL+y7SXk9Cj1ybGehJJiOYAN6ug2MrwT7X6HmS+F/Hk
        3Jvwv1Z3pAZz1DaKt+EQptkgGlpS3EJeBPM1ROJKjFfqboAm7gMU2EapfteMNw==
Message-ID: <4c5eadaa0e013bced982050038de97435ad2881f.camel@iki.fi>
Subject: Re: [PATCH v2 4/5] Bluetooth: hci_conn: Fix modifying handle while
 aborting
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Fri, 04 Aug 2023 19:28:32 +0300
In-Reply-To: <20230804001115.907885-4-luiz.dentz@gmail.com>
References: <20230804001115.907885-1-luiz.dentz@gmail.com>
         <20230804001115.907885-4-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

to, 2023-08-03 kello 17:11 -0700, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This introduces hci_conn_set_handle which takes care of verifying the
> conditions where the hci_conn handle can be modified, including when
> hci_conn_abort has been called and also checks that the handles is
> valid as well.

It looks there could still be problem vs. sequences of the type

[kernel] hci_acl_create_connection(AA:AA:AA:AA:AA:AA)
[controller] < Create Connection AA:AA:AA:AA:AA:AA
[controller] > Connection Complete handle X
[kernel] hci_conn_complete_evt(handle X)
[kernel] hci_acl_create_connection(BB:BB:BB:BB:BB:BB)
[kernel] hci_abort_conn(handle X)
[controller] > Disconnect Complete handle X (from remote)
[kernel] hci_disconn_complete_evt(handle X)
[controller] < Create Connection BB:BB:BB:BB:BB:BB
[controller] > Connection Complete handle X  (same handle value)
[kernel] hci_conn_complete_evt(handle X)
...
[kernel] hci_abort_conn_sync(handle X)

This would seem to terminate the wrong connection.

Some flag/abort_reason could be checked to see if the looked up conn is
to be aborted before doing it. This can also be used to make
hci_disconnect_all_sync iteration UAF-safe.

It's unclear to me if you agree that tasks from hdev->workqueue and
hdev->req_workqueue can run concurrently, so that locking is needed.

>=20
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_conn.c         | 30 ++++++++++++++++++++++++++++++
>  net/bluetooth/hci_event.c        | 29 +++++++++++------------------
>  3 files changed, 42 insertions(+), 18 deletions(-)
>=20
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 8200a6689b39..d2a3a2a9fd7d 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1425,6 +1425,7 @@ int hci_conn_switch_role(struct hci_conn *conn, __u=
8 role);
>  void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active=
);
> =20
>  void hci_conn_failed(struct hci_conn *conn, u8 status);
> +u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle);
> =20
>  /*
>   * hci_conn_get() and hci_conn_put() are used to control the life-time o=
f an
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 923bb7e7be2b..13bd2753abbb 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1231,6 +1231,36 @@ void hci_conn_failed(struct hci_conn *conn, u8 sta=
tus)
>  	hci_conn_del(conn);
>  }
> =20
> +/* This function requires the caller holds hdev->lock */
> +u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle)
> +{
> +	struct hci_dev *hdev =3D conn->hdev;
> +
> +	bt_dev_dbg(hdev, "hcon %p handle 0x%4.4x", conn, handle);
> +
> +	if (conn->handle =3D=3D handle)
> +		return 0;
> +
> +	if (handle > HCI_CONN_HANDLE_MAX) {
> +		bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x",
> +			   handle, HCI_CONN_HANDLE_MAX);
> +		return HCI_ERROR_INVALID_PARAMETERS;
> +	}
> +
> +	/* If abort_reason has been sent it means the connection is being
> +	 * aborted and the handle shall not be changed.
> +	 */
> +	if (conn->abort_reason) {
> +		bt_dev_err(hdev, "hcon %p abort_reason 0x%2.2x", conn,
> +			   conn->abort_reason);
> +		return conn->abort_reason;
> +	}
> +
> +	conn->handle =3D handle;
> +
> +	return 0;
> +}
> +
>  static void create_le_conn_complete(struct hci_dev *hdev, void *data, in=
t err)
>  {
>  	struct hci_conn *conn;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index f1fcece29e7d..218da9b0fe8f 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3179,13 +3179,9 @@ static void hci_conn_complete_evt(struct hci_dev *=
hdev, void *data,
>  	}
> =20
>  	if (!status) {
> -		conn->handle =3D __le16_to_cpu(ev->handle);
> -		if (conn->handle > HCI_CONN_HANDLE_MAX) {
> -			bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x",
> -				   conn->handle, HCI_CONN_HANDLE_MAX);
> -			status =3D HCI_ERROR_INVALID_PARAMETERS;
> +		status =3D hci_conn_set_handle(conn, __le16_to_cpu(ev->handle));
> +		if (status)
>  			goto done;
> -		}
> =20
>  		if (conn->type =3D=3D ACL_LINK) {
>  			conn->state =3D BT_CONFIG;
> @@ -3849,11 +3845,9 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev =
*hdev, void *data,
>  		if (conn->state !=3D BT_BOUND && conn->state !=3D BT_CONNECT)
>  			continue;
> =20
> -		conn->handle =3D __le16_to_cpu(rp->handle[i]);
> +		if (hci_conn_set_handle(conn, __le16_to_cpu(rp->handle[i])))
> +			continue;
> =20
> -		bt_dev_dbg(hdev, "%p handle 0x%4.4x parent %p", conn,
> -			   conn->handle, conn->parent);
> -	=09
>  		if (conn->state =3D=3D BT_CONNECT)
>  			pending =3D true;
>  	}
> @@ -5039,11 +5033,8 @@ static void hci_sync_conn_complete_evt(struct hci_=
dev *hdev, void *data,
> =20
>  	switch (status) {
>  	case 0x00:
> -		conn->handle =3D __le16_to_cpu(ev->handle);
> -		if (conn->handle > HCI_CONN_HANDLE_MAX) {
> -			bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x",
> -				   conn->handle, HCI_CONN_HANDLE_MAX);
> -			status =3D HCI_ERROR_INVALID_PARAMETERS;
> +		status =3D hci_conn_set_handle(conn, __le16_to_cpu(ev->handle));
> +		if (status) {
>  			conn->state =3D BT_CLOSED;
>  			break;
>  		}
> @@ -6978,7 +6969,7 @@ static void hci_le_create_big_complete_evt(struct h=
ci_dev *hdev, void *data,
>  {
>  	struct hci_evt_le_create_big_complete *ev =3D data;
>  	struct hci_conn *conn;
> -	__u8 bis_idx =3D 0;
> +	__u8 i =3D 0;
> =20
>  	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
> =20
> @@ -6996,7 +6987,9 @@ static void hci_le_create_big_complete_evt(struct h=
ci_dev *hdev, void *data,
>  		    conn->iso_qos.bcast.big !=3D ev->handle)
>  			continue;
> =20
> -		conn->handle =3D __le16_to_cpu(ev->bis_handle[bis_idx++]);
> +		if (hci_conn_set_handle(conn,
> +					__le16_to_cpu(ev->bis_handle[i++])))
> +			continue;
> =20
>  		if (!ev->status) {
>  			conn->state =3D BT_CONNECTED;
> @@ -7015,7 +7008,7 @@ static void hci_le_create_big_complete_evt(struct h=
ci_dev *hdev, void *data,
>  		rcu_read_lock();
>  	}
> =20
> -	if (!ev->status && !bis_idx)
> +	if (!ev->status && !i)
>  		/* If no BISes have been connected for the BIG,
>  		 * terminate. This is in case all bound connections
>  		 * have been closed before the BIG creation

