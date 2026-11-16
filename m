Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794848677;
	b=zbvzDMlLlB+26DfI/Gx2643tx7FzMs2/wM+9WilARdKvWcEP2XGx7jz+YgjLkOK8Txv4
	 MlZ3dmQODf7shFoxWQ3x4r3qrDf0M+DYpHZOvoQgaIspRX3aPxzH80zyFDjH8Eo1jmtxX
	 ejiO63Br43U4cvjqz3acBnv9VOqzHl3tezP0REH8qS+X/K/thSuQqREDN1tEJJS/SmgMw
	 a+uyBm4O2zYSxPsXoY5vxnBd6i71RLks3iDuvUYRnM7s9z8H+iwkUfybtw6sf4RLLVZ02
	 TLx+7+EYKcMRFGGPn5ZTxzF23SPlLDnkHQAjJD4oHjfu3adhW6P1bqsPMAH6QKL0pXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OuuyAZ4IWLgVQrPB86XUEajs/Fsetiw6Rysz8jcKkt0=;
	b=qTegPXqKL/zD/iB4lIX2l++oQ3VZAUu9Q6RcvIg+S7ZXHVWCFXuOOJNKp2tFfEEgCxNK
	 qlBVn4+a4JjxpeeMwm96FeP+Vu63YQMPZWihOwVZogc7PoffC0DxeweXds02kEYJ6/ay3
	 37is9XAcz3Y4XImr8/aEU6iVUrcc+KTJY5LIEfjDl58vkB/Gn6/12oh4ryRIFaCTQXtqL
	 Y1T56JPvRoQFUtLUH+yAJ0Qkg9dlnsNeFt2xrcTY4Fpu3PJSetCTnE3tuBOnFcylbFZmV
	 muapaT/eYksGy9w5/ENjffkyvPD3gXPImyUmpRqN598q1ifkbwSUkkB3DgfoFVNUneg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WZYY2r8K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797AE606A338
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 797AE606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WZYY2r8K
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b4bc5b8de5so292687b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:04:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794848676; cv=none;
        d=google.com; s=arc-20260327;
        b=fdaJ8qfi4d9yIfrNYGz+flCQPRiVfmdBV6qFZGxVKyHkvFaVXJekSeMetGx8fQ5sZt
         GUuEp4Rgfk7eALCMhph0iX4JSb26zhx9GZIGPm+M1XkHJGkCxOgPY8i4JUjztmmh9ebj
         yazWWHQbzTKH8FQfvvwvk0J4SXHGfd2rwjATu0Cpik1LW14jYsFOlM2LfQK2w3SlyeUf
         h8g7UX9bCY69QiDh9tXTDrqhQ6ClTeutfO56jn4A4QxCPraaEbnu5EEF2HzincmUbryo
         4+dwgyFz5eMExeKGP2a7nLdRdSxJpMhnhQbA4w6bmkTT7FyvCCw4lTRV9gS04OWEqKSl
         59LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OuuyAZ4IWLgVQrPB86XUEajs/Fsetiw6Rysz8jcKkt0=;
        fh=cafIMaLk87UFIskGY+saxcyFW18xU3iMYjbTLAq/AU0=;
        b=G9uFc7q/9BOVBLXuGmP1oFoXOmsut5BKZb20RUOcBWtlZZ7xiDLWxOETnLuwLggYmR
         cd224WuBczmEsPXG+hnkDoTHLGE7ZmGHRP//ZCO0x1YlqKmtfdZ/N/LdnfS/1y/KZmYW
         F4o1ZaeDU/P+qpdudSnCEtO377Y6hwzm0ipIee6UxmBesBMylMaPAbqk1FodNGfbRFtV
         CC92Y0OI3qg8sXhQNbQeglonqHeQMCF99Zi8fL2wX5aQRqn+vt6eNJORRdVPWnaM7obf
         DS34JrENu8VvUEY9nlili5qccZl8N1cVgMt6Y1Qiy0iU1OgHV007bEN+DepUGzvfSNLm
         n+WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794848676; x=1795453476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OuuyAZ4IWLgVQrPB86XUEajs/Fsetiw6Rysz8jcKkt0=;
        b=WZYY2r8KgTyJC8YKopk67NlqvwpC1c5dZ4/uebpyAgqgLz7Uc/bMqiwjjrEI3xwkoV
         +VhQx82XFmQwmTJncIGsGKv4tFZM4AfYO7d0mx/KDjSYKbsSMEexaRRcyS5s26s059Ve
         TUKHv/A6NpzCtrL7atOzRURA1LFIwh+2swxki0IZzipXDtTzWrQjDbuWmS0LcnOPKnIM
         mD5Oo2li6ok9yYVXWD7LZugQesJkeQBHppksRD3FRdDmebsc4pu8/VvgC4E3sRjmXcA0
         7EHqvZbdaQd0Y6JJ/8XcPAEmz3lBpdyDSuT0uRdlKgHOPX7rBgQsA0a7RUSmh9qCJ26t
         CW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794848676; x=1795453476;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OuuyAZ4IWLgVQrPB86XUEajs/Fsetiw6Rysz8jcKkt0=;
        b=orJD8cfXtBYIUUMh8ZjM1c4lltSOm6mP5KPfBDz1Rd2tUEfwaVrVFdB5RQNrD9LoVl
         Y1DGblbJkDRzWkBP+v8jiosHapJHAWtTY4E4kD2JC20AxfYeg67kgfU3QjWBKBRenO78
         LmKFBW9wf67cYK46cqh1CjL5HCQFX/t5GZHcfMjSxmQCvUDX0ByJSWkiKsUgKVSZnHhN
         9JdRvDNA/zy6rQTgs5Ue3Lpm+HwLxrT5wKgMrnsbpeLaGtQ2W5o2jQL4zGUGBf5Hc3DC
         jw0qrenPrfAMUK+v/cqFqon9u5ZH0+s8qLQQUDwzuqACf7PDBdw2IDrOM7X3BqF0dgMc
         2dow==
