Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966FF15B984
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062659; cv=none; b=CGbmMDSDxk31MGZsc2/+x9JvAh75nbu1SVSSpwog+G5QcV/tqV4GJ8e3BVZ2UDU9QsxcxbFcqx9iDVtjWRO4OchFp/gImDuBCHc0VIHRVcsDRqctB04qsLQavOacEtAdkn44c8A6G/eZFy3x5o5GsWo5xgP6dks4XTTOVj8yzXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062659; c=relaxed/simple;
	bh=6kxZd1iD/qF/Nhh2BE3vFK66qDb6XrqSfYaBHecgrXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMjSUXKaL3uF8rF+KHTxQN+k1/bEOBJ9yjez0XSawcGntWfKNFWwDxz6DVHwSsT+CvfQd1OSIaXBL5Fgpd/AT+zU3ovDkDKrpsHbTlOqUPs8kDkuEoYBYVC6inR9yke39Vz3+NosXkvDt8UqL4NPpbB5RswiZ/Sn3TPLQFbc6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwSUosIu; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwSUosIu"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fad784e304so30445731fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Oct 2024 10:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728062655; x=1728667455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XEB3ubec3EUndjpoacN0TQo8A5H22hGjw4zmr0Wi6Ks=;
        b=MwSUosIuEUG+w1hT99tW3NNEn9grPG2GoL7T7T23X/8xKVUx33SBM91qI2c6nKQKlw
         lvMvM2cvMW1qVyDJyovZ+zQhQ/40Iy8hh2aWINC4xjcrMzKrqwCCb8EBgwXywpBiI0BR
         HcQIldyPosrYx7YKPaQlORwqT2T+Q1SCJW/cWY1Rkt6ZxbyOVXk6y/jmuyW2CvUI0HmH
         sDau5veOJtNC93t4735j4UM3myHhHt16n+dKWb9SJdK0vPQ0rbJmV7lh5RHrloxiYdS2
         5SJmpDcOn7V7G2YcyPZiTpdzwLmRxTGVNhMaBsXyj4/IvI1/LSuef8/cuuVNnlOMwlUm
         PZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728062655; x=1728667455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEB3ubec3EUndjpoacN0TQo8A5H22hGjw4zmr0Wi6Ks=;
        b=HeF4uXVaPb/OVsaNV0yWsqRrRnJ7BfCm5LZlHxRTIarN9lR4kcoPwY8Npkt13pa6uA
         f/+oFn0uF0piAJiS2z3QF0F+0O7v5pTiAiQ/bxFtnO2MV/StlwZHWQWygmPWkMj/swbO
         1laQ5hG9Hy/lVJfDpVi368eaL/Axc1ny5EYIizqTbS/h/Gt3RLZmATBX4HgVZ50f09F3
         h5PwP1FeTZ8cYV2TXg9gaqKUsu4z4wNDe4c7CKsHUwrFfhcfnx2+q6BSCvVkJMNnGq/k
         sdaZj1bVSw6PabIUlP0AyTwb5BTODzetXl8CHvDqO49ih/hd5Pv5VzCwsY4+RjjNc/eK
         I/Yg==
X-Gm-Message-State: AOJu0YyaVzLmKKxPWIsbuPVA4UY8T0uMuj8K1aeX3hQ6qjKkeDA4Emjd
	PYsN4ST2tRre8Hjs4dzp5/oK3n3ZBHy1DjAEyH4IfDnJecYHtX0HCXFk1r9WGxVaa7M6D8yUut3
	SZCrg8bxW8in6fG7dsk+XouLdSfQAMA==
X-Google-Smtp-Source: AGHT+IEibLuK5NReESunI/YIJXnmW/r7aqMu04SKXxv1hXSLOH1IBLfyTVv0jMVjqJ/ikOs72w0ZdB4VgKZNH2kGw90=
X-Received: by 2002:a05:651c:220d:b0:2f7:5d53:7196 with SMTP id
 38308e7fff4ca-2faf3c016cbmr23989811fa.4.1728062654559; Fri, 04 Oct 2024
 10:24:14 -0700 (PDT)
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
 <CABBYNZ+=iNpM0TF4jDCqfJM4VWHY+CY5Vp1Ah91i8jGNKUeMKQ@mail.gmail.com> <CABBYNZ+i88jmqD3pV2Czh=7fBhZ0_73s1+tsumt0+oVo8kSm1w@mail.gmail.com>
