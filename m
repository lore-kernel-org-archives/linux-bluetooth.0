Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238691DE2A2;
	Tue,  8 Oct 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397838; cv=none; b=VcyQ7E8ZoLoiTvSLWHoDZbo04XgISb/wIo6Qa5wdBbrIZpnyt5tXrUYfQhxy1Zp8RR56JWs5woVN6L2X9dCLg0DfGprhE57GFKhfSkIlwI5mbNpM3ZCqKqSOVImK18FlCNBMzPYLUjK+VOLEB4Ulh+jlZhdpPfL10+X6233j6sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397838; c=relaxed/simple;
	bh=hspAm430uzdvSH4Kl/q5TvcGCMWGpbYrsXeWH0f1rI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qATr/knTZZSf7pkYgQIw0AeLRRCFEz7p91ir8z1jlUDJMsaAgEmr6lNoh4QsV5dLUXgYmUD5o4q3X/EFnCqa/tSq9fta84oFkAcapwqhAl9l7ynhUOTcnecTqQnXWmEGerPkKiIxddSqdKoaK64kmR1FoOyg0EbYv4mhr5EOMXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO47RH/K; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO47RH/K"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fada911953so62270171fa.0;
        Tue, 08 Oct 2024 07:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397835; x=1729002635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y5wloPm3zI6pE7+25nJ8Izbhf7i5ZCY51yuv7kxCWg8=;
        b=FO47RH/KMw6qvtI2Ai3QbGaiFWTAdEPesY9Xu6vC8C7LfdnNOuHMuF+bmX/SrbeKZq
         FrKIBxHBDhNyVIpzvkeDp9iQasOlZuaqvxALHjUvcnI39D9QrqcfeMbBmW/Z/m40kBKN
         2wePqFlQ9MAJd8HZ5C3i9WLw7grL4AardRwnq5B1O1Wf44HeINuBgK3QPtSIvxUKDgKU
         dd5dNazhFeTpAh/DYhI2nYka2TorxNqPtbk1GnMUHEKLjAymgwEaI4bOChAjc/16JGLM
         y7wJODH/5rXP+D1esHRgYOeOvX+/2n3qzaSFLQNPbU7OtQ8euzN82O0asC+3GaNyspIT
         o8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397835; x=1729002635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5wloPm3zI6pE7+25nJ8Izbhf7i5ZCY51yuv7kxCWg8=;
        b=CaAKm5QJG6ue5o9wWp8ABrh5TzSuKa+OsNsFFJk7NzQvCDkz0pPRejPxMz6/IFI12j
         DxbKo1es4wPCZvoxfZqA0YripMeJErwDITpiA4s8Qaa0w+bcBqeAicPgKycBs3sUBhC9
         knOVcIGQKWb7BKBBxnUnR3fu3qx1uh56LWSrn7u07BKqLo6uobWs591xmDmpm574rJtv
         OZl9RFxsJpLK3ftg8szEd2mWer/H4g0EBAla04vAu2BmmsuX+hqAysbV4Vk0LU8IfpSU
         UUovICm0vA3pTJLVtopSNO/jrxNZAe2zHWhgjq9q7M5BZI8e5Ovg6Sol+l+/oqKW8QHk
         Jihw==
X-Forwarded-Encrypted: i=1; AJvYcCUmActB/wr3V6nQuDjoxhSqubmWRhAHz6eKnRPkrFrsuSOB0r3x52fgBY2V0Vmzcc6Dn8GorLS6ZuWa0HT6@vger.kernel.org, AJvYcCWpOh2zFKV2t94rIQ/QdNHGhVq/z5o9CdrkvUksRmiPERIzCamv36HvjND0HrzyP59ZY4ctRLh1McR/pITFv2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDUwZFWmg3Bh7lOiU5XOI2jZ9Y39GhK3hosjouoRlVyq5aWK4o
	ISCapsN7V8GRhubaXjvb1ICBhsodj2gBtbINEZi0OAc6M43cwmkskWoXVH+P9BKHIxGHbkh7kTX
	NKpky8WR+s49gFXOORYUQc/2bC1okig==
