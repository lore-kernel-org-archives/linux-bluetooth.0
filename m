Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D4518B491
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Oct 2024 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728334465; cv=none; b=i2N+Ih2jpMsxI9wi/PvkqN+lTNUsyoINcXjZbCmLM1Ye4lFT4Oyt+gqmwjRyvJzshS/J4qxr65btDtfqlPZZqtvfO6U4QQ7oy+F83jpMQENdwlvrzA1d6wiFLlQM8ki2qZA5IWG313wUAK8EMBESXSXft7Cs2Gu2nS/HAx5TCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728334465; c=relaxed/simple;
	bh=1o3ylMQBvHbL4s6EvjwQ83ZBAFkHeaAdnVvQloUKBik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esBn5An2AdutYP4x/kLuomNSw3yMdNLYsaQBlJBiFmFpZkYd/v6VxQKhLMzyAtt/Gg3u2xlSexJpPUJQuO3a9LOmUtbGy3sCSQ5mpXCYjFZxazP0b0TsnwQc90/0MDrkY67eCFWI6XQ8XBAHG/zKoaF7+AWZA4+BOc66QiubiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRhODPWv; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRhODPWv"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fabfc06c26so42678231fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Oct 2024 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728334461; x=1728939261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NUWfORW2qyDuqiXRb9QpHIt2nzH94MZ1C3js1UExrYI=;
        b=XRhODPWvOX7LQkKbJ0+ugvOsujQF3Ct2vJicz7AIbMUHC3simqTC2ZbP3s5EgiJFgo
         r87q4SO/sWW+NxkKdzw6yp1wqwUzs9Grk87WmWd+rqZuk0Bqr5tkTfScFUBnt4Sb8GPK
         kC+Bzo3L5zgSS6OWCDjr1+nbY0jG82/MXwngZYms+BSi8PUAgJZAAMx/40MIHvsEn5AW
         88zZgPap2TmJDluZzt7+P+U0WN3Y1okt5b/BqPo0Vn9wdm8C1KBO0be+zIUrfeNy9sOx
         +lW8qBSwwqpPJdS7638Oaon98gqKC4LhpAZImoKjv669Wi2oisV434j+xFk4pO1xTIm3
         u9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728334461; x=1728939261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUWfORW2qyDuqiXRb9QpHIt2nzH94MZ1C3js1UExrYI=;
        b=I1lsZAoqdXTRb1Ly4YEIUMTDeZK4w2SbxBqISgC8gGIrHS1gAsPSqZWBN7orBsIHLt
         Q8tEYmuQ+4JHUYq+Vi9U+3Z1pu8wyDRNEsLWEw8r/WfOzVuCi5FRyVyT6FMcvwXL6ImT
         6gDF6cbR8TCnguMqdgPpJz/vIQNuGqC7WYSlczKFShbcqd0s4fYfsivEcb6MsSw/xpmq
         UCyiN3pshKxboUouLGgDlMALCsLXk4qLZKCQHt8hTE1n51+Uq4lYqM5uvEkWdRIcvsA9
         ABL/D63viDBkxrC6K0YyDxflr8FbrXU1fBtMxV+9wSflynLLKoKt2vYhoiDfLtVursob
         NAAA==
X-Gm-Message-State: AOJu0YytG9y3+EatRuU0UsstOj3H7GsR5Pqll9i2RgAR4LDHeWv1UtF8
	JS2ci2ja7hHtiQ4aSXnB5SfpKRssKrLtieGfLKesPfn9Onvz/yDDflnE22wK1Jp3n3se/60PzzR
	6+ejR9h+riP0Hr5TFHTURHNWF/uF9wQ==
X-Google-Smtp-Source: AGHT+IGus32TIJmUQFgxvMrMOz1xjwbqVPV3nTAzunzd756PYqWfrKZ46ZCEZPlwa5xvgspGzuHMoxA6Zu8io4g8Qvs=
X-Received: by 2002:a05:651c:2211:b0:2fa:ce00:3689 with SMTP id
 38308e7fff4ca-2faf3c2fe60mr63380851fa.6.1728334460239; Mon, 07 Oct 2024
 13:54:20 -0700 (PDT)
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
 <CABBYNZLfELHraPs15x1PYhBUQrd_OQTnef00Y+5nm0w7US2_Wg@mail.gmail.com> <CABBYNZ+XB+hAN7BmOQiKpdBBHXX_8JrDm3HpXJ=JKVBg8R1CGA@mail.gmail.com>
