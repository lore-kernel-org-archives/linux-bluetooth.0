Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FC1145A1C
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624796; cv=none; b=pDRTzMxxWRPWji2i4MW+lZvp9ZQaIGP6x/jc526k8ESWxRmR8y+ZvMA0KYi4xXyyj7Nhxomm4x8mgngHyle1LX3Egye0oRiWmc13vh5+1x/9epO2IpfizAEO1Pq9bqE0kr7ojxwJogk41P8qNHKB/P3JD5FxS5pBxBZcx7GAMws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624796; c=relaxed/simple;
	bh=PF/E0Af8kXwvfOPI10sZsBvdzmU80CJnnIxHL3erTV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHXMbY1yKuWdQio0LWWKrCKw4SParV3CFxoQCx/gTfwiVt9/Y8v4A9ri4i2YJSz1HuXVLHUSBxRWaLvqcfh44f0xOuh+iswN78e/XJ5haD8Tyb2hQnsLcJmNwf0yTSrKW8zzJrwHpv/AxUuMDrR6WmGMb8PodoiI37vwUWT4MGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apUsHcC/; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apUsHcC/"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb587d0436so58975231fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729624792; x=1730229592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6d1S+7ectDxTFcfmbyKMDScuQ9EoVfSFNp0MJ2BoI5s=;
        b=apUsHcC/H+SQmoRze+UrceiK2kt9sXFHsflBEJ5mKSwrAGUALFlT5hvfaI/JL1mjjb
         9/d3fttqgZSlvyAK96NdtY/hUR3nbxF7/6lNRUTqOOqymHY9/VInmu+DF7dv6KfLKGaA
         Cs/gFnQQ41B5SLBgBrWyDfzoYCY71R2JofK8AVMbztDNYphn3qy0tOUBnTrna6zpLup8
         Zgqr3UXXT7YQ1M+0bc317WrRDhB+qi9xzgfryR+BqLWoTrAtf8v6JEZNlzegAjmPlZCg
         v9W07J2HgC8NyA4qlyIwkXQnD/fyogGqv0E0VYEt3kDXK3i97qwVsxAjt5rrEVoqrY8k
         OwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729624792; x=1730229592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6d1S+7ectDxTFcfmbyKMDScuQ9EoVfSFNp0MJ2BoI5s=;
        b=uxkdtzN9Ti6MFxM4FGrhZ2h9YgUxa3koX9THmsVyPdlIOzLPwOgJWkWxXOgcY8sGbN
         si0pPwNdkF5HEkcgPc1kQPQir1DQqz+Arm6uFQE6nGcPXdAhbAMlsbgaSLvqn0lnxjdG
         6yoyQwfZMQYAheeH+XnSTrKYXQcmbsTTcX+O6JSSs8PStirEObUtz1dlsoTZe2HgAJXL
         fS7r+oVCOIQWvIjOm7EYFDZRdeDqiysHWEikkIbD3nZkLxKV4yFfxCyWec1tHendcmCx
         4V3zK/ZFZb5VvQaiA0004C0B+ocXtY0ANx2NvoEdbC4fofqUwZQRJtJtdB8QzBHKDbxi
         GlVA==
X-Gm-Message-State: AOJu0Ywr7uEkG4qj6i7dLoKNDTyo145N6vmeI8Q2TdsoDXdtJ/B1/7ir
	7Ua2/bIN3zvMVLhKqopW+l7/NSfUY2T6xf8MFAAN0356Ilxf1TuCl6gyyxWQr8yKx3d0HyMwgm4
	AnBiIfQReOogEVrwPAk3UZ+OUYVJn9w==