X-Google-Smtp-Source: AGHT+IFzs+laApkArKBrSxFxCRNylUn3Nj48GCJ/1NaW50SkB7uL6TrU5Wfpbme/dCZbYwgUbvEkhgz3ggmKQHOoByo=
X-Received: by 2002:a2e:a590:0:b0:2f2:b5c6:ccca with SMTP id
 38308e7fff4ca-2fb0def340cmr11623171fa.14.1728397834847; Tue, 08 Oct 2024
 07:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6703b264.050a0220.49194.0502.GAE@google.com> <tencent_29BA32BBF933AC9EDA1B074B621BEF259308@qq.com>
 <CABBYNZKiNBxqZbS7hcBrpiwHRRwAe9gXvHWNvi63qBfykR=SVg@mail.gmail.com>
In-Reply-To: <CABBYNZKiNBxqZbS7hcBrpiwHRRwAe9gXvHWNvi63qBfykR=SVg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Oct 2024 10:30:22 -0400
Message-ID: <CABBYNZJeFv3a=WuKpN0=6KwvELtWXOoRn9HrGhxnVVg_TVaa-Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_core: remove acl hdr handle error message
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com, 
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000fa20fa0623f7fa82"

--000000000000fa20fa0623f7fa82
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 10:12=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Edward,
>
> On Tue, Oct 8, 2024 at 6:47=E2=80=AFAM Edward Adam Davis <eadavis@qq.com>=
 wrote:
