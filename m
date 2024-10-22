Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505671BD000
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615502; cv=none; b=O15jjQ7UxzYVcTcfFpAMWtjuYaoRAZhNJAQ6C+XdN6N6b30fUz8TMfcxJi7EMB1pgWn0sJ3yIe2rjlmmjRKIywOPYwGBkARx0xKqUXlJLfLANl3gj8YpsrZYKlMSjzKtyoxtGqxk3iHqVt0hniHuD2hKK8TL85a0INNu7dlKrK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615502; c=relaxed/simple;
	bh=O3TBJdWHlLq14TpX81IrDrVljGPpiWfYvB05KC1EEVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEbCrPJ8nP6hbccLMsFbNuz2/8RnuiYminN1D8Ru+LNCUtyWHH/ML2TYYPjFpEpN97tJTSZUlNRjbMmyVDbjBPluEcVNXitjSfuNVDsv1bXur7ozkymWYL56euBC1xrdkzZiNQ52U3MTchZ07QrEzABkJsbpJXXSgisg61yLzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJ7Ltv6m; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ7Ltv6m"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso209941fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729615497; x=1730220297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ASaGwMvVOSCv9VHI0RW179KyW8/g3aAGej3HBf+V/0=;
        b=WJ7Ltv6mTxN3DSo/ZSiHOY+b24ll+vcw87kwHwPcFJq1Tqudvte3tRglurV/+8l/tq
         W/F2ojwx+KwrU43IBkmHPfkGkitrletSk0szaQs72KzRktJ8sWig5gGdOKBg+x+7h6bY
         +xTqQE/RkH0kFevzPkq84DIOH6yJXUkQ5ayoJJhmRmRFpipvPEiiKGUXzqAwon3lM7bx
         R5dBNpRTHeC21oQMQasiMy8rliZpW4q/1ruVm2DTM21ahh1GQijsBKGW3rlxa+Wj5ZeX
         mIuSe3IJzrmuC4B70F2XX/5Ys1bvAvs9qlVsNWslFZEEAJooClYX2DZUPsnOTLA7okcN
         kyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729615497; x=1730220297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ASaGwMvVOSCv9VHI0RW179KyW8/g3aAGej3HBf+V/0=;
        b=gQEwBEA3UYkQsOI2QhdYCn1jx5//BQNTb7RfNwt/ZB7S156Pu8MKQHiy6IukjcmZcg
         nfL4dR0GSZ2pgVxn81RctTOgE7HgGep2O8BgLzLh6dsoQ8fztXwtdv1VGAg9JhM06p7S
         lI6/cD+J7SNqwFNXFhMt8a8aDXAsl042hkKufSBs4ZQQXXeXExP5gCzrl95mIeXxRt7+
         A1FdfXaIYw8NdODzJG7ag0TlftwLfpbXv5I//1ZOTyxbjcffIq/xgwccjgr9vTkA2tgv
         wbIupr1otWjvSGos5Y1ygAmh9/YQkMeRHzAhrWepsG7rFDtlXDnECQ1Hx/0JWt5SUMm2
         AkKg==
X-Gm-Message-State: AOJu0YwQbz8ODLLHltVp7/UazM2QrXH8ZfONSKb5Sv23JIEt/bHpBszz
	c3k5WfWKM54IS3e3T+ciZVmK3Tu0zxSxqq8fLHT5fcopK9F5UU/NP1GnVA5+vyej30NSoGn+tT9
	/gEf8oQ+hIKocJcQ0koOjpcZOS01aUg==
X-Google-Smtp-Source: AGHT+IFui0a9JlzREiKzANzNLVInJyuqobfXs2+12HQOsixvh8okuOiFMDa7npljs3q9NqcQkF5L2R16dWTW0Hqxe2E=
X-Received: by 2002:a2e:a585:0:b0:2fb:50e9:34cc with SMTP id
 38308e7fff4ca-2fc91d52ca7mr10699481fa.17.1729615497109; Tue, 22 Oct 2024
 09:44:57 -0700 (PDT)
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
 <CABBYNZ+i88jmqD3pV2Czh=7fBhZ0_73s1+tsumt0+oVo8kSm1w@mail.gmail.com>
 <CABBYNZLfELHraPs15x1PYhBUQrd_OQTnef00Y+5nm0w7US2_Wg@mail.gmail.com>
 <CABBYNZ+XB+hAN7BmOQiKpdBBHXX_8JrDm3HpXJ=JKVBg8R1CGA@mail.gmail.com> <CABBYNZKc5UFjYL5XxX0qy7vdOEENT1Pj7u6U4Pk+_cdJE+zAsg@mail.gmail.com>
