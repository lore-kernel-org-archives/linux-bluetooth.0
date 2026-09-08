Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD45361951
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886543; cv=pass; b=liS6cZWCxl7RDC7AzdtiGsr6g+B0hO8WTwbFtXpb0DaUROQaunriNfgEehj4BW0hUOgcTZgIsDw9y9+aeFMRcovDYDrnLPRCA162CEMmnrvSozLqjEF26Wxc9T/5VN3utWNizGhXa3EE6f9leLVpoa6vc5TTQJTKxxThOh8S4bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886543; c=relaxed/simple;
	bh=wqfbKZYO9T6s7SK5bHBj3gImP672/Xrc97fe6qPVVic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7HTEh2ZpawKw+1pkb490yTLuGsa54oRdiABsVixpqaognoGa/dXX65u2A1T6X881CUIQdcNB9XXkOtNRqKloP7MBgl/DdVCGz2ntVsu3oYNZ4ZqTzfKy6WzLx5e4s6xTQxCAnoaldSoFWA01fYXS63ccZplxlB5WijFCAvUdcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V01kEifl; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V01kEifl"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84830c774a0so4687933b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 09:55:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788886542; cv=none;
        d=google.com; s=arc-20260327;
        b=Z3+TECXj5onSnaJgMpXWflOzm9e4PBth9319lQB+XpP+Firo/nyQv1CfQnUTg9M1AY
         1nuXl4+f0XleN9ov8KH3/GScXf7gldazPLCX+v9JOzEXe1ZgXcsD/2NAvd+E+YUQ0jqc
         7edXhYxvYpWVsGJWCOdUfFcIbEpr0lVV3sdbAfRQWYP3E7sfNWBLxm4uCCfeIJZP6xMx
         pN/drzvkp4M09AEe2s/DxPoBbv7pNABnyVUufHVSziWc+1wOyy6QkxJa+uT6OSR2EGi8
         VsRIQhUG35m63L45h2Jbz6N2AKch8LTBq1HeicI4mkUi4WKi4yuzLl4NQQSmet+tSXiC
         oITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4X/heUJyU+AbJij09DYXBKeBkh36gMwincsy8BAmf6E=;
        fh=27lESFPTxymMMLQ/FvTtyrQNRVlwjUBcTmroof+TEFE=;
        b=OxjD4xPqQHXQM9+HJ4FIZJLgxcOGz16gFCuXhARGmHdS2nJuGIniy8VBhk93bxAMRN
         9JFfxX3L5RdiJZc+qsbXa68Knc7fM5QgF/P8MhrvnkGefUedHpWVP7G7WVVkKhBlX7zS
         MAYLUeQ255RxMjpPzRHMcmjNy5RSeUMhe9uQg5J2UE0Py99ytrmFBHagh8d2e1UyKuit
         J+II0FTnC7HmvE7U/2bYP09QQS8t2pWXbbd0t0FTHlfykcoQJtQY9s/gnpmWRrh04q3N
         0LcwOWylbhidsVU0eWD5UMQvtXWYpqfI8Z+CaqVqU0QhPDEzEZo9U78ZYX7voUnnHgal
         FLQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788886542; x=1789491342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4X/heUJyU+AbJij09DYXBKeBkh36gMwincsy8BAmf6E=;
        b=V01kEiflG9oEN/H+CQPqSSunv+sowUG3HNrok+4YJMwhLwr5SsOibbKtdEIRTBpZeM
         OfDkfXS0YBRmNKqXFE2fzhNBV4hiDCsevCJxxHE1onHeVGMteZWqNVtSOOn/lwD+lo7H
         9Ut8LSqOm7Kd0sgs1e3rE1sJT839rw+Aj2ZmKUOrK8f4V/4m/F+R2kDQk45SOWV8gRmC
         8kw0jGbyaSgl8XKptnpgF2LhZWrW7JhOl9z64eRwz05J1f89jXDB7lHiimdmMMNq+qkt
         zNfc/OQT5MKuTgGP6LOAduOBvyc8+TaD8s1xpDX97vJWa16HQZAmRVOeOmNlhBh/2bn7
         gFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886542; x=1789491342;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4X/heUJyU+AbJij09DYXBKeBkh36gMwincsy8BAmf6E=;
        b=GhTVVMQw4v9gz5LOPwmaO3HKs6Y0b/UIBbt3Fa+OxOy0rBRLcWLzAt6nSnLTO58gwW
         95a3j/Xp5aB5nOBSHDbO8mNCiPwfz4gmuu0gV4gtrrHMtqXBipgFUIw6oTHxb0TijMt2
         +AEMTZ6fOb0JGF1FfWHYqGBwzJx3lnCgfG/GwAxTm9ahM4HgaLvjawUZAjIAAOsp5VzP
         Vw1UYSZOFrw1+r4EikR62q1YpomdgGoBs3JsHnQJQW2SnMF7LNMCCfXdNcFG/aHHNx9m
         z+Wg9Ejn7vG8OupDvJ21S9QoKGp5h2tHXWATOSXtzPQo4kWZU3QZ07fGaMFjpga0kpT+
         S36Q==
