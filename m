Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B11DD532
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Oct 2024 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321396; cv=none; b=cPcHyrIkZ6kAXRttrF8HP7Dc2j6Tt2tHl9FglHv96VMaNxNNTuq25ElUDel8IS4PBvMlvd+kuh2GEXVJGUkYl9EJx8Iurtwz11A3IyliiB9gLxlY3ZvIXTrA1GpFzeqY6qJZ3omCJQYhJg/IuQ9Yd6sebcFnS5eQEW5NC6iMXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321396; c=relaxed/simple;
	bh=4KQP4LMQxVP/GeqJgiDLFNMJG9wfQRhKbYw/gTDh4K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxduX0J/e8TfnAXI1HTX9US4RvTywB38PoTOfxEIz1LIoVZkARmsAXd3a2B9mlTQUb0QrbkZvs+RmCJLnmuz3RgwIkW1ShSf7dBfJ/GQ/HNetI2Fpwq/r2Y2SuJ0I/NDyKuBfmkWLPL4c/bMP/cfyPoJxAYI0oSwXvPr0AhNjzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEGO6EQD; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEGO6EQD"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2facf481587so39571031fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Oct 2024 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728321392; x=1728926192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ttB37CQ3ARRvxpQiEAPPdzSYOC7aVziL1l/8DwwF/w0=;
        b=BEGO6EQDBYO847ZBVhv1fgr0NFZO7Yc13cMtbynMY+Qwdp28Pur2oTMqU3DoTyMg1U
         LklJhvEgB5cjC6S1lzW4ZLt2165rGjBlHcmcZjfb4rztYDEP3yS0xnNvMP5O1xesp6SN
         sYwfgulNROtmH1dI9ODvbnM9VyA0GpaIJV/LTg5wI9W2RHvecy/IzaYOIATMSxu7jYL8
         Dm7JyKz4KnANeXY6YdpSZqWXTHyrNXqjeuh1ondrVhv1DrYo1mKrfu7Ma4r82LCE/Rph
         MWwacEc923mTFUeCaFo2IwZ7HBifuLrGPElZBgHG9h4reun6x3cKqss9BTF1wJ85BcvE
         SyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728321392; x=1728926192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttB37CQ3ARRvxpQiEAPPdzSYOC7aVziL1l/8DwwF/w0=;
        b=H+z8OzljlS2pCpsyAh1v8CuLd3QbN1xq3dxW1/UOvCLr0rLF9kgr7B7gZYKhlNAi08
         /DcsPNpwT+VNFrFGrDve7vHnMaE7godsg8XPvjBvQEDunNq5scFxmADUL+0U0DRgrdsH
         VO8fWsFpi8rFLrLTaSOV8QicAqbArazqlq/jt6W4JZo10ahv4IF2cmnz+24jQUEzwAVw
         rS6B/T67jNZn4bUujMbSZU0y1MqKvwY8qeglC1iJ3WWKar2nj+wr14FnHNdMijm3xAPz
         LiBfEd+mNYN3eqchdU6gSJOda8lbQS5kaAwPTF9qw3ko5TerXh+rGBEpp7oky4iQCMrR
         Y5Tw==
X-Gm-Message-State: AOJu0YxAhS1hpZns30vmZAKDY0akNlg4eC86RivSPsfhbouogPBi2Ckh
	GUSQuTxAkckC94xADq/pbT1L53qYaxKvB8Ij8xfpNiEf9Fcy0bRLVGzfAHN4Fc0IEq/MNUA15jg
	/h94f8f8CEsMkMQMgKA1rBzxYvNWMlQ==
X-Google-Smtp-Source: AGHT+IHfeRcWcRFu7rKa51Ndiui26cywYiWl2aHeggo6seS75se8yKDFdiOnTk9WHqQFMFCF4wiC4Wikwq5z7r2wV0w=
X-Received: by 2002:a2e:819:0:b0:2fb:c20:dbc4 with SMTP id 38308e7fff4ca-2fb0c20dc3bmr10019731fa.27.1728321391801;
 Mon, 07 Oct 2024 10:16:31 -0700 (PDT)
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
 <CABBYNZ+i88jmqD3pV2Czh=7fBhZ0_73s1+tsumt0+oVo8kSm1w@mail.gmail.com> <CABBYNZLfELHraPs15x1PYhBUQrd_OQTnef00Y+5nm0w7US2_Wg@mail.gmail.com>