In-Reply-To: <CABBYNZKc5UFjYL5XxX0qy7vdOEENT1Pj7u6U4Pk+_cdJE+zAsg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 22 Oct 2024 12:44:44 -0400
Message-ID: <CABBYNZLHhVmQj3R5JS13HTp7KrCrs-HBcRFLqn6AU44uLpbXjA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: SCO: Use disable_delayed_work_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="0000000000004dc6ce0625137d74"

--0000000000004dc6ce0625137d74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Mon, Oct 7, 2024 at 4:54=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Mon, Oct 7, 2024 at 1:16=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Fri, Oct 4, 2024 at 1:24=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Fri, Oct 4, 2024 at 12:06=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > #syz test
> > > >
> > > > On Thu, Oct 3, 2024 at 3:21=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > #syz test
> > > > >
> > > > > On Thu, Oct 3, 2024 at 12:32=E2=80=AFPM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > #syz test
> > > > > >
> > > > > > On Thu, Oct 3, 2024 at 11:38=E2=80=AFAM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > #syz test
> > > > > > >
> > > > > > > On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > #syz test
> > > > > > > >
> > > > > > > > On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Den=
tz
> > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > #syz test
> > > > > > > > >
> > > > > > > > > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von D=
entz
> > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > #syz test
> > > > > > > > > >
> > > > > > > > > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von=
 Dentz
> > > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.co=
m>
> > > > > > > > > > >
> > > > > > > > > > > This makes use of disable_delayed_work_sync instead
> > > > > > > > > > > cancel_delayed_work_sync as it not only cancel the on=
going work but also
> > > > > > > > > > > disables new submit which is disarable since the obje=
ct holding the work
> > > > > > > > > > > is about to be freed.
> > > > > > > > > > >
> > > > > > > > > > > In addition to it remove call to sco_sock_set_timer o=
n __sco_sock_close
> > > > > > > > > > > since at that point it is useless to set a timer as t=
he sk will be freed
> > > > > > > > > > > there is nothing to be done in sco_sock_timeout.
> > > > > > > > > > >
> > > > > > > > > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.ap=
pspotmail.com
> > > > > > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0=
d0c4cde787116d465
> > > > > > > > > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeout=
s with delayed_work")
> > > > > > > > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz=
@intel.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  net/bluetooth/sco.c | 13 +------------
> > > > > > > > > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.=
c
> > > > > > > > > > > index a5ac160c592e..2b1e66976068 100644
> > > > > > > > > > > --- a/net/bluetooth/sco.c
> > > > > > > > > > > +++ b/net/bluetooth/sco.c
> > > > > > > > > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct h=
ci_conn *hcon, int err)
> > > > > > > > > > >         }
> > > > > > > > > > >
> > > > > > > > > > >         /* Ensure no more work items will run before =
freeing conn. */
> > > > > > > > > > > -       cancel_delayed_work_sync(&conn->timeout_work)=
;
> > > > > > > > > > > +       disable_delayed_work_sync(&conn->timeout_work=
);
> > > > > > > > > > >
> > > > > > > > > > >         hcon->sco_data =3D NULL;
> > > > > > > > > > >         kfree(conn);
> > > > > > > > > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(str=
uct sock *sk)
> > > > > > > > > > >
> > > > > > > > > > >         case BT_CONNECTED:
> > > > > > > > > > >         case BT_CONFIG:
> > > > > > > > > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > > > > > > > > -                       sk->sk_state =3D BT_DISCONN;
> > > > > > > > > > > -                       sco_sock_set_timer(sk, SCO_DI=
SCONN_TIMEOUT);
> > > > > > > > > > > -                       sco_conn_lock(sco_pi(sk)->con=
n);
> > > > > > > > > > > -                       hci_conn_drop(sco_pi(sk)->con=
n->hcon);
> > > > > > > > > > > -                       sco_pi(sk)->conn->hcon =3D NU=
LL;
> > > > > > > > > > > -                       sco_conn_unlock(sco_pi(sk)->c=
onn);
> > > > > > > > > > > -               } else
> > > > > > > > > > > -                       sco_chan_del(sk, ECONNRESET);
> > > > > > > > > > > -               break;
> > > > > > > > > > > -
> > > > > > > > > > >         case BT_CONNECT2:
> > > > > > > > > > >         case BT_CONNECT:
> > > > > > > > > > >         case BT_DISCONN:
> > > > > > > > > > > --
> > > > > > > > > > > 2.46.1
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > Luiz Augusto von Dentz
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Luiz Augusto von Dentz
> > > > > > > >
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

--0000000000004dc6ce0625137d74
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v1-0001-Bluetooth-SCO-Fix-UAF-on-sco_sock_timeout.patch"
Content-Disposition: attachment; 
	filename="v1-0001-Bluetooth-SCO-Fix-UAF-on-sco_sock_timeout.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m2koedpm0>
