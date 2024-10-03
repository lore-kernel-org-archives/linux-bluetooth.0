Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4D1AB6DD
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Oct 2024 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727983314; cv=none; b=R9xYYbtgXRGolcaXImI2HNL8P6qqs9L9bKkGCFxB46XT0Mr/Gg45NmQ9AmWbodMSAIVqk3VDRebsBnK1zOy9gYUZDBcfKDEc7bFOX8TOrFgD925qxQY2VLjZKKLYzxjh6op/3iccZPpiSPaspiRVMyzj7S0E4U211R2RCHxbLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727983314; c=relaxed/simple;
	bh=CzkdT/7yjQcHpFwnyMf3/20krEjczUi2eTXYbgKDA9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3bvauKYxCMoIA/et7CYa7ASqCW3ZOSOYlFep1+Nlgui73fbTCtQzIhFozZ0/iB2sV4EHM/TFg15Xaee5B2pq6LG3iysB0K2kjwjhHOkkVpG+ySW4YR2KnWyqfx3+bIS28//BilGJ2Wj551ksddlIrQOhHgTwIVPRyzkIn9ufR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hotHyr2C; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hotHyr2C"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fad15b3eeeso16889301fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Oct 2024 12:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727983310; x=1728588110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lcGGeCLGGCrvDyUYlSR4FqObTHlnOxwem9ad0zu2ovo=;
        b=hotHyr2CxnM5GmMq6tw25NRe7XGeygUwsGdLUN8OsnMEr9Oh62kYEZH0BjEu0/Yzfo
         L/9zuX8zTq8jeeaHqjQAwhjO3XPrubMkjXR0ZYwbmoQ/ngaE5qq+fCHAAgi7Tw7AoQa6
         nFVmxkfLo+00wxVPzYb8ZlueH8Az7jbebp0yGgxWcML5d3/ZZmtNmRdVQuMHM6hP0de9
         aHyxsKMnUBunJsdyz9lj6j0Wtd0lqN+EABOhrCB+uON2EZHJ9jOjxkW5vqskK6ak72dn
         IXaZKrUGVuojBIIFv0eZpRn3kuCBnN1I6qnlzUr84rfZXuVFLzeiZiJCw5EF1ZwmGo4s
         lYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727983310; x=1728588110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lcGGeCLGGCrvDyUYlSR4FqObTHlnOxwem9ad0zu2ovo=;
        b=B+2gtsjRmBL3thVSMu7Cy5kThdR7EKNQQFQ9sm0oH8aLHMpdmdL+oojxoykSSoywEY
         b+xpoTDfd2pmtkIpPEh4CNuyEqsIYBD7+V4V8bUwJyxvU4QJVstkszOXg0w/U+EHd1Gr
         4hXd/G7xoggb2Qsmg6gH7iqpfkBm2VSQuChkyZd5YYfLMYtifZMdddSLfC76erspOP5N
         efKbWFqvHBmI7HT5AqU3/Sohc5tgD/3D2RMRyewYxm1ZBW7shxBw6R0taWCZLCCL4D4s
         H1jzszq82w49pgdcnK57EA8g8El0JMJ4QK/dYvQgKgUVZxya+SRDyDn8q4b+s4MkdSnS
         ZDmA==
X-Gm-Message-State: AOJu0YyTqYQvkZnHnx9NVN7q+WofgKiqw+c0JQ4Ezj09BldjbRViek0f
	WbEBi48NbDk2sWuJSepHV3JXvg0t1WcqdShwK97WTbOsEADNw3DlQUoMBH4/NIo3S8mNt41x5KF
	QRtZzDggvT2A33xKL3AmKgKNb4gV49Q==
X-Google-Smtp-Source: AGHT+IFJm05yZaBOUz3ECOwWY18HX/9GCNUPbMKsZ0OHOKanC1Rfj9A2Ixs4YuQ2o1tTeL+Cs99rTxQa56fXZ3lDViI=
X-Received: by 2002:a2e:e11:0:b0:2f9:c337:aca9 with SMTP id
 38308e7fff4ca-2faf3d8e286mr434961fa.44.1727983309505; Thu, 03 Oct 2024
 12:21:49 -0700 (PDT)
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
 <CABBYNZJLj6gSa-1prGM5aLKTJbFJo5mxxJkBU=WoqEx-P6TdOA@mail.gmail.com> <CABBYNZJGF4156YhdOH5DoZ7hkh1NTrpQwntwJZiYJ9AyHYr14w@mail.gmail.com>