In-Reply-To: <CABBYNZ+i88jmqD3pV2Czh=7fBhZ0_73s1+tsumt0+oVo8kSm1w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 4 Oct 2024 13:24:01 -0400
Message-ID: <CABBYNZLfELHraPs15x1PYhBUQrd_OQTnef00Y+5nm0w7US2_Wg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: SCO: Use disable_delayed_work_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="000000000000ace2a30623a9f0b7"

--000000000000ace2a30623a9f0b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Fri, Oct 4, 2024 at 12:06=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Thu, Oct 3, 2024 at 3:21=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Thu, Oct 3, 2024 at 12:32=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Thu, Oct 3, 2024 at 11:38=E2=80=AFAM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > #syz test
> > > >
> > > > On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > #syz test
> > > > >
> > > > > On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > #syz test
> > > > > >
> > > > > > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > #syz test
> > > > > > >
> > > > > > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > > >
> > > > > > > > This makes use of disable_delayed_work_sync instead
> > > > > > > > cancel_delayed_work_sync as it not only cancel the ongoing =
work but also
> > > > > > > > disables new submit which is disarable since the object hol=
ding the work
> > > > > > > > is about to be freed.
> > > > > > > >
> > > > > > > > In addition to it remove call to sco_sock_set_timer on __sc=
o_sock_close
> > > > > > > > since at that point it is useless to set a timer as the sk =
will be freed
> > > > > > > > there is nothing to be done in sco_sock_timeout.
> > > > > > > >
> > > > > > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotm=
ail.com
> > > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cd=
e787116d465
> > > > > > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with=
 delayed_work")
> > > > > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel=
.com>
> > > > > > > > ---
> > > > > > > >  net/bluetooth/sco.c | 13 +------------
> > > > > > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > > > > > index a5ac160c592e..2b1e66976068 100644
> > > > > > > > --- a/net/bluetooth/sco.c
> > > > > > > > +++ b/net/bluetooth/sco.c
> > > > > > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_con=
n *hcon, int err)
> > > > > > > >         }
> > > > > > > >
> > > > > > > >         /* Ensure no more work items will run before freein=
g conn. */
> > > > > > > > -       cancel_delayed_work_sync(&conn->timeout_work);
> > > > > > > > +       disable_delayed_work_sync(&conn->timeout_work);
> > > > > > > >
> > > > > > > >         hcon->sco_data =3D NULL;
> > > > > > > >         kfree(conn);
> > > > > > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(struct so=
ck *sk)
> > > > > > > >
> > > > > > > >         case BT_CONNECTED:
> > > > > > > >         case BT_CONFIG:
> > > > > > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > > > > > -                       sk->sk_state =3D BT_DISCONN;
> > > > > > > > -                       sco_sock_set_timer(sk, SCO_DISCONN_=
TIMEOUT);
> > > > > > > > -                       sco_conn_lock(sco_pi(sk)->conn);
> > > > > > > > -                       hci_conn_drop(sco_pi(sk)->conn->hco=
n);
> > > > > > > > -                       sco_pi(sk)->conn->hcon =3D NULL;
> > > > > > > > -                       sco_conn_unlock(sco_pi(sk)->conn);
> > > > > > > > -               } else
> > > > > > > > -                       sco_chan_del(sk, ECONNRESET);
> > > > > > > > -               break;
> > > > > > > > -
> > > > > > > >         case BT_CONNECT2:
> > > > > > > >         case BT_CONNECT:
> > > > > > > >         case BT_DISCONN:
> > > > > > > > --
> > > > > > > > 2.46.1
> > > > > > > >
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

--000000000000ace2a30623a9f0b7
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v4-0002-Bluetooth-ISO-Use-disable_delayed_work_sync.patch"
Content-Disposition: attachment; 
	filename="v4-0002-Bluetooth-ISO-Use-disable_delayed_work_sync.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1uzvm4p0>
