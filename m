Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C681A08AD
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Oct 2024 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969931; cv=none; b=gw01pvExMkcDgygYH16e/rISJM75aDz4CHDMDhnkEHKaVuYP3Vxyq2r4pk1xTWESsNU2XRmKprh3LVpve3kOV+s/+n7+K0QZ2NKqcVmkZTuTbMRYO6l4lw5IdPvPxCqaiWemIysfsCDLBnuQgm5CGt4Bru8VM9//eWpRIkvV1QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969931; c=relaxed/simple;
	bh=CnY7QHod9NKejQY85pQlr10L9Ur0cKAujIB/NbWC3jY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tq9Q3AhO3H3BRCao82mpmyN+dEtPkbyCgUjJpDa7OULjGDvvfHI8MC/Mq0HVlmoyp/58D5/NINGbamGMkXZGTNiT6Z1rfimabYG/oO0xRk/iHK2TAzhDeMxfpxPUfqJk+skpl55o4f2MzRUqlJB+uG0bRM3wQIHPnTdZiHBVm44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpb82n1p; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpb82n1p"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fac5eb10ceso11502061fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Oct 2024 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727969927; x=1728574727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EyCuKlPfA+Fh8h/Pl0cpCChTDBMu4EoRpc4LPp5Chcs=;
        b=mpb82n1p+RgRifaxv7FCSbhliMaeGzOhEPijE1ZQiRwL25jO4yjzINL3hGcG8ub/IB
         MQxvPh4A6eAyBZ4bekSejYTvSSZio9id8SdDORZPHbDRTF2Aq2ivKmj611cKZjKk5CK7
         XFITl62M1rYgY3/i0VkaHGFinbaWK+N0u60BofRM0ubUK39vdiB+FuQ90Y/6T8XxYq4D
         aPSsQSxB6LJYST7oiwwzwwzhxZC1tIMRcVvO9z44AI0xJvTQxDZGKvrawJUowIt3TCZE
         LVCHMi0f9FwSCCFPoM3lheLnJrwHHSFU7YkXZ6hARz0uHmCLHRUAs7Xb+cQkF0vyE9J/
         Cz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727969927; x=1728574727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyCuKlPfA+Fh8h/Pl0cpCChTDBMu4EoRpc4LPp5Chcs=;
        b=X7Vuj8X3p6ztuA1jD+PNUgLIPsjwegGlbNE2bFDcpipY5kvPCYzdjept3llv1qt46N
         CLETqcZkNvb2woZNsnvhOS04RqS4LXCHlBPxwJ4DppWryHt++7ueEKsPYBgX81utXr8V
         8U6awHxQd4Nw4YmpZPH6H3G9qQ+r7BJhibnDuzFPoJwpI/jZNMU4TiNhqI0HbPkGExHB
         CfaqXom/XDtL+zDM7xZBYWKeB1jV1jM/Sr4LkwA2xBDxS5+spKucDQc1lpB31ZjoN1tI
         SQ3XsNWHNxa/yG3ntqep801e9xCUTddr/Zc2xEssChHPoFMxCvYmWbXB40AJX4bJSaRn
         54QQ==
X-Gm-Message-State: AOJu0YwnQtKJMf183H2ViqcJcX/pS9H996A63wT01p+0QKUNW2Zl/h89
	W1rgyKlfXZLw1RhnpSD9M1pRIbCMhyf2FWs0yUj/zKoPHZNUnVRIyrAyLIk+ZN2b/4gr6PbgR4P
	kNZiLvhUODSYmp7EQxAGInY8FA03+ZA==
