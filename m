Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5711D0BA2
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Oct 2024 19:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898426; cv=none; b=faJg0MjuZ+9OPOU5K0XLANJbePpiQ8E80jUzDagn5NVodzI4DIbMM3yC1Nc60Zzfh9o/Mq5wc7pJV6r2TEfWVzmYOtzq391KOmY7gzOjbnocwoZ0VWze6PQJtuDkwNxOYAeTBq0t7FuODrCeRLTOHWPXfnLz/O8NQx+y//gAMwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898426; c=relaxed/simple;
	bh=h/X0GvZdTUTymwyzeZuSg5j8TAR1inlhxY8lgX9QnMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWagUAeOa1wfVff6NmpMwMM1jny32OTkEheFdrnkGrv5dMCDgLphIDdwq6bhCCkb9FKtdMsuM6CVqAsuv9q7etJJntCI+LEvSVgBWhhdiRTzcWcl9vXww2AD2EwGVGHRFE/ZLFT98o9uyf9Lj7AGITmM3Ta99nNlBT3AeJ8nNAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+eapgag; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+eapgag"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fac3f1287bso2037451fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Oct 2024 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727898422; x=1728503222; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PGWP10b/Vu/zPh6nzCSbxKHvP8ZSGn0i7l8EVyDOHMk=;
        b=b+eapgagHKyJfLPsaPHzrpP6tuuEmSz/P+tM/mCg6x62LvF7ivjPDaPcJG4lxB+MkW
         8wqaitj4EKF2cmW0HTMr2OV7NnAqTLU6zB4GfOhL88wQ+RUOOTcnv2rZp4AwSlhAJ+TO
         PxHhBwKEcEy0OVgIIGYqIor3aD4T7OtbQ3WQJVugKEuqRrsQEzQ76J1Xd96xz0LkXnol
         8UOl+Rsen7kcqFDPVBoHrSblhEx3oTxlYgrDLOVs3cd2Y/JUnLQtRhHMUd8PJkBZsXr3
         Gk7uYEQXpFR+/pJUEgEPfSZAp5p+ijvbZBfmKm62ILNs7ssEVnDz2CxGW/xSZa79cZ/5
         z6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727898422; x=1728503222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGWP10b/Vu/zPh6nzCSbxKHvP8ZSGn0i7l8EVyDOHMk=;
        b=qDJUo+Vffni7usd8538dGf1zcXHotFBi+qCkMFf3MI5QU8DWqU334rg6Nm+DkboPAQ
         JfVGbDidCgy1mhOpqUvp+qrdEnX/zaF97sdz2wI6vufYbpu87U4DOt7NhO5WjWJ7auMR
         FdgP8XFif5+MwjMWATGv6g81ICbk+wD2p03oZRXyHFM2PLXiwxjQRwCPHjdjjdTIwLpo
         q+x93dUvh2GEJPnCC0Y4FtjNo1PrUk3d+37r3L94WODdJn9bOhmygFTX8lr2aVfTYyWG
         ciViJsarsWlY0utNDUNk6pVjDF5KjZAdTVulv0soLmc8dYKEuTdIYlp/lZaFz/Acug60
         KIwA==
X-Gm-Message-State: AOJu0YyK+kCPRu+2eHYwZ5bay11hsfVHnXUVtFRUmL4Ui3YgJ89dmriX
	r1uNgdS00Ykl8uiPr4zCtsOttbFjPteaLaw4TEcFrMN9rXn3Zvydlr110gl2dKR83yHXpWyQgBf
	KjJSn+2a/6jb531ZCwr9RBr3Qvj0i7A==
X-Google-Smtp-Source: AGHT+IFc3zcOWNS3wVhv/dZdWz0cIQPS9iazcfLKb1xFNNydNzp3XBlQ8y6+KrCjfUBX6F1zMvKip2GiUwHLZeD9CAU=
X-Received: by 2002:a05:651c:150a:b0:2fa:d7bf:6f43 with SMTP id
 38308e7fff4ca-2fae1036621mr25305871fa.27.1727898421531; Wed, 02 Oct 2024
 12:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002190452.3405592-1-luiz.dentz@gmail.com> <CABBYNZKqrja__qdidRwqXh9wcJJ6YdGqdh4bejU5HsL02qcFpw@mail.gmail.com>
