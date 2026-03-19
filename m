Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA881396B68
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773944329; cv=pass; b=dPTgr6yRUpzjziNzypOs3e3jwcWOpr4rk1PIBLPEbGWBtjekoIpIbVpvbU80V9Pei8ITAwQHjioqz5YlqYy5be2Pq5ESbVIyhC6pM6Dz4yfQx2baT1sxpE5SbdCkRbkWv6C+vWdxxE0CAx9ja+6pNu5QpvAMTbpk2VI4bu8TCKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773944329; c=relaxed/simple;
	bh=3KppUq2fJwuA6+nSfNRCIVI7GitLneDllExHlfU1F+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2uDKbr+5i+eSWT/rKmmexKOQvZ2QyWYIiGEskWNIqoVjga7jHNVWv+SPgpawM5k3IFCHuk/pAoRayYQBTEOr5uI3IkmNshl6sYqm/RplfTL3KDuZXB0HAqDAagcFfatf4SHCq07aAUDEzyydUDZ8YZZgCOZZCuMzaFCEDK7WD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCm+BAuO; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCm+BAuO"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ca1ba0089so1305171d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 11:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773944327; cv=none;
        d=google.com; s=arc-20240605;
        b=Vd8ucDBAK6HbgjjZ0m64LZHimhV/2k2+f1Zi9/LDL03dMQFuDAZQ08noUvdWS800V5
         ybdnfz4mxfeZySwiblhR8/CS/QBYg75Z77TtyVLR1iA0MY7CNQWY7ZFReHptjDBoRKLG
         GqzwL4O3skElSE2u8vMxQZtVXx9VkzvbidnGPtC8ztxjoxo3Z3GZ4dXfS5lMTGEKX6R+
         LMJHyzrMBa1OCgiQXOVnO+A1CLsroHDrRO3cYJt4PY2KBc9YGlCy1nF/8tQy87xkW3to
         YekFQX2eJ/4yvKOicDolhr8bKB72XAdnWPvQOwq/67oaHZG88CzFABjbjXqm+guiyd0T
         auUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JQuZB2YeCcToNqseZGQhslqK7iqJmKZ1TXwV3DwUxxE=;
        fh=XN5xBc34r4o6wzzvB8y9xhWOuef+hx8d52+8h9ZTpao=;
        b=YM/OVkZGRKK5iT5op3ZcqzLDQOBCKixoQL/BRsM6KoaKla3nZsshlp4ECx7P1l5VkS
         jB2ztOTqiEQaMQxgysedXCIdSIFM3FA5IZHYVQDPKJCojutn/6m5/w9iUMa+vuW/yfOk
         L2rzAmL02iNJKEehZ7oUibN1ranA8XFfM+H+rDo8KNwZ3PuvqcoOfuuKZcAaZfj1W5G7
         6Z06ixC0Mw/o7Jo2KyPTuQcPm8buP+vOUwyS+AJoxjwrsfbVG4gYKgJke2t0N/lZH809
         2m49bDcUdsaWROAb0kGQ1sY8qr4pgXHdiRPJwBh6ddIW+Cxreou9n4ql4cCODUAwJ/O7
         EoQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773944327; x=1774549127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQuZB2YeCcToNqseZGQhslqK7iqJmKZ1TXwV3DwUxxE=;
        b=UCm+BAuObGBKPSCbgGrooTm1t1OKxgs17lvCBMc5ZhnZE+GqNNrPrfFvEU19a40mj1
         uEp0d85F9gZ2g4Lk0fTBDyHvOBKzFZT7WnT8faZRxU0DQmbcrh8mOBo1f4CM47gz0CQq
         pna1WmK0etrLAv1EhT6hXrZSoGJ+mP2UXP9CO3lUn28ettieeYYNA1BCAXG8rz0m1+6o
         Vsu2ah+DefWeCW8dxO+4fU3JVFqH+FsEY4Wz9Enj2UCIoEjkp3FYlZooICQFthFEAHQp
         gYhcBTnqjsxcoJxOm67lgedAwAWYbThphy+Z6EZSMXBR70tA6b7e11nehmr1aJsB6ZZv
         +AJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773944327; x=1774549127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JQuZB2YeCcToNqseZGQhslqK7iqJmKZ1TXwV3DwUxxE=;
        b=k39tgPEA3dl0qIjOZH2fboT5VQVG6wnInYS+WuTOjmT0ASvnSAHwX2T7WOMHGh2+YJ
         TNZow9zK79rWYaByeSsXmuQfGGNOAKXHXFCJoKX0zQx4+cW69cSEp5anSgEhm8XKc+jt
         oGO4W7yB66Cw7zgs9iUY2vyoEdxY1FuFKzdOtRBIizX6lrWQj4lojghz/EfPO4vp/iKe
         1hra5YT/NOBBSL2fQLudPRs1/YHOsE+2vcfmnSQ8ye4B0NtuhGYJzboTR9fuuYl+XeX7
         oZ7DuhzNv98rinfyD0rijvGAwsnYulMEEWkCWPVEfNYoVqWbyZy16GB3zy9ND+6FJ/6/
         IaKw==