X-Google-Smtp-Source: AGHT+IF8z0r8Z6u0LZiWDryb4pwmfh4jUeDtf93iHrYp4ftgfgjs+jlJYPLOZZUf0ho9Dwm1mL+nzLH5mrUItahqfJA=
X-Received: by 2002:a05:651c:507:b0:2fa:d3a5:189c with SMTP id
 38308e7fff4ca-2fc9d5958c9mr373261fa.36.1729624791863; Tue, 22 Oct 2024
 12:19:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002190452.3405592-1-luiz.dentz@gmail.com>
 <CABBYNZKqrja__qdidRwqXh9wcJJ6YdGqdh4bejU5HsL02qcFpw@mail.gmail.com>
 <CABBYNZLoh-K2QLinNwJrbQgSccTKW37C2wt5+AmM272Du3p81A@mail.gmail.com>
 <CABBYNZLeWWtX9PdNarFajZynUSsyrd4mavExPXzY2GUf_ZzECw@mail.gmail.com>
 <CABBYNZJLj6gSa-1prGM5aLKTJbFJo5mxxJkBU=WoqEx-P6TdOA@mail.gmail.com>
 <CABBYNZJGF4156YhdOH5DoZ7hkh1NTrpQwntwJZiYJ9AyHYr14w@mail.gmail.com>
 <CABBYNZ+=iNpM0TF4jDCqfJM4VWHY+CY5Vp1Ah91i8jGNKUeMKQ@mail.gmail.com>
 <CABBYNZ+i88jmqD3pV2Czh=7fBhZ0_73s1+tsumt0+oVo8kSm1w@mail.gmail.com>
 <CABBYNZLfELHraPs15x1PYhBUQrd_OQTnef00Y+5nm0w7US2_Wg@mail.gmail.com>
 <CABBYNZ+XB+hAN7BmOQiKpdBBHXX_8JrDm3HpXJ=JKVBg8R1CGA@mail.gmail.com>
 <CABBYNZKc5UFjYL5XxX0qy7vdOEENT1Pj7u6U4Pk+_cdJE+zAsg@mail.gmail.com> <CABBYNZLHhVmQj3R5JS13HTp7KrCrs-HBcRFLqn6AU44uLpbXjA@mail.gmail.com>
In-Reply-To: <CABBYNZLHhVmQj3R5JS13HTp7KrCrs-HBcRFLqn6AU44uLpbXjA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 22 Oct 2024 15:19:38 -0400
Message-ID: <CABBYNZJYtnHH1MjnNFdzfvu6jFOypL6iHjQ1Ujh8aYaycZzjFQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: SCO: Use disable_delayed_work_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="000000000000507dd3062515a730"

--000000000000507dd3062515a730
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Tue, Oct 22, 2024 at 12:44=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Mon, Oct 7, 2024 at 4:54=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Mon, Oct 7, 2024 at 1:16=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Fri, Oct 4, 2024 at 1:24=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > #syz test
> > > >
> > > > On Fri, Oct 4, 2024 at 12:06=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > #syz test
> > > > >
> > > > > On Thu, Oct 3, 2024 at 3:21=E2=80=AFPM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > #syz test
> > > > > >
> > > > > > On Thu, Oct 3, 2024 at 12:32=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > #syz test
> > > > > > >
> > > > > > > On Thu, Oct 3, 2024 at 11:38=E2=80=AFAM Luiz Augusto von Dent=
z
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > #syz test
> > > > > > > >
> > > > > > > > On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Den=
tz
> > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > #syz test
> > > > > > > > >
> > > > > > > > > On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von D=
entz
> > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > #syz test
> > > > > > > > > >
> > > > > > > > > > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von=
 Dentz
> > > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > #syz test
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto v=
on Dentz
> > > > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.=
com>
> > > > > > > > > > > >
> > > > > > > > > > > > This makes use of disable_delayed_work_sync instead
> > > > > > > > > > > > cancel_delayed_work_sync as it not only cancel the =
ongoing work but also
> > > > > > > > > > > > disables new submit which is disarable since the ob=
ject holding the work
> > > > > > > > > > > > is about to be freed.
> > > > > > > > > > > >
> > > > > > > > > > > > In addition to it remove call to sco_sock_set_timer=
 on __sco_sock_close
> > > > > > > > > > > > since at that point it is useless to set a timer as=
 the sk will be freed
