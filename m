Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF743033F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164583; cv=pass; b=kDDC5A5r7iFUGf23RPSIu0TNaQAFR80ncNdBBgorlP2pT3ob+yh1OU+s1kUfeCo9Cvq+WhKWMaBcTV/GjC4oiadNRiWWW4Nr476/I5YM9F8u9dsSzqVs2RFR4OplZ/EvayjxuFJ+XZt4LHbzot9PTIGZ9jZR8v+b6+RbYvGAAX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164583; c=relaxed/simple;
	bh=+cK51i1drH3pxKAGhAAPOVetQNoxIp3rgAQxXla+Coo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfmim16X4fkKLzKEa7UlHOabn6KowOgbnhdHyewMsOO8GWY+KVSy/Y3wwg9A9FQ64za6SiHm/xb86lUBf4rTv7RyoCfsrk3AMHiMUAYFWmnk36MRNUn7qB7WPocKOzfBYneB34PwOviS3tCO3TDqadZO3319sSF+WALxkNiwWkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lC+r0qWz; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC+r0qWz"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4670676ba03so934103b6e.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 10:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773164581; cv=none;
        d=google.com; s=arc-20240605;
        b=RojtSFEb6MZwCC7sarDDtjLsd1sdjkFythBIrbUfUF1EzwZxTRMSJHui6VR/5Hpzzf
         zhXTwcugM8wHAqa/CLKufzl8vp0SZatrUI2tt0cVIU+LPaOl8GmIdzU+oAoqykFacbwo
         yVzoSBW6W+BMYwm41wT/lDB4XVIj/KK8P3AG7p+XO9ui2cQDBnoGPx2wJcBGCW/OcZeY
         1N/ShxI7ZuSGtBPecC+VSnqefOgtM+aRrGx2tU4ug4fHUPvTbY7Gh+tiSqOzIfoN0Di5
         36WGuzAuFRAP4NV9VHSHo/dFjn/1+751H3+b+JWUmEey4UcyyT0UZqB0trU8++9cX9Ms
         EFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+cK51i1drH3pxKAGhAAPOVetQNoxIp3rgAQxXla+Coo=;
        fh=0iyT5QD/rAiJ1gxT4H1j9J1DC0DYxjjHmLgQa1BGc7U=;
        b=Cf07KeiDJxax+5JA5tQogNiFyMFU5npnEbUE4i0MTFWvKaIrlzc2ljou/m4zDRI6oK
         cUp5sZFzgfOrda1epMoF+NO23A9D3s5Q+ykDlep0a69aA9EVQEfmDyIpyhtcdxwPs943
         pITL/sJtMPU+viqJNzHKLFz1yl30vxwh4GB4ovz9gSnlNTSq+BluPDD2pbq+G74/hSJJ
         qvxxtMHbRD0ZjMytby/Bs5RbrAE3BQnq0WcjATBfJNP7klfwLC1hRUPz9Oe497tk0ED+
         hXxSYpzSE7yFMV2ZftdUa6dgIR7rGTNyeGbyPL6NZbdvmvimkuFQY0qWelox30pPOGC9
         MEzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164581; x=1773769381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cK51i1drH3pxKAGhAAPOVetQNoxIp3rgAQxXla+Coo=;
        b=lC+r0qWzumIn31ZFIAK68vhmzFco88jPwPmElbmoJfeXI5ipEBeF9hnkdCqsP/LxaV
         slfhWgl98fEWVG8ghlBa0UEoV2V5m2w67MmZBXmZxIf5U6o/0ycumJd4+00U8KrZ5oP6
         diVILgAu/+txGYdW9K3h01GifnI7vs+xTpxR0bvItmVqR6DomPHuCrUaYMu7kaTefhLT
         GB9//iZBJizOPU1wkEMEvfeZPflwNk2ZHL1B1xjLlNJ03cegghHZT2JSFZgaP4on+rPi
         1+pfB5y4/S8iuAK2t9U/GCJdZH47XtFCZCC+bHSttTdEAwQp9/ILbfbEYdhJffcjwtwG
         V10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164581; x=1773769381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cK51i1drH3pxKAGhAAPOVetQNoxIp3rgAQxXla+Coo=;
        b=tIgdVcas4Msf7HXx9rutgqi0K4iRKRRRwgS8nPVkGZGksK1yYvjQ54/bEduFSrHQFN
         6Hs5ll4TkPRQ9ZP+9xTlbMLqGBN/XvJjCr551ZO9bZUWSuENjOMfJr+HYks3UZ1jhFmn
         +tdtyQZKumsYNuZHpdikow6VhWMxBOKph4AP3kn1daReuF96dwsHY+GL7/yBzGcLJXRJ
         iQLVbDDsEK1Yabrl3sghHjPJ9YinYSKAnVZCkLAf06sXxl/4AzAnINebm5gEqdXfMtxY
         Yb0luqT14XHTJtufiM1QI1cWxfY0pObAMwFT8UIKWsBoutAqI0DnGddNTvawIpozoIiE
         6/xg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8R4ZrJcAK9GRc8AVje99WNREJrYRyxTEZmEfaaMO4/aPkomhIOpzpmn+NWMjC1xgq/jtK4kC6he26SPdXw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymhdJFH2yow84HbCGN5eaHwu/vyWSQyCVJA9Sr/zaedjutE1A8
	5mQZK3/k+sZ3kaQcdLVK4ctK6eYcJ3YYmheEK838MHClHYO+4XlBOXZ+5APobpffzMieadrOt/+
	U8IP4a4wP68N4G212ix5jy0B2Ok9YEys=
