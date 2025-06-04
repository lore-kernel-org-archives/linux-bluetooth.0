Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3F31E522
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Jun 2025 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040911; cv=none; b=SxNxz9erlLxoKYBrII7zUIPuZZTflNziJx5IUyytlKgFC+faRNLfFnrb6JMQco+LNKCnRwCA73OO3BeJj9Vwal/b5jfKVc9m1MIcyCFmMYlr0ZUtf59GZsgmG+/IKuendJvyYGoijNaoBiMQX6civcyNK316BDaoZd550AaoV6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040911; c=relaxed/simple;
	bh=f5d+H4V4HoWe8DREbkJGpvTv+FdmgGAcByb457S0PL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Da9CuWzTIMhtxJ4UMQgTi5NkSJnufHhy3zGimgTuHurXAe2uAtEc40VBOsdwdPuz5gCKv6ZFhzhnu/4R0DRFfM13E/c3LWzcO5e/NbbKMYq6gq+fn91qUfmcSBZQMFIvDGG/hPAW44DrLRqk5fX8t7bSFCzejOhIpNHLMPLrq0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTbaZOP4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTbaZOP4"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32a63ff3bdfso55734191fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Jun 2025 05:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749040908; x=1749645708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5d+H4V4HoWe8DREbkJGpvTv+FdmgGAcByb457S0PL0=;
        b=VTbaZOP4b3/ZbwHa58jYYkvvajER8mXNR9ugpzstDzKEeUJUfpBOkxWGMy9Agw3AxT
         kFZ+qw86tbsK57WKMMo9yq2UCl+OVwq9jzOPJ99AmDrmODL9lJTCsPWts0ngZ4WRQQfR
         80OWdhDJyLxTrUDyLzzTBPBieW12gbSMWxno4d2Jmr0OAc0priaa5Gv9TvsGEhWyatux
         tsdoRvXEi9QsS74ZUsn0p875OnRRfvRAnFOUPWw+Ns611T5RUbkFpceMEHFKBfqgI3WJ
         2BlxCTbPhospg7dA6cVTIPF1RMQYzvN6yLSw7krfxNpP1uw6PFouflSzZT0g6dyM/2rN
         uP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749040908; x=1749645708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5d+H4V4HoWe8DREbkJGpvTv+FdmgGAcByb457S0PL0=;
        b=fC2aPN1DO2hBefHTYOK7wdUrXyxqTQrbS/0OATmWm+5M5DfO7jLr3D24aML5gvj+UU
         mdk0mB5+DPc4Tub0gzd17LfoWA5peogRADgfmKOfF5XgdQIeHGx8Qoqb59NsUa9qdzqf
         fyOsatkZXHlWEe0VbynSYNfLYg2Eg/MkYIKsmV0gDQN09HasR65b9Kvux5jP71tnGpoF
         GqRLLMkToXAK3SsJy7SRxGTuqEKix+gezUnnL/YyYFd41bLRJGJaty9h08YBi+g9Cuc6
         e1NIc7aDUgxNsOHDER1DVgtCNIjSVKxM/dP88FkSF2nFXGVmgkxbyrjaElxlUytpFkdr
         Cbig==
X-Gm-Message-State: AOJu0YzilglQNG+Ee6G5S9EnI1ay29D9fs4zEyrzJqWe5zU3y7B6ipio
	us3J3QvwBrjminO38oztJWZebTrMBVBRqS4mDvYcwwF6s+gtPiXRZiJ4+XK39YjEE/PIiSWe4HA
	pryW4WdtovqxGnbwYgWEu66fyaNC7XOYfHnsUwZo=
X-Gm-Gg: ASbGnct8TIDVZIygPPONXLdD6EmVkUF3BikHx+YcSGBMfbvP91llxWEKtSh3F+mKReQ
	Sej1t/spb0xYXn9nB6SUkX1I0Ud5A7aLSa+I49jlJxSjc+3wpzWPseLCEAKnkbHnY6IxDcFN7HQ
	fxLF/MLqTJynl7IUr3Zico00HcevJvn7s=