X-Forwarded-Encrypted: i=1; AKwUvBzUbwUTxRNJer/xufpEu831uIK5Ek4U5KjRbj0HRiJT2Cs9jnIkCfQ9GbKBlWwwmzvn7QFkjAVBpvPqVo5ILgA=@vger.kernel.org
X-Gm-Message-State: AFuF++kxmP+n9jKLJz8F7aQgJsm2q1kGH95KpgSJ+2Ns+5r4WfRjmoI6
	+W6HMrkkuowgVUM0aEpTQXrJfIcxG81pe/7xoKIKITg8a3DMfetGY+Ubq2kQOoQeQXDnjzC2Q5b
	9ZPbzFJF2l+7BstPWhGmaGd70+naGqVo=
X-Gm-Gg: AYBFou2MwA0kN6bp8XPVc3m0ipHhkwP+FMy021/qDKLA0tcbSHx092T1YQz8nY1/iIF
	TcKgnqALDy583dSRsCIYNvCMjJdsZROYn0uHqwI1LQoTOB3rG0WaoV6BY4WbQ/4qyBQv3lXVxmI
	yQl/OriVrW5DwnX2156cJKwSG3AsKpvAfb7nhv6GGi9alNUdmZ6JRwxlQLnNofumZ4vaAeWRwSk
	99EzI7oFte4wI4SJ90re47JIPEw1cUh/8PjgYY5nV1MiHLYK2WX9orXfbKPd7OpzNUikkhkoiTa
	r5CppfnTlkyNMNLCMrrpVVEVRNY8c0Hz3aGjcz7tQ75ZLcJXak7uquraFf+/8jwfcCxR2Cju+mw
	r9eOE
X-Received: by 2002:a05:6a21:6110:b0:3d1:39e9:b269 with SMTP id
 adf61e73a8af0-3da39b5cfc5mr49040879637.4.1788886541658; Tue, 08 Sep 2026
 09:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905194725.284347-1-adrianox@gmail.com> <CABBYNZ+_KZXEz2210xPShKy=baN2Xrd4T7YijdCn9y3h-t5V8A@mail.gmail.com>
In-Reply-To: <CABBYNZ+_KZXEz2210xPShKy=baN2Xrd4T7YijdCn9y3h-t5V8A@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Tue, 8 Sep 2026 13:55:28 -0300
X-Gm-Features: AcwNN1XaC2U3kdCp8dxKL8VeVUqbrduVW0Lqh5YW6C9HLUaKhl91MEg9ANX2ioI
Message-ID: <CAMGU2hWQYMihNkc=JeH3b4G4y0a5Q+HhsvTEpy939EJYW=8g+Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: bnep: linearize skb before sending
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Right, thanks, I will send a v2.

Adriano

El mar, 8 sept 2026 a las 12:50, Luiz Augusto von Dentz
(<luiz.dentz@gmail.com>) escribi=C3=B3:
>
> Hi Adriano,
>
> On Sat, Sep 5, 2026 at 3:48=E2=80=AFPM Adriano Cordova <adrianox@gmail.co=
m> wrote:
> >
> > kernel_sendmsg expects contiguous data. Check the skb is linear
> > before building its kvec. Should be already linearized by the
> > stack, so this is defensive, but drops the dead block and the
> > FIXME.
> >
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> >  net/bluetooth/bnep/core.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> > index 5a6a49885ab6..497eb1d2d6ee 100644
> > --- a/net/bluetooth/bnep/core.c
> > +++ b/net/bluetooth/bnep/core.c
> > @@ -457,13 +457,15 @@ static int bnep_tx_frame(struct bnep_session *s, =
struct sk_buff *skb)
> >         }
> >
> >  send:
> > +       if (skb_linearize(skb)) {
> > +               kfree_skb(skb);
> > +               return -ENOMEM;
> > +       }
>
> Looks like we should be linearizing earlier:
>
> https://sashiko.dev/#/patchset/20260905194725.284347-1-adrianox%40gmail.c=
om
>
> >         iv[il++] =3D (struct kvec) { skb->data, skb->len };
> >         len +=3D skb->len;
> >
> > -       /* FIXME: linearize skb */
> > -       {
> > -               len =3D kernel_sendmsg(sock, &s->msg, iv, il, len);
> > -       }
> > +       len =3D kernel_sendmsg(sock, &s->msg, iv, il, len);
> >         kfree_skb(skb);
> >
> >         if (len > 0) {
> > --
> > 2.51.0
> >
>
>
> --
> Luiz Augusto von Dentz