In-Reply-To: <CABBYNZKqrja__qdidRwqXh9wcJJ6YdGqdh4bejU5HsL02qcFpw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Oct 2024 15:46:48 -0400
Message-ID: <CABBYNZLoh-K2QLinNwJrbQgSccTKW37C2wt5+AmM272Du3p81A@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: SCO: Use disable_delayed_work_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="0000000000009fbdf5062383b3b8"

--0000000000009fbdf5062383b3b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This makes use of disable_delayed_work_sync instead
> > cancel_delayed_work_sync as it not only cancel the ongoing work but als=
o
> > disables new submit which is disarable since the object holding the wor=
k
> > is about to be freed.
> >
> > In addition to it remove call to sco_sock_set_timer on __sco_sock_close
> > since at that point it is useless to set a timer as the sk will be free=
d
> > there is nothing to be done in sco_sock_timeout.
> >
> > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde787116d465
> > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_wor=
k")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/sco.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> >
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > index a5ac160c592e..2b1e66976068 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *hcon, int=
 err)
> >         }
> >
> >         /* Ensure no more work items will run before freeing conn. */
> > -       cancel_delayed_work_sync(&conn->timeout_work);
> > +       disable_delayed_work_sync(&conn->timeout_work);
> >
> >         hcon->sco_data =3D NULL;
> >         kfree(conn);
> > @@ -442,17 +442,6 @@ static void __sco_sock_close(struct sock *sk)
> >
> >         case BT_CONNECTED:
> >         case BT_CONFIG:
> > -               if (sco_pi(sk)->conn->hcon) {
> > -                       sk->sk_state =3D BT_DISCONN;
> > -                       sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
> > -                       sco_conn_lock(sco_pi(sk)->conn);
> > -                       hci_conn_drop(sco_pi(sk)->conn->hcon);
> > -                       sco_pi(sk)->conn->hcon =3D NULL;
> > -                       sco_conn_unlock(sco_pi(sk)->conn);
> > -               } else
> > -                       sco_chan_del(sk, ECONNRESET);
> > -               break;
> > -
> >         case BT_CONNECT2:
> >         case BT_CONNECT:
> >         case BT_DISCONN:
> > --
> > 2.46.1
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

--0000000000009fbdf5062383b3b8
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v3-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Disposition: attachment; 
	filename="v3-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1sa3feg0>
X-Attachment-Id: f_m1sa3feg0

