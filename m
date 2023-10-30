Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FA0C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Oct 2023 22:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjJ3WNC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Oct 2023 18:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjJ3WNB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Oct 2023 18:13:01 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45DCBD
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 15:12:58 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SK6w65VLlz49Q2k;
        Tue, 31 Oct 2023 00:12:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1698703975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=HAY+2R+nb0uhJrJgdOVDS2Hn1DR1bg6g5XTFOpx7jCI=;
        b=dChe/xLg0iR0ggQpQWNURT74myChqodrSyPom8RdfEmsyPh0iBsEjXYlsva8lvoIS4iIS9
        3F9NAmUO/AbO4gkqXG5wxJwpDCzcsPLSSgjuelgZwRakDYFDha9CrhqcWeV/YEeKMMoOpu
        PazUAYyi6WSY52bu1b9WDFK3TaDHkWop/iTUKMLEQ3A+bKcPndSp9Dj2dRdovSuwIZWldW
        E3oW7kAC+MTyvM1u/bV0iY5Cr9JT7X0XwpRcnim9eJUEP75jPWRS10ZTx55Fb997FGtCLK
        I/VXJbKplsbCsOVZmeUclX+4tYKodYy7EsasRNLbylGa/9Wv8yy6GnHqPcSfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1698703975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=HAY+2R+nb0uhJrJgdOVDS2Hn1DR1bg6g5XTFOpx7jCI=;
        b=T16OHUiro4hguBAg7cSsk98XIgBVIB1wz7+F250iocDkVCiaBpJS9rtN5qCzi4LgGAV0G1
        jZTZjXEX//b/ijT9mKCirVfdp9M0evHJwvMNDGoiVD3WjU6wxcSgH8IHcNbOWGvckqgy+e
        dj92U3sEC53RYgs7Fqz3AYJ2CNCxJhg9f5FHlRYKkv4cszl5A3Uxdccqcc/bu5O2pSWW1j
        zl5prgvzjB9mH9DP3xFtlOXkyyhij9fVWQPHgB6JseZ725Sk378VmNujALroKYp/iGqTRN
        QMl8pTMdnE7y2Xmj521UNMqe6wlWn4eIfVfx7uF0anH7g8CMTcDYr9h0yj1x7Q==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1698703975; a=rsa-sha256;
        cv=none;
        b=DbTSrs5OxXms9gxrFFtodLwjuLhfkPrCbHkcZlDzwJKC/8wRjKhEneL1Op+kHQj5rIiAu3
        atAm3OjEvs1WlIq9t96jAxc8PGU3xD2GPRzxY4qMXgUhhyp0u1HoFYSZeKGV76XxzQG5Wj
        K3wACCIqgxcotr3ps36ePHZs2Tq7+z3UwdJgal9o9zSCh3KWurqFO9KtJ0vboqicfW4dCj
        2sB7hhBkDFmE0/Y06FgGNIWt/nNAKcAmLwENBikvIbNHTt2FrlZEOFU3n3tAh1LM5zg0By
        0+jM8Tk2ZGeiOWEvM7Dj6julWeiKE6mYYAxT9atiQuN9WgpzJGiISW1wMH9QUw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <96560beaf696de7c21e70b9bf6cd53bdcc29f29f.camel@iki.fi>
Subject: Re: [PATCH 1/1] Bluetooth: ISO: Reassociate a socket with an active
 BIS