In-Reply-To: <CABBYNZJGF4156YhdOH5DoZ7hkh1NTrpQwntwJZiYJ9AyHYr14w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 3 Oct 2024 15:21:36 -0400
Message-ID: <CABBYNZ+=iNpM0TF4jDCqfJM4VWHY+CY5Vp1Ah91i8jGNKUeMKQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: SCO: Use disable_delayed_work_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="0000000000005764420623977718"

--0000000000005764420623977718
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Thu, Oct 3, 2024 at 12:32=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Thu, Oct 3, 2024 at 11:38=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > #syz test
> > > >
> > > > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > #syz test
> > > > >
> > > > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > >
> > > > > > This makes use of disable_delayed_work_sync instead
> > > > > > cancel_delayed_work_sync as it not only cancel the ongoing work=
 but also
> > > > > > disables new submit which is disarable since the object holding=
 the work
> > > > > > is about to be freed.
> > > > > >
> > > > > > In addition to it remove call to sco_sock_set_timer on __sco_so=
ck_close
> > > > > > since at that point it is useless to set a timer as the sk will=
 be freed
> > > > > > there is nothing to be done in sco_sock_timeout.
> > > > > >
> > > > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.=
com
> > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde787=
116d465
> > > > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with del=
ayed_work")
> > > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com=
>
> > > > > > ---
> > > > > >  net/bluetooth/sco.c | 13 +------------
> > > > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > > > >
> > > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > > > index a5ac160c592e..2b1e66976068 100644
> > > > > > --- a/net/bluetooth/sco.c
> > > > > > +++ b/net/bluetooth/sco.c
> > > > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *h=
con, int err)
> > > > > >         }
> > > > > >
> > > > > >         /* Ensure no more work items will run before freeing co=
nn. */
> > > > > > -       cancel_delayed_work_sync(&conn->timeout_work);
> > > > > > +       disable_delayed_work_sync(&conn->timeout_work);
> > > > > >
> > > > > >         hcon->sco_data =3D NULL;
> > > > > >         kfree(conn);
> > > > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(struct sock *=
sk)
> > > > > >
> > > > > >         case BT_CONNECTED:
> > > > > >         case BT_CONFIG:
> > > > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > > > -                       sk->sk_state =3D BT_DISCONN;
> > > > > > -                       sco_sock_set_timer(sk, SCO_DISCONN_TIME=
OUT);
> > > > > > -                       sco_conn_lock(sco_pi(sk)->conn);
> > > > > > -                       hci_conn_drop(sco_pi(sk)->conn->hcon);
> > > > > > -                       sco_pi(sk)->conn->hcon =3D NULL;
> > > > > > -                       sco_conn_unlock(sco_pi(sk)->conn);
> > > > > > -               } else
> > > > > > -                       sco_chan_del(sk, ECONNRESET);
> > > > > > -               break;
> > > > > > -
> > > > > >         case BT_CONNECT2:
> > > > > >         case BT_CONNECT:
> > > > > >         case BT_DISCONN:
> > > > > > --
> > > > > > 2.46.1
> > > > > >
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

--0000000000005764420623977718
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v4-0002-Bluetooth-ISO-Use-disable_delayed_work_sync.patch"
Content-Disposition: attachment; 
	filename="v4-0002-Bluetooth-ISO-Use-disable_delayed_work_sync.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1tomy6c0>
X-Attachment-Id: f_m1tomy6c0