X-Forwarded-Encrypted: i=1; AL+hErFD4Ora9CmareBDlegi70JDPprEXYBxBRxR/NXJSVCXotO3YBE8KwDCYcnkNyiz8O/BGqGrXIdjpPmIHLLyDmM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yoE2DTJlekwrRK8bKhDKHL4DEabk7rqLEiKKx4oYbkwuN4syU
	FRAKt3mjvsGxPqzVHdKtGFGHolZ9n0msEfFMy4uON1ta4tQNBikJfWZ1BNrePUfr+gqsFRRA+jJ
	gRQA0lUVEeHhv5expFbz23XrjhnA5roY=
X-Gm-Gg: AZFdTZeCfujUnFYR4C45sJJhRPYxOY3q0wbvbWagHMS8QyEtUmh/BXFGeFAUVe5kjPV
	qbeD79DpMVN9Ag4ok7PCPN8ho2hhZynQ3cqkvDgAn8ZGcrdmOJW07Y3x8twK/X7w0wgiCfpfE5o
	GOG5bqPrpDCz491PPvdkL0CE223+THEwG5B1fA3fQKi8KdWBs9FsXYvShdtER3G5Dlazg8Awlab
	YmwEysiLTUHgzRO2hFIRF4HouokUnjZrKvcWOoHLVgojKlXTtwIqilgW5aTD4cW2YwAgv8RyqAz
	s8sgmD4aEbf6f5yjAdcys+SWhAQH73So2QyWjHVeIkkcC+91l9JwJ/2+0k95B51fwDCLfR8O5xW
	svPAwkeH8jEU8f51GetbGMpFOC3YI4qtSiJYJHY03XJ9L6ANble2o7jRbcNMvliBsyxe5FR6paD
	qNw74AT87ql4KvLmDlbtz46dOY33OEYR43MFXsmxqytP3L6g6hSicgtMBa
X-Received: by 2002:a05:690e:4145:b0:679:97d1:439e with SMTP id
 956f58d0204a3-67dc76a3aebmr61822d50.2.1794848675703; Mon, 16 Nov 2026
 09:04:35 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115115341.316484-1-ngocthang2710.1999@gmail.com>
In-Reply-To: <20261115115341.316484-1-ngocthang2710.1999@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Nov 2026 12:04:22 -0500
X-Gm-Features: AclHuK-7mHIMY0CY3JZllTpHy6nwtTontz9GqLEJ12QCe-O4w2_0-LpJPkaVhfo
Message-ID: <CABBYNZLEONoqo+mdnNyv19pd3HxyfHAyHTPUpi-et0RFMctN6Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: don't reserve an ident for L2CAP_LE_CREDITS
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stig Hornang <stig@hornang.me>, 
	syzbot+9dc8780713b11155dd74@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nguyen,

