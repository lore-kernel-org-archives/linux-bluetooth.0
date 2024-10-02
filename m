Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667B21730E
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Oct 2024 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902017; cv=none; b=Tnq4mHLUY0fMqjnZ3zDFKCkERZY0SCM2gew4BjkqD2gOLZwML4g8JwBgrcOmH1l2iDe1L+d6QJug8XRY3V34dkTHBdhgOf/hJW1LYIgR7+7FRJSo1BZzrwmhPUnz6TtctxHft0FEIn02LxXtsI4K0abN6krkZeW21XIAxT+RnyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902017; c=relaxed/simple;
	bh=sXkopTABTgrmZNJK5MvngEooy6oh/WwM5ad46iKyxWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DV+9YpCJG2PdqMoD1RvI9b3Ui3zEcbJ9FwcUSsZtp/QlRxTNhQtazbHOZ+N6uS6TfkYwUw5JFhXqFByu2HEr4Q5iQqg638ESk2n7L5YSBgixRypGqOKx6ZSIk2zPuNrO+JoZbWGtFE+4BItJtI8so3g94UJtb47PhH6we/ax3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hw50t97Y; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw50t97Y"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso2475751fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Oct 2024 13:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727902013; x=1728506813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HLU5piaOwj/zQoerTkWI+1qEpTJD0hz3gFbERQmNUyY=;
        b=hw50t97Y++sk5DD0gI3o+R60k5aIly1956qYTu2BiwYt4MUJk2FRimXrNBTDff54pR
         7Vz8q4fLayNxWklvP5nWulT8aVU1fDd2Kn7UVAf8beRGSftgJLC8iw9nbUNpSY9Gwl88
         p//UyJWsfkbhuGLBhme+q1We5zdXZ37MVEhfAA7sAppRBg5H34qA8HNAoxlZ68Qww+Ld
         z5218pCU4vcCxnjOKUZo+BJRyudBKN+ANiFofDBYmheMy9Q8wpZNH46phZnm8OhZL/hw
         jXNf5xvUG0CHPrcwYFd8SGoNMN+YvxXfXWhwvcUGPnZD4Wwozr798iSf+J8E3oa/vmd2
         Brzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727902013; x=1728506813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLU5piaOwj/zQoerTkWI+1qEpTJD0hz3gFbERQmNUyY=;
        b=j2U0h1nF2rKQA7xpwa5ApXiGgJJVrvCZp3m4kKmuVS2ZGVIp7AGmYCFhzu+ox5xYDM
         UmJLtaDu9NHLDOs/sXiZyTXixNyaUlUEpqQgTg3YW6iqlBlsWAUKAwi6KuLXHErVXG/o
         yaFqtmwdrXRV5yphThDiH/nHl7xzDuzO5AnN/rKLwyMKOSJUfYAnof3+ureXYCcj2fP7
         2YfH0mlJSKGaODqjE3IwD3p3f4eqeDlSDdoL83I1+AE94WBRCTdxtp4/bcLk6aIIybkG
         l3xgjSBLJw6YrPagnN1J7c5T1TDBpc/uMrPt3k8O0r/UK2H+TQTiB/zhwJFiDME4gv+v
         MwaA==
X-Gm-Message-State: AOJu0Yx4CS44sX4k4PHKoABLGArWPzvIA8mxrqfZaT9cPkt4SX9CY038
	UJrzM4pIw2NMsAS472uwFiaHR0pPfdg2+f3sJ+YGuYGqlnkk8e4Zy543ckR4V1NkKI+RZYyGfL9
	qu0+cayUqSfBBUDOgDZ8ft7nU5CuRAA==
