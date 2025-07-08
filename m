Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088AA17CA17
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003940; cv=none; b=trbplHiZU2Dg+bNBuQfZrINaqKplc6M7LXHOsXNndEk3ubzB91hJKssgZa6C+TkH8xzdRnpW53gGz4VHLiZXNhU/IQjpcIZEVRNZzgCDN/La4QMF9K9rbV7ylcGTmi7Ru8xF6qziaWAt1wkq/YD4zfOHSkbwbBEngXv8/2+aYiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003940; c=relaxed/simple;
	bh=AuikUvLTm1fHD33daDRLrBNgele6pVfREhEmBoM1k/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flpc5/N7g/rqMsj9xdQ/bbI2kKnrHtBS7bwOAAZkptfKdGLOmYu/RZPmyHpur2OgQbiH6MoRdEi7oU7iliYTNEC3U60NX5ng+8W08QsXGcAomZkrKFC7uW5LSKbQ3xQkIWBt2yoU+fu5B0zNZGFrPaiwN6pH48HSbTsqjyANKhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkG/9vvz; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkG/9vvz"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32cd499007aso36221691fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 12:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752003937; x=1752608737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgYuk0N7fx37dqHg52XcO5NRBzjdFU1cX3YL4E1xTMA=;
        b=dkG/9vvzUFQikZHEBPuw0OyII/svyRlNCsm3vEJSB+9ieUE+zXiTvCfuYgNeO3y6rI
         QUlcHF0/mPDh59nbeccaKDKu1RzFZusAT9nazxrnHE0EYlBBlWgV2zMwwD2EF5dsYiR7
         g8189wGY4KzfEisurfh4h7bf0h0S3wpX8rzxdH/DwVaXl3IldiWde9LfhupoSyUlTwS2
         K5bpEGB0tsPZslg0/i5uwnTRZC0ctrm/3fPXd/aWAL1COZ695ZFzqn3ACLgwvVKY6WEz
         c2UHvap91bseov1BQysKAiLdvHoF9DE5nlVwm2QLqiRDg9be5znHbrJlIkuFmogGfW6t
         mpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752003937; x=1752608737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgYuk0N7fx37dqHg52XcO5NRBzjdFU1cX3YL4E1xTMA=;
        b=FGb3qFovWFXJl+YY8NnqK84UbiI39cPMPJUgxb4NLgWmcmMc32EsxZjdP6K1y9hjIl
         dg0OAOPE2+v3rjuDlWSYOJKiRUQ8A68iWVfOqBmFRslD2I4K9giQfmAce2KQjvITRMrD
         t18MmkFcKn8VyUkX0dqIgHXxgoYLMYK5AUB4H3+s35NNrzCr2QHDkPbXmhOOZyz/tZ+f
         NK2LEfYzF7BYqOZ3ATmrXN/PFhUjxKYixYQ5yk+TlV12Eoz3zrVwwjxsEGUl+t5/4mpI
         HjRbDFbnJ7ijjbOHRvrUUn37AOt+7OLYiTBxxBY50BUkrpkD24eiohSfJFmMgPKZjn1U
         7WNA==
X-Forwarded-Encrypted: i=1; AJvYcCXsJrAAJXJCOtAjZUh/EpsqHqY1emA2U3PNLFFzdgm8WLLku324cUN01TQoRwZRtDu4KZ8wvg+q7tOvlm9pgUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdFX8k/tj6lwpH/0bd93P5e2yOthQuy3vBmZS03BSIi0dW99l
	W8h718KhK9h8ixEiBAKGdG/fmAhLr7JmRArmsDIE3otNvq51luD/zpygOMUJIH8bxmK2zsuacV8
	Hm/X8TPOtSf0xJRmN5nVqp0x2ULp4fmE=