RnJvbSA4N2IxYmE2YTA2NDRhZGEyOTNkMTY4N2ViMzgyZDk0YWU4MjY5ZjNiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFR1ZSwgMSBPY3QgMjAyNCAxNjoxNTo1MSAtMDQwMApTdWJqZWN0
OiBbUEFUQ0ggdjQgMi8yXSBCbHVldG9vdGg6IElTTzogVXNlIGRpc2FibGVfZGVsYXllZF93b3Jr
X3N5bmMKClRoaXMgbWFrZXMgdXNlIG9mIGRpc2FibGVfZGVsYXllZF93b3JrX3N5bmMgaW5zdGVh
ZApjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMgYXMgaXQgbm90IG9ubHkgY2FuY2VscyB0aGUgb25n
b2luZyB3b3JrIGJ1dCBhbHNvCmRpc2FibGVzIG5ldyBzdWJtaXNzaW9ucyB3aGljaCBpcyBkaXNh
cmFibGUgc2luY2UgdGhlIG9iamVjdCBob2xkaW5nIHRoZQp3b3JrIGlzIGFib3V0IHRvIGJlIGZy
ZWVkLgoKSW4gYWRkaXRpb24gdG8gaXQgcmVtb3ZlIGNhbGwgdG8gaXNvX3NvY2tfc2V0X3RpbWVy
IG9uIGlzb19zb2NrX2Rpc2Nvbm4Kc2luY2UgYXQgdGhhdCBwb2ludCBpdCBpcyB1c2VsZXNzIHRv
IHNldCBhIHRpbWVyIGFzIHRoZSBzayB3aWxsIGJlIGZyZWVkCnRoZXJlIGlzIG5vdGhpbmcgdG8g
YmUgZG9uZSBpbiBpc29fc29ja190aW1lb3V0LgoKRml4ZXM6IGNjZjc0ZjIzOTBkNiAoIkJsdWV0
b290aDogQWRkIEJUUFJPVE9fSVNPIHNvY2tldCB0eXBlIikKU2lnbmVkLW9mZi1ieTogTHVpeiBB
dWd1c3RvIHZvbiBEZW50eiA8bHVpei52b24uZGVudHpAaW50ZWwuY29tPgotLS0KIG5ldC9ibHVl
dG9vdGgvaXNvLmMgfCA1NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2lzby5jIGIvbmV0L2JsdWV0b290aC9pc28uYwpp
bmRleCBkNWUwMGQwZGQxYTAuLmNmZjA0ZWZjNTlmNyAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290
aC9pc28uYworKysgYi9uZXQvYmx1ZXRvb3RoL2lzby5jCkBAIC0xNjMsNiArMTYzLDIxIEBAIHN0
YXRpYyBzdHJ1Y3QgaXNvX2Nvbm4gKmlzb19jb25uX2FkZChzdHJ1Y3QgaGNpX2Nvbm4gKmhjb24p
CiAJcmV0dXJuIGNvbm47CiB9CiAKK3N0YXRpYyB2b2lkIGlzb19jb25uX2Ryb3Aoc3RydWN0IGlz
b19jb25uICpjb25uKQoreworCWlmICghY29ubiB8fCAhY29ubi0+aGNvbikKKwkJcmV0dXJuOwor
CisJQlRfREJHKCJjb25uICVwIGhjb24gJXAiLCBjb25uLCBjb25uLT5oY29uKTsKKworCWhjaV9j
b25uX2Ryb3AoY29ubi0+aGNvbik7CisKKwlpc29fY29ubl9sb2NrKGNvbm4pOworCWNvbm4tPmhj
b24tPmlzb19kYXRhID0gTlVMTDsKKwljb25uLT5oY29uID0gTlVMTDsKKwlpc29fY29ubl91bmxv
Y2soY29ubik7Cit9CisKIC8qIERlbGV0ZSBjaGFubmVsLiBNdXN0IGJlIGNhbGxlZCBvbiB0aGUg
bG9ja2VkIHNvY2tldC4gKi8KIHN0YXRpYyB2b2lkIGlzb19jaGFuX2RlbChzdHJ1Y3Qgc29jayAq
c2ssIGludCBlcnIpCiB7CkBAIC0xNzksOCArMTk0LDcgQEAgc3RhdGljIHZvaWQgaXNvX2NoYW5f
ZGVsKHN0cnVjdCBzb2NrICpzaywgaW50IGVycikKIAkJaXNvX3BpKHNrKS0+Y29ubiA9IE5VTEw7
CiAJCWlzb19jb25uX3VubG9jayhjb25uKTsKIAotCQlpZiAoY29ubi0+aGNvbikKLQkJCWhjaV9j
b25uX2Ryb3AoY29ubi0+aGNvbik7CisJCWlzb19jb25uX2Ryb3AoY29ubik7CiAJfQogCiAJc2st
PnNrX3N0YXRlID0gQlRfQ0xPU0VEOwpAQCAtMTk3LDYgKzIxMSwyMSBAQCBzdGF0aWMgdm9pZCBp
c29fY2hhbl9kZWwoc3RydWN0IHNvY2sgKnNrLCBpbnQgZXJyKQogCXNvY2tfc2V0X2ZsYWcoc2ss
IFNPQ0tfWkFQUEVEKTsKIH0KIAorc3RhdGljIHZvaWQgaXNvX2Nvbm5fZGVzdHJ1Y3Qoc3RydWN0
IGlzb19jb25uICpjb25uKQoreworCWlmICghY29ubikKKwkJcmV0dXJuOworCisJQlRfREJHKCJj
b25uICVwIiwgY29ubik7CisKKwlpc29fY29ubl9kcm9wKGNvbm4pOworCisJLyogRW5zdXJlIG5v
IG1vcmUgd29yayBpdGVtcyB3aWxsIHJ1biBiZWZvcmUgZnJlZWluZyBjb25uLiAqLworCWRpc2Fi
bGVfZGVsYXllZF93b3JrX3N5bmMoJmNvbm4tPnRpbWVvdXRfd29yayk7CisKKwlrZnJlZShjb25u
KTsKK30KKwogc3RhdGljIHZvaWQgaXNvX2Nvbm5fZGVsKHN0cnVjdCBoY2lfY29ubiAqaGNvbiwg
aW50IGVycikKIHsKIAlzdHJ1Y3QgaXNvX2Nvbm4gKmNvbm4gPSBoY29uLT5pc29fZGF0YTsKQEAg
LTIxNCwxOSArMjQzLDE2IEBAIHN0YXRpYyB2b2lkIGlzb19jb25uX2RlbChzdHJ1Y3QgaGNpX2Nv
bm4gKmhjb24sIGludCBlcnIpCiAJCXNvY2tfaG9sZChzayk7CiAJaXNvX2Nvbm5fdW5sb2NrKGNv
bm4pOwogCi0JaWYgKHNrKSB7Ci0JCWxvY2tfc29jayhzayk7Ci0JCWlzb19zb2NrX2NsZWFyX3Rp
bWVyKHNrKTsKLQkJaXNvX2NoYW5fZGVsKHNrLCBlcnIpOwotCQlyZWxlYXNlX3NvY2soc2spOwot
CQlzb2NrX3B1dChzayk7CisJaWYgKCFzaykgeworCQlpc29fY29ubl9kZXN0cnVjdChjb25uKTsK
KwkJcmV0dXJuOwogCX0KIAotCS8qIEVuc3VyZSBubyBtb3JlIHdvcmsgaXRlbXMgd2lsbCBydW4g
YmVmb3JlIGZyZWVpbmcgY29ubi4gKi8KLQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmNvbm4t
PnRpbWVvdXRfd29yayk7Ci0KLQloY29uLT5pc29fZGF0YSA9IE5VTEw7Ci0Ja2ZyZWUoY29ubik7
CisJbG9ja19zb2NrKHNrKTsKKwlpc29fc29ja19jbGVhcl90aW1lcihzayk7CisJaXNvX2NoYW5f
ZGVsKHNrLCBlcnIpOworCXJlbGVhc2Vfc29jayhzayk7CisJc29ja19wdXQoc2spOwogfQogCiBz
dGF0aWMgaW50IF9faXNvX2NoYW5fYWRkKHN0cnVjdCBpc29fY29ubiAqY29ubiwgc3RydWN0IHNv
Y2sgKnNrLApAQCAtNjQ2LDYgKzY3Miw4IEBAIHN0YXRpYyB2b2lkIGlzb19zb2NrX2Rlc3RydWN0
KHN0cnVjdCBzb2NrICpzaykKIHsKIAlCVF9EQkcoInNrICVwIiwgc2spOwogCisJaXNvX2Nvbm5f
ZGVzdHJ1Y3QoaXNvX3BpKHNrKS0+Y29ubik7CisKIAlza2JfcXVldWVfcHVyZ2UoJnNrLT5za19y
ZWNlaXZlX3F1ZXVlKTsKIAlza2JfcXVldWVfcHVyZ2UoJnNrLT5za193cml0ZV9xdWV1ZSk7CiB9
CkBAIC03MTQsNyArNzQyLDYgQEAgc3RhdGljIHZvaWQgaXNvX3NvY2tfZGlzY29ubihzdHJ1Y3Qg
c29jayAqc2spCiAJfQogCiAJc2stPnNrX3N0YXRlID0gQlRfRElTQ09OTjsKLQlpc29fc29ja19z
ZXRfdGltZXIoc2ssIElTT19ESVNDT05OX1RJTUVPVVQpOwogCWlzb19jb25uX2xvY2soaXNvX3Bp
KHNrKS0+Y29ubik7CiAJaGNpX2Nvbm5fZHJvcChpc29fcGkoc2spLT5jb25uLT5oY29uKTsKIAlp
c29fcGkoc2spLT5jb25uLT5oY29uID0gTlVMTDsKLS0gCjIuNDYuMQoK
--0000000000005764420623977718--
