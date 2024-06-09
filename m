Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6F717554
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Jun 2024 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717954886; cv=none; b=fokUpQt/UmAKrlWDQQIfOy014/42sxM6tEt8hxSVVcZYApVkk9vM82JaXUanxRxN2g+EKoraDD0k3MRU2yZXECEGZWtnO/RgM7h2hi/+P7jEKTyhv/ZrFyqVd7rnAD4JsdC35H2ZZJ6DmAZ3yb425Hgc3lpWz8u9JQ9rdX9twA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717954886; c=relaxed/simple;
	bh=Ah+rH2/5DH2zHCMDhz53mX1X9YDCO+w2M2y6XlZ7lg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiKBJcAwnHZ/56E5mp7l/XNupJwU8u4/aQEUH3tC0irP6P4qcZ8xXyWoV/4sryWQwmWzzzYwnxId0eYXstLr2tBpHeORDRVAUOmjfOBqGHV4bRI+mrp50tcsyfYuBx4rnqhw/2YJH6shE0iXTI9Gd2sxGuEyJNN5ty8snYvMiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfCiG40v; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfCiG40v"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e73359b979so44001511fa.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Jun 2024 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717954883; x=1718559683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zH2H04IM+hb/03hlWsewPXo09HIvj/f5k6s7zejtt7E=;
        b=LfCiG40vRRrf5oiKP6n1RQGrdeYNYXXk5AKvpBwmCgm7Rx4f431HyACZOygZXZzHuk
         aE12YDDozGrShqAjZwd5fzQAnVRxCGMXM6QBDwQS77iq3t2xtAyb6U7SzRvSbAHJNGs6
         IesBZXPS2i3fWQpG3kjay0RdSBnIOzFwkgLpj9HnKNHFP3RV5tLYV3JfFErPED3t/e40
         Og72ehdmieWPx+6z9Nd2wD0zwsazrIU2p3oyDZ5CF+NLiwd1zf5iEiKD9JzJHZOjgRzo
         pAw+fxReN1MUreSb4nwlAJ2YwJKQxo7C/K9N7DSFemQn/o/4aCXvSugerKxGNJCP14bA
         jtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717954883; x=1718559683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zH2H04IM+hb/03hlWsewPXo09HIvj/f5k6s7zejtt7E=;
        b=WpIOId40atErbqXyk1Y1cSUleNZYl7lJM+v9pcRTgvZihhyDRi2/7XfxPcOhw3Ca51
         BSwds5cgNi0MpA9l1uNqdqP85bQe6w2La9HXHiKrS2IxS5Vo7WwLG57v47sMzNYhR8xO
         1k8SX7z/lh0Rb5peKDbE15CUPNAp2HgXC/TH5tac4cYpgMkafLWm+k3TFzw5mFNLpn6r
         OqX3c6XMw7+rg1T74TxPyXbJfZXj4TPAdgYf7xQXCR8TMMrALtbNQB7JvZ34CtTZ7NJF
         VWqonulaSIIbT5APHY6kZ5YSlQx+qPSIZRqFQlbDxPABswEMaI3TIxM73ULfDugFnqL3
         5jqw==
X-Gm-Message-State: AOJu0YzUM7YB0jVTkxL35uMILDibyN0RCbKDOxfisrimZ4AvVxCOA/MP
	GBrMFEybemY6jjWP0C5YFZlkqzZPExhTAmkiLjB0pTW8vDbyckTrqYmqQNbz8SrPUiB3MkoQA4G
	vZfACEqS1ACXbglRkQdh+Ele8LMk=
X-Google-Smtp-Source: AGHT+IHbJAGmnXvHST21OiAbzSbgBc5wYHz3/Go8ZRhbGlhBsuluNEQ2H+cOmUTDKtS7e+8I0W1ZwcInFRtYaS10Sbw=
X-Received: by 2002:a05:651c:211b:b0:2eb:d94b:1d3a with SMTP id
 38308e7fff4ca-2ebd94b20c3mr30792571fa.40.1717954883066; Sun, 09 Jun 2024
 10:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGew7BttU+g40uRnSCN5XmbXs1KX1ZBbz+xyXC_nw5p4dR2dGA@mail.gmail.com>
 <ad69720e0ba720209cb04240fbc3c5ff059accbc.1717945321.git.pav@iki.fi>
In-Reply-To: <ad69720e0ba720209cb04240fbc3c5ff059accbc.1717945321.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 9 Jun 2024 13:41:10 -0400
Message-ID: <CABBYNZ+HNjgBSnbEe0m-BSqMdJBQGsOz0NjjqkjhNPcGVtYaSw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: fix connection setup in l2cap_connect
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com, 
	der.timosch@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Jun 9, 2024 at 11:06=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> The amp_id argument of l2cap_connect() was removed in
> commit 84a4bb6548a2 ("Bluetooth: HCI: Remove HCI_AMP support")
>
> It was always called with amp_id =3D=3D 0, i.e. AMP_ID_BREDR =3D=3D 0x00 =
(ie.
> non-AMP controller).  In the above commit, the code path for amp_id !=3D =
0
> was preserved, although it should have used the amp_id =3D=3D 0 one.
>
> Restore the previous behavior of the non-AMP code path, to fix problems
> with L2CAP connections.

While at it we could create a test case to cover this code path with
l2cap-tester.

> Fixes: 84a4bb6548a2 ("Bluetooth: HCI: Remove HCI_AMP support")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>
> Notes:
>     v2: do the change in the actually right if branch
>
>     Tried proofreading the commit, and this part seemed suspicious.
>     Can you try if this fixes the problem?
>
>  net/bluetooth/l2cap_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index c49e0d4b3c0d..aed025734d04 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4011,8 +4011,8 @@ static void l2cap_connect(struct l2cap_conn *conn, =
struct l2cap_cmd_hdr *cmd,
>                                 status =3D L2CAP_CS_AUTHOR_PEND;
>                                 chan->ops->defer(chan);
>                         } else {
> -                               l2cap_state_change(chan, BT_CONNECT2);
> -                               result =3D L2CAP_CR_PEND;
> +                               l2cap_state_change(chan, BT_CONFIG);
> +                               result =3D L2CAP_CR_SUCCESS;
>                                 status =3D L2CAP_CS_NO_INFO;
>                         }
>                 } else {
> --
> 2.45.2
>
>


--=20
Luiz Augusto von Dentz
