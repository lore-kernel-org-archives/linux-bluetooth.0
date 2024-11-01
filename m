Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6CE1D0175
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489440; cv=none; b=sAa2u7iKRzci0yslsNDdo+8U+bblsuT9A8KhYR1873lJeDs5mmBedh9cYyWkU5YSffF+7nXoxjyTmZffcwzBwjQdHlWfxcQ5GDJJwtxqo2xWpyTiUWBVp87JzH23Atfrud2azzAdGCVmzsZ59C/sFs+3fT59PYkq/EfJ7GVFfO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489440; c=relaxed/simple;
	bh=R49zwzhtHrDj+vzqre8uZXIbVTQ4yPWT+Za4ZC108iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUVqM986AXQ6nFF2QPveViuExNObWVM7/M41mGcE8YLrfK2nbTWk0tm8mgnCFRa6UVFMchYrOby1+7JY5W2UwnWn7JwDJNPZkmjiqQp1dRsaDAH3AsN80wVFOL4iSfEIYkPajB0j2SEbhw8iPJYnzNU9/pI6f0ahlwHyU/Yy6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESielrgg; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESielrgg"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso21535931fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Nov 2024 12:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730489436; x=1731094236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/VsdE1t8br7BV7ewdTjWAH0Ii+RfMJzEFrcITkRmd3c=;
        b=ESielrggPZesE6EUDyRj9P+h+M8qSY8qdkMmw5Yl2+kwMtoE1J564DPVdCIYllwxPP
         BK0Ifz5lXypLpCX96KzyUWg5uraBD/aXLLvSFiR1HaFg1AC4zJ2IdvuHncBQ7675duvX
         rkPh7R0wHvmYtn1BWk6wKe708SlR3rnPqJHSnLr/NaIYFgKgOMZN/w4ATT4uGFB4SJeB
         /qMZiQYKcpd6yDZMEr9FHYKtZCWm3bVIDwKNWdUwL5HP4zpK/Aq5jr0p/RozDpeZ92rH
         JLfIXgGoypL0Z3aMAAwHrlGshrumVZmgTcmkrHxAhFi5Ho7Ma9J603YJYMN655Q7Ic8x
         b1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730489436; x=1731094236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VsdE1t8br7BV7ewdTjWAH0Ii+RfMJzEFrcITkRmd3c=;
        b=bDVKDBVwe/FfCqVVu938VvkOxxxAUibz6vw8qZiz9lxx7qDvjVgH4uaMI3AKQabCSq
         dFGz1xTlQNTIe/h8kqem8eMGmDHOs9yMm5P1p1bnybLaWv4ePe33LIW5TLwR/RLA+OtL
         E4MphYIcPoH+QByM6blXuDjmi4ShdXMwzJpHJe+pFLebDQlRZsJn1EgQ6LHX25soPMOU
         y/8fN5Tv/103AO0DnMWiCxnhEl0dBSKI8Ms6KbHV/MopZiNvB5xj+YCLHUzEgaKmRFj5
         JGncMNDFH0eHTiTUm3sdssTwU7C4gQcBZmeB+1HCZy4QzyXqRVntEtwDXRafKUsXVrUg
         t/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUTMJwL2C6Y/aRlZbDhx6VIHZHHkbpgOeHkp46m2w8zaE6eNr28jes5r/qKYzdhhOyRIWKFiASEP8hyrRUy4BI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1LtF2CIGdlzLRAEFDEk0JS/LiCdKWvlCWswsFxT94VaGizk7C
	+A0sCI4lg8ww80YslQ6fBRp+iEFMdm802jZAfjG4QjsfMz8hjsdouv49X44tXg4Nxw0T3O6ra0P
	mjr+zOq5WHtxktTR3/P05iYhqrJc=
