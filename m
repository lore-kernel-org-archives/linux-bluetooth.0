Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF11C9B79
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794719; cv=none; b=BZyrgKwbW34ovQUwfzAx2sTdcqpebjszcjGjTyfzF2M7oqMVBwR6zKQW1ZI0ThO0Jf7hKckVkmW0av8Taz/OKLSiSfcRNg+eIHWq4TftMhV8+Q5lxEDoECOPu2EOt1SJYHktTlnxKR2amxZCqAMw5QVEHCcPK2bS/FzU+o+b2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794719; c=relaxed/simple;
	bh=+pRPdaL0bywL8mGhtQrfvnVBzEPIbffRI8sjaXP4B9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiGwdDkSLnKA5pC26tLdJwe2nW+aHp9lIdY7zfleHzVLfcAJ3OtdFIJZXl9rwOmYmLyWQTLvZF2Ax6L2m9Aj0096WqJltyqWrwyNwBDkj5nFytOAFMcgCZubyzqUWmsAQ1tNE06KRcDNDqmBRuDRCZ36naOj2BIeH/NkBvLpPR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBqXvRJ2; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBqXvRJ2"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fabfc06c26so29583231fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Oct 2024 07:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727794715; x=1728399515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qJAyw0QGx8saB1LUVm04pxrl2VZ3C3afp8mcJlOl2WM=;
        b=CBqXvRJ2jxlaqThRcdShR6RNRVufj0sQt2KWusDectZWwd+lvAobdeN+slUvoLUQqV
         HIruB++1UDLHKa+x0VIx4AnFPs5wlrSrfGG+PPX3nh++rST8+tVPHfIekGq27Be6hVJN
         uzYxKLBo9g9i5BNQefF2KuLZnRYqr7kKSUi/mw+sEbgVXAro7ftRqe0kNmWM7l4BS5lg
         g9K1vxaj5/y5n6WFyOE64FLeqCGEB+wjmIxHjCpNPNSuOGUmWBX3hgQ2/XTpWBEASi61
         cvNvCebidO5dl5pMhpB9mclo2yvfWut06feplKKyvvh99Iu/+U/AhWn/eMVA4GJDAokB
         uYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727794715; x=1728399515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJAyw0QGx8saB1LUVm04pxrl2VZ3C3afp8mcJlOl2WM=;
        b=AWo49BysC/+n/ylN5hBur4t6iuV7UYiVHhHU3vLdOgdbSuh8aawAI90ZRsVwOmqQ81
         RaqdBKpTSWFZwr7/ed8AjZg4aGAJPDaZ5MYXueAFXYIqQ3r5G8gAzXWWJSAJApfOLuym
         zeEZZ+hEoZRudMu8gvKtvcSO0kwcQb/YeGJdWsusNjtZvtMuNipO+6T/Wro5P2Li22au
         69ohz3qzpCRMxb/p9i6QFLA/u9Q/BRnTmKt9LGoKXyFi+Ni3PMN24d/akSToKmxXvVS4
         47wckLTU3X2IOvRg6+0dXXrRvRHqQFRbCtQA+AcKznpAFK7thVExGYaOh/lCD0JF0YmZ
         enfQ==
X-Gm-Message-State: AOJu0Yybf4r2op8zr1kMV4klnaPQyFWKG2OO0nCk3gy/mJmv1/Y3xG3t
	umid8/px+37RGv+DZ5WaHvb4gUsOZvrmN9NDP1d+6gVvvb8amuO9gyMEWeG9LCJNjvgUBnAk4No
	Ad8T6zCtp6TpOk5Yuk+MAWO5S+6mGUDkv
X-Google-Smtp-Source: AGHT+IFXZ9JHB0LvByGx1q4VTJ95a1R0dFBYTfcaAjUmLZYmgNV4rgVEdpjc+5UWxNthk6HHQOqWsZY/O6iWJJ8SDHU=
X-Received: by 2002:a2e:d01:0:b0:2f7:5f6e:d894 with SMTP id
 38308e7fff4ca-2fae105f655mr350271fa.25.1727794714490; Tue, 01 Oct 2024
 07:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930193044.2907716-1-luiz.dentz@gmail.com> <CABBYNZJmvW8B65OR3M19pWnKCipDzoHbxKVtGvoQZCBi5feK+g@mail.gmail.com>