In-Reply-To: <CABBYNZLfELHraPs15x1PYhBUQrd_OQTnef00Y+5nm0w7US2_Wg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 7 Oct 2024 13:16:19 -0400
Message-ID: <CABBYNZ+XB+hAN7BmOQiKpdBBHXX_8JrDm3HpXJ=JKVBg8R1CGA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: SCO: Use disable_delayed_work_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="0000000000009dd40e0623e62e35"

--0000000000009dd40e0623e62e35
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Fri, Oct 4, 2024 at 1:24=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Fri, Oct 4, 2024 at 12:06=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Thu, Oct 3, 2024 at 3:21=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Thu, Oct 3, 2024 at 12:32=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > #syz test
> > > >
> > > > On Thu, Oct 3, 2024 at 11:38=E2=80=AFAM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > #syz test
> > > > >
> > > > > On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > #syz test
> > > > > >
> > > > > > On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > #syz test
> > > > > > >
> > > > > > > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > #syz test
> > > > > > > >
> > > > > > > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Den=
tz
> > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > > > >
> > > > > > > > > This makes use of disable_delayed_work_sync instead
> > > > > > > > > cancel_delayed_work_sync as it not only cancel the ongoin=
g work but also
> > > > > > > > > disables new submit which is disarable since the object h=
olding the work
> > > > > > > > > is about to be freed.
> > > > > > > > >
> > > > > > > > > In addition to it remove call to sco_sock_set_timer on __=
sco_sock_close
> > > > > > > > > since at that point it is useless to set a timer as the s=
k will be freed
> > > > > > > > > there is nothing to be done in sco_sock_timeout.
> > > > > > > > >
> > > > > > > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspo=
tmail.com
> > > > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4=
cde787116d465
> > > > > > > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts wi=
th delayed_work")
> > > > > > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@int=
el.com>
> > > > > > > > > ---
> > > > > > > > >  net/bluetooth/sco.c | 13 +------------
> > > > > > > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > > > > > > index a5ac160c592e..2b1e66976068 100644
> > > > > > > > > --- a/net/bluetooth/sco.c
> > > > > > > > > +++ b/net/bluetooth/sco.c
> > > > > > > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_c=
onn *hcon, int err)
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > >         /* Ensure no more work items will run before free=
ing conn. */
> > > > > > > > > -       cancel_delayed_work_sync(&conn->timeout_work);
> > > > > > > > > +       disable_delayed_work_sync(&conn->timeout_work);
> > > > > > > > >
> > > > > > > > >         hcon->sco_data =3D NULL;
> > > > > > > > >         kfree(conn);
> > > > > > > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(struct =
sock *sk)
> > > > > > > > >
> > > > > > > > >         case BT_CONNECTED:
> > > > > > > > >         case BT_CONFIG:
> > > > > > > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > > > > > > -                       sk->sk_state =3D BT_DISCONN;
> > > > > > > > > -                       sco_sock_set_timer(sk, SCO_DISCON=
N_TIMEOUT);
> > > > > > > > > -                       sco_conn_lock(sco_pi(sk)->conn);
> > > > > > > > > -                       hci_conn_drop(sco_pi(sk)->conn->h=
con);
> > > > > > > > > -                       sco_pi(sk)->conn->hcon =3D NULL;
> > > > > > > > > -                       sco_conn_unlock(sco_pi(sk)->conn)=
;
> > > > > > > > > -               } else
> > > > > > > > > -                       sco_chan_del(sk, ECONNRESET);
> > > > > > > > > -               break;
> > > > > > > > > -
> > > > > > > > >         case BT_CONNECT2:
> > > > > > > > >         case BT_CONNECT:
> > > > > > > > >         case BT_DISCONN:
> > > > > > > > > --
> > > > > > > > > 2.46.1
> > > > > > > > >
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

