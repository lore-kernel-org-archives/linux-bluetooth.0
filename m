Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF11D04A6
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033447; cv=none; b=ZyC2USGIJ9ACQvnamOMnsju0RsKJIsg3LvnzLbO937JmwJaWG8DSIvyQHDHsDDwnMDEr+8IhE4F7ni9z3yZw/yQGYPPDKaBOobUzIQyRBGIADmWCBJX2iNSZ95r6RjZPpPzLbzwx62upgORZT7xm+tNk6VNsEd79g1hvwXnEaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033447; c=relaxed/simple;
	bh=9asUNpWgHLW/tFyFK2VbZs//Ya1Tbs4E+VGFc59DxZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCbOmZSv9yVBLgiTn33SvWXOjXQhPW0SYD6Gx26tBKwqxH77Pv9GZO+lOTJqZrEDYewC0nIRfoayETHMDuwg9h7OcDauByHlSOTuQnEDEQ/ORRteV5yWo4yU5pLZxFh+G0Crb9jMnZz9H2uBfEu8hPE2dOKbSsrKMG1P6qJ6TTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPUGkpH/; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPUGkpH/"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ff3232ee75so13376631fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 08:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732033444; x=1732638244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vzi/pfpbRFqeDGRXx1LMmnC6AThP5YQngjLILJF6HAI=;
        b=aPUGkpH/MhjEn2+Nk/VcQvtLQhUhxZKc9MW3i6BZsFpJJYo3Zy1vuSd4IXcJEBotiZ
         bniGpIcQndF0qNn9B+wrs5Ih7sXicGdNiZZbnatL7iH3woNAilIunCpOrlF0eIo6Q9Om
         aMB+C3qJ4uIw0SvAyJRfMUE5ZXA6Yegd9g/42H21ZxCvEuLo6lM4iSEPwQm4YO8Ta/PR
         A2bz46unZIcuN+Y5/9D2KAlyH/M1DUySdhWCQ0YeLkweRGhQCkCpAfnSOSWUUvpkJRX5
         DPDEYKddsYr5IZO4yDm1IviGpe63gK7slhXo3MkhSzQBE/KmuyF4C7lNzjXQRFfg1REu
         xq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732033444; x=1732638244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vzi/pfpbRFqeDGRXx1LMmnC6AThP5YQngjLILJF6HAI=;
        b=xGGjExJtD1XU4Vq2F4/v1JVHJZaoDEg6NamiDIRlI23jNWxppFp1RBo9BBnJw4eHIN
         Nb5oRYKqnWMakIRv2mayaOWDS4QxEsiCjbDQsjDrhWo26s3UjIXS9L/v44A0/d9pZ6r4
         00U5TediHFTPAXd5FFWfO315N3HxHXx72zvif2gOI+ayL6OpvpZK8c711Hm8twffXPCF
         KdhGPZsff7Fo8uV4ltBg1D1up2sD6Q/pv/qAJWEM1bHf0r/WXVDXYPVTdpzEsfCPPbE2
         i9KonA1eEZJ4T2dx1FgOpuZOHjfDKPsXKyD0XQb7pQm5kMQQIkNULJ0iDVC6v/2hufl0
         6HMQ==
X-Gm-Message-State: AOJu0YxXPdA7cAnVqA+zSiLzUnUJ5S6WtBtDkm9ZJonJkZcN6PpaZmgp
	yd9NAusO55k3PVhJ5bqpkZ14vf0fvWuq54frE+QZG+61AVSXZvV35+un0l3EPfLruLh4+je7uU4
	CtVvlbwUYjwh2BUZ4kw/m2bVg14Q=
X-Google-Smtp-Source: AGHT+IGqKxXFwfvIh16mM0Mep1dGMhDzwd+gM0VyhUVNzoUnrkXlCU8/oA0oAjMMhBwlXFvI4XnUGlshKJe15+EqhCE=
X-Received: by 2002:a05:651c:1510:b0:2ff:8b09:6870 with SMTP id
 38308e7fff4ca-2ff8b096a1emr10784981fa.26.1732033443428; Tue, 19 Nov 2024
 08:24:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118094907.2673431-1-quic_jiaymao@quicinc.com>
 <CABBYNZK9Z2fKiFmfnptUsX+yrvaKNW+b_BfQyidM=z2YU499nQ@mail.gmail.com> <421ab7ec-dc32-4bac-a3c0-9ed2d48a902c@quicinc.com>