> > > > > > > > > > > > there is nothing to be done in sco_sock_timeout.
> > > > > > > > > > > >
> > > > > > > > > > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.=
appspotmail.com
> > > > > > > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4=
c0d0c4cde787116d465
> > > > > > > > > > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeo=
uts with delayed_work")
> > > > > > > > > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.den=
tz@intel.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  net/bluetooth/sco.c | 13 +------------
> > > > > > > > > > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sc=
o.c
> > > > > > > > > > > > index a5ac160c592e..2b1e66976068 100644
> > > > > > > > > > > > --- a/net/bluetooth/sco.c
> > > > > > > > > > > > +++ b/net/bluetooth/sco.c
> > > > > > > > > > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct=
 hci_conn *hcon, int err)
> > > > > > > > > > > >         }
> > > > > > > > > > > >
> > > > > > > > > > > >         /* Ensure no more work items will run befor=
e freeing conn. */
> > > > > > > > > > > > -       cancel_delayed_work_sync(&conn->timeout_wor=
k);
> > > > > > > > > > > > +       disable_delayed_work_sync(&conn->timeout_wo=
rk);
> > > > > > > > > > > >
> > > > > > > > > > > >         hcon->sco_data =3D NULL;
> > > > > > > > > > > >         kfree(conn);
> > > > > > > > > > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(s=
truct sock *sk)
> > > > > > > > > > > >
> > > > > > > > > > > >         case BT_CONNECTED:
> > > > > > > > > > > >         case BT_CONFIG:
> > > > > > > > > > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > > > > > > > > > -                       sk->sk_state =3D BT_DISCONN=
;
> > > > > > > > > > > > -                       sco_sock_set_timer(sk, SCO_=
DISCONN_TIMEOUT);
> > > > > > > > > > > > -                       sco_conn_lock(sco_pi(sk)->c=
onn);
> > > > > > > > > > > > -                       hci_conn_drop(sco_pi(sk)->c=
onn->hcon);
> > > > > > > > > > > > -                       sco_pi(sk)->conn->hcon =3D =
NULL;
> > > > > > > > > > > > -                       sco_conn_unlock(sco_pi(sk)-=
>conn);
> > > > > > > > > > > > -               } else
> > > > > > > > > > > > -                       sco_chan_del(sk, ECONNRESET=
);
> > > > > > > > > > > > -               break;
> > > > > > > > > > > > -
> > > > > > > > > > > >         case BT_CONNECT2:
> > > > > > > > > > > >         case BT_CONNECT:
> > > > > > > > > > > >         case BT_DISCONN:
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.46.1
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > --
> > > > > > > > > > > Luiz Augusto von Dentz
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > Luiz Augusto von Dentz
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Luiz Augusto von Dentz
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Luiz Augusto von Dentz
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Luiz Augusto von Dentz
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Luiz Augusto von Dentz
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

--000000000000507dd3062515a730
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v1-0001-Bluetooth-SCO-Fix-UAF-on-sco_sock_timeout.patch"
Content-Disposition: attachment; 
	filename="v1-0001-Bluetooth-SCO-Fix-UAF-on-sco_sock_timeout.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m2ktxkf90>
X-Attachment-Id: f_m2ktxkf90

