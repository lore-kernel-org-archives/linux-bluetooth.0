Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C863976A7
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576289; cv=pass; b=HG8LAQZSZIgE1/Gc+TYX55Qn75NvY5KvvPUbbcsnU38PGNWiPtZbqt5q0EjR9epY7pVCp8WTAyfWYdkv1rkVFLN8+ap+nPPvfMOa2S1Hf2SUZOPDHv/0chdKi5ctDpKTUGlx/xzk6GN4FC1j+xgcUzBINl9dOp2utIpKPf3Fr6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576289; c=relaxed/simple;
	bh=EVdbwGJr6FsBkKY6Yc+hJz2ih3cKejjLmJdn0+aHxaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uptPDw7k8Do0ydrLdpCe5kClDhVMgHbIZ9K1ez/9UTgns5Yjx7xVVr/S26au6bPkPyVRODIFdtNChbg2e/C3JsoNk+ov+KwKujk2S480x/DMWQTem31ZXWlkndo3RO97u5E5frYJkov1pY1fgEtqoTi19FQ5ftSdWUchDVfpY28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcchqpTW; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcchqpTW"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81ed2a06b9eso50710827b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784576287; cv=none;
        d=google.com; s=arc-20260327;
        b=rQ1trVoxnyxWXmwkR84c2g5c0px3NBXicnh64c4rKHy4eUA+yqXhZd1QVux0ZLLa1T
         Y5ZESkDPTP7jWxCIlLhWw/qofPqYFrTMOVGo26Mnt7teke/FkakIIgm1l+0klrmPb+AP
         N8k7tNclQDL15qI4x5Qf1Lw5K1vI5fJJipN0UkTNi2NoytXYUj6/Pf/2zcm3fyTaM1yd
         BcGkpVN9wzxGJpPS/luAs600O0Lt3wiPJmKIMkh2gd9oMLf50CpoPaLnOLPzz7LajVbn
         8+wOEHDMx0TxLnUU94yM6GnGUIquQKgB/W0u15Q7Z6KWR+TnDw6JGwvhVIpr1ri3iQvC
         DRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jSKnjk2ENcmg88vo++w7XKrzY/trrCSju7fNcaEW/hU=;
        fh=S+Linxy1fescbXjALse71ytl3WMimRL+llQ1r5du8lc=;
        b=O8ped4zTmUQkTDbGWjrcYYgDxsA0R56gypN+r0U6cePleKO7reOuHZ0FKwj61Lry59
         ah27HN3GK8akxGfKIcOZFZ585CYO8sHXYIuhMiiZWY49ve21VBxk4VkMf9WzJViKINOk
         W2i4SV3Ez+ARG0Ce11O1iIardoXDd3hvlVxMfTGqE1SHQ92CVIdYmOd0JpOCdiw0msSr
         pv9bTNkZvFq9amhEL8GwCgXkB4LkwpoNnO44+aPmVcRsSUR5X2z+tQ6KAL28OhS+/M/9
         UL27gdXetvF+X+WjTvbYzgMBcWUCm+DNnx8VdoxJmdYHNJ+UQfaCRr5x/iv9TMzciLoS
         8F2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784576287; x=1785181087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jSKnjk2ENcmg88vo++w7XKrzY/trrCSju7fNcaEW/hU=;
        b=BcchqpTW7LQmmD76I4AVJ0rAQfJkIkExZ5IIRi44WN6Wy/6ybUxLB1IvY+FkSDedx3
         Z010UjnB6gvye1XR9hAtUqAE48Nt2ByLh3k9PjkQDBx+gGfY7OJz8H9InmuwaJiu69Fd
         e5JGvRSYV2LSGXG0hO6EnW2tGS3VWiPLhB88UExFkWfRNvFbh/0UQddeYvY0MSpq2d5o
         CeIynBVvU6dlO6ItAsqtanMC8jo3ziPIj0CA04Bz92+xVhPRJ+KaUMMuKzrokVqiXsrx
         WZ/IW/ALXO6jdgl3NRVwtKJQ0SHm3E732C5dSpqTJEL/OGq/i32XrDmz25QO57D1t1uD
         u9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576287; x=1785181087;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jSKnjk2ENcmg88vo++w7XKrzY/trrCSju7fNcaEW/hU=;
        b=VppWAUfpSMVs1FRJdHd8/WttLsaR/MEdnlHd/Wl3ms3mzbgddUuLTnoUS3Wd2q6hvs
         aGMK5Tu6ajJQuDyFGlehd6P4jVgCfRUPSa+4ee86c9xqLOYEAkPK+GEYxJcbFHWY1Mcs
         HpZyI10JeXXuJObBCgbOUl8a3C7gLSGiLFRZpDtdCVU4KOc3AH1xhez2rALhS5sBPzEa
         x4jgWB0uQBei3gKbRjS5OSS4OJEBhW++lHj9vH3nYJec6R3u1GHTAvPUtl+yWfunbPPp
         G7dsK4+TLZmQ5DBc92y0J+afaPy3QP0zxNGMdf5UDyU8FVtFEUdda9J+2IBQ8cuplx7u
         j/Mw==
X-Gm-Message-State: AOJu0YwaS3F8E3/fEAR4gNZh89NOLbK+Pz3LjVGshxKefBExRVcE87Hk
	8wshTj9jvbyGS/1kV3bTinMyCTrDS4gCoHH4bofSSwGa0eSGuvfaurXtnOSpl2ytBUbOBd6e57A
	xt5shu25wPi1mUqlj7e4dOlkiOotVi/A=