On Sun, Nov 15, 2026 at 6:53=E2=80=AFAM Nguyen Ngoc Thang
<ngocthang2710.1999@gmail.com> wrote:
>
> l2cap_chan_le_send_credits() allocates an ident from conn->tx_ida, sends
> L2CAP_LE_CREDITS and then frees the ident unconditionally, since the
> command has no response.
>
> But the ident is visible in tx_ida while the command is in flight, and
> the remote may answer it with L2CAP_COMMAND_REJ anyway. The RX path then
> releases it in l2cap_put_ident() under conn->lock, while the credits path
> runs from recvmsg() with only the socket lock held. Whichever ida_free()
> comes second hits:
>
>   ida_free called for id=3D3 which is not allocated.
>   WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594
>   Call trace:
>    ida_free+0x24c/0x2d4 lib/idr.c:594
>    l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
>    l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
>    l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c
>    l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
>
> Worse, if the ident is reallocated for a real request in between, the
> credits path frees that request's ident instead.
>
> tx_ida only exists to track requests awaiting a response, so a command
> without one has no business in it. Give L2CAP_LE_CREDITS a plain cyclic
> ident instead, which never needs releasing. The ident is still never 0
> and never exhausts the range, which is what commit 6e1930ece855
> ("Bluetooth: L2CAP: fix tx ident leak for commands without a response")
> set out to fix.
>
> Fixes: 6e1930ece855 ("Bluetooth: L2CAP: fix tx ident leak for commands wi=
thout a response")
> Reported-by: syzbot+9dc8780713b11155dd74@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D9dc8780713b11155dd74
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
> Tested in QEMU (x86_64, KASAN + lockdep) with the syzbot C reproducer,
> 15 runs per kernel:
>   base (origin/master 23c62304dde2): 31x "ida_free called for id=3DN ..."
>   patched:                           0 warnings, 1200 LE credits sent,
>                                      none with ident 0 (ident wraps fine)
>
>  net/bluetooth/l2cap_core.c | 44 +++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 7dcb0586a10b..0b861ced5703 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1028,21 +1028,36 @@ int l2cap_chan_check_security(struct l2cap_chan *=
chan, bool initiator)
>                                  initiator);
>  }
>
> -static int l2cap_get_ident(struct l2cap_conn *conn)
> +static u8 l2cap_ident_max(struct l2cap_conn *conn)
>  {
> -       u8 max;
> -       int ident;
> -
>         /* LE link does not support tools like l2ping so use the full ran=
ge */
>         if (conn->hcon->type =3D=3D LE_LINK)
> -               max =3D 255;
> +               return 255;
> +
>         /* Get next available identificator.
>          *    1 - 128 are used by kernel.
>          *  129 - 199 are reserved.
>          *  200 - 254 are used by utilities like l2ping, etc.
>          */
> -       else
> -               max =3D 128;
> +       return 128;
> +}
> +
> +/* Ident for a command that has no response: it is not reserved in tx_id=
a,
> + * so nothing has to release it and it can't be released twice.
> + */
> +static u8 l2cap_next_ident(struct l2cap_conn *conn)
> +{
> +       u8 ident =3D READ_ONCE(conn->tx_ident) % l2cap_ident_max(conn) + =
1;
> +
> +       WRITE_ONCE(conn->tx_ident, ident);
> +
> +       return ident;
> +}
> +
> +static int l2cap_get_ident(struct l2cap_conn *conn)
> +{
> +       u8 max =3D l2cap_ident_max(conn);
> +       int ident;
>
>         /* Allocate ident using min as last used + 1 (cyclic) */
>         ident =3D ida_alloc_range(&conn->tx_ida, READ_ONCE(conn->tx_ident=
) + 1,
> @@ -7081,7 +7096,6 @@ static void l2cap_chan_le_send_credits(struct l2cap=
_chan *chan)
>         struct l2cap_conn *conn =3D chan->conn;
>         struct l2cap_le_credits pkt;
>         u16 return_credits =3D l2cap_le_rx_credits(chan);
> -       int ident;
>
>         if (chan->mode !=3D L2CAP_MODE_LE_FLOWCTL &&
>             chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL)
> @@ -7099,18 +7113,8 @@ static void l2cap_chan_le_send_credits(struct l2ca=
p_chan *chan)
>         pkt.cid     =3D cpu_to_le16(chan->scid);
>         pkt.credits =3D cpu_to_le16(return_credits);
>
> -       ident =3D l2cap_get_ident(conn);
> -
> -       l2cap_send_cmd(conn, ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);
> -
> -       /* L2CAP_LE_CREDITS has no response so the ident is never release=
d by
> -        * l2cap_put_ident() - release it right away, otherwise the tx_id=
a
> -        * range is exhausted after 254 packets and from then on credits =
are
> -        * sent with the invalid ident 0, which some remote stacks ignore=
,
> -        * stalling the channel.
> -        */
> -       if (ident > 0)
> -               ida_free(&conn->tx_ida, ident);
> +       l2cap_send_cmd(conn, l2cap_next_ident(conn), L2CAP_LE_CREDITS,
> +                      sizeof(pkt), &pkt);
>  }
>
>  void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail)
> --
> 2.43.0

Sashiko flagged a problem:
https://sashiko.dev/#/patchset/20261115115341.316484-1-ngocthang2710.1999%4=
0gmail.com


--=20
Luiz Augusto von Dentz
