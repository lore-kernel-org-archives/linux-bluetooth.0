Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B205333442
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941550; cv=pass; b=A1DY8YncrZ2iqpXXdk71RKLBfTKin1xd6HQbr0qQ03lEHKZu/Wk3GuuqprbtkjvfFX3c2WvIGvyUqpcrmSaGSuaXiGFUBofiLwBk+5Lx+Ogfazd1BPIPsjvHHTlkqR2yrkFfwIU8anzmSlBQ+Ik/V0Agl++bPke+fthj7/fnIUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941550; c=relaxed/simple;
	bh=gk8rZrWzIb3H8jPgE5eB4d5s3Vi5/4H8UCbqsdrtjl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8rWArWYtC8mlP+sxp4AMjfTgeSvMByOc1Qt+zDchn9i2Zf9cbeY7Zh6nH0g104LjARTHC46g3u1PZ9KFEEnNdSmZcTckfXlhu1urIeIFG8OdGizDD8iLJr8Bn2tYC3D3LnkD+gMUxCOxaH70HAnT7RqySwAQU7+yYTL5JlqlRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i//BiHAX; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i//BiHAX"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso1620931d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 10:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773941534; cv=none;
        d=google.com; s=arc-20240605;
        b=YClzkGQxPcW3XlSK/M2h3e9swxPScMU2xqtvpf2Ps3LbS+/A02UV9VSdCIfeRkbgqo
         ocTzyKcbGiaiqtlOXFYd0zg2ceqQmgBvA71xqTYuRAKA2m6C7CB/6FfBhamBjXiox9LC
         3qsNmAb3lQBM9V9jfjwgElcVivB8hzWLMz0BUu2r7yccZeEIjs/Pvq0Tim9Uz/u6oAh6
         PKIgiFLFmKsKbhW3VsYBHHiObUprLD8s85KjqTALVBxL++nE03iaJynJwhVZfZ0pVqFZ
         GT5HO9lRILP4hpP8UBcuVXvWjWpUJd9VidPvvPhJjxPrwaTQvVvhbvoXd0y0Tdw+TZQX
         KgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xE+XKZ53A/goIWAVvyO+orVhmG69eJP3z+kq6vOPRQs=;
        fh=5O4meBdZ0tEQixFDhhuVERl0miWeB6wEqR4T7DbhC7c=;
        b=dyk8gFJi7K8Byrl4dESdIbK9eAPxyTmWrVt8YalGnxrDrsLD+0kN9g/cGotdkpKJqM
         Jmln/DZVv9mMGSnnllL8HDT/VpnjZHPQj+UH6x/AVYdXhDwGoqYk0GYMhQh6wzlkTeA5
         /TqOTYVJ+KG6W2ukeQNz5pKfq8klTBWuZRzkn4TcFVUDq4yTPPgRTkQU9LTljcrTeSAb
         GWeXRpVZTK0PoyqTT2VPHBh19ZVvSNmjmQUbNchejSeFR3UvQBke6G7yOIQgYu1DfVhe
         Sdz7q5s/WKtJPmDyN0GAV+Mss7RW6ViHjp79dUyZsNF+vI+iNzzTyN5SUJQyrbQrpKSP
         kI5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773941534; x=1774546334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xE+XKZ53A/goIWAVvyO+orVhmG69eJP3z+kq6vOPRQs=;
        b=i//BiHAX9p0nuq5fnjMxUq1rAqZ7xfHwfkmKqPyYoCS+NE1O8h3ltSvoH2dQ18WAXD
         rSQgAJ61NzuWfNPgue6GWQPnhWSoAvWe1N1VFAWiMwwHt8GK9rjsXJbwfsEsnZuf0G3f
         mSXxoGt9Isv8rteCW+aaTSFTMC7N1dqvDfK2Zb3xhuUPujskLdgRBB8fimIX5L13L5Ow
         qDdQorSgwM5l8+/GlAg4x+5/Er2+F/DcM/+U8gDWjHn7rXMLpV/EjDdSr1I+Z/mYk/6m
         CeuTsyhf3BG/Vk8FtABn+KtYA0mgjpg2VFcgPLmmApqFBk1wgj8tBDXc33Os7cMqt5NH
         dU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773941534; x=1774546334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xE+XKZ53A/goIWAVvyO+orVhmG69eJP3z+kq6vOPRQs=;
        b=cUwDSvYtu/vMa1muNHyoq80sbXIg4V05pYssZ6rfg8/IouLH0MKqCG+e4Xj+J3LRR4
         NidOwO3XeomE0vdwtMGRSQemLA1NTYZT4PBJVXNK7YL8WhuNJYcG/6I0n6aR8eSHT/S5
         GuAhojEksDPRviIGMyPTdzmvncbCjt6Qx0UiUX6jWNzyjqUjiRleNYjADj9iAg7M3BEi
         Zf6Lx7yWT9/I+nwJHf5+lGOgxdlbKl8zCSjzX50a8Ey/xkVOuklGUlAxB7l4BqfYdXee
         iFC+lOD7MB6nMVka/vOeGkcSWZDjwoVvvDIfqoz/akoVeeJ4jPUMudvPIyhS66G7JLHC
         D3Yg==
