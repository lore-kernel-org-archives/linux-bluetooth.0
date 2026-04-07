Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE202DA76A
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775581376; cv=pass; b=nbApxKfmv18coCYZc+OAYtJ0/bm/xY0gSnlPxwR4XNPjuOBTejQ3QZhz46xqXVcSQ4qzN+kqNNPIRRjzX1pn7X+WGgzYWDN2cGb/0nu4pqQNJFigHfa6GapP0VbKPWhX2wyxRm4WJLlWrWtHgQou1Y/vhJEtsQDH9FrXmojFyeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775581376; c=relaxed/simple;
	bh=ILBHbjNqc8Z3IkM7bOCVFiumgXsSDvB3m6rFbAC1fc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8rxzPkPFG5tLtIZ2bJZ0Ivfp4jEf/mOsR4dMQe2vT0/TQv4pnTbePSBQvr9ldAXft+OT+XjOnrZL8LoQxRf9ZH3abxDfU07ePSOErkkg5XNaaS6MofE3cEiJ8rbpIBLpwFlJe4xL3oR3DYTflVWeHK8wzLwhv+ZEVUnlBSKzCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb3HExeX; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb3HExeX"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6501c9903edso5305915d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 10:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775581374; cv=none;
        d=google.com; s=arc-20240605;
        b=k5088V9zr54r73PsC7Rx4wTIp1FF3P4Vig5PbWnjg37/U8CuRkWnfdxkUo3RXsvpG6
         jKrhJ24ZasD6sLP3DNXvQgP6NGufTlsca3ELG1vVJdTULs+q3qqyjw37tesRcf+vs0v0
         TxurOCK9m3llN4+szrgiHeYqrv6Epx4f+6Kris9z993PuBQe1buXKJHIgxEMJ6KgllW6
         CUChYYOp/8rgHbXWBYI6SPgkabKZiYwJ4Se1ceNftXwnyvq3tJKoHmsw6FP/LbUhuTon
         YnRnqGhAOfT6FE08hNXES8qybFXS6v4btABxU9V7/O3Zt2mgjYAVNr16xTcyz0/owc3F
         JcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aZ9nPDW/nr55Tg0jl7VVOcPA95n0wWafk66/WrBtr/s=;
        fh=enJkaQy1p0wkCdIHP7t0N9wD83bUIsHWTcf6KiXoIfA=;
        b=PiYUBItBEbPUdBmFBxfL2pGo+D1bRXq9vUXcLHqlpCnGlRQoFz6B6WEU1DkvufgZPR
         Kqfui6Svufj4AQtOSbCPwIbL0/LDranMx9P6Xd5JuOWD0aMUtfIkra6LZEUrBWR2ssiT
         BQJpr8W4p7VHSn3B9iJUk4ku+uGtLG14jmk/jfMiwrjfHzfsuQgg1nlA4sf+MM39hbri
         q8QCSxy0BuLpdktaPWk+CitjKfES3ezeLvBWKYDv0gExSOP7FLqaOR1UMp/pj+16zWhR
         Ee+IT+wO+O5CTL4c7uJH4uzJ6/FYoosYMBPoKML0vmJjB24NmrRax+ZTCPj3XvgqXgnk
         S31A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775581374; x=1776186174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZ9nPDW/nr55Tg0jl7VVOcPA95n0wWafk66/WrBtr/s=;
        b=Bb3HExeXsoqSvPBBB/du7iAHucWK71mqv2402ANUqDvL7U7MfIX4gXhLSzgKwG1F7G
         Tgv7CRAiE0/E25Hcm5KxFZ2kyjdFWoocMCnpMFC6lb8k0Z9UxcLpLC7QZcfl14iLfX+T
         5Vk1/pOGBGscv7Q43zM6IzGOJ14PfkiiHB4rnTD6iFR/JYKkNkgGHBXvjHIeTyNaq/H1
         35T0ko6aCikR6qbvleh1UJIcrRFQWuYilBmqOtU/oa1iIdbax9rnGrZ7T6gfAfebxUfP
         2Z+2FYPDOMT2+Zw2RwEYmvOwa7ns07jNX9zouqkllHcFekQsj42kBQRgaADucDAIX3rV
         l9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775581374; x=1776186174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aZ9nPDW/nr55Tg0jl7VVOcPA95n0wWafk66/WrBtr/s=;
        b=gTdv8dvju0oWun2LrLf9kpJop9Jqv0B2TiEQr2cgzK2RNFaEIlEPMrvLT86LTnOa2+
         cs9clPQp5AaEdaJUKeG+dCWTmaYxfb20eN+6pw1/yGp8ifM5fn9bIXYNSd5eQwae9ISq
         B23o4Cn708ud+Rq+cE4U2jYqnjkkdzeAjpc91Mo36FAKFSmnIpkSGvx30bxE4W/YozZt
         ylKmmegZmyympsGmnCJouyGFBRaZAZhsGwosP8jCHLn+FmJTMjOcSr8WUolpBwn4n2Rm
         xCL7185Lh5iYRflteVtmUuj06+rrm4BQUDtMf/l4V8CsKJ/cCuqIb7Z3E48d5Z7kjnsa
         Nqxg==
X-Gm-Message-State: AOJu0YxdT4XY5QDeEoFfaRkvFi7zo9dgeQAG+seYxl22IfifEeZOvhkS
	EdFbUytFqruH+7LrAbnDiyFGnZ9UXWCQdYgNnfdZtpRQW1KYTMNA2b8363pY3J6/B2txyiBMNW8
	LiO2p/cswAPCHzv53AyQabOvqxKc56OI=