X-Forwarded-Encrypted: i=1; AJvYcCWQMhMd7xjrdn3pqSNuw7vUNjqhaobOcPSeOJhqFw1oJE6sdhzWk7F26iT1Jj1JHVPwLw8NSstXo65J8G4PPzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+6F0mtF83S88Iw5uUD9AE6hp5WxcMFoAd2TanvkclPbzKOvjY
	BzjuiBmA4fYIA6JBMw6wZ83S/jgewQxZz3J3/dYOo/iybGLxDadfagTH0TErKdtckx3Nsrn6i9n
	tQL0G74lYpTaS/NCvWKrNs8n2u/zHpiuqZvehR3UE2A==
X-Gm-Gg: ATEYQzwIbnjfjHo0iBHDztsFDQH9wv4Ao4xIEL4YGXA0Vcscco1WzuZOQbJG7xNB3XH
	rmq1N+cIcOAfz7B+c5pjrzwHlCybJzWwa1hxKmewQAiIRquspMBqktk6bhxAIhhr0Jdnwo4UY/t
	S1SkLg/ykYkuaGLKhOoWUDDJU/zFCmuoeVvNqGZ8gzAZTAd8bZIYVCIsnvYSqKHlIdRNCesBgfK
	RQG1tQVhWC7zWSWeLLos5X8nEUggSLC9PvvUddYEeN3M3mE6O/xxR52vMStoY/c1QNrKeEyrfIi
	ZpoDu8gO3II9aTBZef7HxuO+FZi25ZGI5UBYMobOtEuvNeO+lpFO4H+98d/HVkDUZX930w==
X-Received: by 2002:a53:ce8f:0:b0:64a:e799:1d92 with SMTP id
 956f58d0204a3-64eaa802241mr414202d50.61.1773944326879; Thu, 19 Mar 2026
 11:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abwTCkavRurEcEGO@v4bel> <CABBYNZLfCm26CAnOpYV-M8GcF-jsjs-QCCQ2mxayRnQPEF9ZVg@mail.gmail.com>
In-Reply-To: <CABBYNZLfCm26CAnOpYV-M8GcF-jsjs-QCCQ2mxayRnQPEF9ZVg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Mar 2026 14:18:35 -0400
X-Gm-Features: AaiRm50cVpss1vF7B1-plDtfEtPvDuw8idpZ5tqZ0tXU-bQtyI_qeZTld8r6qG0
Message-ID: <CABBYNZ+hhi198+ZC7L_igp0iZPjQC+3VQ2_kC1Bhuxg7L2_5QQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len
 infinite loop
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hyunwoo,

On Thu, Mar 19, 2026 at 1:32=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hyunwoo,
>
> On Thu, Mar 19, 2026 at 11:15=E2=80=AFAM Hyunwoo Kim <imv4bel@gmail.com> =
wrote:
> >
> > l2cap_config_req() accepts CONFIG_REQ when the channel is already in
> > BT_CONNECTED state. This causes l2cap_ertm_init() to be called a
> > second time, re-initializing tx_q, srej_q, srej_list, and
> > retrans_list without freeing the previous allocations, and setting
> > chan->sdu to NULL without freeing the existing skb. This leaks all
> > previously allocated ERTM resources.
> >
> > Additionally, l2cap_parse_conf_req() does not validate the minimum
> > value of remote_mps derived from the RFC max_pdu_size option. A zero
> > value propagates to l2cap_segment_sdu() where pdu_len becomes zero,
> > causing the while loop to never terminate since len is never
> > decremented, exhausting all available memory.
> >
> > Fix by removing BT_CONNECTED from the allowed states in
> > l2cap_config_req() and adding a pdu_len zero check in
> > l2cap_segment_sdu() as a safeguard.
>
> This part is not clerarm it should be allowed to change the MTU while con=
nected.

Looks like AI agree with me (Second point, first point is probably not
possible):

https://sashiko.dev/#/patchset/abwTCkavRurEcEGO%40v4bel

>
> > Fixes: 96298f640104 ("Bluetooth: L2CAP: handle l2cap config request dur=
ing open state")
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/bluetooth/l2cap_core.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index ad98db9632fd..a6ce09781083 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -2381,6 +2381,9 @@ static int l2cap_segment_sdu(struct l2cap_chan *c=
han,
> >         /* Remote device may have requested smaller PDUs */
> >         pdu_len =3D min_t(size_t, pdu_len, chan->remote_mps);
> >
> > +       if (!pdu_len)
> > +               return -EINVAL;
> > +
> >         if (len <=3D pdu_len) {
> >                 sar =3D L2CAP_SAR_UNSEGMENTED;
> >                 sdu_len =3D 0;
> > @@ -4267,8 +4270,7 @@ static inline int l2cap_config_req(struct l2cap_c=
onn *conn,
> >                 return 0;
> >         }
> >
> > -       if (chan->state !=3D BT_CONFIG && chan->state !=3D BT_CONNECT2 =
&&
> > -           chan->state !=3D BT_CONNECTED) {
> > +       if (chan->state !=3D BT_CONFIG && chan->state !=3D BT_CONNECT2)=
 {
> >                 cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
> >                                        chan->dcid);
> >                 goto unlock;
> > --
> > 2.43.0
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