In-Reply-To: <CABBYNZ+XB+hAN7BmOQiKpdBBHXX_8JrDm3HpXJ=JKVBg8R1CGA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 7 Oct 2024 16:54:06 -0400
Message-ID: <CABBYNZKc5UFjYL5XxX0qy7vdOEENT1Pj7u6U4Pk+_cdJE+zAsg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: SCO: Use disable_delayed_work_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="0000000000008e615b0623e9391d"

--0000000000008e615b0623e9391d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Mon, Oct 7, 2024 at 1:16=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Fri, Oct 4, 2024 at 1:24=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Fri, Oct 4, 2024 at 12:06=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Thu, Oct 3, 2024 at 3:21=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > #syz test
> > > >
> > > > On Thu, Oct 3, 2024 at 12:32=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > #syz test
> > > > >
> > > > > On Thu, Oct 3, 2024 at 11:38=E2=80=AFAM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > #syz test
> > > > > >
> > > > > > On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > #syz test
> > > > > > >
> > > > > > > On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > #syz test
> > > > > > > >
> > > > > > > > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Den=
tz
> > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > #syz test
> > > > > > > > >
> > > > > > > > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von D=
entz
> > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > > > > >
> > > > > > > > > > This makes use of disable_delayed_work_sync instead
> > > > > > > > > > cancel_delayed_work_sync as it not only cancel the ongo=
ing work but also
> > > > > > > > > > disables new submit which is disarable since the object=
 holding the work
> > > > > > > > > > is about to be freed.
> > > > > > > > > >
> > > > > > > > > > In addition to it remove call to sco_sock_set_timer on =
__sco_sock_close
> > > > > > > > > > since at that point it is useless to set a timer as the=
 sk will be freed
> > > > > > > > > > there is nothing to be done in sco_sock_timeout.
> > > > > > > > > >
> > > > > > > > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.apps=
potmail.com
> > > > > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0=
c4cde787116d465
> > > > > > > > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts =
with delayed_work")
> > > > > > > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@i=
ntel.com>
> > > > > > > > > > ---
> > > > > > > > > >  net/bluetooth/sco.c | 13 +------------
> > > > > > > > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > > > > > > > index a5ac160c592e..2b1e66976068 100644
> > > > > > > > > > --- a/net/bluetooth/sco.c
> > > > > > > > > > +++ b/net/bluetooth/sco.c
> > > > > > > > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci=
_conn *hcon, int err)
> > > > > > > > > >         }
> > > > > > > > > >
> > > > > > > > > >         /* Ensure no more work items will run before fr=
eeing conn. */
> > > > > > > > > > -       cancel_delayed_work_sync(&conn->timeout_work);
> > > > > > > > > > +       disable_delayed_work_sync(&conn->timeout_work);
> > > > > > > > > >
> > > > > > > > > >         hcon->sco_data =3D NULL;
> > > > > > > > > >         kfree(conn);
> > > > > > > > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(struc=
t sock *sk)
> > > > > > > > > >
> > > > > > > > > >         case BT_CONNECTED:
> > > > > > > > > >         case BT_CONFIG:
> > > > > > > > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > > > > > > > -                       sk->sk_state =3D BT_DISCONN;
> > > > > > > > > > -                       sco_sock_set_timer(sk, SCO_DISC=
ONN_TIMEOUT);
> > > > > > > > > > -                       sco_conn_lock(sco_pi(sk)->conn)=
;
> > > > > > > > > > -                       hci_conn_drop(sco_pi(sk)->conn-=
>hcon);
> > > > > > > > > > -                       sco_pi(sk)->conn->hcon =3D NULL=
;
> > > > > > > > > > -                       sco_conn_unlock(sco_pi(sk)->con=
n);
> > > > > > > > > > -               } else
> > > > > > > > > > -                       sco_chan_del(sk, ECONNRESET);
> > > > > > > > > > -               break;
> > > > > > > > > > -
> > > > > > > > > >         case BT_CONNECT2:
> > > > > > > > > >         case BT_CONNECT:
> > > > > > > > > >         case BT_DISCONN:
> > > > > > > > > > --
> > > > > > > > > > 2.46.1
> > > > > > > > > >
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

--0000000000008e615b0623e9391d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v4-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Disposition: attachment; 
	filename="v4-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1zhpbli0>
X-Attachment-Id: f_m1zhpbli0

