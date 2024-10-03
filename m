Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61E5199EA7
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Oct 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973192; cv=none; b=F73+OCqQC4wpwo2iQ9wWjmvxScpkH0OD9YyxcxBIhVCLZaoaih55mCy6QKUiJiPLqlJFMZc47Qd0KBfHHdBHSMcLZ+W4rvCUQSwGunUj814f5Ap0Obu8bUhqZM/rBAXgScyPh1S7VmRb6NCMrXvKS1/98lVVozHNtq/ZEDTmFqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973192; c=relaxed/simple;
	bh=c8A6PAe8kMG3mRjDinvQENev7ttv0mVLvLMg5UoSzpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHIoEp5D5dQ4YJY+YqOhgFT/SkcAwNkNZ88GHgfUpvSKPx5BCXeDb4ec+BxDZQR52UWJfDruoKgPgIQdxZYo70cd6UwWytxxOHem5tZzoNYS3Ksg3CLxuAOEGWYeMAxf74u68gMbmeSxKmj+OyyhR5EDHUEEMgNNEELJ8DRVqUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJ+xKLoC; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ+xKLoC"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fabd2c4ac0so14944381fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Oct 2024 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727973188; x=1728577988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wa1yj+exeQQkdW+amx0CpPyKeB1JjdynmahfeTXalX4=;
        b=jJ+xKLoCnlEn+djuY7dM55X9HigOTJRXtf0ffM/qT73y0q4gH/X0OnY6D/GON2X75T
         ggGBWvaKP9NTFZmN24FA12eu17gN3i/79J3mJjnB1jX1GB7EBRqymgqG48nV48vkt1Yt
         9p9jb1YUdcXqF/PIwCc9ZZxSj38FXztvKMBQ9y/yyi5VMNYfFPMldFyz6UUiSNEcKb8o
         K+te5y1WGF0/AaHBfgYAm6KZILZ8l+iS1jra190LfC6PC82LDFMyit6z/XyseJT4Q/8C
         qrGqZxBlOMhhEkdyqGlA0oZR8Sy7w6CZZL2BrjBXzcMtcemw84uZ0wJo3e33FR/ijHLt
         WtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727973188; x=1728577988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wa1yj+exeQQkdW+amx0CpPyKeB1JjdynmahfeTXalX4=;
        b=gPBV2GMuDE4ADTWviBJQLK5oQgG/K2TW6OumZe4tjENPBPxyWYdnYJumUKWXsE7JKG
         3xKSXjzhNSNQ54Kr2JmZfhW/dqAVhcVsBKuT8omK7CWQpUXMakB8Elxo1JWLQ8CmdG1n
         S+QyTHbUVskn1+qr/lmOhYm7bnEzZj0rOobP4ndQK1/LcbrhQmJ1NSZM5c0HCoYWSbmk
         UC7p0nYqB/EmasBrFXLb7ZLr0TvnDlKisHuAXWhq6qllYjqd8GNl9U932Xuu75FO8UDM
         WFFWnXAhTXCEccITvtomp/RHAJxB+9LIPZQOi9fu4Pq8j5pG8lQZElbEjc2LKggeu+SX
         Xypw==
X-Gm-Message-State: AOJu0YxJb5O7X26yqPOFJBZINks9SwX/EVOFjLX6CHp4it+1Soi1CB9O
	DHcjdxkK7eHEyFEZXjbaIQ+I8amvdBxqWTkSHDzSd6ybKdHj+zIEImvhqBRA+CWNvqNf5jAMwaB
	4QEd4HF3dDhBD2QyUd4VDHu3DF1kvkg==