X-Google-Smtp-Source: AGHT+IFwUF0pvc6zTXvS0VpjjQnYxaRXp/ZxeKnKd4Ohm0U7XMzQbR8d/g6FNXghoPIapMHAxo79xwCqUVShPgMBfZc=
X-Received: by 2002:a05:651c:2206:b0:2fa:e4d0:eb4f with SMTP id
 38308e7fff4ca-2fae4d0eca3mr19544541fa.4.1727902012870; Wed, 02 Oct 2024
 13:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002190452.3405592-1-luiz.dentz@gmail.com>
 <CABBYNZKqrja__qdidRwqXh9wcJJ6YdGqdh4bejU5HsL02qcFpw@mail.gmail.com> <CABBYNZLoh-K2QLinNwJrbQgSccTKW37C2wt5+AmM272Du3p81A@mail.gmail.com>
In-Reply-To: <CABBYNZLoh-K2QLinNwJrbQgSccTKW37C2wt5+AmM272Du3p81A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Oct 2024 16:46:40 -0400
Message-ID: <CABBYNZLeWWtX9PdNarFajZynUSsyrd4mavExPXzY2GUf_ZzECw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: SCO: Use disable_delayed_work_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="000000000000af3d2c06238489f3"

--000000000000af3d2c06238489f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > This makes use of disable_delayed_work_sync instead
> > > cancel_delayed_work_sync as it not only cancel the ongoing work but a=
lso
> > > disables new submit which is disarable since the object holding the w=
ork
> > > is about to be freed.
> > >
> > > In addition to it remove call to sco_sock_set_timer on __sco_sock_clo=
se
> > > since at that point it is useless to set a timer as the sk will be fr=
eed
> > > there is nothing to be done in sco_sock_timeout.
> > >
> > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde787116d46=
5
> > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_w=
ork")
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > ---
> > >  net/bluetooth/sco.c | 13 +------------
> > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > >
> > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > index a5ac160c592e..2b1e66976068 100644
> > > --- a/net/bluetooth/sco.c
> > > +++ b/net/bluetooth/sco.c
> > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *hcon, i=
nt err)
> > >         }
> > >
> > >         /* Ensure no more work items will run before freeing conn. */
> > > -       cancel_delayed_work_sync(&conn->timeout_work);
> > > +       disable_delayed_work_sync(&conn->timeout_work);
> > >
> > >         hcon->sco_data =3D NULL;
> > >         kfree(conn);
> > > @@ -442,17 +442,6 @@ static void __sco_sock_close(struct sock *sk)
> > >
> > >         case BT_CONNECTED:
> > >         case BT_CONFIG:
> > > -               if (sco_pi(sk)->conn->hcon) {
> > > -                       sk->sk_state =3D BT_DISCONN;
> > > -                       sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
> > > -                       sco_conn_lock(sco_pi(sk)->conn);
> > > -                       hci_conn_drop(sco_pi(sk)->conn->hcon);
> > > -                       sco_pi(sk)->conn->hcon =3D NULL;
> > > -                       sco_conn_unlock(sco_pi(sk)->conn);
> > > -               } else
> > > -                       sco_chan_del(sk, ECONNRESET);
> > > -               break;
> > > -
> > >         case BT_CONNECT2:
> > >         case BT_CONNECT:
> > >         case BT_DISCONN:
> > > --
> > > 2.46.1
> > >
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

--000000000000af3d2c06238489f3
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v4-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Disposition: attachment; 
	filename="v4-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1sc8fnx0>
X-Attachment-Id: f_m1sc8fnx0