In-Reply-To: <CABBYNZJmvW8B65OR3M19pWnKCipDzoHbxKVtGvoQZCBi5feK+g@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Oct 2024 10:58:22 -0400
Message-ID: <CABBYNZJvjcnQm33Qn_ZbdPcrd2ZTF9jOQGJJcva35YigkfchAQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="00000000000033ddb206236b8e63"

--00000000000033ddb206236b8e63
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Mon, Sep 30, 2024 at 4:36=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> On Mon, Sep 30, 2024 at 3:30=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > rfcomm_sk_state_change attempts to use sock_lock so it must never be
> > called with it locked but rfcomm_sock_ioctl always attempt to lock it
> > causing the following trace:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > WARNING: possible circular locking dependency detected
> > 6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
> > ------------------------------------------------------
> > syz-executor386/5093 is trying to acquire lock:
> > ffff88807c396258 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at:=
 lock_sock include/net/sock.h:1671 [inline]
> > ffff88807c396258 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at:=
 rfcomm_sk_state_change+0x5b/0x310 net/bluetooth/rfcomm/sock.c:73
> >
> > but task is already holding lock:
> > ffff88807badfd28 (&d->lock){+.+.}-{3:3}, at: __rfcomm_dlc_close+0x226/0=
x6a0 net/bluetooth/rfcomm/core.c:491
> >
> > Reported-by: syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dd7ce59b06b3eb14fd218
> > Fixes: 3241ad820dbb ("[Bluetooth] Add timestamp support to L2CAP, RFCOM=
M and SCO")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/rfcomm/sock.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> > index 37d63d768afb..f48250e3f2e1 100644
> > --- a/net/bluetooth/rfcomm/sock.c
> > +++ b/net/bluetooth/rfcomm/sock.c
> > @@ -865,9 +865,7 @@ static int rfcomm_sock_ioctl(struct socket *sock, u=
nsigned int cmd, unsigned lon
> >
> >         if (err =3D=3D -ENOIOCTLCMD) {
> >  #ifdef CONFIG_BT_RFCOMM_TTY
> > -               lock_sock(sk);
> >                 err =3D rfcomm_dev_ioctl(sk, cmd, (void __user *) arg);
> > -               release_sock(sk);
> >  #else
> >                 err =3D -EOPNOTSUPP;
> >  #endif
> > --
> > 2.46.1
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

--00000000000033ddb206236b8e63
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v1-0001-Bluetooth-RFCOMM-FIX-possible-deadlock-in-rfcomm_.patch"
Content-Disposition: attachment; 
	filename="v1-0001-Bluetooth-RFCOMM-FIX-possible-deadlock-in-rfcomm_.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1qkclcc0>
X-Attachment-Id: f_m1qkclcc0

RnJvbSA5ZDY1MTU1NWVhNTMyNDg1Y2MzOGU3NTkxMzRlMGMyMzFjODkwZWFiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IE1vbiwgMzAgU2VwIDIwMjQgMTM6MjY6MjEgLTA0MDAKU3ViamVj
dDogW1BBVENIIHYxXSBCbHVldG9vdGg6IFJGQ09NTTogRklYIHBvc3NpYmxlIGRlYWRsb2NrIGlu
CiByZmNvbW1fc2tfc3RhdGVfY2hhbmdlCgpyZmNvbW1fc2tfc3RhdGVfY2hhbmdlIGF0dGVtcHRz
IHRvIHVzZSBzb2NrX2xvY2sgc28gaXQgbXVzdCBuZXZlciBiZQpjYWxsZWQgd2l0aCBpdCBsb2Nr
ZWQgYnV0IHJmY29tbV9zb2NrX2lvY3RsIGFsd2F5cyBhdHRlbXB0IHRvIGxvY2sgaXQKY2F1c2lu
ZyB0aGUgZm9sbG93aW5nIHRyYWNlOgoKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09CldBUk5JTkc6IHBvc3NpYmxlIGNpcmN1bGFyIGxvY2tpbmcg
ZGVwZW5kZW5jeSBkZXRlY3RlZAo2LjguMC1zeXprYWxsZXItMDg5NTEtZ2ZlNDZhN2RkMTg5ZSAj
MCBOb3QgdGFpbnRlZAotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0Kc3l6LWV4ZWN1dG9yMzg2LzUwOTMgaXMgdHJ5aW5nIHRvIGFjcXVpcmUgbG9j
azoKZmZmZjg4ODA3YzM5NjI1OCAoc2tfbG9jay1BRl9CTFVFVE9PVEgtQlRQUk9UT19SRkNPTU0p
eysuKy59LXswOjB9LCBhdDogbG9ja19zb2NrIGluY2x1ZGUvbmV0L3NvY2suaDoxNjcxIFtpbmxp
bmVdCmZmZmY4ODgwN2MzOTYyNTggKHNrX2xvY2stQUZfQkxVRVRPT1RILUJUUFJPVE9fUkZDT01N
KXsrLisufS17MDowfSwgYXQ6IHJmY29tbV9za19zdGF0ZV9jaGFuZ2UrMHg1Yi8weDMxMCBuZXQv
Ymx1ZXRvb3RoL3JmY29tbS9zb2NrLmM6NzMKCmJ1dCB0YXNrIGlzIGFscmVhZHkgaG9sZGluZyBs
b2NrOgpmZmZmODg4MDdiYWRmZDI4ICgmZC0+bG9jayl7Ky4rLn0tezM6M30sIGF0OiBfX3JmY29t
bV9kbGNfY2xvc2UrMHgyMjYvMHg2YTAgbmV0L2JsdWV0b290aC9yZmNvbW0vY29yZS5jOjQ5MQoK
UmVwb3J0ZWQtYnk6IHN5emJvdCtkN2NlNTliMDZiM2ViMTRmZDIxOEBzeXprYWxsZXIuYXBwc3Bv
dG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlk
PWQ3Y2U1OWIwNmIzZWIxNGZkMjE4CkZpeGVzOiAzMjQxYWQ4MjBkYmIgKCJbQmx1ZXRvb3RoXSBB
ZGQgdGltZXN0YW1wIHN1cHBvcnQgdG8gTDJDQVAsIFJGQ09NTSBhbmQgU0NPIikKU2lnbmVkLW9m
Zi1ieTogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei52b24uZGVudHpAaW50ZWwuY29tPgot
LS0KIG5ldC9ibHVldG9vdGgvcmZjb21tL3NvY2suYyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvcmZjb21tL3NvY2suYyBi
L25ldC9ibHVldG9vdGgvcmZjb21tL3NvY2suYwppbmRleCAzN2Q2M2Q3NjhhZmIuLmY0ODI1MGUz
ZjJlMSAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9yZmNvbW0vc29jay5jCisrKyBiL25ldC9i
bHVldG9vdGgvcmZjb21tL3NvY2suYwpAQCAtODY1LDkgKzg2NSw3IEBAIHN0YXRpYyBpbnQgcmZj
b21tX3NvY2tfaW9jdGwoc3RydWN0IHNvY2tldCAqc29jaywgdW5zaWduZWQgaW50IGNtZCwgdW5z
aWduZWQgbG9uCiAKIAlpZiAoZXJyID09IC1FTk9JT0NUTENNRCkgewogI2lmZGVmIENPTkZJR19C
VF9SRkNPTU1fVFRZCi0JCWxvY2tfc29jayhzayk7CiAJCWVyciA9IHJmY29tbV9kZXZfaW9jdGwo
c2ssIGNtZCwgKHZvaWQgX191c2VyICopIGFyZyk7Ci0JCXJlbGVhc2Vfc29jayhzayk7CiAjZWxz
ZQogCQllcnIgPSAtRU9QTk9UU1VQUDsKICNlbmRpZgotLSAKMi40Ni4xCgo=
--00000000000033ddb206236b8e63--
