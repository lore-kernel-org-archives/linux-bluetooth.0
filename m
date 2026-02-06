Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194625A655
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Feb 2026 20:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770411278; cv=pass; b=nPHymNG9pcGA1JgHCUPK+fK8Vx2r9wEAqNs0d+rIsvVAR+0GHmaeADozdVyHXU2N1ZIlGaL+2dabtldk+ylPlBQo7UA9p3RA34mC662C0s5SZUi+Mb2Zcnl/SIZoV4ICJOq0zN01trwydLH9+u9aephLYC3HAN2rYkc2FGv3M/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770411278; c=relaxed/simple;
	bh=zMNRanjJMKC3jAJqRF02bws1+cSDHB3fQi8w/RpC3V0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUIPgdPWn29TZBIgT8Julq3yGzGOpr5FJFiYiUEm8FKfbUq+irLF8kWLNID7HJxJ9ul7n9Dnpajfh9OHezODXV311nIAjRTG0StU7cYHuiXiu6Q94MJmhK73csQi70f4zZ4umZMxzsL3RDYR0zKOQOUQuvPn8fH3ewze67GIP/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQXLAk7I; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQXLAk7I"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79456d5ebf9so12698197b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Feb 2026 12:54:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770411277; cv=none;
        d=google.com; s=arc-20240605;
        b=M3JAeQFsvwiFyq9kmyrc94CD1ANyu/NGs6pNh2m1CFzXFBIarNYY9o5vVt1VhfLD5F
         rAIvNBIdlX3U6nK4f8xgsMPFsvXdGGiDMRa0Ga9fOPypBqjQ/l90TybpjL+T41J2bfb/
         6leZQHH+Mjnd0+mKocOWKXWefTwNjoPnO9vgdaH7R5h6ltZKc1Atc2/8PPWBCpw/Ztfs
         T0x0jibC6HZU/fB0A6tvrd+XU7c6ynYWu55dhFcz13nyFKmnLGuJ13FuDb9EjCbnnszS
         xp5RetMZUkFQFSjBhXxlXQoIaT7fvM0AU5o+WsHfENE0thrztr3UrvKzqgDYZ10b7UtS
         eAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xc1I9/r/tC1+9D0oNtvLf28pN/kvSm+LK+JbX9GDAeg=;
        fh=mhkjHKbe7dOm5blDNTf3rXzO3YvOA/tMKOjsfLw17ek=;
        b=ifDXZ1KJUZfgLxy6BzLz5mbd3Le4G1zbdwkIE1wzR8P4H0nXbOB+21vYTCkLJcEPQf
         7/b3pSz81iAfodal9Gt6BW74dqc6jRpfxd/D5EUmebLC875ikFascBv18VhINHrRO9YW
         TUeQD3/3K7Dhege+PXXdcDRJXa6IAs+FNIM3i5cYajlHyh8MvAWRQvVExPBkGpBK9VZ7
         Nw1DTr2FtjtESZyzPB3OLif/EekCr7TeocPnvcE8JiAdZVqvwXBdkJya9G4mtMBh6ovS
         H40LHO61v/l4qriq4Zu2m0yo+8DxrY/e41unU1LgDAVpQKHR69km3ROTFArH1fFr4E0v
         Wy+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770411277; x=1771016077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xc1I9/r/tC1+9D0oNtvLf28pN/kvSm+LK+JbX9GDAeg=;
        b=cQXLAk7IY7fUpi36dcG3c/sviMEpnHkuY2SBF63GUDSO4ie7Mg1XWyChQ2+AialKNS
         8pkgaCS8C/q6hNq7D+4X91nYqSa5XN2lO9HVnzvyM+tdxMYhRaxbRFzCs05F2HgsyBY1
         AdHpDueUOorYeW45SiXEvAf7ZJHexuAibwHPRlugj07Q4XxG8tZPX02TPirvXxzE+a7Z
         s1ah0mUBkjBNa8tXvGP+ocTmsbVdpd4uwjUyqpFaaMA7dkyEovDaNhCupWS2aryWx4PD
         hFLH3YajwYqYwfis5ywvSNxt82Pllcp14v7ySzJrdFlNXBUEL8vrngQ7/zWEiDDO2KLQ
         PQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770411277; x=1771016077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xc1I9/r/tC1+9D0oNtvLf28pN/kvSm+LK+JbX9GDAeg=;
        b=cFs9gQ8F+pwELZEIoMGGrlFuF9F5axZO/gO0bnKU6LiIG3OUNNUzcOimoUUh7pHv9A
         wOtrEkEVjopsVZ3ixIzVGXgp30yGbT2sGAeqdjcH+RG3frVfZQbRv8HttGBiyZMES951
         HSUtTzQMkakf3GDwDl5AvU8lYNiMxe/JmX0hIYZNliOJuCiMnFJ1eZTpBKh4lrPJ9JPG
         XwBlefcr9mT0W5DhtbUa4UIbeu8jdvhAaJmb72+1nVOqqeQdF80xNqm9nfojnv0aW0aV
         mhF9J6hWSyeXfLk7ctxp19GsaOG+D/m2C0GdtsCFnDV9boHrEofcbof3Zdnxk2qAHsv/
         iJsA==