X-Gm-Gg: AeBDiesjgvM5qp+BulfwlpLwzOwUh+1gB77Mz3kbrlg4gEumElgg1SPYStPHzcDbKVz
	dZ5XX07kbuCVZ5BI567dEdzbtc+0g5shR3WiEtduDPiavP1aQN5WF30jx2F68Xcf5gBMYOX//6w
	G0fFrWMLVgTTseHMvOzv7f1pMkVinygEoF03FLoa7OieQ8Zll4+nhMzqupbQefMApUYQ3pESaH/
	PrxdFZi4cUTT4RiUQsCqLEAi5glDHPIaCjTStnfZWypU+jVFQ3RpALRZwMGRTTT90GsuHqSCYIP
	eGTqoxuaNw2i8hJlmtNqk8azRUqyy5FITgnU77bvpUKC3iuepx+UK/mXRsv1cBCUAOgSNQ==
X-Received: by 2002:a05:690e:440d:b0:650:1b68:8750 with SMTP id
 956f58d0204a3-6504869ce13mr12907202d50.14.1775581373770; Tue, 07 Apr 2026
 10:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407151345.126999-1-metze@samba.org> <CABBYNZ+H7qnZFSz=Tx-S2Rdet9a1vEbb_kGbzv_VjC1ZGS5t_Q@mail.gmail.com>
 <4e4c1f7f-9ae9-4043-9ebc-e061e24868c8@samba.org>
In-Reply-To: <4e4c1f7f-9ae9-4043-9ebc-e061e24868c8@samba.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Apr 2026 13:02:42 -0400
X-Gm-Features: AQROBzBkQe9NBinyk_kk_zOnL1IORcSlBtuzNPmK1PGXne164YWpTa5vT6ndINc
Message-ID: <CABBYNZJMY-MH+1H0kFoXPxuKbjjWaPDzzaxX=-C9uwYtdxWo4Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: SCO: check for codecs->num_codecs == 1 before
 assigning to sco_pi(sk)->codec
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-bluetooth@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Marcel Holtmann <marcel@holtmann.org>, 
	David Wei <dw@davidwei.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Tue, Apr 7, 2026 at 12:45=E2=80=AFPM Stefan Metzmacher <metze@samba.org>=
 wrote:
>
> Hi Luiz,
>
> > On Tue, Apr 7, 2026 at 11:13=E2=80=AFAM Stefan Metzmacher <metze@samba.=
org> wrote:
> >>
> >> copy_struct_from_sockptr() fill 'buffer' in
> >> sco_sock_setsockopt() with zeros, so there's no
> >> real problem.
> >>
> >> But it actually looks strange to do this,
> >> without checking all of codecs->codecs[0]
> >> really comes from userspace:
> >>
> >>    sco_pi(sk)->codec =3D codecs->codecs[0];
> >>
> >> As only optlen < sizeof(struct bt_codecs) is checked
> >> and codecs->num_codecs is not checked against !=3D 1,
> >> but only <=3D 1, and the space for the additional struct bt_codec
> >> is not checked.
> >>
> >> Note I don't understand bluetooth and I didn't do any runtime
> >> tests with this! I just found it when debugging a problem
> >> in copy_struct_from_sockptr().
> >>
> >> I just added this to check the size is as expected:
> >>
> >>    BUILD_BUG_ON(struct_size(codecs, codecs, 0) !=3D 1);
> >>    BUILD_BUG_ON(struct_size(codecs, codecs, 1) !=3D 8);
> >>
> >> And made sure it still compiles using this:
> >>
> >>    make CF=3D-D__CHECK_ENDIAN__ W=3D1ce C=3D1 net/bluetooth/sco.o
> >>
> >> Fixes: 3e643e4efa1e ("Bluetooth: Improve setsockopt() handling of malf=
ormed user input")
> >> Cc: Michal Luczaj <mhal@rbox.co>
> >> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> >> Cc: Marcel Holtmann <marcel@holtmann.org>
> >> Cc: David Wei <dw@davidwei.uk>
> >> Cc: linux-bluetooth@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> >> ---
> >>   net/bluetooth/sco.c | 8 +++++++-
> >>   1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> >> index b84587811ef4..359eabf7dddb 100644
> >> --- a/net/bluetooth/sco.c
> >> +++ b/net/bluetooth/sco.c
> >> @@ -1045,7 +1045,13 @@ static int sco_sock_setsockopt(struct socket *s=
ock, int level, int optname,
> >>
> >>                  codecs =3D (void *)buffer;
> >>
> >> -               if (codecs->num_codecs > 1) {
> >> +               if (codecs->num_codecs !=3D 1) {
> >> +                       hci_dev_put(hdev);
> >> +                       err =3D -EINVAL;
> >> +                       break;
> >> +               }
> >> +
> >> +               if (optlen < struct_size(codecs, codecs, codecs->num_c=
odecs)) {
> >
> > I guess this is odd because there was no need for this code to exist,
> > BT_CODEC should have used struct bt_codec rather than struct bt_codecs
> > since we can only set exactly one codec, that said I don't think we
> > can change this now thus why we need to perform these checks, anyway
> > back to your changes why don't we have both checks for num_codecs !=3D =
1
> > && optlen < struct_size(codecs, codecs, codecs->num_codecs)) since the
> > handling is the same?
>
> Should I submit a v2 using this:
> if (codecs->num_codecs !=3D 1 || optlen < struct_size(codecs, codecs, cod=
ecs->num_codecs))
>
> Or can you to take it from here?
> As I don't really care and the patch is not strictly needed.

I can fix it myself, no problem.

> Thanks!
> metze



--=20
Luiz Augusto von Dentz
