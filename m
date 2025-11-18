Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC2F35CB8F
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480690; cv=none; b=uIG5HCykKbX9HI3A2ycujHByAWjzUMcx0kPJXJ1DF6z1Y/RUSg+txwK8+2x4endmIqDLQ1LvfjrwC2nCqg4QAXuht1gwJEM8+cxU7lGkFtCX0fqLA+kYRDROCodfSZcm1rGIUfEtpDhD3BHASpbKE1sgOeCQlcEOcD+ZnKUMfGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480690; c=relaxed/simple;
	bh=TWV5xtuz6oL9NSz54guqmz93RN4MF0WByuonz4VVzJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cyle+/OoRtckXoSMWGxNBjqOjQT8Ars85rkHMSLul9JkWFeXhM1/9cwuEJjY8x0JpBLw3opsiD/QTEBPVUo2+nkCS/ERw4ZJJBhnP5oLuSoZd+y/OyL438PTymrUnDqMTzWG+v5h8YQjaxeKkdZ+2xLJoxOllPCfNvb9iCJ1QL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGIsFI18; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGIsFI18"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37a415a22ecso46367251fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 07:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763480687; x=1764085487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtGZtG7DVqgEl6JgTT5x8+ojzv8mILi291Xw6tlqn9M=;
        b=jGIsFI188KpnF2nfyr2rpZJNBNlR/6otGIQTiJNpZ36v3Q5plsiM6ZFg/yvuai0z3Q
         MSR+VAz2eKQgMwfurvSjNMgWVfTlDxHzh5oqBngYdmc+v6w3jquWOUbqturyFS6uR/0+
         8nVtES1kQEntElCRu0GvqQ4jr3E/RdrXT9vDo8c+23NMX/Cz2EUFvJ4n1icW+imylb/O
         S3dF4hjnpMnlaNLwTrkhJNWy3BKPIpYU1FMtkZ7lE9GHWlpVQDKd2mGcQ+Pwrbmv6Cww
         RKR+nA63cuVaPUyukAiWpd7UXVluTpYyeXQSyEn0g67ZLmOS0SXnZQxyT/UtGWL0dlyc
         snSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480687; x=1764085487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UtGZtG7DVqgEl6JgTT5x8+ojzv8mILi291Xw6tlqn9M=;
        b=m998IOBwSUJbvQ+n7SOiCMeoiF5Lie/igarLlLlSHRc0+cf+ttW4wJpQywNX7YEm6K
         trQu97YfSEXWAs9nuhqwwnM9J7XJQ0Rx3Cn1koFhW3OEGFSZcwE1jJEsCtPmTjrJeGbg
         1YD34zPzod5ABfvaZzq0Lhs2JYmGR35M8bclPY7MtCZVlgE5Qo9GALtNBwM+yMRl5BmH
         A/IpZdXbA5XMAV2PTQKRfhgJ4einskxmIV//5VNGZR75/nk24AfWAVZ/Vh7tDsQ2MgU6
         Y83rDIbU25tyIeA50SONlbAIE1xZ7yjjC5bd6J8b4Iu3CcIUPSgjKmTaBlxug7yYQNIj
         w00w==
X-Gm-Message-State: AOJu0YwdNdD5oQ01ccZPGuLD25h+AK9opKtU85Db9MyEeFGYbOegHQhZ
	/HdTYbEON3/LQGKsT2e3fgTtQMVU9ijOeKy/fmfH6sOeUADIgizZ5aSllnpQILCSB7bBKsquBUF
	RPvLlti7DYtHfUQvaOZLqYu+sv6rk1xQ=
X-Gm-Gg: ASbGnctj1IXTPhbiGaY5ji3bBhfdixgwdG9BEGpV2au+fixTDoe3s07yTWsfmMtWgOe
	hwMzrA9gJ/FhUY+Qvb9uvTxokIQp9ZzhH/2Hxs2mY4JyMzA5NvZWDThLEdxs9vxf42XQna+wGFq
	dyl6BcFYgzY76PmWzm2NvAFxldccHrlxUSewPQc/gO0t2xULPJ24VlvhgH+UcpV/MEDn8w6SLuP
	ft8O5OmsRcg5QDNB2ZHUNgFYRbY+034Y+s9dp4IQvR3ZsdY6xC3skNarxqtpNKLISFzVQ==
X-Google-Smtp-Source: AGHT+IFK11jPg+1NIchShRcKpjOHgeGcW7XszFqroZ2x0khx/7Wd7y7IXDp+T4SyjSRprEFdj7/aN5sOdh5eUvKxW3s=
X-Received: by 2002:a05:651c:4203:b0:37a:832f:519 with SMTP id
 38308e7fff4ca-37bc7d4c905mr9383771fa.3.1763480686727; Tue, 18 Nov 2025
 07:44:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117190232.3918619-1-luiz.dentz@gmail.com> <02779265-0d40-436c-99fd-2e247a09aae1@molgen.mpg.de>