X-Google-Smtp-Source: AGHT+IGJHCqhd/A06HrJyX1aYGiNaG0YannS6ePSSWH5W6hwjr+r9tpb8I0Xpe24IMaCK2eFlqMUbRn5kNlxD6tfD7w=
X-Received: by 2002:a2e:a586:0:b0:32a:6731:7995 with SMTP id
 38308e7fff4ca-32ac729d05amr7386741fa.38.1749040907619; Wed, 04 Jun 2025
 05:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603095617.92785-1-sdoregor@sdore.me> <20250603095617.92785-3-sdoregor@sdore.me>
 <CABBYNZJYwKurqo+HDUKYtFx0+-rNquj=OHgpcZRZYVmAxDzqpA@mail.gmail.com>
 <c8b55be8b9abdb73bc57e8a2d455770199a2b21b.camel@sdore.me> <CABBYNZKL2gYmWPfP1owAUSAieWgt4ARaFp0-T5+vQ+rgjWnNHw@mail.gmail.com>
 <4c6bec3c1c02243cf57e1618d1fd35a2f12bdf22.camel@sdore.me>
In-Reply-To: <4c6bec3c1c02243cf57e1618d1fd35a2f12bdf22.camel@sdore.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 4 Jun 2025 08:41:34 -0400
X-Gm-Features: AX0GCFt5G_SBveykXcOBsZWO135iFe8ztdQvU4dO1FAvwfF6VvuT0rq2I8_gepw
Message-ID: <CABBYNZL++r5p=opkw-saPK8yqKQWEPrU-AvcQvPK_x+0yXEUkQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] plugins/sixaxis: Implement cable pairing for DualSense
To: sdoregor@sdore.me
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Egor,

On Tue, Jun 3, 2025 at 2:35=E2=80=AFPM Egor Vorontsov <sdoregor@sdore.me> w=
rote:
>
> On Tue, 2025-06-03 at 11:38 -0400, Luiz Augusto von Dentz wrote:
> > Perhaps it is possible to write the link keys directly via cable but
> > then we need the OOB data, etc, to generate the keys which in my
> > opinion it just extra work that doesn't really add anything if just
> > works, or autopair, is used.
>
> In my experimental PoC I just generated a random 128-bit string and
> used it as the link key for both sides (placed into `LinkKey=3D' in
> BlueZ's `/info' and sent to DualSense over USB), which showed to be
> working perfectly.

Hmm, not so sure this is secure though, I mean it could be a rogue USB
device pretending to be a controller so it would automatically be
considered paired if we just self generate the keys without asking for
user confirmation.

> > Is it not seamless right now? Doesn't it use 'just works'/autopair?
>
> It is kind of seamless, but you still have to accept the pairing
> manually (e.g. be discoverable and with an active agent). In terms of
> security I'd say this behavior is indeed preferable (otherwise one
> could spoof the VID:PID and zero-click bond with the host), but it
> still requires two separate confirmations.

Yeah, the zero-click bond might be a security concern though, so I
think having the user do a confirmation for each step is sort of
assuring he knows (or at least pretend) what is going on.

> If we could generate a static key, place it to both devices BUT at the
> same time mark the device as unconfirmed/untrusted/etc. locally, so
> that it is still going to trigger one and only one interactive pairing
> confirmation, that'd be the intended design at least in my view.

When would we generate the confirmation though? I sort of trust more
the Bluetooth process to generate and exchange keys.

> Another possible way would be to automatically accept the first, dummy
> pairing request that doesn't bear a link key yet -- so no security risk
> there, but still more seamless experience for the user.
>
> --
> Egor Vorontsov <sdoregor@sdore.me>



--=20
Luiz Augusto von Dentz