X-Gm-Gg: AR+sD12jZYPKYIj0F7WjZwDH59CbtfMpfhlN9Kc1cZ3armdBl0/Rw1CwSRMrqWpiPHW
	a8BrGfbjhCD7YcPqgImeb/UAtOL2f9Ldt7XXjq4vVn56+aZVzvhT7eFeOehE3jcCJjb2Bpx+Vki
	/xLspsojJfY86Kqt0pK2l3jVfHeTdLtK4OM7NnAcdrHolKArZNSc9TcIiJPRLSd1vzwU5tst12y
	JTjDSWlBudmaTu111iTRZ095d0pb0Ps/oV5tGP3AVuWspjlxjqCt9jhEIeJQSVKa7/hbXyevrDO
	NdUEoWdxobTHICm8twSWsrJbyYAR2NZ1VLrtZYTUwUI5z7/n
X-Received: by 2002:a05:690c:6c02:b0:81e:685a:2f78 with SMTP id
 00721157ae682-81ef25bc64dmr48162597b3.43.1784576286980; Mon, 20 Jul 2026
 12:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4d96c545ad1a2fed02440a3478905853286aa0c7.1784571683.git.pav@iki.fi>
In-Reply-To: <4d96c545ad1a2fed02440a3478905853286aa0c7.1784571683.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Jul 2026 15:37:55 -0400
X-Gm-Features: AUfX_mz7bq7Pm0lk6Pxz-HYSXb5Ulr4Ia6duGJKDu1HkD8kgJEJvqJBxKStKB-c
Message-ID: <CABBYNZKtXwpnz9PH3eR31ETKAvPOoCnWebKf0UUDpe7tPQs3Kg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: ISO: fix UAF on socket close before
 shutdown completes
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	iulia.tanasescu@nxp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Jul 20, 2026 at 2:30=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> iso_sock_disconn() aims to disconnect the hcon by dropping it, which
> triggers iso_conn_del() once the HCI operation completes, requiring
> valid hcon->iso_data to do socket cleanup.  iso_sock_disconn() sets
> conn->hcon =3D NULL to avoid a second drop, but also preventing clearing
> hcon->iso_data on socket release. Closing the socket before
> iso_conn_del() runs then results to UAF.
>
> Fix by using a separate flag to track the hcon drop status, instead of
> clearing conn->hcon.
>
> Log: (BlueZ iso-tester ISO Connect Close - Success)
> BUG: KASAN: slab-use-after-free in iso_conn_hold_unless_zero
> ...
>  iso_conn_hold_unless_zero (net/bluetooth/iso.c:138)
>  iso_conn_del (net/bluetooth/iso.c:270)
>  hci_conn_failed (net/bluetooth/hci_conn.c:1408)
>  hci_abort_conn_sync (net/bluetooth/hci_sync.c:5817)
>
> Allocated by task 34:
>  iso_conn_add (net/bluetooth/iso.c:216)
>  iso_connect_cis (net/bluetooth/iso.c:507)
>  iso_sock_connect (net/bluetooth/iso.c:1211)
>  __sys_connect (net/socket.c:2148)
>
> Freed by task 34:
>  iso_chan_del (net/bluetooth/iso.c:248)
>  iso_sock_close (net/bluetooth/iso.c:885)
>  iso_sock_release (net/bluetooth/iso.c:2022)
>  sock_close (net/socket.c:722)
>
> Fixes: fbdc4bc47268 ("Bluetooth: ISO: Use defer setup to separate PA sync=
 and BIG sync")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  net/bluetooth/iso.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 2e95a153912c..6abc2b1f59bc 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -30,6 +30,7 @@ struct iso_conn {
>         /* @lock: spinlock protecting changes to iso_conn fields */
>         spinlock_t      lock;
>         struct sock     *sk;
> +       bool            hcon_dropped;

It might be safer to add a flag or something so we can perform atomic
operations to check if dropping is necessary.

>         struct delayed_work     timeout_work;
>
> @@ -107,7 +108,8 @@ static void iso_conn_free(struct kref *ref)
>
>         if (conn->hcon) {
>                 conn->hcon->iso_data =3D NULL;
> -               hci_conn_drop(conn->hcon);
> +               if (!conn->hcon_dropped)
> +                       hci_conn_drop(conn->hcon);
>         }
>
>         /* Ensure no more work items will run since hci_conn has been dro=
pped */
> @@ -306,6 +308,7 @@ static int __iso_chan_add(struct iso_conn *conn, stru=
ct sock *sk,
>
>         iso_pi(sk)->conn =3D conn;
>         conn->sk =3D sk;
> +       conn->hcon_dropped =3D false;
>
>         if (parent)
>                 bt_accept_enqueue(parent, sk, true);
> @@ -836,8 +839,10 @@ static void iso_sock_disconn(struct sock *sk)
>
>         sk->sk_state =3D BT_DISCONN;
>         iso_conn_lock(iso_pi(sk)->conn);
> -       hci_conn_drop(iso_pi(sk)->conn->hcon);
> -       iso_pi(sk)->conn->hcon =3D NULL;
> +       if (!iso_pi(sk)->conn->hcon_dropped) {
> +               iso_pi(sk)->conn->hcon_dropped =3D true;
> +               hci_conn_drop(iso_pi(sk)->conn->hcon);
> +       }
>         iso_conn_unlock(iso_pi(sk)->conn);
>  }
>
> --
> 2.55.0
>


--=20
Luiz Augusto von Dentz