X-Gm-Gg: ATEYQzwGyS8xDR1rZQknUnHU7DkCZZVC1HdKdhCbPpCseYYgr/QB5ssw8rJhLBwvGBQ
	am87qi3XtwzfpmQzd5t8sZI+ynE4RCkUY6FdkbNHYsH4d2Whnv6aREP8Km64wfe2EWTsdzfb6M7
	y0SRG6WudENGFokvK0kMipkgpfL96cPJz6KAhASkYixzkBdN6kP10ZFurwZsw1R530mPFtm3gQS
	VW8SSZAVeg+34tj4gsHjm3NrAOF0c1reRWcLbnjyB9zTHVEPwZ8exQLn7fo1zxBEnd+kia2jcVw
	fW3m9aAT68kCkNJHswES65DhjIYD5oO2S8cIwDxEV8L32GkUxOMQbGHWkA==
X-Received: by 2002:a05:6808:3a12:b0:467:ee:7a2f with SMTP id
 5614622812f47-46700ee813fmr5089490b6e.28.1773164580704; Tue, 10 Mar 2026
 10:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302233756.910702-1-dajid.morel@volvo.com>
 <CABBYNZKaNmSPbCpJ-GKu2eSrgd_GcOOWkekHW0OMK8WMLESYWQ@mail.gmail.com>
 <CAM8DPm20Sm1t_NMoWQFZtkmdaiL1ALs8SFMqxe-QtT5wjbp6xA@mail.gmail.com>
 <CABBYNZKmu3b2h2NyhhV7CwmB=h1R9uAe0HXDCP73iAvqzy7AYA@mail.gmail.com>
 <CAM8DPm2z-6xUm3SyFJ9umn4=o9bBov6PhKV0TEDCBc14eMFSew@mail.gmail.com>
 <CABBYNZJZWkEy2D4WW8ODMoU-ZmsT1aN0LccOzdsCxuKnFZHnuA@mail.gmail.com>
 <CAM8DPm1fWn7jovVPgcBrApy_czP0TbnBi=oUZmhjMqDkORv2bw@mail.gmail.com>
 <CABBYNZJ6NNL26BOxV2E6HBA6D3vgOauRQ=75vRcBMA0D-vSEHw@mail.gmail.com>
 <CAM8DPm0rgZEY+aNj8-RJv7JwvMOBQuRu7qt7G+z_OpVL+zk3Gw@mail.gmail.com>
 <ea9528bd-ccde-4da3-b85b-793e370b4da1@molgen.mpg.de> <CAM8DPm20ECFZF6v19SrLwA8o92YXY_dsWvOyFDOuym5S7P2kCg@mail.gmail.com>
 <CABBYNZ+ePfwbc2NS-hG5g98trXOvUqRtp-ZiXD2crrvx-Lygzg@mail.gmail.com>
 <CAM8DPm1Ca6CDx3nOeJhEvTiD0510RteKd5Mw=Fg8hkZuA4oRKg@mail.gmail.com>
 <CABBYNZKtAkftUyyo4B5D7ADN80as3rE5dHHQcKoWa7tmUfBzgw@mail.gmail.com>
 <72946edd-fad1-4201-8c23-f36cfe925cb7@molgen.mpg.de> <CABBYNZJ31JR4ejwS68_kad6uxmNt0gBFB9eyM-yA+Ck5iiQQdQ@mail.gmail.com>