RnJvbSAwMTg2MDRmNGJlOGYxZTc2OWEzNThiMWU3YmY5M2UxYzJjYzgzZTI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFR1ZSwgMjIgT2N0IDIwMjQgMTI6MzE6MDggLTA0MDAKU3ViamVj
dDogW1BBVENIIHYxXSBCbHVldG9vdGg6IFNDTzogRml4IFVBRiBvbiBzY29fc29ja190aW1lb3V0
Cgpjb25uLT5zayBtYXliZSBoYXZlIGJlZW4gdW5saW5rZWQvZnJlZWQgd2hpbGUgd2FpdGluZyBm
b3Igc2NvX2Nvbm5fbG9jawpzbyB0aGlzIGNoZWNrcyBpZiB0aGUgY29ubi0+c2sgaXMgc3RpbGwg
dmFsaWQgYnkgY2hlY2tpbmcgaWYgaXQgcGFydCBvZgpzY29fc2tfbGlzdC4KClJlcG9ydGVkLWJ5
OiBzeXpib3QrNGMwZDBjNGNkZTc4NzExNmQ0NjVAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpD
bG9zZXM6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD00YzBkMGM0Y2Rl
Nzg3MTE2ZDQ2NQpGaXhlczogYmEzMTZiZTFiNmEwICgiQmx1ZXRvb3RoOiBzY2hlZHVsZSBTQ08g
dGltZW91dHMgd2l0aCBkZWxheWVkX3dvcmsiKQpTaWduZWQtb2ZmLWJ5OiBMdWl6IEF1Z3VzdG8g
dm9uIERlbnR6IDxsdWl6LnZvbi5kZW50ekBpbnRlbC5jb20+Ci0tLQogaW5jbHVkZS9uZXQvYmx1
ZXRvb3RoL2JsdWV0b290aC5oIHwgIDEgKwogbmV0L2JsdWV0b290aC9hZl9ibHVldG9vdGguYyAg
ICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKwogbmV0L2JsdWV0b290aC9zY28uYyAgICAg
ICAgICAgICAgIHwgMTggKysrKysrKysrKysrLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDM1IGlu
c2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQvYmx1
ZXRvb3RoL2JsdWV0b290aC5oIGIvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2JsdWV0b290aC5oCmlu
ZGV4IDVkNjU1ZTEwOWIyYy4uZjY2YmM4NWM2NDExIDEwMDY0NAotLS0gYS9pbmNsdWRlL25ldC9i
bHVldG9vdGgvYmx1ZXRvb3RoLmgKKysrIGIvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2JsdWV0b290
aC5oCkBAIC00MDMsNiArNDAzLDcgQEAgaW50ICBidF9zb2NrX3JlZ2lzdGVyKGludCBwcm90bywg
Y29uc3Qgc3RydWN0IG5ldF9wcm90b19mYW1pbHkgKm9wcyk7CiB2b2lkIGJ0X3NvY2tfdW5yZWdp
c3RlcihpbnQgcHJvdG8pOwogdm9pZCBidF9zb2NrX2xpbmsoc3RydWN0IGJ0X3NvY2tfbGlzdCAq
bCwgc3RydWN0IHNvY2sgKnMpOwogdm9pZCBidF9zb2NrX3VubGluayhzdHJ1Y3QgYnRfc29ja19s
aXN0ICpsLCBzdHJ1Y3Qgc29jayAqcyk7Citib29sIGJ0X3NvY2tfbGlua2VkKHN0cnVjdCBidF9z
b2NrX2xpc3QgKmwsIHN0cnVjdCBzb2NrICpzKTsKIHN0cnVjdCBzb2NrICpidF9zb2NrX2FsbG9j
KHN0cnVjdCBuZXQgKm5ldCwgc3RydWN0IHNvY2tldCAqc29jaywKIAkJCSAgIHN0cnVjdCBwcm90
byAqcHJvdCwgaW50IHByb3RvLCBnZnBfdCBwcmlvLCBpbnQga2Vybik7CiBpbnQgIGJ0X3NvY2tf
cmVjdm1zZyhzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3QgbXNnaGRyICptc2csIHNpemVfdCBs
ZW4sCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2FmX2JsdWV0b290aC5jIGIvbmV0L2JsdWV0
b290aC9hZl9ibHVldG9vdGguYwppbmRleCBlMzlmYmE1NTY1YzUuLjBiNGQwYThiZDM2MSAxMDA2
NDQKLS0tIGEvbmV0L2JsdWV0b290aC9hZl9ibHVldG9vdGguYworKysgYi9uZXQvYmx1ZXRvb3Ro
L2FmX2JsdWV0b290aC5jCkBAIC0xODUsNiArMTg1LDI4IEBAIHZvaWQgYnRfc29ja191bmxpbmso
c3RydWN0IGJ0X3NvY2tfbGlzdCAqbCwgc3RydWN0IHNvY2sgKnNrKQogfQogRVhQT1JUX1NZTUJP
TChidF9zb2NrX3VubGluayk7CiAKK2Jvb2wgYnRfc29ja19saW5rZWQoc3RydWN0IGJ0X3NvY2tf
bGlzdCAqbCwgc3RydWN0IHNvY2sgKnMpCit7CisJc3RydWN0IHNvY2sgKnNrOworCisJaWYgKCFs
IHx8ICFzKQorCQlyZXR1cm4gZmFsc2U7CisKKwlyZWFkX2xvY2soJmwtPmxvY2spOworCisJc2tf
Zm9yX2VhY2goc2ssICZsLT5oZWFkKSB7CisJCWlmIChzID09IHNrKSB7CisJCQlyZWFkX3VubG9j
aygmbC0+bG9jayk7CisJCQlyZXR1cm4gdHJ1ZTsKKwkJfQorCX0KKworCXJlYWRfdW5sb2NrKCZs
LT5sb2NrKTsKKworCXJldHVybiBmYWxzZTsKK30KK0VYUE9SVF9TWU1CT0woYnRfc29ja19saW5r
ZWQpOworCiB2b2lkIGJ0X2FjY2VwdF9lbnF1ZXVlKHN0cnVjdCBzb2NrICpwYXJlbnQsIHN0cnVj
dCBzb2NrICpzaywgYm9vbCBiaCkKIHsKIAljb25zdCBzdHJ1Y3QgY3JlZCAqb2xkX2NyZWQ7CmRp
ZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL3Njby5jIGIvbmV0L2JsdWV0b290aC9zY28uYwppbmRl
eCBhNWFjMTYwYzU5MmUuLjFjNzI1MmEzNjg2NiAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9z
Y28uYworKysgYi9uZXQvYmx1ZXRvb3RoL3Njby5jCkBAIC03Niw2ICs3NiwxNiBAQCBzdHJ1Y3Qg
c2NvX3BpbmZvIHsKICNkZWZpbmUgU0NPX0NPTk5fVElNRU9VVAkoSFogKiA0MCkKICNkZWZpbmUg
U0NPX0RJU0NPTk5fVElNRU9VVAkoSFogKiAyKQogCitzdGF0aWMgc3RydWN0IHNvY2sgKnNjb19z
b2NrX2hvbGQoc3RydWN0IHNjb19jb25uICpjb25uKQoreworCWlmICghY29ubiB8fCAhYnRfc29j
a19saW5rZWQoJnNjb19za19saXN0LCBjb25uLT5zaykpCisJCXJldHVybiBOVUxMOworCisJc29j
a19ob2xkKGNvbm4tPnNrKTsKKworCXJldHVybiBjb25uLT5zazsKK30KKwogc3RhdGljIHZvaWQg
c2NvX3NvY2tfdGltZW91dChzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiB7CiAJc3RydWN0IHNj
b19jb25uICpjb25uID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCBzY29fY29ubiwKQEAgLTg3
LDkgKzk3LDcgQEAgc3RhdGljIHZvaWQgc2NvX3NvY2tfdGltZW91dChzdHJ1Y3Qgd29ya19zdHJ1
Y3QgKndvcmspCiAJCXNjb19jb25uX3VubG9jayhjb25uKTsKIAkJcmV0dXJuOwogCX0KLQlzayA9
IGNvbm4tPnNrOwotCWlmIChzaykKLQkJc29ja19ob2xkKHNrKTsKKwlzayA9IHNjb19zb2NrX2hv
bGQoY29ubik7CiAJc2NvX2Nvbm5fdW5sb2NrKGNvbm4pOwogCiAJaWYgKCFzaykKQEAgLTE5NCw5
ICsyMDIsNyBAQCBzdGF0aWMgdm9pZCBzY29fY29ubl9kZWwoc3RydWN0IGhjaV9jb25uICpoY29u
LCBpbnQgZXJyKQogCiAJLyogS2lsbCBzb2NrZXQgKi8KIAlzY29fY29ubl9sb2NrKGNvbm4pOwot
CXNrID0gY29ubi0+c2s7Ci0JaWYgKHNrKQotCQlzb2NrX2hvbGQoc2spOworCXNrID0gc2NvX3Nv
Y2tfaG9sZChjb25uKTsKIAlzY29fY29ubl91bmxvY2soY29ubik7CiAKIAlpZiAoc2spIHsKLS0g
CjIuNDcuMAoK
--000000000000507dd3062515a730--
