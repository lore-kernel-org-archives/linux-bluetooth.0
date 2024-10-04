Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198191AA794
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058022; cv=none; b=JRMPWvmBelhginDVScxtCAnN3ME4sz4+pTgf5C44odF1DrZN/eKgVkpwE346iE8Hg7GNt1Xe7D0VJPC21nkwqu9GUF5WtZQQfaADA1puSPtccKPHbl5iY3rebaDHqHDHs/YyjHM821xhHWeke+KU9Ngz147qtNxRn4N+WFY36vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058022; c=relaxed/simple;
	bh=wqTS1oNOCDQfjLgrhL7QQrCI8QNYDyH+WuHVG4h0FwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ck38m0WSrve5/nJ/SmFo4zv3Qqd4vYN8lNuiMGHgCHhuTlRUPSPXpfKHHlGBENIZ4Q6OmdWF69Y3Ez4ZxdpeAW7mUJDBKV/OqbhgK+m2bZHu+Ta4/nsSbvdGKz52H0gynFlPeyD6bfQXX7BG1iz3DeiYfEE4DM1QN6RxD1vODAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmNtay42; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmNtay42"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso24961821fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Oct 2024 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728058018; x=1728662818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MIrFT4Uqkk9i0febl8vcEZ4ojmezLzGzvAavBRyvKNw=;
        b=VmNtay42hz/4MzT3x2FnIcaP/smu6Pp6t39r0eWkfv1G2jJAP1VKjEifTrTlRsnlVt
         5WKZGK4f30LDubQzv0sQ0I5yik17pUUTs8SXz16gopSyfszDMuFDduyenXQVs9LkdFUA
         o6oXXQKtZw1ySCVf8KTihtollZjGAF1DZ7XVd1HEmLOrM5sgWXOBFKMP9x0X/teTz20I
         6+qIBruT+DOIakR8qmezOsz8LUXpdMfgl9yD0EGJdfuP21mrf1v+3p7Bs2MjhyIskec3
         kFa+z8VIbYk0KiWM0Ho1+bi6eChxVme8NW8RPzteUgsAit4dYXIEPtzbRC3pzCRnbl8h
         KVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728058018; x=1728662818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIrFT4Uqkk9i0febl8vcEZ4ojmezLzGzvAavBRyvKNw=;
        b=DkJabprUUJ8scFalAeqyNbDcPmUSwTdIHDVMcuqbx0wTp2paq8bTazK46zrHTj5r1f
         95qjFiKp149U7RpQI4qWsudLdQkaxcX4jsXWkMM1sXfheXuhdpCN6bziuPOUw3bEZSVN
         jI5YwW089zlGNOYFInJdT1jWiI50LyY0H77hKuKxHz2ce64GVJGZmhvTDIyYt2hCnuxX
         kEjSPoKEjFiD5IvJOdInfdBz+o0jIA7WcHTtot0eddmXPYWJMkF/DHOAwHZIvbs4GUZw
         hT59JTFcqm8ynRg07/FbFyrolE9JlhOGSOXxc5QJqcQv0PyNfVjJpRiNcCbcEwTGB01X
         +Saw==
X-Gm-Message-State: AOJu0YxoBoVvhqkNeWA8yQemrOXJQvDsyGa/J5Ff3DbaMJiCqAJQRn7R
	V3Vn7bj4O+fzT9NyiQW4E8RI+lj2jFaYHtrMBn4hoTM+Df6xFJxt2drxpKOKcki+8LspvjfXwBA
	CCm/g6P4LskNXQSS8fCr2dhVmozvjbA==
X-Google-Smtp-Source: AGHT+IHdmsI+amEveU1ZyGXE0Dd5UEBjvsDyeHwPLznsuCNtjbvvu5lLTm8r4haATZfFs7ieX9MLt7dnGz9jS/C8Aec=
X-Received: by 2002:a2e:9e42:0:b0:2fa:e0c4:f08b with SMTP id
 38308e7fff4ca-2faf3c6630emr14170861fa.36.1728058018065; Fri, 04 Oct 2024
 09:06:58 -0700 (PDT)
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
 <CABBYNZJGF4156YhdOH5DoZ7hkh1NTrpQwntwJZiYJ9AyHYr14w@mail.gmail.com> <CABBYNZ+=iNpM0TF4jDCqfJM4VWHY+CY5Vp1Ah91i8jGNKUeMKQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+=iNpM0TF4jDCqfJM4VWHY+CY5Vp1Ah91i8jGNKUeMKQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 4 Oct 2024 12:06:45 -0400
