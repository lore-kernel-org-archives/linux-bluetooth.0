Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795043093;
	b=2oecFUZmHT9kzCTwxADMosYjVWd8CZ0bxcQbChTH99K2xS18VHj9fHOccMqS43bN9O72
	 ZNjfZBqLoz5itrbUG6EW3RjKoVu5AYI3c8KNc+35Iw/QhX0MxAiYcHgITGidZ2elbOEXr
	 +7G25X7RMv+zNY5Api20p7+3dAKUqMTkKdhXvRKn/DXCckRgPGqXpjeJ2eAnhlAh1StHA
	 prfQ89Dgc3vWa6qyrcQw1RSIwiBJScRxL2AWwLtCezOoC1yu5VnTXdF+IlwIODVMfYGki
	 LPMvkxTrRBzkKQ8F4Pw5vQ5IQXWkdpYy2V979QrL+lQzIi4gPdzeHIXO4wPmrXytHvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=KZTFDK7wToVuIFH9xLlz+M7Y14/N8hcRBkBM/5LM+64=;
	b=SqgNs80z+uU4a0AaMI1Ji55+2n8/4OX28PL7mIqJEh7OdTVyQOOu/WjQxhC9hMOJJu7Q
	 PV4rOY5X1IcyWspbflMzuo074G1v8FJvlZmhyXGl8/IThSnYbemz/Fjyu9vkX45d8S9A/
	 1igJeymwipliON6NwyRICaXIwNZemj6GkazoThnjBQenOnxR8pZZwkisFpS7iXWHn+XIk
	 yR76sfGIg22UKzWpge/PQbU6BBwKU0gKgQaiJra3EGbNrcjcINXbU7cj4dH0McIcGE9Ht
	 uCT+C7Zp8iyESxZ4rNMvQHpyUOusjBjvvDNHpzIQ7pkFPqsvL84owf1xLLwn4DYYRGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fk7F4CVz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4960606A32F
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 23:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4960606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fk7F4CVz
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67dabd38cdfso1869325d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:04:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795043092; cv=none;
        d=google.com; s=arc-20260327;
        b=hyV0IUQrV10u8phDQe4E3UDo7namv5TFGVzQqSVtkprrl9IfIXSgsZGLnv3JJ+8Jf+
         GPSC3OmyDlfWgrF2/BHOv9qLhIE076ado7ShoJHmXhMZjo2p9n5S6kIHrxyb2kMppA+C
         ffRcPn/2FN8sysH+QSbehP4ao1/rrmgn7SYqtXjeVWIcaYEjNpv2GRKkg6H9vvTKeQ5u
         uhOPJ/1tmC39/Yoxdhf0s/qW9ZU9/mwun2wwYXPjdoOqOEKUHjic27NjbClZ+eH9bazm
         KqmOzCSyeBD9IPutzWwAhBWjRcGDL7e8l30j6Si1EPQgx/H4yPAU3Qpdx5WS1OZDdNRq
         lGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KZTFDK7wToVuIFH9xLlz+M7Y14/N8hcRBkBM/5LM+64=;
        fh=epaCqHH5oWjBKJrh9YScy5IbnruG0DtPxVaTp4+ZegY=;
        b=jTM8DZioYD6ITC8J+oc+x1CqXncINpCC5hFuheW9jWb1HFnVj6hMltLIxA9Pv/bt/V
         aqGQvKH1bv5+ADaGBAAEKgHYfPsWuRqa3SmW6t5aBwJioGr2LopBNwgKc+SNpBH0pcke
         +cChK3QlKsRqchurBIR/iiG54NwzCimtTQ9t7zWdET4dpU5JJuYAdAygnQn2CbJ9Ha1J
         uho3F8DB9Z8Eg6RMCf6JIynspB5PBrXWlWo0IU8CIhzrDpQKiKSUncKSZqpl36whxMcw
         Du27bGS0udGTkYOq/nBGI552OgdupPJxJKCgX7P59N+rdSZWAY93gk9vELqKhNQ+N10X
         /SRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795043092; x=1795647892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KZTFDK7wToVuIFH9xLlz+M7Y14/N8hcRBkBM/5LM+64=;
        b=Fk7F4CVzIqTVpBYAzrvf0DhPem4rMGXqFCTAbCqTTl4z67X4xNwlAGDndr5BqH51ft
         LKGecTsrb0y1pnpukSvjvXLetjlRaFkXGUN6avocCGpK2gOYpB9YXYWlWLW/3cawXhca
         fAS6gWBmJujv/mEChv+vsaCONpyijeSbjLLkAykNNop8mwz/9HDKo4fbiklZtb7bBTjc
         IShiTtGpUenlO8tazBgBdu7IR7B7EkNtVTIdCxD8JBasbDAsCiuApqk47LFEbawrjA6a
         NBM//6juStVXcvNpiKZQhz4ToUey9Pcd8WJ9m2UZzSgSBWxT024VsZ3u9FFUCZzlXGfj
         fAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795043092; x=1795647892;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KZTFDK7wToVuIFH9xLlz+M7Y14/N8hcRBkBM/5LM+64=;
        b=GwH6zIxLVz8pgd+FlniZsJio6fShNou2jpOuMKm4YC33EPiTXv6dMtBGT7ERG/rCg3
         wyZb/lvTQee0ctrhPoz453ac3iNOlNCt3/wmhh0/Ml0vKVbsBOeIy2rd2lShnyYHku3F
         +FUHjhh1aSGaAcWrmJ4mKKC2ONOdqI2X4cGX5BLrYkjHKKaNAbi/gZ9bKN4gLTH7vkjd
         vwZRUrcVdrQu8MszlMZDtjKs+vuTvUZ7KVPr3dHB2W6AcyxMRl44XoCqjIM9mB5omF+5
         UqeaICYqOrOeG5CV3HDYgcghZL/S8mCLoWi8Y6Tw1TRiS48+5cXQecL3E7TNKQImvrvW
         Z6eg==
