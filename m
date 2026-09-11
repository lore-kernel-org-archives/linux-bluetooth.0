Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6834D3A9
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136406; cv=pass; b=klDBivQITXKNcPvTaFmOesqF+X4u/eiVZlSWZ7EAGUEFZwVfq3KhfgReCXJIbvm5QSvKo5zzyUHk4tIBPVdV/goViCF1JAwymqV/XmiWLYPKO+k4GAbaT8hWnwLhxnr8Izv9G2WX6p7FJWND/jlybbcK8qSBDQ6eOx/R8xf0nL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136406; c=relaxed/simple;
	bh=RMor0UjpnIQerIf6eU/Oyu0zv/c7ZStsziFIsf3kuhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6S+AnAdecUebVMLQWRYdjAy+UQpIc46gSoyUyePKlr0PzLQG69GNLiv1BG34en1GJa8rtxi0lzVOa2O2qOZk1LyXZjTVGmpOVCHe1Hrp6Z4Nu+WC88aL6+m96auKPKb79898lre5wBQQkoXFb2o8SBhyNkmNR78fIa3PWtmOjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdL2qifc; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdL2qifc"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-855c26cf490so5865467b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 07:20:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789136403; cv=none;
        d=google.com; s=arc-20260327;
        b=L/lDBsB7lBsvIchr672i+FoHg33in0N/MFq7cVAMOWqZtBivzvyYeXflZ5eRZu4/JI
         yCMd8FXlOIgkNR8Tby2Eg3laA7GNAdXP5s4KofpbbgoZbjCkKqU1qr9qlb0oApDG/Rb1
         hyEw2/XMp+3Bv2elrP+UCHA7EM0clGrQW1VmV8RjRAG3RqS0AcW4xjrp716T9eMLmlbJ
         ER5MRPgfHU0rSuQNWsECOFgl2hee+t8lsm7LxT9gVcp6YVtaC15Ca8UMp3WgFLia9qwR
         /4XKupUP0CRwOc3Rbbz3ilOZkpvpe+5AzaaVKJNGSbM29z3uUARIWQFs4SX360Tnc4Wn
         ks4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r3Yt5+Zdt1a8UShs4GHn2PBuNhJp4NwVMMMb48n+Y2U=;
        fh=AX8/p0nls+8HbjTzGetYcRy6ab2xFxZORN+f4NJwX1Q=;
        b=BmFYO9HjpLdUi/b3bozXawkd9ZCZ1ZYVqVy4krtnfGbmo6bZQOWcsMgdHTv/orUJUP
         BIj/tRpZXwTlDneLB07dp60Ni1B24W3/Wbh77n72mCDi8ZHdQJfF7yK9gYWn7zJmNfMH
         5J+yCatKkJVpAyX+gNBZwZG4nEp5ODlJzNdnprW4R0sdxVCl+QwGGKlFmWajnXzpn5WZ
         TiGWhA1PmbWQxMo6vhvBoaKzdt4+DGkDtgrW7vwSt6JGzh1xK337y9eAEFkRp+SKuXIS
         ttZjsfz4+ezjqPclPNzr6DMgQtwjKFKoU6EFgkDKhrdwv4UkX9Rr9bsX2gWZuCMoL2Bg
         QiKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789136403; x=1789741203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r3Yt5+Zdt1a8UShs4GHn2PBuNhJp4NwVMMMb48n+Y2U=;
        b=fdL2qifccc1qJeebD0Gtl/rzve7bzFVTzLIr5T8cvaSX4T5bO4I/b8942VVpD2U2ua
         9varJyHhP4xEP3VGBU0wQ55Jz648Fs5y9VeywvW9lp68Pfibgb8uxq+PQSbxhfDLpN+i
         fr7tlM/UVZJCMhoU8ls1E3tFuvzyvLWaBmEo0v0QYNtA5nZ2M7U2npWZ3lCB7k9PsfKK
         0Et/I2U/9i+mjU4Mow3hHQciwilYKfN6v77NW1lxFdiMudJC5WRrdKVwbWn45C/4p+w+
         5uVGJP0qklnO45hQk7d9uTucZbUfgH7mdsk83Ha0P7tTKDZ4Z+6ekabhIe2I1CMAtPih
         84Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789136403; x=1789741203;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r3Yt5+Zdt1a8UShs4GHn2PBuNhJp4NwVMMMb48n+Y2U=;
        b=IqfY7INjTznHBbu8PjhMcTRCldF0n0/SBCNlFDJpIPpBJa/+Qca6hsQKTUtW2MZ3rp
         oJNQ4flTb7hJz+nRhZ6zXeDJBOKCN5ZhfYH9MelobDvD+gxtbZ0Z8WZOnHW7X0ccQofQ
         1raO2/mDpqT4aNw3UK2ZCC9GXyd6wSGucQbmfF0QNWWihlNlPaWSUg7H2zPGjere7a49
         DWVyyE5yaFzA0yiv/3M3exLBAvWazksf8hJ+HrBx1meCMn9dkdfqo2zOeCSzNsWH/+y2
         2zBGcMw3MPKLGDvmeNMui6hh3nY0jhaKWPlN+BRhAm6Ih5c1QK//V/36bB48+7q3+niN
         hmFA==