Message-ID: <CABBYNZ+i88jmqD3pV2Czh=7fBhZ0_73s1+tsumt0+oVo8kSm1w@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: SCO: Use disable_delayed_work_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="000000000000518ee30623a8dc42"

--000000000000518ee30623a8dc42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Thu, Oct 3, 2024 at 3:21=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Thu, Oct 3, 2024 at 12:32=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Thu, Oct 3, 2024 at 11:38=E2=80=AFAM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > #syz test
> > > >
> > > > On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > #syz test
> > > > >
> > > > > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > #syz test
> > > > > >
> > > > > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > >
> > > > > > > This makes use of disable_delayed_work_sync instead
> > > > > > > cancel_delayed_work_sync as it not only cancel the ongoing wo=
rk but also
> > > > > > > disables new submit which is disarable since the object holdi=
ng the work
> > > > > > > is about to be freed.
> > > > > > >
> > > > > > > In addition to it remove call to sco_sock_set_timer on __sco_=
sock_close
> > > > > > > since at that point it is useless to set a timer as the sk wi=
ll be freed
> > > > > > > there is nothing to be done in sco_sock_timeout.
> > > > > > >
> > > > > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmai=
l.com
> > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde7=
87116d465
> > > > > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with d=
elayed_work")
> > > > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.c=
om>
> > > > > > > ---
> > > > > > >  net/bluetooth/sco.c | 13 +------------
> > > > > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > > > > >
> > > > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > > > > index a5ac160c592e..2b1e66976068 100644
> > > > > > > --- a/net/bluetooth/sco.c
> > > > > > > +++ b/net/bluetooth/sco.c
> > > > > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn =
*hcon, int err)
> > > > > > >         }
> > > > > > >
> > > > > > >         /* Ensure no more work items will run before freeing =
conn. */
> > > > > > > -       cancel_delayed_work_sync(&conn->timeout_work);
> > > > > > > +       disable_delayed_work_sync(&conn->timeout_work);
> > > > > > >
> > > > > > >         hcon->sco_data =3D NULL;
> > > > > > >         kfree(conn);
> > > > > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(struct sock=
 *sk)
> > > > > > >
> > > > > > >         case BT_CONNECTED:
> > > > > > >         case BT_CONFIG:
> > > > > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > > > > -                       sk->sk_state =3D BT_DISCONN;
> > > > > > > -                       sco_sock_set_timer(sk, SCO_DISCONN_TI=
MEOUT);
> > > > > > > -                       sco_conn_lock(sco_pi(sk)->conn);
> > > > > > > -                       hci_conn_drop(sco_pi(sk)->conn->hcon)=
;
> > > > > > > -                       sco_pi(sk)->conn->hcon =3D NULL;
> > > > > > > -                       sco_conn_unlock(sco_pi(sk)->conn);
> > > > > > > -               } else
> > > > > > > -                       sco_chan_del(sk, ECONNRESET);
> > > > > > > -               break;
> > > > > > > -
> > > > > > >         case BT_CONNECT2:
> > > > > > >         case BT_CONNECT:
> > > > > > >         case BT_DISCONN:
> > > > > > > --
> > > > > > > 2.46.1
> > > > > > >
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

--000000000000518ee30623a8dc42
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v4-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Disposition: attachment; 
	filename="v4-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1ux48px0>
X-Attachment-Id: f_m1ux48px0