X-Attachment-Id: f_m1uzvm4p0

RnJvbSAwNTM0YWJhM2M2ZTBmOGJlYmIwMDM1MTZlNDMzZGNiZGRkM2UyMDE0IE1vbiBTZXAgMTcg
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
dG9vdGgvaXNvLmMgfCA1OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2lzby5jIGIvbmV0L2JsdWV0b290aC9pc28uYwpp
bmRleCBkNWUwMGQwZGQxYTAuLjAzMGQ0MDJjYzliZCAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290
aC9pc28uYworKysgYi9uZXQvYmx1ZXRvb3RoL2lzby5jCkBAIC0xNjMsNiArMTYzLDI0IEBAIHN0
YXRpYyBzdHJ1Y3QgaXNvX2Nvbm4gKmlzb19jb25uX2FkZChzdHJ1Y3QgaGNpX2Nvbm4gKmhjb24p
CiAJcmV0dXJuIGNvbm47CiB9CiAKK3N0YXRpYyB2b2lkIGlzb19jb25uX2Ryb3Aoc3RydWN0IGlz
b19jb25uICpjb25uKQoreworCWlmICghY29ubiB8fCAhY29ubi0+aGNvbikKKwkJcmV0dXJuOwor
CisJQlRfREJHKCJjb25uICVwIGhjb24gJXAiLCBjb25uLCBjb25uLT5oY29uKTsKKworCWhjaV9j
b25uX2Ryb3AoY29ubi0+aGNvbik7CisKKwlpc29fY29ubl9sb2NrKGNvbm4pOworCWNvbm4tPmhj
b24tPmlzb19kYXRhID0gTlVMTDsKKwljb25uLT5oY29uID0gTlVMTDsKKwlpc29fY29ubl91bmxv
Y2soY29ubik7CisKKwkvKiBFbnN1cmUgbm8gbW9yZSB3b3JrIGl0ZW1zIHdpbGwgcnVuIHNpbmNl
IGhjaV9jb25uIGhhcyBiZWVuIGRyb3BwZWQgKi8KKwlkaXNhYmxlX2RlbGF5ZWRfd29ya19zeW5j
KCZjb25uLT50aW1lb3V0X3dvcmspOworfQorCiAvKiBEZWxldGUgY2hhbm5lbC4gTXVzdCBiZSBj
YWxsZWQgb24gdGhlIGxvY2tlZCBzb2NrZXQuICovCiBzdGF0aWMgdm9pZCBpc29fY2hhbl9kZWwo
c3RydWN0IHNvY2sgKnNrLCBpbnQgZXJyKQogewpAQCAtMTc5LDggKzE5Nyw3IEBAIHN0YXRpYyB2
b2lkIGlzb19jaGFuX2RlbChzdHJ1Y3Qgc29jayAqc2ssIGludCBlcnIpCiAJCWlzb19waShzaykt
PmNvbm4gPSBOVUxMOwogCQlpc29fY29ubl91bmxvY2soY29ubik7CiAKLQkJaWYgKGNvbm4tPmhj
b24pCi0JCQloY2lfY29ubl9kcm9wKGNvbm4tPmhjb24pOworCQlpc29fY29ubl9kcm9wKGNvbm4p
OwogCX0KIAogCXNrLT5za19zdGF0ZSA9IEJUX0NMT1NFRDsKQEAgLTE5Nyw2ICsyMTQsMjEgQEAg
c3RhdGljIHZvaWQgaXNvX2NoYW5fZGVsKHN0cnVjdCBzb2NrICpzaywgaW50IGVycikKIAlzb2Nr
X3NldF9mbGFnKHNrLCBTT0NLX1pBUFBFRCk7CiB9CiAKK3N0YXRpYyB2b2lkIGlzb19jb25uX2Rl
c3RydWN0KHN0cnVjdCBpc29fY29ubiAqY29ubikKK3sKKwlpZiAoIWNvbm4pCisJCXJldHVybjsK
KworCUJUX0RCRygiY29ubiAlcCIsIGNvbm4pOworCisJaWYgKGNvbm4tPnNrKQorCQlpc29fcGko
Y29ubi0+c2spLT5jb25uID0gTlVMTDsKKworCWlzb19jb25uX2Ryb3AoY29ubik7CisKKwlrZnJl
ZShjb25uKTsKK30KKwogc3RhdGljIHZvaWQgaXNvX2Nvbm5fZGVsKHN0cnVjdCBoY2lfY29ubiAq
aGNvbiwgaW50IGVycikKIHsKIAlzdHJ1Y3QgaXNvX2Nvbm4gKmNvbm4gPSBoY29uLT5pc29fZGF0
YTsKQEAgLTIxNCwxOSArMjQ2LDE2IEBAIHN0YXRpYyB2b2lkIGlzb19jb25uX2RlbChzdHJ1Y3Qg
aGNpX2Nvbm4gKmhjb24sIGludCBlcnIpCiAJCXNvY2tfaG9sZChzayk7CiAJaXNvX2Nvbm5fdW5s
b2NrKGNvbm4pOwogCi0JaWYgKHNrKSB7Ci0JCWxvY2tfc29jayhzayk7Ci0JCWlzb19zb2NrX2Ns
ZWFyX3RpbWVyKHNrKTsKLQkJaXNvX2NoYW5fZGVsKHNrLCBlcnIpOwotCQlyZWxlYXNlX3NvY2so
c2spOwotCQlzb2NrX3B1dChzayk7CisJaWYgKCFzaykgeworCQlpc29fY29ubl9kZXN0cnVjdChj
b25uKTsKKwkJcmV0dXJuOwogCX0KIAotCS8qIEVuc3VyZSBubyBtb3JlIHdvcmsgaXRlbXMgd2ls
bCBydW4gYmVmb3JlIGZyZWVpbmcgY29ubi4gKi8KLQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMo
JmNvbm4tPnRpbWVvdXRfd29yayk7Ci0KLQloY29uLT5pc29fZGF0YSA9IE5VTEw7Ci0Ja2ZyZWUo
Y29ubik7CisJbG9ja19zb2NrKHNrKTsKKwlpc29fc29ja19jbGVhcl90aW1lcihzayk7CisJaXNv
X2NoYW5fZGVsKHNrLCBlcnIpOworCXJlbGVhc2Vfc29jayhzayk7CisJc29ja19wdXQoc2spOwog
fQogCiBzdGF0aWMgaW50IF9faXNvX2NoYW5fYWRkKHN0cnVjdCBpc29fY29ubiAqY29ubiwgc3Ry
dWN0IHNvY2sgKnNrLApAQCAtNjQ2LDYgKzY3NSw4IEBAIHN0YXRpYyB2b2lkIGlzb19zb2NrX2Rl
c3RydWN0KHN0cnVjdCBzb2NrICpzaykKIHsKIAlCVF9EQkcoInNrICVwIiwgc2spOwogCisJaXNv
X2Nvbm5fZGVzdHJ1Y3QoaXNvX3BpKHNrKS0+Y29ubik7CisKIAlza2JfcXVldWVfcHVyZ2UoJnNr
LT5za19yZWNlaXZlX3F1ZXVlKTsKIAlza2JfcXVldWVfcHVyZ2UoJnNrLT5za193cml0ZV9xdWV1
ZSk7CiB9CkBAIC03MTQsNyArNzQ1LDYgQEAgc3RhdGljIHZvaWQgaXNvX3NvY2tfZGlzY29ubihz
dHJ1Y3Qgc29jayAqc2spCiAJfQogCiAJc2stPnNrX3N0YXRlID0gQlRfRElTQ09OTjsKLQlpc29f
c29ja19zZXRfdGltZXIoc2ssIElTT19ESVNDT05OX1RJTUVPVVQpOwogCWlzb19jb25uX2xvY2so
aXNvX3BpKHNrKS0+Y29ubik7CiAJaGNpX2Nvbm5fZHJvcChpc29fcGkoc2spLT5jb25uLT5oY29u
KTsKIAlpc29fcGkoc2spLT5jb25uLT5oY29uID0gTlVMTDsKLS0gCjIuNDYuMQoK
--000000000000ace2a30623a9f0b7--
