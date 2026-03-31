Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4D3BFE25
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940966; cv=pass; b=Hm/BxHJeNEhMN20hM0dis7TGjCdvL2J7QiCyNmOcx6mnmoBJDrCsohqZBlPjcR2xKdNi36JVBfQsy4aYlShQhZzfJ9jqUzyBt9k55RO6rpyTx+dWK7WYvWrUjC0S2eoer9TKxfUXljHTevgwN2Vy0eMMRqkZmIm0DLiK9ZcxSh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940966; c=relaxed/simple;
	bh=d81XBBGSeWKoAcynpllynS5rx08wjPE8TOFIPUaiMi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpqDsAlSK4t6srmkFZIMG3hAnYsX+DKCzqN0zhAS1P0VN6CR56bvD3wDKLhj6l8Iqgi0t+I1dO70pwG/9ZldPjYAIdZZS7r31HPbtXiMjjXGz7vytq0w14b92hJmrmWG3w57uEl8FTdXdnchSIeTXnqcjzga677ST6/CQHE/MwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVjWaZ5h; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVjWaZ5h"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a133b686f7so6205517e87.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 00:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774940963; cv=none;
        d=google.com; s=arc-20240605;
        b=iVe9/YuhPCJy8HgDG+Adbon8l3AfLU+tC7O33B/kqK3OKL0ZLZJWpnYnKX29QEcCfg
         zZwmmYMOnpV9F29t2PqJLPKvCgbB/pHL+UUK8r7vffPcFRD/I6L8nYk/NmukjcVz/Doj
         1vT8qb1soH7YFsgi42DFM2hpVp7WbjxKZuC2NrYW0hg44LxQ62nnYOchjqFlg/bHn2BH
         XZETts0qrFo0LhcpKtmPzQmemk1UhnSe4OwHXLtraygU9UqLtWW6QW7MOvmqKO+FOGeA
         DFGcUP6896AvsiYJmJ0l8HajamI8blyTYDbP2lkrfWn0p5x2MmMRoC3FHT+R55R1wLdD
         PJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d81XBBGSeWKoAcynpllynS5rx08wjPE8TOFIPUaiMi0=;
        fh=A/GRua1t7QsM9SDk4UFRUAjHiFZwuLtI49o9JjUIIbA=;
        b=Q5cBACA33uvt0tz/ik8o6dqsfgVP1wN0eXzNAAS0QJnU/p0uOULodORJ4QugUmOrTS
         AcpWH2AVFnUF/rIo4ekggpdfWUzuyiri9RKZ5RTrAoR8ry93mrDLyWVYHZppcHL1KxbW
         FjcQa9MGfOUqOTaTljCzziDbI6gfwFujL5YY6G9la/Szld2tzRXvtiljU56pT2suqft4
         8WdaQ6jDCBPuhd6ck4Dr/ewprOhCY2DV3tXkp8iU8hYut+F5pukmUZZg0U3W/h4U2oIp
         teZT4plv3RDS0ZkkbtWhJS1ilReGtizJP5jFrzNsBlstyXe1wOsJpqEu4fKjdWOGYjcW
         lj1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774940963; x=1775545763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d81XBBGSeWKoAcynpllynS5rx08wjPE8TOFIPUaiMi0=;
        b=mVjWaZ5h4yW6nalkFg5/0ORo6sXAh1KlQMhpikjpnzJb76DipUvBjeWGQHwTAmlGkH
         GlPJECGPEyJDhAD0APUT9grL7Rcerrx6QqnxMyBvPiroEuzzYsUYXKs9JYeo7RpUkchw
         ZgX1RST0e3sLFCknyVWQ8cNdpqv2zZKxs874mIYiYOG2KfW8VECeoKgKYNtzTDOo63dC
         JOOkIPbwoVZcLsVwmR9S00Wg4u5yMN3c8CEDswowbWiYjYsR4OxJaB+JIhqwYobfSCQU
         gPD9IYa2X5KklsSF3u0KXcPY5HlKrVTB2V5IFiZtKLacfu4N+JlUrjJm9MLVDUz5iRo7
         YWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774940963; x=1775545763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d81XBBGSeWKoAcynpllynS5rx08wjPE8TOFIPUaiMi0=;
        b=dtSyNMXcdC3be4NMrt3mMWIv5LMMWLvqTRa8Jf7/n/Uqrc6NsqLMoCpHdqBu42hMbh
         Bj5HAu+Y1AzMOOjEfc909W3oAT4Sg6lDnSMCGYBn9VERpB8SlYhw3beFMaqptifWiduI
         aZ/7/JjwHmNYVdTUEjPxamxNfxpGSlODIvyUFIedobfSfW1KbbsDxgZNpWLuzQ1e5Ifn
         pM+wwmqjASPXh/MTw0ChHPx9I7nEdQpZqi16lEZ+4rkUJUKt5H1UFSsdmCnnshGiK/7A
         KQpwxAbg2+8exfxGDwquX8J3sEN3lUIsjyn69zXp2ASv9FwHs0oYPL7TyVFyQBIWfTHq
         mOHg==