X-Google-Smtp-Source: AGHT+IEUQvAeqURU4c8lESg5KdqQGvAwg4rQ90DQNKaKzYCiKa+Iq6krMw3K1e9LnmJhBsnb0XjAxEHRvJbguP0STWk=
X-Received: by 2002:a2e:a99d:0:b0:2fa:c49b:d161 with SMTP id
 38308e7fff4ca-2fae10246d9mr53694551fa.4.1727973187741; Thu, 03 Oct 2024
 09:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002190452.3405592-1-luiz.dentz@gmail.com>
 <CABBYNZKqrja__qdidRwqXh9wcJJ6YdGqdh4bejU5HsL02qcFpw@mail.gmail.com>
 <CABBYNZLoh-K2QLinNwJrbQgSccTKW37C2wt5+AmM272Du3p81A@mail.gmail.com>
 <CABBYNZLeWWtX9PdNarFajZynUSsyrd4mavExPXzY2GUf_ZzECw@mail.gmail.com> <CABBYNZJLj6gSa-1prGM5aLKTJbFJo5mxxJkBU=WoqEx-P6TdOA@mail.gmail.com>
In-Reply-To: <CABBYNZJLj6gSa-1prGM5aLKTJbFJo5mxxJkBU=WoqEx-P6TdOA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 3 Oct 2024 12:32:54 -0400
Message-ID: <CABBYNZJGF4156YhdOH5DoZ7hkh1NTrpQwntwJZiYJ9AyHYr14w@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: SCO: Use disable_delayed_work_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="00000000000009950e0623951c62"

--00000000000009950e0623951c62
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Thu, Oct 3, 2024 at 11:38=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > #syz test
> > > >
> > > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > >
> > > > > This makes use of disable_delayed_work_sync instead
> > > > > cancel_delayed_work_sync as it not only cancel the ongoing work b=
ut also
> > > > > disables new submit which is disarable since the object holding t=
he work
> > > > > is about to be freed.
> > > > >
> > > > > In addition to it remove call to sco_sock_set_timer on __sco_sock=
_close
> > > > > since at that point it is useless to set a timer as the sk will b=
e freed
> > > > > there is nothing to be done in sco_sock_timeout.
> > > > >
> > > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.co=
m
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde78711=
6d465
> > > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delay=
ed_work")
> > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > ---
> > > > >  net/bluetooth/sco.c | 13 +------------
> > > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > > index a5ac160c592e..2b1e66976068 100644
> > > > > --- a/net/bluetooth/sco.c
> > > > > +++ b/net/bluetooth/sco.c
> > > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *hco=
n, int err)
> > > > >         }
> > > > >
> > > > >         /* Ensure no more work items will run before freeing conn=
. */
> > > > > -       cancel_delayed_work_sync(&conn->timeout_work);
> > > > > +       disable_delayed_work_sync(&conn->timeout_work);
> > > > >
> > > > >         hcon->sco_data =3D NULL;
> > > > >         kfree(conn);
> > > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(struct sock *sk=
)
> > > > >
> > > > >         case BT_CONNECTED:
> > > > >         case BT_CONFIG:
> > > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > > -                       sk->sk_state =3D BT_DISCONN;
> > > > > -                       sco_sock_set_timer(sk, SCO_DISCONN_TIMEOU=
T);
> > > > > -                       sco_conn_lock(sco_pi(sk)->conn);
> > > > > -                       hci_conn_drop(sco_pi(sk)->conn->hcon);
> > > > > -                       sco_pi(sk)->conn->hcon =3D NULL;
> > > > > -                       sco_conn_unlock(sco_pi(sk)->conn);
> > > > > -               } else
> > > > > -                       sco_chan_del(sk, ECONNRESET);
> > > > > -               break;
> > > > > -
> > > > >         case BT_CONNECT2:
> > > > >         case BT_CONNECT:
> > > > >         case BT_DISCONN:
> > > > > --
> > > > > 2.46.1
> > > > >
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

--00000000000009950e0623951c62
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v4-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Disposition: attachment; 
	filename="v4-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1tim19c0>
X-Attachment-Id: f_m1tim19c0