X-Google-Smtp-Source: AGHT+IEGafQZXkW3BaP0hgWsXk+a8j1r18uzaIh8ZvO4v/89F66GHyRcTH05wN+a/6dgK5ONykh+ic/9YHRHGEN/rh4=
X-Received: by 2002:a2e:b8c5:0:b0:2f6:5921:f35b with SMTP id
 38308e7fff4ca-2fedb7a1fc4mr25720291fa.27.1730489435998; Fri, 01 Nov 2024
 12:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101114410.234311-1-dmantipov@yandex.ru> <CABBYNZK=H9JtzaQudQ1b7TGU5VaJ_qX_bbSJhKSwWKh+5_1uUQ@mail.gmail.com>
 <5cc24ab9-80c0-4280-8c4c-d8b052524e1d@yandex.ru> <CABBYNZKvP3u+7juqNNUHOS0PTb=QVzxob+rC3PVq-XXu9vGU+A@mail.gmail.com>
 <fe1588ee-1f00-429c-a917-d1c5e08f3831@yandex.ru> <CABBYNZJiYHWgtBExZ2jbuemJdyo6inpiYMGF7qc9Xbjqu__L7w@mail.gmail.com>
 <CABBYNZJXMyJ0bjVAe=sY+zonvFwS2Eh2wiSuzGd+a6U-3-8=fg@mail.gmail.com>
In-Reply-To: <CABBYNZJXMyJ0bjVAe=sY+zonvFwS2Eh2wiSuzGd+a6U-3-8=fg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 1 Nov 2024 15:30:23 -0400
Message-ID: <CABBYNZK3cVQ1nZbRDW2-VRTwOsJOW7hoRQEV26Qeh2juDjnMvA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: fix use-after-free in device_for_each_child()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="0000000000001eedb90625def81f"

--0000000000001eedb90625def81f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 1:37=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Dmitry,
>
> On Fri, Nov 1, 2024 at 11:31=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Dmitry,
> >
> > On Fri, Nov 1, 2024 at 11:17=E2=80=AFAM Dmitry Antipov <dmantipov@yande=
x.ru> wrote:
> > >
> > > On 11/1/24 6:12 PM, Luiz Augusto von Dentz wrote:
> > >
> > > > There is no Tested-by thus why I assumed it wasn't tested by syzbot=
 yet.
> > >
> > > Ugh. Until today I've assumed that Tested-by: is applicable to human-=
driven
> > > testing only :-).
> >
> > Nope, in fact it is very handy to have syzbot test your changes since
> > it may hit other problems as well.
>
> Looks like this doesn't solve the problem, in fact I think you are
> getting it backwards, you are trying to reparent the parent dev not
> the child and I assume by destroying the parent device there should be
> some way to reset the parent which seems to be the intent the
> following code in hci_conn_del_sysfs:
>
>     while (1) {
>         struct device *dev;
>
>         dev =3D device_find_child(&conn->dev, NULL, __match_tty);
>         if (!dev)
>             break;
>         device_move(dev, NULL, DPM_ORDER_DEV_LAST);
>         put_device(dev);
>     }
>
> But note that it only does that after matching tty, but I guess we
> want to do it regardless otherwise we may have the child objects still
> access it, that said we should probably use device_for_each_child
> though if that is safe to do calls to device_move under its callback.

#syz test

> > > Dmitry
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

--0000000000001eedb90625def81f
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v1-0001-Bluetooth-fix-use-after-free-in-device_for_each_c.patch"
Content-Disposition: attachment; 
	filename="v1-0001-Bluetooth-fix-use-after-free-in-device_for_each_c.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m2z4ozu60>
X-Attachment-Id: f_m2z4ozu60