X-Forwarded-Encrypted: i=1; AJvYcCV2vq8Zp2sYwhxeqVXQNhsswL6j97oUp1H13Dk57tHAaBteWEOF1jaU+lT8aGgZpFI0Kxa1I8suvDVtfpQE59E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbJaHUSXqm9QDjKLcsKdHd/qXbfA+PclaTVS2vpBwiEztAn5PY
	pt/9SBhLHu4+TyLL2i5jQF9OiEdn6VNi4bSDBPOXNDbm3pS5RPlAmzebZwwG5QubDiYACqA4IDf
	hleHC4S4YWREljSDOy4fNl6dt85T4ZlTbWSvRtDE=
X-Gm-Gg: ATEYQzzC8/7Vh9bioZA1n0uYr07oT656kljwrnwlqtuzgameSCY8R/CwnCokpPK0qQ6
	OZhuwpA256tC1qGByiGfGsdWUMRlr9Ity2e/IdMnT0qJnuwftmQwQzIzSFN7XulSiTm/J7PuJeU
	ifrU6yF3bDvxLZUa0UW2s4K5QRBcPdg/eh683GTEn3fkiMHv10GSjhnHFNEqtiiLplzFl3IwOXT
	YLkVXnHGn9DSyT+Zj+kG/1qK/Cqef83wNvfJZHllFRL6RnQ4AD002uV1thkMA+wNOSCvRljb0ep
	0TlnlWxZxVTtdZdSRBQzQTFgdfXrijXnLpFSHVQd7+GA/nbVYPNYuFSlrvCxsFXBLlU0Fg==
X-Received: by 2002:a53:d049:0:20b0:64d:695d:6ae4 with SMTP id
 956f58d0204a3-64eaa82aad0mr281676d50.68.1773941534153; Thu, 19 Mar 2026
 10:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abwTCkavRurEcEGO@v4bel>
In-Reply-To: <abwTCkavRurEcEGO@v4bel>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Mar 2026 13:32:02 -0400
X-Gm-Features: AaiRm52EtcSLB0118AfPcdOU22f6TqO08kycIT_SHEpmIZqAYvQYDDQC_IqLWVc
Message-ID: <CABBYNZLfCm26CAnOpYV-M8GcF-jsjs-QCCQ2mxayRnQPEF9ZVg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len
 infinite loop
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hyunwoo,

On Thu, Mar 19, 2026 at 11:15=E2=80=AFAM Hyunwoo Kim <imv4bel@gmail.com> wr=
ote:
>
> l2cap_config_req() accepts CONFIG_REQ when the channel is already in
> BT_CONNECTED state. This causes l2cap_ertm_init() to be called a
> second time, re-initializing tx_q, srej_q, srej_list, and
> retrans_list without freeing the previous allocations, and setting
> chan->sdu to NULL without freeing the existing skb. This leaks all
> previously allocated ERTM resources.
>
> Additionally, l2cap_parse_conf_req() does not validate the minimum
> value of remote_mps derived from the RFC max_pdu_size option. A zero
> value propagates to l2cap_segment_sdu() where pdu_len becomes zero,
> causing the while loop to never terminate since len is never
> decremented, exhausting all available memory.
>
> Fix by removing BT_CONNECTED from the allowed states in
> l2cap_config_req() and adding a pdu_len zero check in
> l2cap_segment_sdu() as a safeguard.

This part is not clerarm it should be allowed to change the MTU while conne=
cted.

> Fixes: 96298f640104 ("Bluetooth: L2CAP: handle l2cap config request durin=
g open state")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/bluetooth/l2cap_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ad98db9632fd..a6ce09781083 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2381,6 +2381,9 @@ static int l2cap_segment_sdu(struct l2cap_chan *cha=
n,
>         /* Remote device may have requested smaller PDUs */
>         pdu_len =3D min_t(size_t, pdu_len, chan->remote_mps);
>
> +       if (!pdu_len)
> +               return -EINVAL;
> +
>         if (len <=3D pdu_len) {
>                 sar =3D L2CAP_SAR_UNSEGMENTED;
>                 sdu_len =3D 0;
> @@ -4267,8 +4270,7 @@ static inline int l2cap_config_req(struct l2cap_con=
n *conn,
>                 return 0;
>         }
>
> -       if (chan->state !=3D BT_CONFIG && chan->state !=3D BT_CONNECT2 &&
> -           chan->state !=3D BT_CONNECTED) {
> +       if (chan->state !=3D BT_CONFIG && chan->state !=3D BT_CONNECT2) {
>                 cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
>                                        chan->dcid);
>                 goto unlock;
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