RnJvbSA0MTIyZGJjYjg0N2ViYmM0YWU3MjYyMDIzMGJiYzhiOTI2Y2Q0NGY1IE1vbiBTZXAgMTcg
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
bnR6QGludGVsLmNvbT4KLS0tCiBuZXQvYmx1ZXRvb3RoL3Njby5jIHwgNjcgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDIgaW5z
ZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9z
Y28uYyBiL25ldC9ibHVldG9vdGgvc2NvLmMKaW5kZXggYTVhYzE2MGM1OTJlLi4xOWFmMTQ4YmJh
ZjggMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvc2NvLmMKKysrIGIvbmV0L2JsdWV0b290aC9z
Y28uYwpAQCAtMTU1LDYgKzE1NSwzNiBAQCBzdGF0aWMgc3RydWN0IHNjb19jb25uICpzY29fY29u
bl9hZGQoc3RydWN0IGhjaV9jb25uICpoY29uKQogCXJldHVybiBjb25uOwogfQogCitzdGF0aWMg
dm9pZCBzY29fY29ubl9kcm9wKHN0cnVjdCBzY29fY29ubiAqY29ubikKK3sKKwlpZiAoIWNvbm4g
fHwgIWNvbm4tPmhjb24pCisJCXJldHVybjsKKworCUJUX0RCRygiY29ubiAlcCBoY29uICVwIiwg
Y29ubiwgY29ubi0+aGNvbik7CisKKwloY2lfY29ubl9kcm9wKGNvbm4tPmhjb24pOworCisJc2Nv
X2Nvbm5fbG9jayhjb25uKTsKKwljb25uLT5oY29uLT5zY29fZGF0YSA9IE5VTEw7CisJY29ubi0+
aGNvbiA9IE5VTEw7CisJc2NvX2Nvbm5fdW5sb2NrKGNvbm4pOworCisJLyogRW5zdXJlIG5vIG1v
cmUgd29yayBpdGVtcyB3aWxsIHJ1biBzaW5jZSBoY2lfY29ubiBoYXMgYmVlbiBkcm9wcGVkICov
CisJZGlzYWJsZV9kZWxheWVkX3dvcmtfc3luYygmY29ubi0+dGltZW91dF93b3JrKTsKK30KKwor
c3RhdGljIHZvaWQgc2NvX2Nvbm5fZGVzdHJ1Y3Qoc3RydWN0IHNjb19jb25uICpjb25uKQorewor
CWlmICghY29ubikKKwkJcmV0dXJuOworCisJQlRfREJHKCJjb25uICVwIiwgY29ubik7CisKKwlz
Y29fY29ubl9kcm9wKGNvbm4pOworCisJa2ZyZWUoY29ubik7Cit9CisKIC8qIERlbGV0ZSBjaGFu
bmVsLgogICogTXVzdCBiZSBjYWxsZWQgb24gdGhlIGxvY2tlZCBzb2NrZXQuICovCiBzdGF0aWMg
dm9pZCBzY29fY2hhbl9kZWwoc3RydWN0IHNvY2sgKnNrLCBpbnQgZXJyKQpAQCAtMTcxLDggKzIw
MSw3IEBAIHN0YXRpYyB2b2lkIHNjb19jaGFuX2RlbChzdHJ1Y3Qgc29jayAqc2ssIGludCBlcnIp
CiAJCXNjb19waShzayktPmNvbm4gPSBOVUxMOwogCQlzY29fY29ubl91bmxvY2soY29ubik7CiAK
LQkJaWYgKGNvbm4tPmhjb24pCi0JCQloY2lfY29ubl9kcm9wKGNvbm4tPmhjb24pOworCQlzY29f
Y29ubl9kcm9wKGNvbm4pOwogCX0KIAogCXNrLT5za19zdGF0ZSA9IEJUX0NMT1NFRDsKQEAgLTE5
MiwyNiArMjIxLDIzIEBAIHN0YXRpYyB2b2lkIHNjb19jb25uX2RlbChzdHJ1Y3QgaGNpX2Nvbm4g
Kmhjb24sIGludCBlcnIpCiAKIAlCVF9EQkcoImhjb24gJXAgY29ubiAlcCwgZXJyICVkIiwgaGNv
biwgY29ubiwgZXJyKTsKIAotCS8qIEtpbGwgc29ja2V0ICovCiAJc2NvX2Nvbm5fbG9jayhjb25u
KTsKIAlzayA9IGNvbm4tPnNrOwogCWlmIChzaykKIAkJc29ja19ob2xkKHNrKTsKIAlzY29fY29u
bl91bmxvY2soY29ubik7CiAKLQlpZiAoc2spIHsKLQkJbG9ja19zb2NrKHNrKTsKLQkJc2NvX3Nv
Y2tfY2xlYXJfdGltZXIoc2spOwotCQlzY29fY2hhbl9kZWwoc2ssIGVycik7Ci0JCXJlbGVhc2Vf
c29jayhzayk7Ci0JCXNvY2tfcHV0KHNrKTsKKwlpZiAoIXNrKSB7CisJCXNjb19jb25uX2Rlc3Ry
dWN0KGNvbm4pOworCQlyZXR1cm47CiAJfQogCi0JLyogRW5zdXJlIG5vIG1vcmUgd29yayBpdGVt
cyB3aWxsIHJ1biBiZWZvcmUgZnJlZWluZyBjb25uLiAqLwotCWNhbmNlbF9kZWxheWVkX3dvcmtf
c3luYygmY29ubi0+dGltZW91dF93b3JrKTsKLQotCWhjb24tPnNjb19kYXRhID0gTlVMTDsKLQlr
ZnJlZShjb25uKTsKKwkvKiBLaWxsIHNvY2tldCAqLworCWxvY2tfc29jayhzayk7CisJc2NvX3Nv
Y2tfY2xlYXJfdGltZXIoc2spOworCXNjb19jaGFuX2RlbChzaywgZXJyKTsKKwlyZWxlYXNlX3Nv
Y2soc2spOworCXNvY2tfcHV0KHNrKTsKIH0KIAogc3RhdGljIHZvaWQgX19zY29fY2hhbl9hZGQo
c3RydWN0IHNjb19jb25uICpjb25uLCBzdHJ1Y3Qgc29jayAqc2ssCkBAIC0zOTUsNiArNDIxLDgg
QEAgc3RhdGljIHZvaWQgc2NvX3NvY2tfZGVzdHJ1Y3Qoc3RydWN0IHNvY2sgKnNrKQogewogCUJU
X0RCRygic2sgJXAiLCBzayk7CiAKKwlzY29fY29ubl9kZXN0cnVjdChzY29fcGkoc2spLT5jb25u
KTsKKwogCXNrYl9xdWV1ZV9wdXJnZSgmc2stPnNrX3JlY2VpdmVfcXVldWUpOwogCXNrYl9xdWV1
ZV9wdXJnZSgmc2stPnNrX3dyaXRlX3F1ZXVlKTsKIH0KQEAgLTQ0MiwxNyArNDcwLDYgQEAgc3Rh
dGljIHZvaWQgX19zY29fc29ja19jbG9zZShzdHJ1Y3Qgc29jayAqc2spCiAKIAljYXNlIEJUX0NP
Tk5FQ1RFRDoKIAljYXNlIEJUX0NPTkZJRzoKLQkJaWYgKHNjb19waShzayktPmNvbm4tPmhjb24p
IHsKLQkJCXNrLT5za19zdGF0ZSA9IEJUX0RJU0NPTk47Ci0JCQlzY29fc29ja19zZXRfdGltZXIo
c2ssIFNDT19ESVNDT05OX1RJTUVPVVQpOwotCQkJc2NvX2Nvbm5fbG9jayhzY29fcGkoc2spLT5j
b25uKTsKLQkJCWhjaV9jb25uX2Ryb3Aoc2NvX3BpKHNrKS0+Y29ubi0+aGNvbik7Ci0JCQlzY29f
cGkoc2spLT5jb25uLT5oY29uID0gTlVMTDsKLQkJCXNjb19jb25uX3VubG9jayhzY29fcGkoc2sp
LT5jb25uKTsKLQkJfSBlbHNlCi0JCQlzY29fY2hhbl9kZWwoc2ssIEVDT05OUkVTRVQpOwotCQli
cmVhazsKLQogCWNhc2UgQlRfQ09OTkVDVDI6CiAJY2FzZSBCVF9DT05ORUNUOgogCWNhc2UgQlRf
RElTQ09OTjoKLS0gCjIuNDYuMQoK
--000000000000518ee30623a8dc42--