From:   Pauli Virtanen <pav@iki.fi>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        linux-bluetooth@vger.kernel.org
Date:   Tue, 31 Oct 2023 00:12:49 +0200
In-Reply-To: <20231030154318.4339-2-iulia.tanasescu@nxp.com>
References: <20231030154318.4339-1-iulia.tanasescu@nxp.com>
         <20231030154318.4339-2-iulia.tanasescu@nxp.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=mQGiBDuWdUoRBAD5TV1PNJbFxQRmG3moFyJT74l8/6ailvCjgIzwl6Umi4oaDsrogD+myums6lgYe+J2kmbe1Sk2MiOdWzRgY+HbrW5tr8UV+hmNg88gMz9gl2ygWHgG/CSa53Zn+R6TmXXL23KafCYOWH2NKaXxU31c/0Da+yEI+AgkrW8nCOMeFwCgzuJK2qqKtjLqh7Iukt1Urxdp1IUEAMFVHx9TPoFEk4OsuWJRunn7cylFsI/FQlXqXa4GHwhA5zKTMJHo6aX8ITQlnZfdZuxBWF2bmdK2/CRzp0dirJw+f4Qa163kaH2gTq5b+xZXF56xgYMO3wgANtDG1ZKBmYpnV7lFPYpbuNuR0JpksBL5G1Ml3WGblpb4EWtVNrWfA/91HylTGtZnNIxI8iJUjDN0uPHgPVM90C/bU2Ll3i3UpyuXwSFIJq00+bxGQh/wWa50G6GvrBStzhAXdQ1xQRusQBppFByjCpVpzkCyV6POe74pa4m88PRhXKlj2MKWbWjxZeU88sAWhFx5u79Cs6imTSckOCyg0eiO4ca1TLZOGbQbUGF1bGkgVmlydGFuZW4gPHBhdkBpa2kuZmk+iIEEExEKAEECGyMCHgECF4ACGQEFCwkIBwMFFQoJCAsFFgIDAQAWIQSfjAgX4lc0PoQd+D3oFDFvs7SlYAUCWZ8gRwUJHgn8fQAKCRDoFDFvs7SlYELXAJ47uNwB5yXTPDmAhIebcrlE0Ub0kgCdGAfxvoNmbwJwk1sAikf9H5FBBBC0I1BhdWxpIFZpcnRhbmVuIDxwdHZpcnRhbkBjYy5odXQuZmk+iEkEMBECAAkFAlIFBAACHSAACgkQ6BQxb7O0pWDfnACgrnO9z6UBQDTtzYqJzNhdO5p9ji4An2BS0BThXwtWTNfn7ZoZcTIW+wQ7tCZQYXVsaSBWaXJ0YW5lbiA8cGF1bGkudmlydGFuZW5AaHV0LmZpPohJBDARAgAJB
        QJSBQQOAh0gAAoJEOgUMW+ztKVgZ3kAnRT88CSMune7hmpFgHYnZGvto6p6AJsH1V3wqODSn0c18aRHXy1XsSvh+bQmUGF1bGkgVmlydGFuZW4gPHBhdWxpLnZpcnRhbmVuQGlraS5maT6IfgQTEQoAPgIbIwIeAQIXgAULCQgHAwUVCgkICwUWAgMBABYhBJ+MCBfiVzQ+hB34PegUMW+ztKVgBQJZnyBHBQkeCfx9AAoJEOgUMW+ztKVgycwAoKg8QDz9HWOv/2N5e6qOCNhLuAtDAKDFZYfpefdj1YjkITIV9L8Pgy2UeLQmUGF1bGkgVmlydGFuZW4gPHBhdWxpLnZpcnRhbmVuQHRray5maT6ISQQwEQIACQUCUgUEFwIdIAAKCRDoFDFvs7SlYJ/NAJ0Vbzi14XXcR4nQoB5/4jtVYMnxDACeP5HzZj0fJ6jO1o6rLRC1jxdtWC+0LVBhdWxpIFZpcnRhbmVuIDxwYXVsaS52aXJ0YW5lbkBzYXVuYWxhaHRpLmZpPohJBDARAgAJBQJSBQQgAh0gAAoJEOgUMW+ztKVgM6kAn0mOV/EX8ptYEFEMpJpm0ZqlbM50AJ9fqg6GnP1EM1244sUfOu68000Dp5kBogRLOyfGEQQAsukDATfU5HB0Y+6Ub6PF0fDWXQ47RULV0AUDwJrmQSE4Xz3QXvZNVBEXz2CSpfT/MJFVwVxh10chNGaDOro6qgCdVMCFNunDgdwGtFrGvrVGT1sdSJNXM+mINIBm+i3MQv3FJQVZ+7LivleR5ZWOueQQJVSTH1Rf4ymbzBqc8fMAoMviiEI4NIRv2PZTgpOFLU5KaHznA/9cPcNkH8P1sllmDyDt9sVxEYj/1O+R/WaTalA3azQyCm19MVGouK/+Ku+RHON2S9/JibnemZhiqS+eDf63OGTbHMRhhwwObv3VY+8ftBnAX+IKQ5Y4ECWpnPeQHNmoJQ64ha7XYAPdSgSDvAlGCKmYLq
        Q8Cw9mpY4Cq50cs9rT/QQAhbWuU2Ti3YR/mVStexyHhp5BIi9QvGeCvHePi/O771fW8kXjX+9uFXoP1yX2juNY86+cR5Vgy4flqZu24Rq+5Hd4RNztZXs1sqR5w6f1C8uo3L+dhqXD4Bo4BYIuL6tdoiyNEUemVtjvTa03rjY4JHAbNjci20k+v3P43oZ9M+K0K1BhdWxpIFZpcnRhbmVuIChNYWVtbyB1cGxvYWRzKSA8cGF2QGlraS5maT6IZgQTEQoAJgIbAwYLCQgHAwIEFQIIAwQWAgMBAh4BAheABQJWzk4PBQkLlFGaAAoJEBJBo7AePJIwgHIAn14IziSme6nI/rHtGgDtfPup8KDBAJ9dYxHDYDgiFfqDkDNJMliyJ7xr0JkCDQRVadGcARAAtl2T0BPQKIEV0S/RRUT+Nu96jc5Xk7F5gUUdu+FAuooBpCyRqwPwefxuv4HpEGG9VJ5AZpGjd1j9wqTuS3XrGe6s+LlVSYE4mSFes9mhnRiPK99zOy6DwNYO0CQiSFxhwqRGspAfzgoFncbd8oA2yYTPiS65vain+sxOF4tj1FdNMJR4IwpIeeqfLASfQwdOr2QWHwZRZ3iR7BV/XTzofrOgr0CkEAGxKLh+arRtfBz4Dl8zj+kOXHyi/Wd7TYhERYwipuejBSDW6z86CQllscjUyaqj7eTq9eg7tPFrGLV3dv4mtk5p9j1XSlZhu2BrKAcfnuZDKym+4Y7s/s5SDxqY05gv2DEBkWyz1xCld07Wlp0e4J54MctlzZNuZ/C3v/yLscj0mNGGX7Q1I5cZ/9JW7ZQ7a83HvIywhW+YUFkfriObX/RDDXMjwb5PKGl1obi4Z3abkjtxzcl18q/UqAtPPgUGoVlHeuprgOVQBojc52iB0kMomJo33aQPYwBW2sptu59nukQ73LOwG8jrk+KR7c3QktOarHYhhcbgNnO5cgkpe0fYRYrhHiqLsxgJFWNybKhFdGXT21Z
        WNjPpAASFSfV7jOAJ/3xDTJXpuInIslloa8/+XohQ2NjuUItF5WaS7V0q31TtTcy5Tyks4etB3wINx38np3sUSZXRFisAEQEAAbQbUGF1bGkgVmlydGFuZW4gPHBhdkBpa2kuZmk+iQJXBBMBCgBBAhsDBQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAAhkBFiEEiNDtwDFNJaodBiJZHOiglY3YpVcFAllP1OgFCQ1MBMwACgkQHOiglY3YpVeCCQ/+LHJXPgofheRxdcJ3e7f13w+5V3zQBFC6i3ZKedVHCSkwjOvvYcl7VV39EC7hKIRO/PUw9pDuuDkiiJ5sbz9cvGhXQ8rvD6RCV5ldqdHOHK8e17eI2MfoLVgg2P4/KmnbfTBeVwXtFl2nBS8zKQyLYPC1Pt/1RRIjah/nWkkN6CpsaTG2nopUTkIS/0BKeUamuif4dveiRqb8A01t4uuf79Xkn2L0XO92EizHrBmYwG8eyTZYcHctccSvRYgxYK2G2dAAZoqar4yPYDzQ5iLyi+UhpDvC2QSYDygZvk5rTU9k+MgeZta52NsHG+izlsff73Ep9EgUdiXn0QaF+50qdWbTDlbTPJubKlT5E7rNTFOUEx2kCJWXb1QtpkrpW6FyfzGceVqNd8+NTAkJ1E/AlbssC47WTJ3Az8CZkEwF1D+rMKmCDYLxrTH5yu0G0K/cQHAceV+OzhoqXeV2DMhjaVUNOtmLb+LNzzeIAuA4O7e7NuxH+uKIetzYRsHLg0nlPhziIk1sjkxEtYGCPj0G3m6eDHAdpAJ1MFV8KxKA5AXwR27he34MllcVlzLah+nHXidnYDP+gTk33GqH6EsC+werHekkqrPn6U7ge6h+mEFEW8IUIxSEm7ALDZTNbJO1fEe35tjTOIwkEUceyjqp6l6navgs5GFx1xyMBljldwe0JlBhdWxpIFZpcnRhbmVuIDxwYXVsaS52aXJ0YW5lbkBpa2kuZmk+iQJU
        BBMBCgA+AhsDBQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAFiEEiNDtwDFNJaodBiJZHOiglY3YpVcFAllP1OgFCQ1MBMwACgkQHOiglY3YpVfiOA//YLTyfBMolR5K/s2WV/mgwQEJZqhdwBT+L/0mxqhuFMWuDnvkUzzBxLTM5a66SB4/JZtyQt14VSnRCuxBUaw/IUftK0ru3zIZjWFfLgHwSUwJCSy6oYwm7x2MAiKQUtAzpSfFJnwyQG2wK1uy6EpSjBX7YphlpKKv6UGiL0QuwWtXALrbI4EVbnozes89CaZHeE6zx/aDQgKa4ajInkIIvtOBmRqbvTPkJjcH84o7b84rP10DSO2Q2ooP8WYQ85y9RkF00yndR01VwNnURt7XmjVuoy8el0WUMv0q7evGTWSmXDPtUMq8e5DKt1uHWdkjV3uhHXjUTlI2gdMrxzbzxPYIWVWg4eE9jEdQvvGaYhDfFpmqF/ZSQT9jUCuWXMMpscy8NrmHnJtTvHBEfmaSgOQPnI7D7AA62q6mAVWEjcfKpgEs0Z2SK75P5yHmD2yEdZy+wSD8zheY1YDqvL50rx+l3mqoONmBwiW7R5dkMInqgQ156Uf8yMc8vv5exARr8WhJV61R2mSeHfxTFMMXaFG//NTHNX7ZpP0tECyePbu+IB32oa7P45EoNRZnLDG2KDOFsoUuy+CzQYPku5Gz8aqcgP7k8wb4J3QPPfiaAYrRJ9XOoiLUDodnWnPW9zLA1yWMnarzilEFPVmBztx6JKxlbFxnOfO6u5ry+uXZC4w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 (3.50.0-1.fc39) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