RnJvbSAxMjAyYWU0ZTE2YzA0MmExNDk3MjVlMzBiM2U4ODU3MTIwZjBmMmE3IE1vbiBTZXAgMTcg
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
bnR6QGludGVsLmNvbT4KLS0tCiBuZXQvYmx1ZXRvb3RoL3Njby5jIHwgOTkgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNzEgaW5z
ZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9z
Y28uYyBiL25ldC9ibHVldG9vdGgvc2NvLmMKaW5kZXggYTVhYzE2MGM1OTJlLi5hOTM3YzNiOWQ2
MzkgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvc2NvLmMKKysrIGIvbmV0L2JsdWV0b290aC9z
Y28uYwpAQCAtNTEsNiArNTEsNyBAQCBzdHJ1Y3Qgc2NvX2Nvbm4gewogCXN0cnVjdCBkZWxheWVk
X3dvcmsJdGltZW91dF93b3JrOwogCiAJdW5zaWduZWQgaW50ICAgIG10dTsKKwlzdHJ1Y3Qga3Jl
ZglyZWY7CiB9OwogCiAjZGVmaW5lIHNjb19jb25uX2xvY2soYykJc3Bpbl9sb2NrKCZjLT5sb2Nr
KQpAQCAtNzYsMTIgKzc3LDU5IEBAIHN0cnVjdCBzY29fcGluZm8gewogI2RlZmluZSBTQ09fQ09O
Tl9USU1FT1VUCShIWiAqIDQwKQogI2RlZmluZSBTQ09fRElTQ09OTl9USU1FT1VUCShIWiAqIDIp
CiAKK3N0YXRpYyB2b2lkIHNjb19jb25uX2ZyZWUoc3RydWN0IGtyZWYgKnJlZikKK3sKKwlzdHJ1
Y3Qgc2NvX2Nvbm4gKmNvbm4gPSBjb250YWluZXJfb2YocmVmLCBzdHJ1Y3Qgc2NvX2Nvbm4sIHJl
Zik7CisKKwlCVF9EQkcoImNvbm4gJXAiLCBjb25uKTsKKworCWlmIChjb25uLT5zaykKKwkJc2Nv
X3BpKGNvbm4tPnNrKS0+Y29ubiA9IE5VTEw7CisKKwlpZiAoY29ubi0+aGNvbikgeworCQljb25u
LT5oY29uLT5zY29fZGF0YSA9IE5VTEw7CisJCWhjaV9jb25uX2Ryb3AoY29ubi0+aGNvbik7CisJ
fQorCisJLyogRW5zdXJlIG5vIG1vcmUgd29yayBpdGVtcyB3aWxsIHJ1biBzaW5jZSBoY2lfY29u
biBoYXMgYmVlbiBkcm9wcGVkICovCisJZGlzYWJsZV9kZWxheWVkX3dvcmtfc3luYygmY29ubi0+
dGltZW91dF93b3JrKTsKKworCWtmcmVlKGNvbm4pOworfQorCitzdGF0aWMgdm9pZCBzY29fY29u
bl9wdXQoc3RydWN0IHNjb19jb25uICpjb25uKQoreworCWlmICghY29ubikKKwkJcmV0dXJuOwor
CisJQlRfREJHKCJjb25uICVwIHJlZmNudCAlZCIsIGNvbm4sIGtyZWZfcmVhZCgmY29ubi0+cmVm
KSk7CisKKwlrcmVmX3B1dCgmY29ubi0+cmVmLCBzY29fY29ubl9mcmVlKTsKK30KKworc3RhdGlj
IHN0cnVjdCBzY29fY29ubiAqc2NvX2Nvbm5faG9sZF91bmxlc3NfemVybyhzdHJ1Y3Qgc2NvX2Nv
bm4gKmNvbm4pCit7CisJaWYgKCFjb25uKQorCQlyZXR1cm4gTlVMTDsKKworCUJUX0RCRygiY29u
biAlcCByZWZjbnQgJXUiLCBjb25uLCBrcmVmX3JlYWQoJmNvbm4tPnJlZikpOworCisJaWYgKCFr
cmVmX2dldF91bmxlc3NfemVybygmY29ubi0+cmVmKSkKKwkJcmV0dXJuIE5VTEw7CisKKwlyZXR1
cm4gY29ubjsKK30KKwogc3RhdGljIHZvaWQgc2NvX3NvY2tfdGltZW91dChzdHJ1Y3Qgd29ya19z
dHJ1Y3QgKndvcmspCiB7CiAJc3RydWN0IHNjb19jb25uICpjb25uID0gY29udGFpbmVyX29mKHdv
cmssIHN0cnVjdCBzY29fY29ubiwKIAkJCQkJICAgICB0aW1lb3V0X3dvcmsud29yayk7CiAJc3Ry
dWN0IHNvY2sgKnNrOwogCisJY29ubiA9IHNjb19jb25uX2hvbGRfdW5sZXNzX3plcm8oY29ubik7
CisJaWYgKCFjb25uKQorCQlyZXR1cm47CisKIAlzY29fY29ubl9sb2NrKGNvbm4pOwogCWlmICgh
Y29ubi0+aGNvbikgewogCQlzY29fY29ubl91bmxvY2soY29ubik7CkBAIC05MSw2ICsxMzksNyBA
QCBzdGF0aWMgdm9pZCBzY29fc29ja190aW1lb3V0KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykK
IAlpZiAoc2spCiAJCXNvY2tfaG9sZChzayk7CiAJc2NvX2Nvbm5fdW5sb2NrKGNvbm4pOworCXNj
b19jb25uX3B1dChjb25uKTsKIAogCWlmICghc2spCiAJCXJldHVybjsKQEAgLTEyOCw5ICsxNzcs
MTQgQEAgc3RhdGljIHN0cnVjdCBzY29fY29ubiAqc2NvX2Nvbm5fYWRkKHN0cnVjdCBoY2lfY29u
biAqaGNvbikKIHsKIAlzdHJ1Y3Qgc2NvX2Nvbm4gKmNvbm4gPSBoY29uLT5zY29fZGF0YTsKIAor
CWNvbm4gPSBzY29fY29ubl9ob2xkX3VubGVzc196ZXJvKGNvbm4pOwogCWlmIChjb25uKSB7Ci0J
CWlmICghY29ubi0+aGNvbikKKwkJaWYgKCFjb25uLT5oY29uKSB7CisJCQlzY29fY29ubl9sb2Nr
KGNvbm4pOwogCQkJY29ubi0+aGNvbiA9IGhjb247CisJCQlzY29fY29ubl91bmxvY2soY29ubik7
CisJCX0KKwkJc2NvX2Nvbm5fcHV0KGNvbm4pOwogCQlyZXR1cm4gY29ubjsKIAl9CiAKQEAgLTEz
OCw2ICsxOTIsNyBAQCBzdGF0aWMgc3RydWN0IHNjb19jb25uICpzY29fY29ubl9hZGQoc3RydWN0
IGhjaV9jb25uICpoY29uKQogCWlmICghY29ubikKIAkJcmV0dXJuIE5VTEw7CiAKKwlrcmVmX2lu
aXQoJmNvbm4tPnJlZik7CiAJc3Bpbl9sb2NrX2luaXQoJmNvbm4tPmxvY2spOwogCUlOSVRfREVM
QVlFRF9XT1JLKCZjb25uLT50aW1lb3V0X3dvcmssIHNjb19zb2NrX3RpbWVvdXQpOwogCkBAIC0x
NjIsMTcgKzIxNywxNSBAQCBzdGF0aWMgdm9pZCBzY29fY2hhbl9kZWwoc3RydWN0IHNvY2sgKnNr
LCBpbnQgZXJyKQogCXN0cnVjdCBzY29fY29ubiAqY29ubjsKIAogCWNvbm4gPSBzY29fcGkoc2sp
LT5jb25uOworCXNjb19waShzayktPmNvbm4gPSBOVUxMOwogCiAJQlRfREJHKCJzayAlcCwgY29u
biAlcCwgZXJyICVkIiwgc2ssIGNvbm4sIGVycik7CiAKIAlpZiAoY29ubikgewogCQlzY29fY29u
bl9sb2NrKGNvbm4pOwogCQljb25uLT5zayA9IE5VTEw7Ci0JCXNjb19waShzayktPmNvbm4gPSBO
VUxMOwogCQlzY29fY29ubl91bmxvY2soY29ubik7Ci0KLQkJaWYgKGNvbm4tPmhjb24pCi0JCQlo
Y2lfY29ubl9kcm9wKGNvbm4tPmhjb24pOworCQlzY29fY29ubl9wdXQoY29ubik7CiAJfQogCiAJ
c2stPnNrX3N0YXRlID0gQlRfQ0xPU0VEOwpAQCAtMTg3LDMxICsyNDAsMzAgQEAgc3RhdGljIHZv
aWQgc2NvX2Nvbm5fZGVsKHN0cnVjdCBoY2lfY29ubiAqaGNvbiwgaW50IGVycikKIAlzdHJ1Y3Qg
c2NvX2Nvbm4gKmNvbm4gPSBoY29uLT5zY29fZGF0YTsKIAlzdHJ1Y3Qgc29jayAqc2s7CiAKKwlj
b25uID0gc2NvX2Nvbm5faG9sZF91bmxlc3NfemVybyhjb25uKTsKIAlpZiAoIWNvbm4pCiAJCXJl
dHVybjsKIAogCUJUX0RCRygiaGNvbiAlcCBjb25uICVwLCBlcnIgJWQiLCBoY29uLCBjb25uLCBl
cnIpOwogCi0JLyogS2lsbCBzb2NrZXQgKi8KIAlzY29fY29ubl9sb2NrKGNvbm4pOwogCXNrID0g
Y29ubi0+c2s7CiAJaWYgKHNrKQogCQlzb2NrX2hvbGQoc2spOwogCXNjb19jb25uX3VubG9jayhj
b25uKTsKKwlzY29fY29ubl9wdXQoY29ubik7CiAKLQlpZiAoc2spIHsKLQkJbG9ja19zb2NrKHNr
KTsKLQkJc2NvX3NvY2tfY2xlYXJfdGltZXIoc2spOwotCQlzY29fY2hhbl9kZWwoc2ssIGVycik7
Ci0JCXJlbGVhc2Vfc29jayhzayk7Ci0JCXNvY2tfcHV0KHNrKTsKKwlpZiAoIXNrKSB7CisJCXNj
b19jb25uX3B1dChjb25uKTsKKwkJcmV0dXJuOwogCX0KIAotCS8qIEVuc3VyZSBubyBtb3JlIHdv
cmsgaXRlbXMgd2lsbCBydW4gYmVmb3JlIGZyZWVpbmcgY29ubi4gKi8KLQljYW5jZWxfZGVsYXll
ZF93b3JrX3N5bmMoJmNvbm4tPnRpbWVvdXRfd29yayk7Ci0KLQloY29uLT5zY29fZGF0YSA9IE5V
TEw7Ci0Ja2ZyZWUoY29ubik7CisJLyogS2lsbCBzb2NrZXQgKi8KKwlsb2NrX3NvY2soc2spOwor
CXNjb19zb2NrX2NsZWFyX3RpbWVyKHNrKTsKKwlzY29fY2hhbl9kZWwoc2ssIGVycik7CisJcmVs
ZWFzZV9zb2NrKHNrKTsKKwlzb2NrX3B1dChzayk7CiB9CiAKIHN0YXRpYyB2b2lkIF9fc2NvX2No
YW5fYWRkKHN0cnVjdCBzY29fY29ubiAqY29ubiwgc3RydWN0IHNvY2sgKnNrLApAQCAtMzk1LDYg
KzQ0Nyw4IEBAIHN0YXRpYyB2b2lkIHNjb19zb2NrX2Rlc3RydWN0KHN0cnVjdCBzb2NrICpzaykK
IHsKIAlCVF9EQkcoInNrICVwIiwgc2spOwogCisJc2NvX2Nvbm5fcHV0KHNjb19waShzayktPmNv
bm4pOworCiAJc2tiX3F1ZXVlX3B1cmdlKCZzay0+c2tfcmVjZWl2ZV9xdWV1ZSk7CiAJc2tiX3F1
ZXVlX3B1cmdlKCZzay0+c2tfd3JpdGVfcXVldWUpOwogfQpAQCAtNDQyLDE3ICs0OTYsNiBAQCBz
dGF0aWMgdm9pZCBfX3Njb19zb2NrX2Nsb3NlKHN0cnVjdCBzb2NrICpzaykKIAogCWNhc2UgQlRf
Q09OTkVDVEVEOgogCWNhc2UgQlRfQ09ORklHOgotCQlpZiAoc2NvX3BpKHNrKS0+Y29ubi0+aGNv
bikgewotCQkJc2stPnNrX3N0YXRlID0gQlRfRElTQ09OTjsKLQkJCXNjb19zb2NrX3NldF90aW1l
cihzaywgU0NPX0RJU0NPTk5fVElNRU9VVCk7Ci0JCQlzY29fY29ubl9sb2NrKHNjb19waShzaykt
PmNvbm4pOwotCQkJaGNpX2Nvbm5fZHJvcChzY29fcGkoc2spLT5jb25uLT5oY29uKTsKLQkJCXNj
b19waShzayktPmNvbm4tPmhjb24gPSBOVUxMOwotCQkJc2NvX2Nvbm5fdW5sb2NrKHNjb19waShz
ayktPmNvbm4pOwotCQl9IGVsc2UKLQkJCXNjb19jaGFuX2RlbChzaywgRUNPTk5SRVNFVCk7Ci0J
CWJyZWFrOwotCiAJY2FzZSBCVF9DT05ORUNUMjoKIAljYXNlIEJUX0NPTk5FQ1Q6CiAJY2FzZSBC
VF9ESVNDT05OOgotLSAKMi40Ni4xCgo=
--0000000000008e615b0623e9391d--