X-Forwarded-Encrypted: i=1; AKwUvBxi3z82P3x/zr4ybgH2RPwvtPOuxCyGjFCJjAzzAJqrsUlHOEBj9ZSFwPT5th8fwYal/v2Io7D5v8KrJpMWkEM=@vger.kernel.org
X-Gm-Message-State: AFuF++l8WZJmSkJill81wNgKBE8MTcEBgTH0cwWb3/KVShHK+5TJb+Qj
	SCoIGS1S2KSEhfei1teceWtGZlLff+Vxa2AXqDVJaRuuQzT6wicm0SsP5fYvSTPo2rO68Nl4+BS
	MIpmhkaC46WO201gP3U5Cbsa+n5wMiR/xUztb
X-Gm-Gg: AYBFou3kW55pdz4h3+vWIhRCZDEScYhHFzxqfLq/8AaFnOPeX903tZSzIhQOrITyjLp
	iqdTqyZe9AA4YoV14n/rT+xfHiXUq+Je3rtl7LzJEs/gUfj8ojdhwMIEPzm0M/CAA2KTIuMLsVv
	mEElsKP1NrEYhvciAcP3arqamYAecH1IpaAmscEdACZj3QP8GPpTofchve9wmecvmHc8HmJUqqN
	5GzakZWwi3JgwkewLGF7iFx9yCAKOZk6uHCWoVekPt/Bi6R3JSURysHWfGKnV6qhpuGjTxdAiGx
	+LIQjy6cbbiZtIkplVmp2CjGmlIRq66a7J1lT1Ojhsds0ke3d9goRVnP4xq13efMx11kwICLwfB
	D9w35IzclBfL+43rkXYqrmY9vpv06B6ASnCUqi9e8yg==
X-Received: by 2002:a05:690c:e158:b0:853:c23e:9077 with SMTP id
 00721157ae682-884b00f4fdamr12294907b3.26.1789136403298; Fri, 11 Sep 2026
 07:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717-bcm4356a3-bt-v1-1-ffa2d5233360@gmail.com>
 <CALHNRZ9ofDZ61YW-ZN07sf8sZ6gx4n-8SusSR_vop7R_vqbGFA@mail.gmail.com>
 <CALHNRZ-D1Yz1bgp5hJjwBW32Lhd4Lbt0dQj=3wq-xWqp6uSC7g@mail.gmail.com> <CALHNRZ80CF9Rp0SaDzfgSPSBMWMG+QQ-7FphLAYadt=dRv+qGA@mail.gmail.com>
In-Reply-To: <CALHNRZ80CF9Rp0SaDzfgSPSBMWMG+QQ-7FphLAYadt=dRv+qGA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Sep 2026 10:19:51 -0400
X-Gm-Features: AcwNN1UuOU3RMCORVSwRUX1Ml1EIca_rM0ZS5LZ0LQmn5E9EHcyMUWAgFlVIz8Q
Message-ID: <CABBYNZK6EUcGD48eEQj_HE7fMAZxOUze-sFgUqP5qLoF7fOc3A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btbcm: Add entry for BCM4356A3 UART bluetooth
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aaron,

On Thu, Sep 10, 2026 at 10:57=E2=80=AFPM Aaron Kling <webgeek1234@gmail.com=
> wrote:
>
> On Tue, Sep 8, 2026 at 1:16=E2=80=AFAM Aaron Kling <webgeek1234@gmail.com=
> wrote:
> >
> > On Tue, Aug 25, 2026 at 5:34=E2=80=AFPM Aaron Kling <webgeek1234@gmail.=
com> wrote:
> > >
> > > On Fri, Jul 17, 2026 at 4:41=E2=80=AFPM Aaron Kling via B4 Relay
> > > <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> > > >
> > > > From: Aaron Kling <webgeek1234@gmail.com>
> > > >
> > > > This patch adds the device ID for the bluetooth chip used in the
> > > > Nvidia specific Broadcom BCM4356 PCI-E WiFi / UART BT chip.
> > > >
> > > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > > ---
> > > >  drivers/bluetooth/btbcm.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> > > > index 463d59890befe..14acea7325478 100644
> > > > --- a/drivers/bluetooth/btbcm.c
> > > > +++ b/drivers/bluetooth/btbcm.c
> > > > @@ -506,6 +506,7 @@ static const struct bcm_subver_table bcm_uart_s=
ubver_table[] =3D {
> > > >         { 0x6606, "BCM4345C5"   },      /* 003.006.006 */
> > > >         { 0x230f, "BCM4356A2"   },      /* 001.003.015 */
> > > >         { 0x2310, "BCM4343A2"   },      /* 001.003.016 */
> > > > +       { 0x2409, "BCM4356A3"   },      /* 001.004.009 */
> > > >         { 0x220e, "BCM20702A1"  },      /* 001.002.014 */
> > > >         { 0x420d, "BCM4349B1"   },      /* 002.002.013 */
> > > >         { 0x420e, "BCM4349B1"   },      /* 002.002.014 */
> > > >
> > > > ---
> > > > base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
> > > > change-id: 20260717-bcm4356a3-bt-cd78cc0f42e8
> > > >
> > > > Best regards,
> > > > --
> > > > Aaron Kling <webgeek1234@gmail.com>
> > >
> > > Are there any thoughts on this change? If not, could it get picked up=
 please?
> >
> > I see other changes were picked up a few days ago. Is there a reason
> > this one hasn't been picked up yet?
>
> Something appears to have gone very wrong with the automation related
> to this change. Patchwork reports the id as archived. The
> auto-generated github pr shows as closed with unmerged changes, and
> appears to have been pushed over with completely unrelated changes.
> Can someone please take a look at this?

It has been archieved, please resend so it can be tested by CI once again.

> Aaron



--=20
Luiz Augusto von Dentz