RnJvbSAzNjljNjJjNmQ2ZjI0MzE3N2NlMGIxMjYxYzZlZWRhNmZmODFkMDk3IE1vbiBTZXAgMTcg
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
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRp
b25zKCspLCAzMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL3Njby5j
IGIvbmV0L2JsdWV0b290aC9zY28uYwppbmRleCBhNWFjMTYwYzU5MmUuLjUyZjczODJiMWZjYyAx
MDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9zY28uYworKysgYi9uZXQvYmx1ZXRvb3RoL3Njby5j
CkBAIC0xNTUsNiArMTU1LDI2IEBAIHN0YXRpYyBzdHJ1Y3Qgc2NvX2Nvbm4gKnNjb19jb25uX2Fk
ZChzdHJ1Y3QgaGNpX2Nvbm4gKmhjb24pCiAJcmV0dXJuIGNvbm47CiB9CiAKK3N0YXRpYyB2b2lk
IHNjb19jb25uX2Rlc3RydWN0KHN0cnVjdCBzY29fY29ubiAqY29ubikKK3sKKwlpZiAoIWNvbm4p
CisJCXJldHVybjsKKworCUJUX0RCRygiY29ubiAlcCIsIGNvbm4pOworCisJaWYgKGNvbm4tPmhj
b24pIHsKKwkJc2NvX2Nvbm5fbG9jayhjb25uKTsKKwkJY29ubi0+aGNvbi0+c2NvX2RhdGEgPSBO
VUxMOworCQljb25uLT5oY29uID0gTlVMTDsKKwkJc2NvX2Nvbm5fdW5sb2NrKGNvbm4pOworCX0K
KworCS8qIEVuc3VyZSBubyBtb3JlIHdvcmsgaXRlbXMgd2lsbCBydW4gYmVmb3JlIGZyZWVpbmcg
Y29ubi4gKi8KKwlkaXNhYmxlX2RlbGF5ZWRfd29ya19zeW5jKCZjb25uLT50aW1lb3V0X3dvcmsp
OworCisJa2ZyZWUoY29ubik7Cit9CisKIC8qIERlbGV0ZSBjaGFubmVsLgogICogTXVzdCBiZSBj
YWxsZWQgb24gdGhlIGxvY2tlZCBzb2NrZXQuICovCiBzdGF0aWMgdm9pZCBzY29fY2hhbl9kZWwo
c3RydWN0IHNvY2sgKnNrLCBpbnQgZXJyKQpAQCAtMTY1LDE1ICsxODUsOSBAQCBzdGF0aWMgdm9p
ZCBzY29fY2hhbl9kZWwoc3RydWN0IHNvY2sgKnNrLCBpbnQgZXJyKQogCiAJQlRfREJHKCJzayAl
cCwgY29ubiAlcCwgZXJyICVkIiwgc2ssIGNvbm4sIGVycik7CiAKLQlpZiAoY29ubikgewotCQlz
Y29fY29ubl9sb2NrKGNvbm4pOwotCQljb25uLT5zayA9IE5VTEw7Ci0JCXNjb19waShzayktPmNv
bm4gPSBOVUxMOwotCQlzY29fY29ubl91bmxvY2soY29ubik7Ci0KLQkJaWYgKGNvbm4tPmhjb24p
Ci0JCQloY2lfY29ubl9kcm9wKGNvbm4tPmhjb24pOwotCX0KKwkvKiBEcm9wIEhDSSBjb25uZWN0
aW9uICovCisJaWYgKGNvbm4gJiYgY29ubi0+aGNvbikKKwkJaGNpX2Nvbm5fZHJvcChjb25uLT5o
Y29uKTsKIAogCXNrLT5za19zdGF0ZSA9IEJUX0NMT1NFRDsKIAlzay0+c2tfZXJyICAgPSBlcnI7
CkBAIC0xOTIsMjYgKzIwNiwyMyBAQCBzdGF0aWMgdm9pZCBzY29fY29ubl9kZWwoc3RydWN0IGhj
aV9jb25uICpoY29uLCBpbnQgZXJyKQogCiAJQlRfREJHKCJoY29uICVwIGNvbm4gJXAsIGVyciAl
ZCIsIGhjb24sIGNvbm4sIGVycik7CiAKLQkvKiBLaWxsIHNvY2tldCAqLwogCXNjb19jb25uX2xv
Y2soY29ubik7CiAJc2sgPSBjb25uLT5zazsKIAlpZiAoc2spCiAJCXNvY2tfaG9sZChzayk7CiAJ
c2NvX2Nvbm5fdW5sb2NrKGNvbm4pOwogCi0JaWYgKHNrKSB7Ci0JCWxvY2tfc29jayhzayk7Ci0J
CXNjb19zb2NrX2NsZWFyX3RpbWVyKHNrKTsKLQkJc2NvX2NoYW5fZGVsKHNrLCBlcnIpOwotCQly
ZWxlYXNlX3NvY2soc2spOwotCQlzb2NrX3B1dChzayk7CisJaWYgKCFzaykgeworCQlzY29fY29u
bl9kZXN0cnVjdChjb25uKTsKKwkJcmV0dXJuOwogCX0KIAotCS8qIEVuc3VyZSBubyBtb3JlIHdv
cmsgaXRlbXMgd2lsbCBydW4gYmVmb3JlIGZyZWVpbmcgY29ubi4gKi8KLQljYW5jZWxfZGVsYXll
ZF93b3JrX3N5bmMoJmNvbm4tPnRpbWVvdXRfd29yayk7Ci0KLQloY29uLT5zY29fZGF0YSA9IE5V
TEw7Ci0Ja2ZyZWUoY29ubik7CisJLyogS2lsbCBzb2NrZXQgKi8KKwlsb2NrX3NvY2soc2spOwor
CXNjb19zb2NrX2NsZWFyX3RpbWVyKHNrKTsKKwlzY29fY2hhbl9kZWwoc2ssIGVycik7CisJcmVs
ZWFzZV9zb2NrKHNrKTsKKwlzb2NrX3B1dChzayk7CiB9CiAKIHN0YXRpYyB2b2lkIF9fc2NvX2No
YW5fYWRkKHN0cnVjdCBzY29fY29ubiAqY29ubiwgc3RydWN0IHNvY2sgKnNrLApAQCAtMzk1LDYg
KzQwNiw4IEBAIHN0YXRpYyB2b2lkIHNjb19zb2NrX2Rlc3RydWN0KHN0cnVjdCBzb2NrICpzaykK
IHsKIAlCVF9EQkcoInNrICVwIiwgc2spOwogCisJc2NvX2Nvbm5fZGVzdHJ1Y3Qoc2NvX3BpKHNr
KS0+Y29ubik7CisKIAlza2JfcXVldWVfcHVyZ2UoJnNrLT5za19yZWNlaXZlX3F1ZXVlKTsKIAlz
a2JfcXVldWVfcHVyZ2UoJnNrLT5za193cml0ZV9xdWV1ZSk7CiB9CkBAIC00NDIsMTcgKzQ1NSw2
IEBAIHN0YXRpYyB2b2lkIF9fc2NvX3NvY2tfY2xvc2Uoc3RydWN0IHNvY2sgKnNrKQogCiAJY2Fz
ZSBCVF9DT05ORUNURUQ6CiAJY2FzZSBCVF9DT05GSUc6Ci0JCWlmIChzY29fcGkoc2spLT5jb25u
LT5oY29uKSB7Ci0JCQlzay0+c2tfc3RhdGUgPSBCVF9ESVNDT05OOwotCQkJc2NvX3NvY2tfc2V0
X3RpbWVyKHNrLCBTQ09fRElTQ09OTl9USU1FT1VUKTsKLQkJCXNjb19jb25uX2xvY2soc2NvX3Bp
KHNrKS0+Y29ubik7Ci0JCQloY2lfY29ubl9kcm9wKHNjb19waShzayktPmNvbm4tPmhjb24pOwot
CQkJc2NvX3BpKHNrKS0+Y29ubi0+aGNvbiA9IE5VTEw7Ci0JCQlzY29fY29ubl91bmxvY2soc2Nv
X3BpKHNrKS0+Y29ubik7Ci0JCX0gZWxzZQotCQkJc2NvX2NoYW5fZGVsKHNrLCBFQ09OTlJFU0VU
KTsKLQkJYnJlYWs7Ci0KIAljYXNlIEJUX0NPTk5FQ1QyOgogCWNhc2UgQlRfQ09OTkVDVDoKIAlj
YXNlIEJUX0RJU0NPTk46Ci0tIAoyLjQ2LjEKCg==
--00000000000009950e0623951c62--