X-Google-Smtp-Source: AGHT+IFFdnsRm8AgzVN2EzzDkhuW9x8dNz/3rvbmIrkE9OGQwL1snM2zW92iZc1eRSM6+6JK51wdh479KfzIUfESrqk=
X-Received: by 2002:a2e:be03:0:b0:2fa:d225:642f with SMTP id
 38308e7fff4ca-2faea24353dmr13447651fa.14.1727969926662; Thu, 03 Oct 2024
 08:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002190452.3405592-1-luiz.dentz@gmail.com>
 <CABBYNZKqrja__qdidRwqXh9wcJJ6YdGqdh4bejU5HsL02qcFpw@mail.gmail.com>
 <CABBYNZLoh-K2QLinNwJrbQgSccTKW37C2wt5+AmM272Du3p81A@mail.gmail.com> <CABBYNZLeWWtX9PdNarFajZynUSsyrd4mavExPXzY2GUf_ZzECw@mail.gmail.com>
In-Reply-To: <CABBYNZLeWWtX9PdNarFajZynUSsyrd4mavExPXzY2GUf_ZzECw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 3 Oct 2024 11:38:33 -0400
Message-ID: <CABBYNZJLj6gSa-1prGM5aLKTJbFJo5mxxJkBU=WoqEx-P6TdOA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: SCO: Use disable_delayed_work_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="000000000000a969ea0623945967"

--000000000000a969ea0623945967
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >
> > > > This makes use of disable_delayed_work_sync instead
> > > > cancel_delayed_work_sync as it not only cancel the ongoing work but=
 also
> > > > disables new submit which is disarable since the object holding the=
 work
> > > > is about to be freed.
> > > >
> > > > In addition to it remove call to sco_sock_set_timer on __sco_sock_c=
lose
> > > > since at that point it is useless to set a timer as the sk will be =
freed
> > > > there is nothing to be done in sco_sock_timeout.
> > > >
> > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde787116d=
465
> > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed=
_work")
> > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > ---
> > > >  net/bluetooth/sco.c | 13 +------------
> > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > >
> > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > index a5ac160c592e..2b1e66976068 100644
> > > > --- a/net/bluetooth/sco.c
> > > > +++ b/net/bluetooth/sco.c
> > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *hcon,=
 int err)
> > > >         }
> > > >
> > > >         /* Ensure no more work items will run before freeing conn. =
*/
> > > > -       cancel_delayed_work_sync(&conn->timeout_work);
> > > > +       disable_delayed_work_sync(&conn->timeout_work);
> > > >
> > > >         hcon->sco_data =3D NULL;
> > > >         kfree(conn);
> > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(struct sock *sk)
> > > >
> > > >         case BT_CONNECTED:
> > > >         case BT_CONFIG:
> > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > -                       sk->sk_state =3D BT_DISCONN;
> > > > -                       sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT)=
;
> > > > -                       sco_conn_lock(sco_pi(sk)->conn);
> > > > -                       hci_conn_drop(sco_pi(sk)->conn->hcon);
> > > > -                       sco_pi(sk)->conn->hcon =3D NULL;
> > > > -                       sco_conn_unlock(sco_pi(sk)->conn);
> > > > -               } else
> > > > -                       sco_chan_del(sk, ECONNRESET);
> > > > -               break;
> > > > -
> > > >         case BT_CONNECT2:
> > > >         case BT_CONNECT:
> > > >         case BT_DISCONN:
> > > > --
> > > > 2.46.1
> > > >
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

--000000000000a969ea0623945967
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v4-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Disposition: attachment; 
	filename="v4-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1tgo44t0>
X-Attachment-Id: f_m1tgo44t0