--0000000000009dd40e0623e62e35
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v4-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Disposition: attachment; 
	filename="v4-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1z9wyuq0>
X-Attachment-Id: f_m1z9wyuq0

RnJvbSBhZjIzNmI1OGEzYmNiMjVhYTE1ZDFmY2M5NzdmZGJlOWFkMjY1Y2RmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFR1ZSwgMSBPY3QgMjAyNCAxNTo0NjoxMCAtMDQwMApTdWJqZWN0
OiBbUEFUQ0ggdjQgMS8yXSBCbHVldG9vdGg6IFNDTzogVXNlIGRpc2FibGVfZGVsYXllZF93b3Jr
X3N5bmMKClRoaXMgbWFrZXMgdXNlIG9mIGRpc2FibGVfZGVsYXllZF93b3JrX3N5bmMgaW5zdGVh
ZApjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMgYXMgaXQgbm90IG9ubHkgY2FuY2VsIHRoZSBvbmdv
aW5nIHdvcmsgYnV0IGFsc28KZGlzYWJsZXMgbmV3IHN1Ym1pdCB3aGljaCBpcyBkaXNhcmFibGUg
c2luY2UgdGhlIG9iamVjdCBob2xkaW5nIHRoZSB3b3JrCmlzIGFib3V0IHRvIGJlIGZyZWVkLgoK
SW4gYWRkaXRpb24gdG8gaXQgcmVtb3ZlIGNhbGwgdG8gc2NvX3NvY2tfc2V0X3RpbWVyIG9uIF9f
c2NvX3NvY2tfY2xvc2UKc2luY2UgYXQgdGhhdCBwb2ludCBpdCBpcyB1c2VsZXNzIHRvIHNldCBh
IHRpbWVyIGFzIHRoZSBzayB3aWxsIGJlIGZyZWVkCnRoZXJlIGlzIG5vdGhpbmcgdG8gYmUgZG9u
ZSBpbiBzY29fc29ja190aW1lb3V0LgoKUmVwb3J0ZWQtYnk6IHN5emJvdCs0YzBkMGM0Y2RlNzg3
MTE2ZDQ2NUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9zeXprYWxs
ZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTRjMGQwYzRjZGU3ODcxMTZkNDY1CkZpeGVzOiBiYTMx
NmJlMWI2YTAgKCJCbHVldG9vdGg6IHNjaGVkdWxlIFNDTyB0aW1lb3V0cyB3aXRoIGRlbGF5ZWRf
d29yayIpClNpZ25lZC1vZmYtYnk6IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXoudm9uLmRl
bnR6QGludGVsLmNvbT4KLS0tCiBuZXQvYmx1ZXRvb3RoL3Njby5jIHwgODUgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNTMgaW5z
ZXJ0aW9ucygrKSwgMzIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9z
Y28uYyBiL25ldC9ibHVldG9vdGgvc2NvLmMKaW5kZXggYTVhYzE2MGM1OTJlLi5mYWI2OGNiNjAz
NzEgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvc2NvLmMKKysrIGIvbmV0L2JsdWV0b290aC9z
Y28uYwpAQCAtMTU1LDYgKzE1NSw0NiBAQCBzdGF0aWMgc3RydWN0IHNjb19jb25uICpzY29fY29u
bl9hZGQoc3RydWN0IGhjaV9jb25uICpoY29uKQogCXJldHVybiBjb25uOwogfQogCitzdGF0aWMg
dm9pZCBzY29fY29ubl9kcm9wKHN0cnVjdCBzY29fY29ubiAqY29ubikKK3sKKwlpZiAoIWNvbm4g
fHwgKCFjb25uLT5oY29uICYmICFjb25uLT5zaykpCisJCXJldHVybjsKKworCUJUX0RCRygiY29u
biAlcCBoY29uICVwIiwgY29ubiwgY29ubi0+aGNvbik7CisKKwlzY29fY29ubl9sb2NrKGNvbm4p
OworCisJaWYgKGNvbm4tPnNrKSB7CisJCXNjb19waShjb25uLT5zayktPmNvbm4gPSBOVUxMOwor
CQljb25uLT5zayA9IE5VTEw7CisJfQorCisJaWYgKGNvbm4tPmhjb24pIHsKKwkJc3RydWN0IGhj
aV9jb25uICpoY29uID0gY29ubi0+aGNvbjsKKworCQljb25uLT5oY29uLT5zY29fZGF0YSA9IE5V
TEw7CisJCWNvbm4tPmhjb24gPSBOVUxMOworCQloY2lfY29ubl9kcm9wKGhjb24pOworCX0KKwor
CXNjb19jb25uX3VubG9jayhjb25uKTsKKworCS8qIEVuc3VyZSBubyBtb3JlIHdvcmsgaXRlbXMg
d2lsbCBydW4gc2luY2UgaGNpX2Nvbm4gaGFzIGJlZW4gZHJvcHBlZCAqLworCWRpc2FibGVfZGVs
YXllZF93b3JrX3N5bmMoJmNvbm4tPnRpbWVvdXRfd29yayk7Cit9CisKK3N0YXRpYyB2b2lkIHNj
b19jb25uX2Rlc3RydWN0KHN0cnVjdCBzY29fY29ubiAqY29ubikKK3sKKwlpZiAoIWNvbm4pCisJ
CXJldHVybjsKKworCUJUX0RCRygiY29ubiAlcCIsIGNvbm4pOworCisJc2NvX2Nvbm5fZHJvcChj
b25uKTsKKworCWtmcmVlKGNvbm4pOworfQorCiAvKiBEZWxldGUgY2hhbm5lbC4KICAqIE11c3Qg
YmUgY2FsbGVkIG9uIHRoZSBsb2NrZWQgc29ja2V0LiAqLwogc3RhdGljIHZvaWQgc2NvX2NoYW5f
ZGVsKHN0cnVjdCBzb2NrICpzaywgaW50IGVycikKQEAgLTE2NSwxNSArMjA1LDggQEAgc3RhdGlj
IHZvaWQgc2NvX2NoYW5fZGVsKHN0cnVjdCBzb2NrICpzaywgaW50IGVycikKIAogCUJUX0RCRygi
c2sgJXAsIGNvbm4gJXAsIGVyciAlZCIsIHNrLCBjb25uLCBlcnIpOwogCi0JaWYgKGNvbm4pIHsK
LQkJc2NvX2Nvbm5fbG9jayhjb25uKTsKLQkJY29ubi0+c2sgPSBOVUxMOwotCQlzY29fcGkoc2sp
LT5jb25uID0gTlVMTDsKLQkJc2NvX2Nvbm5fdW5sb2NrKGNvbm4pOwotCi0JCWlmIChjb25uLT5o
Y29uKQotCQkJaGNpX2Nvbm5fZHJvcChjb25uLT5oY29uKTsKLQl9CisJaWYgKGNvbm4pCisJCXNj
b19jb25uX2Ryb3AoY29ubik7CiAKIAlzay0+c2tfc3RhdGUgPSBCVF9DTE9TRUQ7CiAJc2stPnNr
X2VyciAgID0gZXJyOwpAQCAtMTkyLDI2ICsyMjUsMjMgQEAgc3RhdGljIHZvaWQgc2NvX2Nvbm5f
ZGVsKHN0cnVjdCBoY2lfY29ubiAqaGNvbiwgaW50IGVycikKIAogCUJUX0RCRygiaGNvbiAlcCBj
b25uICVwLCBlcnIgJWQiLCBoY29uLCBjb25uLCBlcnIpOwogCi0JLyogS2lsbCBzb2NrZXQgKi8K
IAlzY29fY29ubl9sb2NrKGNvbm4pOwogCXNrID0gY29ubi0+c2s7CiAJaWYgKHNrKQogCQlzb2Nr
X2hvbGQoc2spOwogCXNjb19jb25uX3VubG9jayhjb25uKTsKIAotCWlmIChzaykgewotCQlsb2Nr
X3NvY2soc2spOwotCQlzY29fc29ja19jbGVhcl90aW1lcihzayk7Ci0JCXNjb19jaGFuX2RlbChz
aywgZXJyKTsKLQkJcmVsZWFzZV9zb2NrKHNrKTsKLQkJc29ja19wdXQoc2spOworCWlmICghc2sp
IHsKKwkJc2NvX2Nvbm5fZGVzdHJ1Y3QoY29ubik7CisJCXJldHVybjsKIAl9CiAKLQkvKiBFbnN1
cmUgbm8gbW9yZSB3b3JrIGl0ZW1zIHdpbGwgcnVuIGJlZm9yZSBmcmVlaW5nIGNvbm4uICovCi0J
Y2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZjb25uLT50aW1lb3V0X3dvcmspOwotCi0JaGNvbi0+
c2NvX2RhdGEgPSBOVUxMOwotCWtmcmVlKGNvbm4pOworCS8qIEtpbGwgc29ja2V0ICovCisJbG9j
a19zb2NrKHNrKTsKKwlzY29fc29ja19jbGVhcl90aW1lcihzayk7CisJc2NvX2NoYW5fZGVsKHNr
LCBlcnIpOworCXJlbGVhc2Vfc29jayhzayk7CisJc29ja19wdXQoc2spOwogfQogCiBzdGF0aWMg
dm9pZCBfX3Njb19jaGFuX2FkZChzdHJ1Y3Qgc2NvX2Nvbm4gKmNvbm4sIHN0cnVjdCBzb2NrICpz
aywKQEAgLTM5NSw2ICs0MjUsOCBAQCBzdGF0aWMgdm9pZCBzY29fc29ja19kZXN0cnVjdChzdHJ1
Y3Qgc29jayAqc2spCiB7CiAJQlRfREJHKCJzayAlcCIsIHNrKTsKIAorCXNjb19jb25uX2Rlc3Ry
dWN0KHNjb19waShzayktPmNvbm4pOworCiAJc2tiX3F1ZXVlX3B1cmdlKCZzay0+c2tfcmVjZWl2
ZV9xdWV1ZSk7CiAJc2tiX3F1ZXVlX3B1cmdlKCZzay0+c2tfd3JpdGVfcXVldWUpOwogfQpAQCAt
NDQyLDE3ICs0NzQsNiBAQCBzdGF0aWMgdm9pZCBfX3Njb19zb2NrX2Nsb3NlKHN0cnVjdCBzb2Nr
ICpzaykKIAogCWNhc2UgQlRfQ09OTkVDVEVEOgogCWNhc2UgQlRfQ09ORklHOgotCQlpZiAoc2Nv
X3BpKHNrKS0+Y29ubi0+aGNvbikgewotCQkJc2stPnNrX3N0YXRlID0gQlRfRElTQ09OTjsKLQkJ
CXNjb19zb2NrX3NldF90aW1lcihzaywgU0NPX0RJU0NPTk5fVElNRU9VVCk7Ci0JCQlzY29fY29u
bl9sb2NrKHNjb19waShzayktPmNvbm4pOwotCQkJaGNpX2Nvbm5fZHJvcChzY29fcGkoc2spLT5j
b25uLT5oY29uKTsKLQkJCXNjb19waShzayktPmNvbm4tPmhjb24gPSBOVUxMOwotCQkJc2NvX2Nv
bm5fdW5sb2NrKHNjb19waShzayktPmNvbm4pOwotCQl9IGVsc2UKLQkJCXNjb19jaGFuX2RlbChz
aywgRUNPTk5SRVNFVCk7Ci0JCWJyZWFrOwotCiAJY2FzZSBCVF9DT05ORUNUMjoKIAljYXNlIEJU
X0NPTk5FQ1Q6CiAJY2FzZSBCVF9ESVNDT05OOgotLSAKMi40Ni4xCgo=
--0000000000009dd40e0623e62e35--