X-Gm-Message-State: AOJu0Yw0r5jMuXIeGm5KmmY/PVd34/UFLSv0ZvFDVxQFwvxSTp690RmT
	ReOklYML5J2E6w6YytA01kztnt0SDCLPYMp0y+1IeOAfip5JLbfMc77x7Xf/n91hgaZebEx05/h
	AIsj1gXZHYrOpN1JSy3HLndKkWIEP/98=
X-Gm-Gg: ATEYQzwwm92ZjJCWrjf1TJd5UUXmNz6HHjX+E2EXv+ZeJ0jzbA0C+TAZ3fx4Q5wyvnn
	NlJ8SixZJgrFwrexQxbuIqXxMHEClWlEVAX3q5A3/LQaBSAVF0wfv5+X5IrWZmdQJ4hrcA2JicF
	gf3BIFfFZypMAiaDwgWSxeVKaFv2VgQUf0WrlltGu4ZfyPunb+bOwQRNqPXODV+I2fGzIiJ/9P1
	aAjP97WkNqu/YK1J7BFhQhnz7hscgB1509qzSGbQ2am0SlcNik1huqZ5PCnra5+Z/cspHyJDNPq
	r6L6Yw==
X-Received: by 2002:a05:651c:110e:b0:38a:49d1:3d with SMTP id
 38308e7fff4ca-38c732638e5mr45938511fa.17.1774940962503; Tue, 31 Mar 2026
 00:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328200938.140528-1-xiaoguai0992@gmail.com>
 <CABBYNZLu31g8KnERbrOSDav90OaYOoSXjcS4ALBi8RmiXMaVig@mail.gmail.com> <69caf5f7.050a0220.3c2ca3.53f7@mx.google.com>
In-Reply-To: <69caf5f7.050a0220.3c2ca3.53f7@mx.google.com>
From: Kangzheng Gu <xiaoguai0992@gmail.com>
Date: Tue, 31 Mar 2026 15:09:07 +0800
X-Gm-Features: AQROBzBYx72iNMoZuHbjpNvWBurmlx6V-DU_JMEagDsUp62-_9yKTCj4EAkgYO8
Message-ID: <CAKvcANMPGahbwOaTh3t99cPhWh1Df6HmcAU3xc6TSd2esdV-9g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: ISO: validate ISO_END fragments
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	Nathan Rebello <nathan.c.rebello@gmail.com>, kyungtae.kim@dartmouth.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the feedback. I do not have access to actual hardware to
validate this.

I chose to use =E2=80=98>=E2=80=99 rather than =E2=80=98!=3D=E2=80=99 becau=
se of the subsequent code,
conn->rx_len -=3D skb->len.
This made me wonder why it is not simply conn->rx_len =3D 0.
My understanding is that there may be situations where an ISO_END
packet carries more data than expected, which we may not want to
reject outright.

Since I am not certain whether strictly enforcing conn->rx_len =3D=3D
skb->len could introduce compatibility issues with existing Bluetooth
firmware, I opted for a more defensive check using =E2=80=98>=E2=80=99 inst=
ead of
=E2=80=98!=3D=E2=80=99.

If one can make sure such a strict check will not introduction any
regression, I would like to provide a updated version of this patch.

Best Regards,
Kangzheng Gu


>
> Hi Luiz,
>
> Thanks for the feedback. I've sent a v3 addressing this -- checking
> !conn->rx_skb instead of !conn->rx_len:
>
> https://lore.kernel.org/linux-bluetooth/20260330221015.322337-1-nathan.c.=
rebello@gmail.com/
>
> Nathan Rebello