RnJvbSA2MDA1MzQ4MTViMTQ1MTAyNDU2YjBmMmVhZGEwMDViZDNlODllYTZiIE1vbiBTZXAgMTcg
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
aW50ZWwuY29tPgotLS0KIG5ldC9ibHVldG9vdGgvc2NvLmMgfCA2NiArKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRp
b25zKCspLCAzMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL3Njby5j
IGIvbmV0L2JsdWV0b290aC9zY28uYwppbmRleCBhNWFjMTYwYzU5MmUuLjZhYTA4ZTcwOTM5MSAx
MDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9zY28uYworKysgYi9uZXQvYmx1ZXRvb3RoL3Njby5j
CkBAIC0xNTUsNiArMTU1LDI4IEBAIHN0YXRpYyBzdHJ1Y3Qgc2NvX2Nvbm4gKnNjb19jb25uX2Fk
ZChzdHJ1Y3QgaGNpX2Nvbm4gKmhjb24pCiAJcmV0dXJuIGNvbm47CiB9CiAKK3N0YXRpYyB2b2lk
IHNjb19jb25uX2Rlc3RydWN0KHN0cnVjdCBzY29fY29ubiAqY29ubikKK3sKKwlpZiAoIWNvbm4p
CisJCXJldHVybjsKKworCUJUX0RCRygiY29ubiAlcCIsIGNvbm4pOworCisJaWYgKGNvbm4tPmhj
b24pIHsKKwkJaGNpX2Nvbm5fZHJvcChjb25uLT5oY29uKTsKKworCQlzY29fY29ubl9sb2NrKGNv
bm4pOworCQljb25uLT5oY29uLT5zY29fZGF0YSA9IE5VTEw7CisJCWNvbm4tPmhjb24gPSBOVUxM
OworCQlzY29fY29ubl91bmxvY2soY29ubik7CisJfQorCisJLyogRW5zdXJlIG5vIG1vcmUgd29y
ayBpdGVtcyB3aWxsIHJ1biBiZWZvcmUgZnJlZWluZyBjb25uLiAqLworCWRpc2FibGVfZGVsYXll
ZF93b3JrX3N5bmMoJmNvbm4tPnRpbWVvdXRfd29yayk7CisKKwlrZnJlZShjb25uKTsKK30KKwog
LyogRGVsZXRlIGNoYW5uZWwuCiAgKiBNdXN0IGJlIGNhbGxlZCBvbiB0aGUgbG9ja2VkIHNvY2tl
dC4gKi8KIHN0YXRpYyB2b2lkIHNjb19jaGFuX2RlbChzdHJ1Y3Qgc29jayAqc2ssIGludCBlcnIp
CkBAIC0xNjUsMTYgKzE4Nyw2IEBAIHN0YXRpYyB2b2lkIHNjb19jaGFuX2RlbChzdHJ1Y3Qgc29j
ayAqc2ssIGludCBlcnIpCiAKIAlCVF9EQkcoInNrICVwLCBjb25uICVwLCBlcnIgJWQiLCBzaywg
Y29ubiwgZXJyKTsKIAotCWlmIChjb25uKSB7Ci0JCXNjb19jb25uX2xvY2soY29ubik7Ci0JCWNv
bm4tPnNrID0gTlVMTDsKLQkJc2NvX3BpKHNrKS0+Y29ubiA9IE5VTEw7Ci0JCXNjb19jb25uX3Vu
bG9jayhjb25uKTsKLQotCQlpZiAoY29ubi0+aGNvbikKLQkJCWhjaV9jb25uX2Ryb3AoY29ubi0+
aGNvbik7Ci0JfQotCiAJc2stPnNrX3N0YXRlID0gQlRfQ0xPU0VEOwogCXNrLT5za19lcnIgICA9
IGVycjsKIAlzay0+c2tfc3RhdGVfY2hhbmdlKHNrKTsKQEAgLTE5MiwyNiArMjA0LDIzIEBAIHN0
YXRpYyB2b2lkIHNjb19jb25uX2RlbChzdHJ1Y3QgaGNpX2Nvbm4gKmhjb24sIGludCBlcnIpCiAK
IAlCVF9EQkcoImhjb24gJXAgY29ubiAlcCwgZXJyICVkIiwgaGNvbiwgY29ubiwgZXJyKTsKIAot
CS8qIEtpbGwgc29ja2V0ICovCiAJc2NvX2Nvbm5fbG9jayhjb25uKTsKIAlzayA9IGNvbm4tPnNr
OwogCWlmIChzaykKIAkJc29ja19ob2xkKHNrKTsKIAlzY29fY29ubl91bmxvY2soY29ubik7CiAK
LQlpZiAoc2spIHsKLQkJbG9ja19zb2NrKHNrKTsKLQkJc2NvX3NvY2tfY2xlYXJfdGltZXIoc2sp
OwotCQlzY29fY2hhbl9kZWwoc2ssIGVycik7Ci0JCXJlbGVhc2Vfc29jayhzayk7Ci0JCXNvY2tf
cHV0KHNrKTsKKwlpZiAoIXNrKSB7CisJCXNjb19jb25uX2Rlc3RydWN0KGNvbm4pOworCQlyZXR1
cm47CiAJfQogCi0JLyogRW5zdXJlIG5vIG1vcmUgd29yayBpdGVtcyB3aWxsIHJ1biBiZWZvcmUg
ZnJlZWluZyBjb25uLiAqLwotCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmY29ubi0+dGltZW91
dF93b3JrKTsKLQotCWhjb24tPnNjb19kYXRhID0gTlVMTDsKLQlrZnJlZShjb25uKTsKKwkvKiBL
aWxsIHNvY2tldCAqLworCWxvY2tfc29jayhzayk7CisJc2NvX3NvY2tfY2xlYXJfdGltZXIoc2sp
OworCXNjb19jaGFuX2RlbChzaywgZXJyKTsKKwlyZWxlYXNlX3NvY2soc2spOworCXNvY2tfcHV0
KHNrKTsKIH0KIAogc3RhdGljIHZvaWQgX19zY29fY2hhbl9hZGQoc3RydWN0IHNjb19jb25uICpj
b25uLCBzdHJ1Y3Qgc29jayAqc2ssCkBAIC0zOTUsNiArNDA0LDggQEAgc3RhdGljIHZvaWQgc2Nv
X3NvY2tfZGVzdHJ1Y3Qoc3RydWN0IHNvY2sgKnNrKQogewogCUJUX0RCRygic2sgJXAiLCBzayk7
CiAKKwlzY29fY29ubl9kZXN0cnVjdChzY29fcGkoc2spLT5jb25uKTsKKwogCXNrYl9xdWV1ZV9w
dXJnZSgmc2stPnNrX3JlY2VpdmVfcXVldWUpOwogCXNrYl9xdWV1ZV9wdXJnZSgmc2stPnNrX3dy
aXRlX3F1ZXVlKTsKIH0KQEAgLTQ0MiwxNyArNDUzLDYgQEAgc3RhdGljIHZvaWQgX19zY29fc29j
a19jbG9zZShzdHJ1Y3Qgc29jayAqc2spCiAKIAljYXNlIEJUX0NPTk5FQ1RFRDoKIAljYXNlIEJU
X0NPTkZJRzoKLQkJaWYgKHNjb19waShzayktPmNvbm4tPmhjb24pIHsKLQkJCXNrLT5za19zdGF0
ZSA9IEJUX0RJU0NPTk47Ci0JCQlzY29fc29ja19zZXRfdGltZXIoc2ssIFNDT19ESVNDT05OX1RJ
TUVPVVQpOwotCQkJc2NvX2Nvbm5fbG9jayhzY29fcGkoc2spLT5jb25uKTsKLQkJCWhjaV9jb25u
X2Ryb3Aoc2NvX3BpKHNrKS0+Y29ubi0+aGNvbik7Ci0JCQlzY29fcGkoc2spLT5jb25uLT5oY29u
ID0gTlVMTDsKLQkJCXNjb19jb25uX3VubG9jayhzY29fcGkoc2spLT5jb25uKTsKLQkJfSBlbHNl
Ci0JCQlzY29fY2hhbl9kZWwoc2ssIEVDT05OUkVTRVQpOwotCQlicmVhazsKLQogCWNhc2UgQlRf
Q09OTkVDVDI6CiAJY2FzZSBCVF9DT05ORUNUOgogCWNhc2UgQlRfRElTQ09OTjoKLS0gCjIuNDYu
MQoK
--000000000000a969ea0623945967--
