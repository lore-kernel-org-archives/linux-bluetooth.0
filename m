Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81F3CDB474
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 16:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjJPQaq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 12:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPQao (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 12:30:44 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BB3A7
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 09:30:42 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4S8Mzh0KWBz49Q5M;
        Mon, 16 Oct 2023 19:30:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1697473840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=OsKNQlpQtmU3xGG7JR8xhonyPmRIJ+7uDQq/7OZwVlQ=;
        b=F7avvPVdniyDmo3rlZII5dtZfgDA04uthURUY3kUG4dh03sLPUrXIg7RTzRoSu8p+Aotpz
        4G+o/FnKvksZHzcQNF9SY6tpYkxO0ukLWdRffwcSZeGlbcN/FXNcTZpHzpdxuA/9MnSWa3
        rUtrF10k0IWkq67srwkS7csdJA8TqwtXsx506AoIbW7l4BqWVUeF31BVwl3YqYXzI9HKab
        ysFhmgby7yL5fvj+x6fKaKDN8Iia3UvmPU5S4/ddmHUAMnKpnuodADgwlFrntGS9tcJtXe
        oY6LAS9oliLQRCJcLxjfi+N1EG460vsIiw+potVY5Hrdb1DLuDCvmv96lLYh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1697473840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=OsKNQlpQtmU3xGG7JR8xhonyPmRIJ+7uDQq/7OZwVlQ=;
        b=eD9PwqeqSUpQiV9aQ+Mkb9HN85Q441vjd2aA3yAAsYdQNNsLCl4NvisCT8hJ2W0wNbiD9j
        onEb+ImoKFyQk4Rybo1+L5zALsA0uEcvme3WMkZvKH6tleRUwDL9m4tGm+xa1yXI7n5sTZ
        6SgJA95R7Nn3xMndU2i7G1p8oJUS9dE6QhwZ+zmeuo53HQpkAw8J1rk1iozyu4xMqWKHPc
        fsJzRxn9QX84YWTk1WA6yNhwn4ndTXeCnAFdhY6Vxyo385J5kvClIHUovDc8wJ4Xu4m280
        iOJwlbgFqfV9RSyXlm+PHP+t2dsf34T354ZWPNggiooBfDJXIDm1Wj/BnPy5TA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1697473840; a=rsa-sha256;
        cv=none;
        b=i6rsnfGk8Dh7YFMc6oQEBjp1I8BMC/LU9DvU+AHOjw2pfzjtqPJOIFs077P6ECJ1+KgquP
        WA61Z0qtFyjTouHj7pIdP0bLlOrJf2z2/L6p3RcoxfeZDvb1Lp1PzADBKVGg55xRHL3NKy
        ngmVi/iyTH9rL+rb43qdsitdjQp+mK7WEJP/ZrQQqntdgduH0GKYHirJpJThlRl1Qv0dK4
        0NKJBnZHvgspaxY6HYPJTa8YvO7pjIVuhtM2w5DYRqryNXM3o/5PplY4M26nNujYvCFrBv
        tyx+QnU+B6eBOd593jU1AYE8QLrnF1KH0BLCkkuObTi2VWZ/gEQkQ/269SPheQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <f36d88931187444302d1610bb9c54a386ff437cf.camel@iki.fi>
Subject: Re: [PATCH 1/1] Bluetooth: ISO: Allow binding a PA sync socket
From:   Pauli Virtanen <pav@iki.fi>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        linux-bluetooth@vger.kernel.org
Date:   Mon, 16 Oct 2023 19:30:36 +0300
In-Reply-To: <20231016154545.2883-2-iulia.tanasescu@nxp.com>
References: <20231016154545.2883-1-iulia.tanasescu@nxp.com>
         <20231016154545.2883-2-iulia.tanasescu@nxp.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 (3.50.0-1.fc39) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

ma, 2023-10-16 kello 18:45 +0300, Iulia Tanasescu kirjoitti:
> This makes it possible to bind a PA sync socket to a number of BISes
> before issuing the BIG Create Sync command.
>=20
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  net/bluetooth/iso.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>=20
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 07b80e97aead..6938ff4accb3 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -813,6 +813,40 @@ static int iso_sock_bind_bc(struct socket *sock, str=
uct sockaddr *addr,
>  	return 0;
>  }
> =20
> +static int iso_sock_bind_pa_sk(struct sock *sk, struct sockaddr_iso *sa,
> +			       int addr_len)
> +{
> +	int err =3D 0;
> +
> +	lock_sock(sk);
> +
> +	if (sk->sk_type !=3D SOCK_SEQPACKET) {
> +		err =3D -EINVAL;
> +		goto done;
> +	}
> +
> +	if (addr_len <=3D sizeof(*sa)) {
> +		err =3D -EINVAL;
> +		goto done;
> +	}
> +
> +	iso_pi(sk)->bc_num_bis =3D sa->iso_bc->bc_num_bis;
> +
> +	for (int i =3D 0; i < iso_pi(sk)->bc_num_bis; i++)
> +		if (sa->iso_bc->bc_bis[i] < 0x01 ||
> +		    sa->iso_bc->bc_bis[i] > 0x1f) {
> +			err =3D -EINVAL;
> +			goto done;
> +		}
> +
> +	memcpy(iso_pi(sk)->bc_bis, sa->iso_bc->bc_bis,
> +	       iso_pi(sk)->bc_num_bis);
> +
> +done:
> +	release_sock(sk);
> +	return err;
> +}
> +
>  static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
>  			 int addr_len)
>  {
> @@ -826,6 +860,13 @@ static int iso_sock_bind(struct socket *sock, struct=
 sockaddr *addr,
>  	    addr->sa_family !=3D AF_BLUETOOTH)
>  		return -EINVAL;
> =20
> +	/* Allow the user to bind a PA sync socket to a number
> +	 * of BISes to sync to.
> +	 */
> +	if (sk->sk_state =3D=3D BT_CONNECT2 &&
> +	    test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
> +		return iso_sock_bind_pa_sk(sk, sa, addr_len);
> +
>  	lock_sock(sk);

If there's no reason not to, could we do instead

	lock_sock(sk);

	if (sk->sk_state =3D=3D BT_CONNECT2 &&
	    test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
		err =3D iso_sock_bind_pa_sk(sk, sa, addr_len);
		goto done;
	}

so that we don't race between branching on sk->sk_state and then taking
the lock.=C2=A0iso_sock_bind_pa_sk wouldn't also need to do locking then.

> =20
>  	if (sk->sk_state !=3D BT_OPEN) {

--=20
Pauli Virtanen