> >
> > Syzbot reported a uninit-value in hci_rx_work.This is because l2cap did=
n't
> > execute the corresponding connection request to call l2cap_send_cmd() o=
r
> > l2cap_do_send(), and ultimately called hci_add_acl_hdr() to set hdr->ha=
ndle.
>
> What are you talking about here, what these functions have to do with
> a local handle variable?
>
> > Therefore, when calling the thread callback function hci_rx_work() to c=
all
> > hci_acldata_packet, hdr->handle should not be used directly.
>
> It is not being used directly, the handle is a local variable which
> get assigned:
>
>     handle =3D __le16_to_cpu(hdr->handle);
>
> If what you are saying is that there is no guarantee that skb->len >=3D
> HCI_ACL_HDR_SIZE then we probably want to replace skb_pull with
> skb_pull_data.
>
> > Reported-and-tested-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotma=
il.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D6ea290ba76d8c1eb1ac2
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  net/bluetooth/hci_core.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index d6976db02c06..20605a7f3f4e 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3791,8 +3791,7 @@ static void hci_acldata_packet(struct hci_dev *hd=
ev, struct sk_buff *skb)
> >                 l2cap_recv_acldata(conn, skb, flags);
> >                 return;
> >         } else {
> > -               bt_dev_err(hdev, "ACL packet for unknown connection han=
dle %d",
> > -                          handle);
> > +               bt_dev_err(hdev, "ACL packet for unknown connection han=
dle");
> >         }
> >
> >         kfree_skb(skb);
> > --
> > 2.43.0
> >
>
>
> --
> Luiz Augusto von Dentz

#syz test

--=20
Luiz Augusto von Dentz

--000000000000fa20fa0623f7fa82
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v1-0001-Bluetooth-hci_core-Fix-not-checking-skb-length-on.patch"
Content-Disposition: attachment; 
	filename="v1-0001-Bluetooth-hci_core-Fix-not-checking-skb-length-on.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m20jfd430>
X-Attachment-Id: f_m20jfd430

RnJvbSBjZGEwMTM1Njk3ZDg2ZGU4YTJkNzMyZGYxN2UwZmE0OTdjMmYwMmZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFR1ZSwgOCBPY3QgMjAyNCAxMDoxNjo0OCAtMDQwMApTdWJqZWN0
OiBbUEFUQ0ggdjFdIEJsdWV0b290aDogaGNpX2NvcmU6IEZpeCBub3QgY2hlY2tpbmcgc2tiIGxl
bmd0aCBvbgogaGNpX2FjbGRhdGFfcGFja2V0CgpUaGlzIGZpeGVzIG5vdCBjaGVja2luZyBpZiBz
a2IgcmVhbGx5IGNvbnRhaW5zIGFuIEFDTCBoZWFkZXIgb3RoZXJ3aXNlCnRoZSBjb2RlIG1heSBh
dHRlbXB0IHRvIGFjY2VzcyBzb21lIHVuaW5pdGlsaXplZC9pbnZhbGlkIG1lbW9yeSBwYXN0IHRo
ZQphY3R1YWwgc2tiLT5kYXRhLgoKU2lnbmVkLW9mZi1ieTogTHVpeiBBdWd1c3RvIHZvbiBEZW50
eiA8bHVpei52b24uZGVudHpAaW50ZWwuY29tPgotLS0KIG5ldC9ibHVldG9vdGgvaGNpX2NvcmUu
YyB8IDEzICsrKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9oY2lfY29yZS5jIGIvbmV0
L2JsdWV0b290aC9oY2lfY29yZS5jCmluZGV4IGIyZjhmOWM1YjYxMC4uZDVmOTE3MDc2ZTBlIDEw
MDY0NAotLS0gYS9uZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmMKKysrIGIvbmV0L2JsdWV0b290aC9o
Y2lfY29yZS5jCkBAIC0zNzY1LDE4ICszNzY1LDIyIEBAIHN0YXRpYyB2b2lkIGhjaV90eF93b3Jr
KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIC8qIEFDTCBkYXRhIHBhY2tldCAqLwogc3RhdGlj
IHZvaWQgaGNpX2FjbGRhdGFfcGFja2V0KHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBzdHJ1Y3Qgc2tf
YnVmZiAqc2tiKQogewotCXN0cnVjdCBoY2lfYWNsX2hkciAqaGRyID0gKHZvaWQgKikgc2tiLT5k
YXRhOworCXN0cnVjdCBoY2lfYWNsX2hkciAqaGRyOwogCXN0cnVjdCBoY2lfY29ubiAqY29ubjsK
IAlfX3UxNiBoYW5kbGUsIGZsYWdzOwogCi0Jc2tiX3B1bGwoc2tiLCBIQ0lfQUNMX0hEUl9TSVpF
KTsKKwloZHIgPSBza2JfcHVsbF9kYXRhKHNrYiwgc2l6ZW9mKCpoZHIpKTsKKwlpZiAoIWhkcikg
eworCQlidF9kZXZfZXJyKGhkZXYsICJBQ0wgcGFja2V0IHRvbyBzbWFsbCIpOworCQlnb3RvIGRy
b3A7CisJfQogCiAJaGFuZGxlID0gX19sZTE2X3RvX2NwdShoZHItPmhhbmRsZSk7CiAJZmxhZ3Mg
ID0gaGNpX2ZsYWdzKGhhbmRsZSk7CiAJaGFuZGxlID0gaGNpX2hhbmRsZShoYW5kbGUpOwogCi0J
QlRfREJHKCIlcyBsZW4gJWQgaGFuZGxlIDB4JTQuNHggZmxhZ3MgMHglNC40eCIsIGhkZXYtPm5h
bWUsIHNrYi0+bGVuLAotCSAgICAgICBoYW5kbGUsIGZsYWdzKTsKKwlidF9kZXZfZGJnKGhkZXYs
ICJsZW4gJWQgaGFuZGxlIDB4JTQuNHggZmxhZ3MgMHglNC40eCIsIHNrYi0+bGVuLAorCQkgICBo
YW5kbGUsIGZsYWdzKTsKIAogCWhkZXYtPnN0YXQuYWNsX3J4Kys7CiAKQEAgLTM3OTcsNiArMzgw
MSw3IEBAIHN0YXRpYyB2b2lkIGhjaV9hY2xkYXRhX3BhY2tldChzdHJ1Y3QgaGNpX2RldiAqaGRl
diwgc3RydWN0IHNrX2J1ZmYgKnNrYikKIAkJCSAgIGhhbmRsZSk7CiAJfQogCitkcm9wOgogCWtm
cmVlX3NrYihza2IpOwogfQogCi0tIAoyLjQ2LjEKCg==
--000000000000fa20fa0623f7fa82--