X-Gm-Message-State: APuU4Z+NW/X0rFZkOsqi57bIE+6ys0cCt0cwMTloqjasaZLoY2lL79Kx
	g47x70OnWSzhKQhF0zAk9ycrxjmn7Whf88rHOhQqM2jdWpBIZDFRs73E82OZinModaki9uvVEaR
	8soEb/jdxH+QFXfeWN7fILqH3HT1ZzZ0=
X-Gm-Gg: AZFdTZfj5L2nn7uuZ6/Fd1y5JwKg2hObX2Xmhvd5oz3YK1GQiPc8+D1/4pAcXJ6nCrg
	fCPfAcuGmmIlB0QWSq4vSL9Euk5p9zsQ42NfiLByL3NzV6OF1BnoTE9dFfD2lWl0/IywDAhony0
	O/ewkk4kpT/RfNGDaFPyt1A4OBcKp3U3HQ0yPvLEpzlT8JMrQN7EgTwMoI6jI+4aGJC7QSG/wsr
	c1xkMu2LzgahU8oGfIBnaabclbz3/igBfBn8pFwgQKKJ/AzITT6MpIVrLbfRZI/eu5Y381z9pfN
	oXZ0sQN7j/KLYoAp2yOaXzy8zVuVl2hKo0axEdAoEkmE8CJVT5BZQkBipx2VhDIysb2UMwWcSFO
	MxvGTBEq1BX1+cTUnrNeI6VRoU0nlADmSbRhM3XfVtcsIPFfshM31LgbFGDjx2avkDk2LCoKdy8
	/Q9TIzDwcoPCG0zT6k2fMnRvCVnYWTLnd/ZMVQfEd4cSQoobOGM1VNslOl
X-Received: by 2002:a05:690e:408d:b0:67d:b472:88a8 with SMTP id
 956f58d0204a3-67dd4025a14mr2161968d50.82.1795043091673; Wed, 18 Nov 2026
 15:04:51 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118213322.60067-1-mohammed.saad.alquraini@gmail.com>
In-Reply-To: <20261118213322.60067-1-mohammed.saad.alquraini@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Nov 2026 18:04:39 -0500
X-Gm-Features: AclHuK-21xvoF1R7FRBUL1DF35OsNzAIO8RSAqbqE4KfBM5RlmzDAc_5P9bd6dI
Message-ID: <CABBYNZJvzYd98m9rosF2m+nP50tTUf1MwHBPThpcUYHNoUxKzw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: check security before completing a
 deferred BR/EDR accept
To: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mohammed,

On Wed, Nov 18, 2026 at 4:34=E2=80=AFPM Mohammed Alquraini
<mohammed.saad.alquraini@gmail.com> wrote:
>
> A BR/EDR L2CAP service that listens with BT_DEFER_SETUP asks the kernel t=
o
> enforce its BT_SECURITY level and only decides which peer to admit. The
> deferred-accept completion path does not honour that.
>
> The child channel is placed on the parent's accept queue at CONN_REQ time=
 and