X-Gm-Message-State: AOJu0Yy9GFxGZ67SxZSPm/FK7DSaSNiywz5MSwyMeO2ZnS1AMXNq5vfx
	yBSDXWaIXiW9BKQ3n007GTSin7xrmHTk8QPD28w2QpgXMQ3j6eesLY0KZxPQDwQX6zNb1BdE8u2
	CW8tj+yhW4kpFk0OwSOHfLrIjTixYe8gCkc5i
X-Gm-Gg: AZuq6aIlHYU0y8xsHZnw9Tqn43eIUSKA19fezpuuSBdw2wtWqVYwHEQvti5z9Lfzibi
	FBD+lla6DsAFJm8z6h7bCLKiAdI3/3Lh9xkNQgfzs0CijBMq8p5mkAJETb2qV1SzFcgKrxZi/Jw
	9Fh3iYChcCiRVbatSovbLWvmyQKzBDr0xJnhLVsJTR2FiDTobYNh0JYr8X3+YKECRmqPD2jt929
	Z/HHObytXjvNw/b2w+72A7xYvlvD/6iqzjpTyMBDjpvBQDtLA5FVKOrNFxwP9yCvoP0T0RDXyBZ
	E4hBMbcwxQ1tpZzQwIejWzGe6+FiN0v6Cyur1i9IdqhZFX/L8kZGmfu7kg==
X-Received: by 2002:a05:690c:38a:b0:786:506c:3cc4 with SMTP id
 00721157ae682-7952ab50045mr43169307b3.53.1770411277423; Fri, 06 Feb 2026
 12:54:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206202106.337275-1-luiz.dentz@gmail.com> <d7dff451-317d-4e31-9e77-a098390b3483@molgen.mpg.de>
In-Reply-To: <d7dff451-317d-4e31-9e77-a098390b3483@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 6 Feb 2026 15:54:26 -0500
X-Gm-Features: AZwV_QgCd_dSiKQw3Hq_ZXbm2YiT-LXE5Q0X6sQeDjrgijmGgAH9iAnAvX8MlG0
Message-ID: <CABBYNZ+9uYDp=1c=N452H6M-3p7CEJTvjmNWGaizEc9ci+ugJw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix result of L2CAP_ECRED_CONN_RSP
 when MTU is too short
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Fri, Feb 6, 2026 at 3:32=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> Dear Luiz,
>
>
> Thank you for your patch.
>
> Am 06.02.26 um 21:21 schrieb Luiz Augusto von Dentz:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > Test L2CAP/ECFC/BV-26-C expect the response to L2CAP_ECRED_CONN_REQ wit=
h
> > and MTU value < L2CAP_ECRED_MIN_MTU (64) to be L2CAP_CR_LE_INVALID_PARA=
MS
>
> s/and/an/
>
> > rather than L2CAP_CR_LE_UNACCEPT_PARAMS.
> >
> > Also fix not including the correct number of CIDs in the response since
> > the spec requires all CIDs being rejected to be included in the
> > response.
>
> Could be a separate patch to make the commits smaller.