ma, 2023-10-30 kello 17:43 +0200, Iulia Tanasescu kirjoitti:
> For ISO Broadcast, all BISes from a BIG have the same lifespan - they
> cannot be created or terminated independently from each other.
>
> This links together all BIS hcons that are part of the same BIG, so all
> hcons are kept alive as long as the BIG is active.
>=20
> If multiple BIS sockets are opened for a BIG handle, and only part of
> them are closed at some point, the associated hcons will be marked as
> open. If new sockets will later be opened for the same BIG, they will
> be reassociated with the open BIS hcons.

Can you explain here a bit the new BIS hci_conn refcounting scheme,
it's not straightforward to follow? Who owns their refcounts?

>=20
> All BIS hcons will be cleaned up and the BIG will be terminated when
> the last BIS socket is closed from userspace.
>=20
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  include/net/bluetooth/hci_core.h | 24 +++++++++++++
>  net/bluetooth/hci_conn.c         | 27 ++++++++++++++
>  net/bluetooth/iso.c              | 60 ++++++++++++++++++++++++++++++++
>  3 files changed, 111 insertions(+)
>=20
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 20988623c5cc..201c0809540a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1292,6 +1292,30 @@ static inline struct hci_conn *hci_conn_hash_looku=
p_big(struct hci_dev *hdev,
>  	return NULL;
>  }
> =20
> +static inline struct hci_conn *
> +hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16=
 state)
