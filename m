Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1361FE46D
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526009; cv=none; b=aKXhTGXApcTxyFaIkgQu1Jah1xTcbRWgppdqteoa8WCqTyzGfwbUmNw+op5p37b57vQG62Hku0tE1iIpRkbHccQZeDGmZF+iF4ag5jfnBjeGyziB/2P+zvahvT8vMLzTotugfzyx/P4Dt+VZJjDq4dmUQRZiVhXmJA0U9aQYRCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526009; c=relaxed/simple;
	bh=0uBFjQK55vtJmavjqaPicM6t21S5KJsRzcRFSUfOPqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFj43It4jhyn02NH/2DyRSSeGprCPJBu06cxLWrcoctOCQzS6bRlghuG8DYUwr+xfgYMXdGKFDvY9noyw98smvMeWuiW3DtVRdTvZYbb6VLd368Do0gdTT11yxY+KlSN75zh9A2HXF7VV5QEhsPfN9QFb27qtbC+lwB3uu71MFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkjDIbsi; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkjDIbsi"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so28496281fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745526006; x=1746130806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuOVEW/w23OTlYq5VD/9jLEhFG5pDF0yoyq7+5+r1rs=;
        b=nkjDIbsi33EtzQSFaphzlldUNv/CIIqeIjjLPcHZt+cVAHJuO5foPStzDaSo30ivcw
         dF/inxUh/ypMCNmlQDv2eikIDMw5MPhC3U8uNp95pWRuF6tVGF2cwONVAgLLbX6ur33H
         9NSzD85DKCxiCc5H0Ifd4Shc5UDX6FKtxVQdhRQ0W8/MghyNIL3qXUvDEQif83Z8K8OJ
         3g1UKbvaY/mU3M2jaPbva86N0wadgPuHr7Ak+/9pBjVZeWcRuxmZP6VY/2R6gXF/KW9G
         TrehyIV4OaDtrPK+V6ApJfQusWnm4mmRYDITVdEK9asUYnXBpEdSPllrmIihTNl8xSSQ
         vE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745526006; x=1746130806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuOVEW/w23OTlYq5VD/9jLEhFG5pDF0yoyq7+5+r1rs=;
        b=JSWswfZPmFGXF/u2uzh7sn+OPV7G7ZMVT8mnSvLvRjje/YyLc6h0bHLjsvTNd44yxV
         UPB/U/sgDUDN41S6ooz9GIRtgxS1jh+j45/CRYva4FiRI21fyMcI5AYlNrAq8gc9vXSd
         I4W8ZEPVWIq9FVU/2HNFIcVfP//A1AHF0PH9aESXE1iW2gU+0dtX3l1c0R7k07K8Ha2f
         KzdHlIMh6Pv0rx1JG6qjdZNs1kMAPCoccvfFwlhhMv8lN2Y+HtRDQ2CTBPwzt8c9v7Te
         DFyKA1zAn0zieJPPikGJLr5TsWkvkCuWFB76R5T8HsoYP3A58LTuGja5ILiBPGdM+EHv
         Am5Q==
X-Gm-Message-State: AOJu0Ywu+PWyMnusgv+VWmIj4m73BOXfgQ4ouCgmI7U7ozcbuPAGzzyB
	Q8g8Nx6vpGYvh997R1uWaHvAIdEuNPSxxTAgCfQZcuY+mPgpFZuIgyuUQIjfvRrlmJ6PshQ9Hdm
	RXQLqLEhaFo5MLQsNF4azJB4z8hBVikbY
X-Gm-Gg: ASbGncvWkyGSSI2nss6QgI5EQ1FagHvid7y/ZY46nytccinU5Mue/dkPdD/0CguEmpk
	x253n45m/lgQeBVGM4qgH+ZUNqkBGaIbeUcesupOSom/iZY/6S/03p5G3pAXZ1YsGtmboGcbj62
	akRYLIRR852RFkvxlvpYLl
X-Google-Smtp-Source: AGHT+IGlOe//WYFM+JV3Op06hzYw+TuBSaTl2fXdDailwPu2EeCrLa2Ov163i3mDg/SJ7NVByCCwyeksQUqHUJ+3xqk=
X-Received: by 2002:a05:651c:1446:b0:30d:b2a6:8e1b with SMTP id
 38308e7fff4ca-317cde05f21mr11419311fa.13.1745526005527; Thu, 24 Apr 2025
 13:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01117138d56019a8598f24f0df2dd289713cfab4.1745524193.git.pav@iki.fi>
In-Reply-To: <01117138d56019a8598f24f0df2dd289713cfab4.1745524193.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 24 Apr 2025 16:19:52 -0400
X-Gm-Features: ATxdqUFXrK5XbyAkY8nwQoG-ez3GEAtDQDQqvoVomXx7tm-Bysl-G2PWCZHUeA0
Message-ID: <CABBYNZKRDZRUW-H9gXaS3kjxgcK8UXieQ0_S2Gtdjvbctgks-g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: copy RX timestamp to new fragments
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Apr 24, 2025 at 3:59=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Copy timestamp too when allocating new skb for received fragment.
> Fixes missing RX timestamps with fragmentation.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>

Hmm I though it only matters for TX timestamp but this is actually
different,  anyway I don't think it would be possible to backport to
that old patch, so we might need to use a more recent one when we
introduced l2cap_recv_frag to make sure it properly backported:

Fixes: 4d7ea8ee90e4 ("Bluetooth: L2CAP: Fix handling fragmented length")

I can fix it up in place though, so don't bother spinning a new one,
btw shall we replace the __net_timestamp with skb_set_delivery_time?

> ---
>  net/bluetooth/l2cap_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 5ca7ac43c58d..73472756618a 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7415,6 +7415,9 @@ static int l2cap_recv_frag(struct l2cap_conn *conn,=
 struct sk_buff *skb,
>                         return -ENOMEM;
>                 /* Init rx_len */
>                 conn->rx_len =3D len;
> +
> +               skb_set_delivery_time(conn->rx_skb, skb->tstamp,
> +                                     skb->tstamp_type);
>         }
>
>         /* Copy as much as the rx_skb can hold */
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