In-Reply-To: <421ab7ec-dc32-4bac-a3c0-9ed2d48a902c@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 Nov 2024 11:23:50 -0500
Message-ID: <CABBYNZJdvSj0cTRjeR2WeCvv92xeWiXMFjnGC3inZik-D0iefg@mail.gmail.com>
Subject: Re: [PATCH v1] hog: Check security level before setting
To: Jiayang Mao <quic_jiaymao@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com, 
	"Jiayang Mao (QUIC)" <quic_jiaymao@qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiayang,

On Mon, Nov 18, 2024 at 10:23=E2=80=AFPM Jiayang Mao <quic_jiaymao@quicinc.=
com> wrote:
>
> Hi Luiz,
>
> On 2024/11/18 23:13, Luiz Augusto von Dentz wrote:
> > Hi Jiayang,
> >
> > On Mon, Nov 18, 2024 at 4:49=E2=80=AFAM Jiayang Mao <quic_jiaymao@quici=
nc.com> wrote:
> >>
> >> bt_gatt_client_set_security could fail if the security level is
> >> already BT_ATT_SECURITY_MEDIUM. So, get and check the security
> >> level before setting it.
> >
> > Seems a bit strange that this is not handled by the kernel, can you
> > elaborate on the conditions to trigger it?
> >
>
> In the kernel, the failure happens when smp_sufficient_security() in
> 'net/bluetooth/smp.c' returns true. In some cases, when security level
> is already MEDIUM but long term key is not ready, setting security level
> will fail. Checking security level before setting it can prevent this
> failure.

Hmm, is this about encryption change happening before the LTK is
distributed? Ive seen that sometimes remote devices also have this
problem e.g. GATT read return encryption required error but the link
is already encrypted.

Btw, I assume the problem is in this following code:

https://github.com/torvalds/linux/blob/master/net/bluetooth/l2cap_sock.c#L9=
31

That would fail with 1 because smp_sufficient_security would return
true but we assume that to be an error, well it is an error but I
guess it should have been -EALREADY that way one does not need to
check the error again:

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 18e89e764f3b..ada0915c7421 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -919,6 +919,11 @@ static int l2cap_sock_setsockopt(struct socket
*sock, int level, int optname,
                        break;
                }

+               if (chan->sec_level =3D=3D sec.level) {
+                       err =3D -EALREADY;
+                       break;
+               }
+
                chan->sec_level =3D sec.level;

                if (!chan->conn)

Anyway I think it is safer to do that on userspace first so it acts
properly with older kernels.

> >> Signed-off-by: Jiayang Mao <quic_jiaymao@quicinc.com>
> >> ---
> >>   profiles/input/hog.c | 6 ++++--
> >>   1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> >> index 017e320f0..011cc0a88 100644
> >> --- a/profiles/input/hog.c
> >> +++ b/profiles/input/hog.c
> >> @@ -191,8 +191,10 @@ static int hog_accept(struct btd_service *service=
)
> >>                          return -ECONNREFUSED;
> >>
> >>                  client =3D btd_device_get_gatt_client(device);
> >> -               if (!bt_gatt_client_set_security(client,
> >> -                                               BT_ATT_SECURITY_MEDIUM=
))
> >> +               if (BT_ATT_SECURITY_MEDIUM !=3D
> >> +                       bt_gatt_client_get_security(client) &&
> >> +                   !bt_gatt_client_set_security(client,
> >> +                                                BT_ATT_SECURITY_MEDIU=
M))
> >>                          return -ECONNREFUSED;
> >
> >
> > Definitely not the right way to fix this since there might be other
> > places that do attempt to set the security, so Id got with something
> > like the following:
> >
> > diff --git a/src/shared/att.c b/src/shared/att.c
> > index 4a406f4b91a4..dabbdb4315eb 100644
> > --- a/src/shared/att.c
> > +++ b/src/shared/att.c
> > @@ -727,6 +727,9 @@ static bool bt_att_chan_set_security(struct
> > bt_att_chan *chan, int level)
> >   {
> >          struct bt_security sec;
> >
> > +       if (level =3D=3D bt_att_chan_get_security(chan))
> > +               return true;
> > +
> >          if (chan->type =3D=3D BT_ATT_LOCAL) {
> >                  chan->sec_level =3D level;
> >                  return true;
> >
> >>          }
> >>
> >> --
> >> 2.25.1
> >>
> >>
> >
> >
>


--=20
Luiz Augusto von Dentz