RnJvbSA4NWI0Mzg2NzNkZDRmMWJiNjg2NzYyOTRkNTY3NGQyMGEwZDQ3YzA5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFR1ZSwgMSBPY3QgMjAyNCAxNTo0NjoxMCAtMDQwMApTdWJqZWN0
OiBbUEFUQ0ggdjRdIEJsdWV0b290aDogU0NPOiBVc2UgZGlzYWJsZV9kZWxheWVkX3dvcmtfc3lu
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
aW50ZWwuY29tPgotLS0KIG5ldC9ibHVldG9vdGgvc2NvLmMgfCAyMCArKysrKy0tLS0tLS0tLS0t
LS0tLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9zY28uYyBiL25ldC9ibHVldG9vdGgvc2NvLmMKaW5k
ZXggYTVhYzE2MGM1OTJlLi5jZWU4N2M2YzkxOTQgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgv
c2NvLmMKKysrIGIvbmV0L2JsdWV0b290aC9zY28uYwpAQCAtMTY5LDEwICsxNjksMTEgQEAgc3Rh
dGljIHZvaWQgc2NvX2NoYW5fZGVsKHN0cnVjdCBzb2NrICpzaywgaW50IGVycikKIAkJc2NvX2Nv
bm5fbG9jayhjb25uKTsKIAkJY29ubi0+c2sgPSBOVUxMOwogCQlzY29fcGkoc2spLT5jb25uID0g
TlVMTDsKLQkJc2NvX2Nvbm5fdW5sb2NrKGNvbm4pOwotCi0JCWlmIChjb25uLT5oY29uKQorCQlp
ZiAoY29ubi0+aGNvbikgewogCQkJaGNpX2Nvbm5fZHJvcChjb25uLT5oY29uKTsKKwkJCWNvbm4t
Pmhjb24gPSBOVUxMOworCQl9CisJCXNjb19jb25uX3VubG9jayhjb25uKTsKIAl9CiAKIAlzay0+
c2tfc3RhdGUgPSBCVF9DTE9TRUQ7CkBAIC0yMDgsNyArMjA5LDcgQEAgc3RhdGljIHZvaWQgc2Nv
X2Nvbm5fZGVsKHN0cnVjdCBoY2lfY29ubiAqaGNvbiwgaW50IGVycikKIAl9CiAKIAkvKiBFbnN1
cmUgbm8gbW9yZSB3b3JrIGl0ZW1zIHdpbGwgcnVuIGJlZm9yZSBmcmVlaW5nIGNvbm4uICovCi0J
Y2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZjb25uLT50aW1lb3V0X3dvcmspOworCWRpc2FibGVf
ZGVsYXllZF93b3JrX3N5bmMoJmNvbm4tPnRpbWVvdXRfd29yayk7CiAKIAloY29uLT5zY29fZGF0
YSA9IE5VTEw7CiAJa2ZyZWUoY29ubik7CkBAIC00NDIsMTcgKzQ0Myw2IEBAIHN0YXRpYyB2b2lk
IF9fc2NvX3NvY2tfY2xvc2Uoc3RydWN0IHNvY2sgKnNrKQogCiAJY2FzZSBCVF9DT05ORUNURUQ6
CiAJY2FzZSBCVF9DT05GSUc6Ci0JCWlmIChzY29fcGkoc2spLT5jb25uLT5oY29uKSB7Ci0JCQlz
ay0+c2tfc3RhdGUgPSBCVF9ESVNDT05OOwotCQkJc2NvX3NvY2tfc2V0X3RpbWVyKHNrLCBTQ09f
RElTQ09OTl9USU1FT1VUKTsKLQkJCXNjb19jb25uX2xvY2soc2NvX3BpKHNrKS0+Y29ubik7Ci0J
CQloY2lfY29ubl9kcm9wKHNjb19waShzayktPmNvbm4tPmhjb24pOwotCQkJc2NvX3BpKHNrKS0+
Y29ubi0+aGNvbiA9IE5VTEw7Ci0JCQlzY29fY29ubl91bmxvY2soc2NvX3BpKHNrKS0+Y29ubik7
Ci0JCX0gZWxzZQotCQkJc2NvX2NoYW5fZGVsKHNrLCBFQ09OTlJFU0VUKTsKLQkJYnJlYWs7Ci0K
IAljYXNlIEJUX0NPTk5FQ1QyOgogCWNhc2UgQlRfQ09OTkVDVDoKIAljYXNlIEJUX0RJU0NPTk46
Ci0tIAoyLjQ2LjEKCg==
--000000000000af3d2c06238489f3--