X-Attachment-Id: f_m2koedpm0

RnJvbSA0YTk2MGQ2MmI5NWRlYWI2OThjNGUxM2FmMDM2YTNmMDU4OWFkZDcwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFR1ZSwgMjIgT2N0IDIwMjQgMTI6MzE6MDggLTA0MDAKU3ViamVj
dDogW1BBVENIIHYxXSBCbHVldG9vdGg6IFNDTzogRml4IFVBRiBvbiBzY29fc29ja190aW1lb3V0
Cgpjb25uLT5zayBtYXliZSBoYXZlIGJlZW4gdW5saW5rZWQvZnJlZWQgd2hpbGUgd2FpdGluZyBm
b3Igc2NvX2Nvbm5fbG9jawpzbyB0aGlzIGNoZWNrcyBpZiB0aGUgY29ubi0+c2sgaXMgc3RpbGwg
dmFsaWQgYnkgY2hlY2tpbmcgaWYgaXQgcGFydCBvZgpzY29fc2tfbGlzdC4KClJlcG9ydGVkLWJ5
OiBzeXpib3QrNGMwZDBjNGNkZTc4NzExNmQ0NjVAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpD
bG9zZXM6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD00YzBkMGM0Y2Rl
Nzg3MTE2ZDQ2NQpGaXhlczogYmEzMTZiZTFiNmEwICgiQmx1ZXRvb3RoOiBzY2hlZHVsZSBTQ08g
dGltZW91dHMgd2l0aCBkZWxheWVkX3dvcmsiKQpTaWduZWQtb2ZmLWJ5OiBMdWl6IEF1Z3VzdG8g
dm9uIERlbnR6IDxsdWl6LnZvbi5kZW50ekBpbnRlbC5jb20+Ci0tLQogbmV0L2JsdWV0b290aC9z
Y28uYyB8IDIzICsrKysrKysrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvc2Nv
LmMgYi9uZXQvYmx1ZXRvb3RoL3Njby5jCmluZGV4IGE1YWMxNjBjNTkyZS4uOWEyOGIyZjgzZTdj
IDEwMDY0NAotLS0gYS9uZXQvYmx1ZXRvb3RoL3Njby5jCisrKyBiL25ldC9ibHVldG9vdGgvc2Nv
LmMKQEAgLTc2LDYgKzc2LDI3IEBAIHN0cnVjdCBzY29fcGluZm8gewogI2RlZmluZSBTQ09fQ09O
Tl9USU1FT1VUCShIWiAqIDQwKQogI2RlZmluZSBTQ09fRElTQ09OTl9USU1FT1VUCShIWiAqIDIp
CiAKK3N0YXRpYyBib29sIHNjb19jb25uX2xpbmtlZChzdHJ1Y3Qgc2NvX2Nvbm4gKmNvbm4pCit7
CisJc3RydWN0IHNvY2sgKnNrOworCisJaWYgKCFjb25uIHx8ICFjb25uLT5zaykKKwkJcmV0dXJu
IGZhbHNlOworCisJcmVhZF9sb2NrKCZzY29fc2tfbGlzdC5sb2NrKTsKKworCXNrX2Zvcl9lYWNo
KHNrLCAmc2NvX3NrX2xpc3QuaGVhZCkgeworCQlpZiAoc2sgPT0gY29ubi0+c2spIHsKKwkJCXJl
YWRfdW5sb2NrKCZzY29fc2tfbGlzdC5sb2NrKTsKKwkJCXJldHVybiB0cnVlOworCQl9CisJfQor
CisJcmVhZF91bmxvY2soJnNjb19za19saXN0LmxvY2spOworCisJcmV0dXJuIGZhbHNlOworfQor
CiBzdGF0aWMgdm9pZCBzY29fc29ja190aW1lb3V0KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykK
IHsKIAlzdHJ1Y3Qgc2NvX2Nvbm4gKmNvbm4gPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IHNj
b19jb25uLApAQCAtODcsNyArMTA4LDcgQEAgc3RhdGljIHZvaWQgc2NvX3NvY2tfdGltZW91dChz
dHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJCXNjb19jb25uX3VubG9jayhjb25uKTsKIAkJcmV0
dXJuOwogCX0KLQlzayA9IGNvbm4tPnNrOworCXNrID0gc2NvX2Nvbm5fbGlua2VkKGNvbm4pID8g
Y29ubi0+c2sgOiBOVUxMOwogCWlmIChzaykKIAkJc29ja19ob2xkKHNrKTsKIAlzY29fY29ubl91
bmxvY2soY29ubik7Ci0tIAoyLjQ3LjAKCg==
--0000000000004dc6ce0625137d74--