> is reported pollable (bt_accept_poll() returns EPOLLIN for a BT_CONNECT2 =
child
> on a BT_DEFER_SETUP listener) before the link security procedure resolves=
.
> When userspace recvmsg()s the deferred child in that window, l2cap_sock_d=
efer()
> moves the channel to BT_CONFIG and __l2cap_connect_rsp_defer() replies
> L2CAP_CR_SUCCESS with no security check. If the security procedure then f=
ails,
> l2cap_security_cfm() has no branch that matches a failed result on a BT_C=
ONFIG
> channel, so the channel is never torn down: a peer that failed the servic=
e's
> required security level keeps a connected, data-passing channel.
>
> The sibling setsockopt(BT_SECURITY) path already rechecks with
> l2cap_chan_check_security(), and the non-deferred incoming path denies wi=
th
> L2CAP_CR_SEC_BLOCK; only the BR/EDR basic/ERTM deferred-accept path was
> missed. This is the BR/EDR counterpart of commit 522e9ed157e3 ("Bluetooth=
:
> l2cap: Check encryption key size on incoming connection").

That is encryption key size, not security level, and why is it
mentioned here and doesn't have a Fixes tag if that was missed?

> Gate the deferred completion on the security state. In l2cap_sock_defer()=
,
> before completing a BR/EDR deferred accept, call l2cap_chan_check_securit=
y();
> if the level is not yet met, mark the socket BT_SK_ACCEPTED, leave the ch=
annel
> in BT_CONNECT2 and send nothing. l2cap_security_cfm() then resolves it: o=
n
> failure the existing BT_CONNECT2 branch denies with L2CAP_CR_SEC_BLOCK; o=
n
> success, a channel the daemon already accepted is completed through the s=
ame
> path a non-deferred accept takes (state -> BT_CONFIG, CONN_RSP SUCCESS +
> CONF_REQ) rather than re-signalling an accept already made, so exactly on=
e
> CONN_RSP is sent per channel and the on-air sequence stays strictly monot=
onic
> (AUTHEN_PEND, then AUTHOR_PEND for a not-yet-accepted channel, then SUCCE=
SS).
>
> Validated on an arm64 QEMU rig with a BR/EDR peer emulated over /dev/vhci=
:
> with the patch, an early accept followed by a genuine Authentication_Comp=
lete
> failure is answered with CONN_RSP result=3D3 (SEC_BLOCK) and no data is e=
ver
> delivered, identical to the non-deferred control; an early accept followe=
d by
> a successful (keyless) auth completes only after the security chain finis=
hes,
> with exactly one CONN_RSP SUCCESS and no trailing PEND; a deferred listen=
er
> that accepts only after the security resolves goes through the designed
> CR_PEND -> recvmsg -> SUCCESS path with the link at the required level.
>
> AI assistance was used in finding and preparing this patch.
>
> Fixes: f66dc81f44d9 ("Bluetooth: Add support for deferring L2CAP connecti=
on setup")
> Signed-off-by: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
> ---
>  include/net/bluetooth/bluetooth.h |  1 +
>  net/bluetooth/l2cap_core.c        | 10 +++++++++-
>  net/bluetooth/l2cap_sock.c        |  7 +++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -407,6 +407,7 @@
>         BT_SK_SUSPEND,
>         BT_SK_PKT_STATUS,
>         BT_SK_PKT_SEQNUM,
> +       BT_SK_ACCEPTED,
>  };
>
>  struct bt_sock_list {
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -8011,7 +8011,15 @@
>                         __u16 res, stat;
>
>                         if (!status && l2cap_check_enc_key_size(hcon, cha=
n)) {
> -                               if (test_bit(FLAG_DEFER_SETUP, &chan->fla=
gs)) {
> +                               bool deferred =3D test_bit(FLAG_DEFER_SET=
UP, &chan->flags);
> +                               struct sock *sk =3D chan->data;
> +
> +                               /* Complete inline if the daemon accepted=
 early. */
> +                               if (deferred && sk &&
> +                                   test_and_clear_bit(BT_SK_ACCEPTED, &b=
t_sk(sk)->flags))
> +                                       deferred =3D false;

I read this thru a couple of times and I still don't get how can you
get !status when security hasn't completed? Are you perhaps forcing
invalid behavior from the controller or something similar?

> +                               if (deferred) {
>                                         res =3D L2CAP_CR_PEND;
>                                         stat =3D L2CAP_CS_AUTHOR_PEND;
>                                         chan->ops->defer(chan);
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1274,6 +1274,13 @@
>                         release_sock(sk);
>                         __l2cap_le_connect_rsp_defer(chan);
>                 } else {
> +                       /* Defer completion until security resolves. */
> +                       if (!l2cap_chan_check_security(chan, false)) {
> +                               set_bit(BT_SK_ACCEPTED, &bt_sk(sk)->flags=
);
> +                               release_sock(sk);
> +                               l2cap_chan_unlock_conn(chan, have_conn);
> +                               return err;
> +                       }

Why wouldn't we do it earlier? This is too late, the userspace has
been awaken by the likes of l2cap_sock_defer_cb when the client socket
should really have been rejected not accepted.

>                         sk->sk_state =3D BT_CONFIG;
>                         chan->state =3D BT_CONFIG;
>                         release_sock(sk);
> --
> 2.43.0



--=20
Luiz Augusto von Dentz