Nope, would mean 2 patches would be needed to be backported to get one
qualification test fixed, so I prefer to have it all fixed with one
change when covering qualification tests.

> > Link: https://github.com/bluez/bluez/issues/1868
> > Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced C=
redit Based Mode")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >   include/net/bluetooth/l2cap.h |  6 +++---
> >   net/bluetooth/l2cap_core.c    | 11 +++++++----
> >   2 files changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2ca=
p.h
> > index 6f9cf7a05986..010f1a8fd15f 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -284,9 +284,9 @@ struct l2cap_conn_rsp {
> >   #define L2CAP_CR_LE_BAD_KEY_SIZE    0x0007
> >   #define L2CAP_CR_LE_ENCRYPTION              0x0008
> >   #define L2CAP_CR_LE_INVALID_SCID    0x0009
> > -#define L2CAP_CR_LE_SCID_IN_USE              0X000A
> > -#define L2CAP_CR_LE_UNACCEPT_PARAMS  0X000B
> > -#define L2CAP_CR_LE_INVALID_PARAMS   0X000C
> > +#define L2CAP_CR_LE_SCID_IN_USE              0x000A
> > +#define L2CAP_CR_LE_UNACCEPT_PARAMS  0x000B
> > +#define L2CAP_CR_LE_INVALID_PARAMS   0x000C
>
> What changed here?

Typo, 0'X' vs 0x

> >
> >   /* connect/create channel status */
> >   #define L2CAP_CS_NO_INFO    0x0000
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 81038458be0c..0b9753df802d 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -5051,13 +5051,15 @@ static inline int l2cap_ecred_conn_req(struct l=
2cap_conn *conn,
> >       struct l2cap_chan *chan, *pchan;
> >       u16 mtu, mps;
> >       __le16 psm;
> > -     u8 result, len =3D 0;
> > +     u8 result, rsp_len =3D 0;
> >       int i, num_scid;
> >       bool defer =3D false;
> >
> >       if (!enable_ecred)
> >               return -EINVAL;
> >
> > +     memset(pdu, 0, sizeof(*pdu));
> > +
> >       if (cmd_len < sizeof(*req) || (cmd_len - sizeof(*req)) % sizeof(u=
16)) {
> >               result =3D L2CAP_CR_LE_INVALID_PARAMS;
> >               goto response;
> > @@ -5066,6 +5068,9 @@ static inline int l2cap_ecred_conn_req(struct l2c=
ap_conn *conn,
> >       cmd_len -=3D sizeof(*req);
> >       num_scid =3D cmd_len / sizeof(u16);
> >
> > +     /* Always respond with the same number of scids as in the request=
 */
> > +     rsp_len =3D cmd_len;
> > +
> >       if (num_scid > L2CAP_ECRED_MAX_CID) {
> >               result =3D L2CAP_CR_LE_INVALID_PARAMS;
> >               goto response;
> > @@ -5075,7 +5080,7 @@ static inline int l2cap_ecred_conn_req(struct l2c=
ap_conn *conn,
> >       mps  =3D __le16_to_cpu(req->mps);
> >
> >       if (mtu < L2CAP_ECRED_MIN_MTU || mps < L2CAP_ECRED_MIN_MPS) {
> > -             result =3D L2CAP_CR_LE_UNACCEPT_PARAMS;
> > +             result =3D L2CAP_CR_LE_INVALID_PARAMS;
> >               goto response;
> >       }
> >
> > @@ -5095,8 +5100,6 @@ static inline int l2cap_ecred_conn_req(struct l2c=
ap_conn *conn,
> >
> >       BT_DBG("psm 0x%2.2x mtu %u mps %u", __le16_to_cpu(psm), mtu, mps)=
;
> >
> > -     memset(pdu, 0, sizeof(*pdu));
> > -
> >       /* Check if we have socket listening on psm */
> >       pchan =3D l2cap_global_chan_by_psm(BT_LISTEN, psm, &conn->hcon->s=
rc,
> >                                        &conn->hcon->dst, LE_LINK);
>
> Diff looks fine otherwise.
>
>
> Kind regards,
>
> Paul



--=20
Luiz Augusto von Dentz