In-Reply-To: <CABBYNZJ31JR4ejwS68_kad6uxmNt0gBFB9eyM-yA+Ck5iiQQdQ@mail.gmail.com>
From: Dajid Morel <dajidp.morel@gmail.com>
Date: Tue, 10 Mar 2026 18:42:48 +0100
X-Gm-Features: AaiRm5338KyUVVZQYgwpKMpr9KHuEfth5Y4vtVwMkhcbAD8IVwFzoyZwzw9-hFs
Message-ID: <CAM8DPm1VDqYxpOxEm6iNp4vAkJV6Rciy5-mg-JtNJ8AFYs3g1Q@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Dajid Morel <dajid.morel@volvo.com>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz, Paul,

Thank you for considering the backport to the LTS series.

Regarding Luiz's note on whether the patch applies cleanly: I actually
tried to apply the first
commit (a56a1138cbd8) to our 5.15 LTS tree today.

As you suspected, it does not apply cleanly. The patch targets
net/bluetooth/hci_sync.c, but
the 5.15 LTS kernel predates this refactoring and still handles this
logic within net/bluetooth/hci_request.c.

Given this architectural difference in the 5.15 LTS tree, a direct
cherry-pick fails.

Thank you again for your time and guidance on this issue.

Best regards,

Dajid Morel

Le mar. 10 mars 2026 =C3=A0 15:19, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> a =C3=A9crit :
>
> Hi Paul,
>
> On Tue, Mar 10, 2026 at 10:04=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.=
de> wrote:
> >
> > Dear Dajid, dear Luiz,
> >
> >
> > Am 10.03.26 um 14:47 schrieb Luiz Augusto von Dentz:
> >
> > >> Trace Analysis (failure_with_firmware.log attached): Here is the
> > >> relevant excerpt showing the host aborting the sequence on the 5.15
> > >> kernel:
> > >>
> > >> < HCI Command: LE Create Connection (0x08|0x000d) plen 25 #65 [hci0]
> > >> 13.006556 > HCI Event: Command Status (0x0f) plen 4 #66 [hci0] 13.00=
9473
> > >> LE Create Connection (0x08|0x000d) ncmd 1 Status: Success (0x00) [=
=E2=80=A6] <
> > >> HCI Command: LE Create Connectio.. (0x08|0x000e) plen 0 #88 [hci0]
> > >> 17.048391 > HCI Event: Command Complete (0x0e) plen 4 #89 [hci0]
> > >> 17.052037 LE Create Connection Cancel (0x08|0x000e) ncmd 1 Status:
> > >> Success (0x00) > HCI Event: LE Meta Event (0x3e) plen 19 #90 [hci0]
> > >> 17.054039 LE Connection Complete (0x01) Status: Unknown Connection
> > >> Identifier (0x02)
> > >
> > > Ok, so it is actually cancelling after 4 seconds, not 2 seconds as yo=
u
> > > repeatedly blabbed about so in the end it doesn't correspond to
> > > HCI_CMD_TIMEOUT but probably something else that sets 4 seconds.
> > >
> > >> The host systematically aborts the connection attempt after exactly =
4.04
> > >> seconds (17.048s - 13.006s).
> > >>
> > >> You mentioned: =E2=80=9COn the recent kernels the timeout is configu=
rable.=E2=80=9D
> > >>
> > >> Could you point me to the specific commit/patchset or API that
> > >> introduced this configurable timeout?
> > >
> > > It is the third time already:
> > >
> > > https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4d565356=
199d60e1cb94e5a77a
> >
> > This entered v5.17-rc7.
>
> This contains a Fixes tag so it was probably considered for
> backporting, but I guess it depends if the patch applies cleanly, etc.
>
> > > But you may also need the following:
> > >
> > > https://github.com/bluez/bluetooth-next/commit/bf98feea5b65ced367a871=
cf35fc044dedbcfb85
> >
> > This entered v6.10-rc1.
> >
> > Luiz, would it make sense to backport both commits to the longterm
> > stable support (LTS) series?
>
> It doesn't have any Fixes tag or Cc: stable, and if I recall correctly
> this was done on purpose since this introduces a change in the
> behavior as previously sockets timeout was not use as connection
> timeout, but I can see it being valuable for stable trees to align
> them both.
>
> >
> >
> > Kind regards,
> >
> > Paul
>
>
>
> --
> Luiz Augusto von Dentz