In-Reply-To: <02779265-0d40-436c-99fd-2e247a09aae1@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Nov 2025 10:44:34 -0500
X-Gm-Features: AWmQ_bmb4FQdism1oTnwH1J4E8Rvk5W893MEBYUryTfSppEuhiqC7k8ckobj0uk
Message-ID: <CABBYNZK_qE1ttJVvJMF-v4rMFHHo4Gx79oYHwcc3M9NaHZBtLw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: SMP: Fix not generating mackey and ltk when repairing
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon, Nov 17, 2025 at 4:41=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Luiz,
>
>
> Thank you for your patch.
>
> Am 17.11.25 um 20:02 schrieb Luiz Augusto von Dentz:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > The change eed467b517e8 ("Bluetooth: fix passkey uninitialized when use=
d")
> > introduced a goto that bypasses the creation of temporary mackey and lt=
k
> > which are later used by the likes of DHKey Check step.
> >
> > Later ffee202a78c2 ("Bluetooth: Always request for user confirmation fo=
r
> > Just Works (LE SC)") which means confirm_hint is always set in case
> > JUST_WORKS so the branch checking for an existing LTK becomes pointless
> > as confirm_hint will always be set, so this just merge both cases of
> > malicius or legimate devices to be confirmed before continuing with the
>
> malicious
> legitimate
>
> > pairing procedure.
> >
> > Link: github.com/bluez/bluez/issues/1622
>
> Add https://
>
> > Fixes: eed467b517e8 ("Bluetooth: fix passkey uninitialized when used")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >   net/bluetooth/smp.c | 30 ++++++++----------------------
> >   1 file changed, 8 insertions(+), 22 deletions(-)
> >
> > diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> > index 45512b2ba951..08461ca06cde 100644
> > --- a/net/bluetooth/smp.c
> > +++ b/net/bluetooth/smp.c
> > @@ -2136,7 +2136,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_con=
n *conn, struct sk_buff *skb)
> >       struct smp_chan *smp =3D chan->data;
> >       struct hci_conn *hcon =3D conn->hcon;
> >       u8 *pkax, *pkbx, *na, *nb, confirm_hint;
> > -     u32 passkey;
> > +     u32 passkey =3D 0;
> >       int err;
> >
> >       bt_dev_dbg(hcon->hdev, "conn %p", conn);
> > @@ -2188,24 +2188,6 @@ static u8 smp_cmd_pairing_random(struct l2cap_co=
nn *conn, struct sk_buff *skb)
> >               smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->pr=
nd),
> >                            smp->prnd);
> >               SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
> > -
> > -             /* Only Just-Works pairing requires extra checks */
> > -             if (smp->method !=3D JUST_WORKS)
> > -                     goto mackey_and_ltk;
> > -
> > -             /* If there already exists long term key in local host, l=
eave
> > -              * the decision to user space since the remote device cou=
ld
> > -              * be legitimate or malicious.
> > -              */
> > -             if (hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
> > -                              hcon->role)) {
> > -                     /* Set passkey to 0. The value can be any number =
since
> > -                      * it'll be ignored anyway.
> > -                      */
> > -                     passkey =3D 0;
> > -                     confirm_hint =3D 1;
> > -                     goto confirm;
> > -             }
> >       }
> >
> >   mackey_and_ltk:
> > @@ -2226,11 +2208,15 @@ static u8 smp_cmd_pairing_random(struct l2cap_c=
onn *conn, struct sk_buff *skb)
> >       if (err)
> >               return SMP_UNSPECIFIED;
> >
> > -     confirm_hint =3D 0;
> > -
> > -confirm:
> > +     /* Always require user confirmation for Just-Works pairing to pre=
vent
> > +      * impersonation attacks, or in case of a legitimate device that =
is
> > +      * repairing use the confimation to as and indication to proceed =
with
>
> confirmation
>
> > +      * the creation of new keys.
> > +      */
> >       if (smp->method =3D=3D JUST_WORKS)
> >               confirm_hint =3D 1;
> > +     else
> > +             confirm_hint =3D 0;
>
> Use ternary operator?
>
> >
> >       err =3D mgmt_user_confirm_request(hcon->hdev, &hcon->dst, hcon->t=
ype,
> >                                       hcon->dst_type, passkey, confirm_=
hint);
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Will fix the comments above, thanks for the review.

>
> Kind regards,
>
> Paul



--=20
Luiz Augusto von Dentz