RnJvbSBmZTBhMGRiOGEyNzJiNzNjNjFhOTU3YWRjY2FmMzAzOGY2NWQ3N2ZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEbWl0cnkgQW50aXBvdiA8ZG1hbnRpcG92QHlhbmRleC5ydT4K
RGF0ZTogRnJpLCAxIE5vdiAyMDI0IDE0OjQ0OjEwICswMzAwClN1YmplY3Q6IFtQQVRDSCB2MV0g
Qmx1ZXRvb3RoOiBmaXggdXNlLWFmdGVyLWZyZWUgaW4gZGV2aWNlX2Zvcl9lYWNoX2NoaWxkKCkK
ClN5emJvdCBoYXMgcmVwb3J0ZWQgdGhlIGZvbGxvd2luZyBLQVNBTiBzcGxhdDoKCkJVRzogS0FT
QU46IHNsYWItdXNlLWFmdGVyLWZyZWUgaW4gZGV2aWNlX2Zvcl9lYWNoX2NoaWxkKzB4MThmLzB4
MWEwClJlYWQgb2Ygc2l6ZSA4IGF0IGFkZHIgZmZmZjg4ODAxZjYwNTMwOCBieSB0YXNrIGtibmVw
ZCBibmVwMC80OTgwCgpDUFU6IDAgVUlEOiAwIFBJRDogNDk4MCBDb21tOiBrYm5lcGQgYm5lcDAg
Tm90IHRhaW50ZWQgNi4xMi4wLXJjNC0wMDE2MS1nYWU5MGY2YTYxNzBkICMxCkhhcmR3YXJlIG5h
bWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9TIDEuMTYuMy0y
LmZjNDAgMDQvMDEvMjAxNApDYWxsIFRyYWNlOgogPFRBU0s+CiBkdW1wX3N0YWNrX2x2bCsweDEw
MC8weDE5MAogPyBkZXZpY2VfZm9yX2VhY2hfY2hpbGQrMHgxOGYvMHgxYTAKIHByaW50X3JlcG9y
dCsweDEzYS8weDRjYgogPyBfX3ZpcnRfYWRkcl92YWxpZCsweDVlLzB4NTkwCiA/IF9fcGh5c19h
ZGRyKzB4YzYvMHgxNTAKID8gZGV2aWNlX2Zvcl9lYWNoX2NoaWxkKzB4MThmLzB4MWEwCiBrYXNh
bl9yZXBvcnQrMHhkYS8weDExMAogPyBkZXZpY2VfZm9yX2VhY2hfY2hpbGQrMHgxOGYvMHgxYTAK
ID8gX19wZnhfZGV2X21lbWFsbG9jX25vaW8rMHgxMC8weDEwCiBkZXZpY2VfZm9yX2VhY2hfY2hp
bGQrMHgxOGYvMHgxYTAKID8gX19wZnhfZGV2aWNlX2Zvcl9lYWNoX2NoaWxkKzB4MTAvMHgxMAog
cG1fcnVudGltZV9zZXRfbWVtYWxsb2Nfbm9pbysweGYyLzB4MTgwCiBuZXRkZXZfdW5yZWdpc3Rl
cl9rb2JqZWN0KzB4MWVkLzB4MjcwCiB1bnJlZ2lzdGVyX25ldGRldmljZV9tYW55X25vdGlmeSsw
eDEyM2MvMHgxZDgwCiA/IF9fbXV0ZXhfdHJ5bG9ja19jb21tb24rMHhkZS8weDI1MAogPyBfX3Bm
eF91bnJlZ2lzdGVyX25ldGRldmljZV9tYW55X25vdGlmeSsweDEwLzB4MTAKID8gdHJhY2VfY29u
dGVudGlvbl9lbmQrMHhlNi8weDE0MAogPyBfX211dGV4X2xvY2srMHg0ZTcvMHg4ZjAKID8gX19w
ZnhfbG9ja19hY3F1aXJlLnBhcnQuMCsweDEwLzB4MTAKID8gcmN1X2lzX3dhdGNoaW5nKzB4MTIv
MHhjMAogPyB1bnJlZ2lzdGVyX25ldGRldisweDEyLzB4MzAKIHVucmVnaXN0ZXJfbmV0ZGV2aWNl
X3F1ZXVlKzB4MzBkLzB4M2YwCiA/IF9fcGZ4X3VucmVnaXN0ZXJfbmV0ZGV2aWNlX3F1ZXVlKzB4
MTAvMHgxMAogPyBfX3BmeF9kb3duX3dyaXRlKzB4MTAvMHgxMAogdW5yZWdpc3Rlcl9uZXRkZXYr
MHgxYy8weDMwCiBibmVwX3Nlc3Npb24rMHgxZmIzLzB4MmFiMAogPyBfX3BmeF9ibmVwX3Nlc3Np
b24rMHgxMC8weDEwCiA/IF9fcGZ4X2xvY2tfcmVsZWFzZSsweDEwLzB4MTAKID8gX19wZnhfd29r
ZW5fd2FrZV9mdW5jdGlvbisweDEwLzB4MTAKID8gX19rdGhyZWFkX3BhcmttZSsweDEzMi8weDIw
MAogPyBfX3BmeF9ibmVwX3Nlc3Npb24rMHgxMC8weDEwCiA/IGt0aHJlYWQrMHgxM2EvMHgzNzAK
ID8gX19wZnhfYm5lcF9zZXNzaW9uKzB4MTAvMHgxMAoga3RocmVhZCsweDJiNy8weDM3MAogPyBf
X3BmeF9rdGhyZWFkKzB4MTAvMHgxMAogcmV0X2Zyb21fZm9yaysweDQ4LzB4ODAKID8gX19wZnhf
a3RocmVhZCsweDEwLzB4MTAKIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMAogPC9UQVNLPgoK
QWxsb2NhdGVkIGJ5IHRhc2sgNDk3NDoKIGthc2FuX3NhdmVfc3RhY2srMHgzMC8weDUwCiBrYXNh
bl9zYXZlX3RyYWNrKzB4MTQvMHgzMAogX19rYXNhbl9rbWFsbG9jKzB4YWEvMHhiMAogX19rbWFs
bG9jX25vcHJvZisweDFkMS8weDQ0MAogaGNpX2FsbG9jX2Rldl9wcml2KzB4MWQvMHgyODIwCiBf
X3ZoY2lfY3JlYXRlX2RldmljZSsweGVmLzB4N2QwCiB2aGNpX3dyaXRlKzB4MmM3LzB4NDgwCiB2
ZnNfd3JpdGUrMHg2YTAvMHhmYzAKIGtzeXNfd3JpdGUrMHgxMmYvMHgyNjAKIGRvX3N5c2NhbGxf
NjQrMHhjNy8weDI1MAogZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzcvMHg3ZgoK
RnJlZWQgYnkgdGFzayA0OTc5Ogoga2FzYW5fc2F2ZV9zdGFjaysweDMwLzB4NTAKIGthc2FuX3Nh
dmVfdHJhY2srMHgxNC8weDMwCiBrYXNhbl9zYXZlX2ZyZWVfaW5mbysweDNiLzB4NjAKIF9fa2Fz
YW5fc2xhYl9mcmVlKzB4NGYvMHg3MAoga2ZyZWUrMHgxNDEvMHg0OTAKIGhjaV9yZWxlYXNlX2Rl
disweDRkOS8weDYwMAogYnRfaG9zdF9yZWxlYXNlKzB4NmEvMHhiMAogZGV2aWNlX3JlbGVhc2Ur
MHhhNC8weDI0MAoga29iamVjdF9wdXQrMHgxZWMvMHg1YTAKIHB1dF9kZXZpY2UrMHgxZi8weDMw
CiB2aGNpX3JlbGVhc2UrMHg4MS8weGYwCiBfX2ZwdXQrMHgzZjYvMHhiMzAKIHRhc2tfd29ya19y
dW4rMHgxNTEvMHgyNTAKIGRvX2V4aXQrMHhhNzkvMHgyYzMwCiBkb19ncm91cF9leGl0KzB4ZDUv
MHgyYTAKIGdldF9zaWduYWwrMHgxZmNkLzB4MjIxMAogYXJjaF9kb19zaWduYWxfb3JfcmVzdGFy
dCsweDkzLzB4NzgwCiBzeXNjYWxsX2V4aXRfdG9fdXNlcl9tb2RlKzB4MTQwLzB4MjkwCiBkb19z
eXNjYWxsXzY0KzB4ZDQvMHgyNTAKIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc3
LzB4N2YKCkluICdoY2lfY29ubl9kZWxfc3lzZnMoKScsICdkZXZpY2VfdW5yZWdpc3RlcigpJyBt
YXkgYmUgY2FsbGVkIHdoZW4KYW4gdW5kZXJseWluZyAoa29iamVjdCkgcmVmZXJlbmNlIGNvdW50
ZXIgaXMgZ3JlYXRlciB0aGFuIDEuIFRoaXMKbWVhbnMgdGhhdCByZXBhcmVudGluZyAoaGFwcGVu
ZWQgd2hlbiB0aGUgZGV2aWNlIGlzIGFjdHVhbGx5IGZyZWVkKQppcyBkZWxheWVkIGFuZCwgZHVy
aW5nIHRoYXQgZGVsYXksIHBhcmVudCBjb250cm9sbGVyIGRldmljZSAoaGNpWCkKbWF5IGJlIGRl
bGV0ZWQuIFNpbmNlIHRoZSBsYXR0ZXIgbWF5IGNyZWF0ZSBhIGRhbmdsaW5nIHBvaW50ZXIgdG8K
ZnJlZWQgcGFyZW50LCBhdm9pZCB0aGF0IHNjZW5hcmlvIGJ5IHJlcGFyZW50aW5nIHRvIE5VTEwg
ZXhwbGljaXRseS4KClJlcG9ydGVkLWJ5OiBzeXpib3QrNmNmNTY1MmQzZGY0OWZhZTJlM2ZAc3l6
a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpDbG9zZXM6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3Qu
Y29tL2J1Zz9leHRpZD02Y2Y1NjUyZDNkZjQ5ZmFlMmUzZgpGaXhlczogYTg1ZmI5MWUzZDcyICgi
Qmx1ZXRvb3RoOiBGaXggZG91YmxlIGZyZWUgaW4gaGNpX2Nvbm5fY2xlYW51cCIpClNpZ25lZC1v
ZmYtYnk6IERtaXRyeSBBbnRpcG92IDxkbWFudGlwb3ZAeWFuZGV4LnJ1PgpTaWduZWQtb2ZmLWJ5
OiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50ekBpbnRlbC5jb20+Ci0tLQog
bmV0L2JsdWV0b290aC9oY2lfc3lzZnMuYyB8IDUgKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2hj
aV9zeXNmcy5jIGIvbmV0L2JsdWV0b290aC9oY2lfc3lzZnMuYwppbmRleCAzNjdlMzJmZTMwZWIu
LmRhNzRiMzg2MzdjZSAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9oY2lfc3lzZnMuYworKysg
Yi9uZXQvYmx1ZXRvb3RoL2hjaV9zeXNmcy5jCkBAIC03MywxMCArNzMsMTMgQEAgdm9pZCBoY2lf
Y29ubl9kZWxfc3lzZnMoc3RydWN0IGhjaV9jb25uICpjb25uKQogCQlyZXR1cm47CiAJfQogCisJ
LyogSWYgdGhlcmUgYXJlIGRldmljZXMgdXNpbmcgdGhlIGNvbm5lY3Rpb24gYXMgcGFyZW50IHJl
c2V0IGl0IHRvIE5VTEwKKwkgKiBiZWZvcmUgdW5yZWdpc3RlcmluZyB0aGUgZGV2aWNlLgorCSAq
LwogCXdoaWxlICgxKSB7CiAJCXN0cnVjdCBkZXZpY2UgKmRldjsKIAotCQlkZXYgPSBkZXZpY2Vf
ZmluZF9jaGlsZCgmY29ubi0+ZGV2LCBOVUxMLCBfX21hdGNoX3R0eSk7CisJCWRldiA9IGRldmlj
ZV9maW5kX2FueV9jaGlsZCgmY29ubi0+ZGV2KTsKIAkJaWYgKCFkZXYpCiAJCQlicmVhazsKIAkJ
ZGV2aWNlX21vdmUoZGV2LCBOVUxMLCBEUE1fT1JERVJfREVWX0xBU1QpOwotLSAKMi40Ny4wCgo=
--0000000000001eedb90625def81f--