X-Gm-Gg: ASbGncuFcb2r5x2j5zRMWmMHYTnwRN6IL1V4gBDWvX0hsSikTxd6OUV6BPv7WpYNKfw
	C2FMoNH8L35CG8SmUJP7MlkyKPBSshqNn9IGvl8QrCoNP1MKk584O0AUZNRjkcvbckdip5NAiJ3
	eQSJf6+CvlfFwlLuN99F4AA42BIAaCjgTc9cgQsuOhvw50UQ==
X-Google-Smtp-Source: AGHT+IH67cVPDCrEYnBDOgOtBvH3Em711WEAweO72jje5YIcuvZm7S6LbogBSiMJ+9h9NYq9MDMSFX+bOStIl1egXFo=
X-Received: by 2002:a05:651c:31c5:b0:32c:bc69:e954 with SMTP id
 38308e7fff4ca-32f433ac9a4mr2193431fa.37.1752003936607; Tue, 08 Jul 2025
 12:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708125947.11988-1-ceggers@arri.de> <175200300826.4179900.1130269204271239270.git-patchwork-notify@kernel.org>
In-Reply-To: <175200300826.4179900.1130269204271239270.git-patchwork-notify@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Jul 2025 16:45:24 -0300
X-Gm-Features: Ac12FXw7tQbF5vYjflv-RgZnyVcvH1uU-V28Aq9tkuScTxKpCF-HzpBv5BkqIAg
Message-ID: <CABBYNZKhyvfj+dsDvW5qWgJiuQYkJzjmoVd3j=i4-E918Sforw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/15] mesh: crypto: remove dead function declaration
To: patchwork-bot+bluetooth@kernel.org
Cc: Christian Eggers <ceggers@arri.de>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Tue, Jul 8, 2025 at 3:43=E2=80=AFPM <patchwork-bot+bluetooth@kernel.org>=
 wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Tue, 8 Jul 2025 14:59:33 +0200 you wrote:
> > The implementation of mesh_aes_ecb_one() has been removed in commit
> > dfed4839463f ("mesh: Convert crypto to use ELL wrappers").
> > ---
> >  mesh/crypto.h | 2 --
> >  1 file changed, 2 deletions(-)
>
> Here is the summary with links:
>   - [BlueZ,01/15] mesh: crypto: remove dead function declaration
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D441f0539a1f8
>   - [BlueZ,02/15] mesh: crypto: remove unused function parameter
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3De1b2647179c5
>   - [BlueZ,03/15] mesh: friend: remove dead function declarations
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D2d012a2f629c
>   - [BlueZ,04/15] mesh: mesh-config: remove dead function prototype
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D797b330b9ff5
>   - [BlueZ,05/15] mesh: mesh-io-mgmt: Fix NULL pointer dereference
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D806aa9de2b42
>   - [BlueZ,06/15] mesh: model: remove dead function prototype
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd40ed08f446e
>   - [BlueZ,07/15] mesh: net: remove unused stuff
>     (no matching commit)
>   - [BlueZ,08/15] mesh: net: update comment
>     (no matching commit)

Had to skip the 2 above since they didn't build for me.

>   - [BlueZ,09/15] mesh: net: remove obsolete struct net_key
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D2d9afa114507
>   - [BlueZ,10/15] mesh: net-keys: introduce BEACON_LEN_SNB, BEACON_LEN_MP=
B, BEACON_LEN_MAX
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D0cb00fce1b3e
>   - [BlueZ,11/15] mesh: net-keys: remove dead function prototype
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D41b4b531beb8
>   - [BlueZ,12/15] mesh: node: remove dead function prototype
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D6ef0f297235d
>   - [BlueZ,13/15] mesh: prov: cleanup header
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3De29506315cc8
>   - [BlueZ,14/15] mesh: remove unneeded casts to bool
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D4e5a3a80a842
>   - [BlueZ,15/15] mesh: use '0x1' rathen than 'true' for bit operations
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Da3824b4aac0e
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>


--=20
Luiz Augusto von Dentz