RnJvbSAwZDg5MDkwMzBjMmQ4Mjk2N2VmYzkzYTAwOGI5MjYxMGEzZDc3YjBkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFR1ZSwgMSBPY3QgMjAyNCAxNTo0NjoxMCAtMDQwMApTdWJqZWN0
OiBbUEFUQ0ggdjNdIEJsdWV0b290aDogU0NPOiBVc2UgZGlzYWJsZV9kZWxheWVkX3dvcmtfc3lu
YwoKVGhpcyBtYWtlcyB1c2Ugb2YgZGlzYWJsZV9kZWxheWVkX3dvcmtfc3luYyBpbnN0ZWFkCmNh
bmNlbF9kZWxheWVkX3dvcmtfc3luYyBhcyBpdCBub3Qgb25seSBjYW5jZWwgdGhlIG9uZ29pbmcg
d29yayBidXQgYWxzbwpkaXNhYmxlcyBuZXcgc3VibWl0IHdoaWNoIGlzIGRpc2FyYWJsZSBzaW5j
ZSB0aGUgb2JqZWN0IGhvbGRpbmcgdGhlIHdvcmsKaXMgYWJvdXQgdG8gYmUgZnJlZWQuCgpJbiBh
ZGRpdGlvbiB0byBpdCByZW1vdmUgY2FsbCB0byBzY29fc29ja19zZXRfdGltZXIgb24gX19zY29f
c29ja19jbG9zZQpzaW5jZSBhdCB0aGF0IHBvaW50IGl0IGlzIHVzZWxlc3MgdG8gc2V0IGEgdGlt
ZXIgYXMgdGhlIHNrIHdpbGwgYmUgZnJlZWQKdGhlcmUgaXMgbm90aGluZyB0byBiZSBkb25lIGlu
IHNjb19zb2NrX3RpbWVvdXQuCgpSZXBvcnRlZC1ieTogc3l6Ym90KzRjMGQwYzRjZGU3ODcxMTZk
NDY1QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KQ2xvc2VzOiBodHRwczovL3N5emthbGxlci5h
cHBzcG90LmNvbS9idWc/ZXh0aWQ9NGMwZDBjNGNkZTc4NzExNmQ0NjUKRml4ZXM6IGJhMzE2YmUx
YjZhMCAoIkJsdWV0b290aDogc2NoZWR1bGUgU0NPIHRpbWVvdXRzIHdpdGggZGVsYXllZF93b3Jr
IikKU2lnbmVkLW9mZi1ieTogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei52b24uZGVudHpA
aW50ZWwuY29tPgotLS0KIG5ldC9ibHVldG9vdGgvc2NvLmMgfCAxMyArLS0tLS0tLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL25ldC9ibHVldG9vdGgvc2NvLmMgYi9uZXQvYmx1ZXRvb3RoL3Njby5jCmluZGV4IGE1YWMx
NjBjNTkyZS4uMmIxZTY2OTc2MDY4IDEwMDY0NAotLS0gYS9uZXQvYmx1ZXRvb3RoL3Njby5jCisr
KyBiL25ldC9ibHVldG9vdGgvc2NvLmMKQEAgLTIwOCw3ICsyMDgsNyBAQCBzdGF0aWMgdm9pZCBz
Y29fY29ubl9kZWwoc3RydWN0IGhjaV9jb25uICpoY29uLCBpbnQgZXJyKQogCX0KIAogCS8qIEVu
c3VyZSBubyBtb3JlIHdvcmsgaXRlbXMgd2lsbCBydW4gYmVmb3JlIGZyZWVpbmcgY29ubi4gKi8K
LQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmNvbm4tPnRpbWVvdXRfd29yayk7CisJZGlzYWJs
ZV9kZWxheWVkX3dvcmtfc3luYygmY29ubi0+dGltZW91dF93b3JrKTsKIAogCWhjb24tPnNjb19k
YXRhID0gTlVMTDsKIAlrZnJlZShjb25uKTsKQEAgLTQ0MiwxNyArNDQyLDYgQEAgc3RhdGljIHZv
aWQgX19zY29fc29ja19jbG9zZShzdHJ1Y3Qgc29jayAqc2spCiAKIAljYXNlIEJUX0NPTk5FQ1RF
RDoKIAljYXNlIEJUX0NPTkZJRzoKLQkJaWYgKHNjb19waShzayktPmNvbm4tPmhjb24pIHsKLQkJ
CXNrLT5za19zdGF0ZSA9IEJUX0RJU0NPTk47Ci0JCQlzY29fc29ja19zZXRfdGltZXIoc2ssIFND
T19ESVNDT05OX1RJTUVPVVQpOwotCQkJc2NvX2Nvbm5fbG9jayhzY29fcGkoc2spLT5jb25uKTsK
LQkJCWhjaV9jb25uX2Ryb3Aoc2NvX3BpKHNrKS0+Y29ubi0+aGNvbik7Ci0JCQlzY29fcGkoc2sp
LT5jb25uLT5oY29uID0gTlVMTDsKLQkJCXNjb19jb25uX3VubG9jayhzY29fcGkoc2spLT5jb25u
KTsKLQkJfSBlbHNlCi0JCQlzY29fY2hhbl9kZWwoc2ssIEVDT05OUkVTRVQpOwotCQlicmVhazsK
LQogCWNhc2UgQlRfQ09OTkVDVDI6CiAJY2FzZSBCVF9DT05ORUNUOgogCWNhc2UgQlRfRElTQ09O
TjoKLS0gCjIuNDYuMQoK
--0000000000009fbdf5062383b3b8--