> +{
> +	struct hci_conn_hash *h =3D &hdev->conn_hash;
> +	struct hci_conn  *c;
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(c, &h->list, list) {
> +		if (bacmp(&c->dst, BDADDR_ANY) || c->type !=3D ISO_LINK ||
> +			c->state !=3D state)
> +			continue;
> +
> +		if (handle =3D=3D c->iso_qos.bcast.big) {
> +			rcu_read_unlock();
> +			return c;
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return NULL;
> +}
> +
>  static inline struct hci_conn *
>  hci_conn_hash_lookup_pa_sync_big_handle(struct hci_dev *hdev, __u8 big)
>  {
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 2cee330188ce..b8ab5c0cd48e 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -2228,7 +2228,17 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev=
, bdaddr_t *dst,
>  			      __u8 base_len, __u8 *base)
>  {
>  	struct hci_conn *conn;
> +	struct hci_conn *parent;
>  	__u8 eir[HCI_MAX_PER_AD_LENGTH];
> +	struct hci_link *link;
> +
> +	/* Look for any BIS that is open for rebinding */
> +	conn =3D hci_conn_hash_lookup_big_state(hdev, qos->bcast.big, BT_OPEN);
> +	if (conn) {
> +		memcpy(qos, &conn->iso_qos, sizeof(*qos));
> +		conn->state =3D BT_CONNECTED;
> +		return conn;
> +	}
> =20
>  	if (base_len && base)
>  		base_len =3D eir_append_service_data(eir, 0,  0x1851,
> @@ -2256,6 +2266,20 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev=
, bdaddr_t *dst,
>  	conn->iso_qos =3D *qos;
>  	conn->state =3D BT_BOUND;
> =20
> +	/* Link BISes together */
> +	parent =3D hci_conn_hash_lookup_big(hdev,
> +					  conn->iso_qos.bcast.big);
> +	if (parent && parent !=3D conn) {
> +		link =3D hci_conn_link(parent, conn);
> +		if (!link) {
> +			hci_conn_drop(conn);
> +			return ERR_PTR(-ENOLINK);
> +		}
> +
> +		/* Link takes the refcount */
> +		hci_conn_drop(conn);
> +	}

So the first hci_conn added in a BIG is assigned as "parent". How does
the refcounting here work?

hci_conn_link takes refcount of the parent (cf. hci_conn_unlink), but
it's not incremented here so I guess it may go negative.

hci_conn_unlink does not drop child connections, and they're not
dropped by the socket closing below unless last, so I'm not sure if
they are then cleaned up if closing sockets in any order.

This change will also expose BIS hci_conns to hci_conn_cleanup_child,
which was written only for unicast, and might not be right for the use
case here.

> +
>  	return conn;
>  }
> =20
> @@ -2287,6 +2311,9 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hd=
ev, bdaddr_t *dst,
>  	if (IS_ERR(conn))
>  		return conn;
> =20
> +	if (conn->state =3D=3D BT_CONNECTED)
> +		return conn;
> +
>  	data.big =3D qos->bcast.big;
>  	data.bis =3D qos->bcast.bis;
> =20
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index e01b6abe36fb..13353d7dc4b1 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -587,6 +587,44 @@ static struct sock *iso_get_sock_listen(bdaddr_t *sr=
c, bdaddr_t *dst,
>  	return sk ? sk : sk1;
>  }
> =20
> +static struct sock *iso_get_sock_big(struct sock *match_sk, bdaddr_t *sr=
c,
> +				     bdaddr_t *dst, uint8_t big)
> +{
> +	struct sock *sk =3D NULL;
> +
> +	read_lock(&iso_sk_list.lock);
> +
> +	sk_for_each(sk, &iso_sk_list.head) {
> +		if (match_sk =3D=3D sk)
> +			continue;
> +
> +		/* Look for sockets that have already been
> +		 * connected to the BIG
> +		 */
> +		if (sk->sk_state !=3D BT_CONNECTED &&
> +		    sk->sk_state !=3D BT_CONNECT)
> +			continue;
> +
> +		/* Match Broadcast destination */
> +		if (bacmp(&iso_pi(sk)->dst, dst))
> +			continue;
> +
> +		/* Match BIG handle */
> +		if (iso_pi(sk)->qos.bcast.big !=3D big)
> +			continue;
> +
> +		/* Match source address */
> +		if (bacmp(&iso_pi(sk)->src, src))
> +			continue;
> +
> +		break;
> +	}
> +
> +	read_unlock(&iso_sk_list.lock);
> +
> +	return sk;

What keeps sk alive?

This pattern is used also in iso_get_sock_listen, but I don't
understand why it's OK. In unix/ & netrom/ & ax25/ I see sock_hold
before lock release in similar constructs.

> +}
> +
>  static void iso_sock_destruct(struct sock *sk)
>  {
>  	BT_DBG("sk %p", sk);
> @@ -639,6 +677,28 @@ static void iso_sock_kill(struct sock *sk)
> =20
>  static void iso_sock_disconn(struct sock *sk)
>  {
> +	struct sock *bis_sk;
> +	struct hci_conn *hcon =3D iso_pi(sk)->conn->hcon;
> +
> +	if (test_bit(HCI_CONN_BIG_CREATED, &hcon->flags)) {
> +		bis_sk =3D iso_get_sock_big(sk, &iso_pi(sk)->src,
> +					  &iso_pi(sk)->dst,
> +					  iso_pi(sk)->qos.bcast.big);
> +
> +		/* If there are any other connected sockets for the
> +		 * same BIG, just delete the sk and leave the bis
> +		 * hcon active, in case later rebinding is needed.
> +		 */
> +		if (bis_sk) {
> +			hcon->state =3D BT_OPEN;
> +			iso_pi(sk)->conn->hcon =3D NULL;
> +			release_sock(sk);
> +			iso_conn_del(hcon, bt_to_errno(hcon->abort_reason));

iso_conn_del must be called with hdev->lock held, that's assumed in
iso_connect*.

Locks must be taken in order hci_dev_lock > lock_sock > iso_conn_lock.

Could this use iso_chan_del instead (plus maybe iso_sock_clear_timer)?
Lifetime of iso_conn currently follows hcon, not sure if that needs to
be changed?

> +			lock_sock(sk);
> +			return;
> +		}
> +	}
> +
>  	sk->sk_state =3D BT_DISCONN;
>  	iso_sock_set_timer(sk, ISO_DISCONN_TIMEOUT);
>  	iso_conn_lock(iso_pi(sk)->conn);

Not related to this patch precisely, but I suspect the disconnect
timeout is something that is not useful for ISO sockets and maybe we
should remove it, since closing sockets is used for CIG/BIG management.

--=20
Pauli Virtanen
