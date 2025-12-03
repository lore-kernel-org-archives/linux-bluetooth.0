Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6552566F7
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Dec 2025 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764799020; cv=none; b=kM60VapgwxzwS0pwxczTQXObWasrKDEWn+zzPLgdxF8XRkJzGwaGACQ8pEHv+6eERludpr+kZYan1Y3pNY8SquS++RpJxN2JbPpNtWVx0blW+ut9OGdpDwhlcyMbMjd1WWn7HXaC5wL0uyQJ9gfwQrKi56yxbLG6YHmQZ0KlsS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764799020; c=relaxed/simple;
	bh=6gEA0pJKVhBkDBYlpt0GRUh0HGVim6UTDPeTrbtrn4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+Jv/3XTkiS1jDF9d4c/tmjvO+4ZWLreV+U1ansbp9kgQ5rg6yNKfgeUSDB5olt4ujPyEECAn1nwsQj2fUBJS3VaNjeaqXrM6KSEUn0wzzxc+MgH0AES5NtbJFC82aFatxv5LGka0KbHUdqqlYptp2h9zmEXojbgs7XkmghJ5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jA611M+o; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA611M+o"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37b97e59520so1790321fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Dec 2025 13:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764799017; x=1765403817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Saws8Y94qpSylG9D9HDPB01VzD98ZNCI0FRXIYw3WZM=;
        b=jA611M+oQkl5YN5+jiJuwLamSpCH2ADQkpUro1BrjTwYBNnoaIhRXie2hxqljdamfl
         KUQnEGKkhB4WAlKSlF6Akfg3+FyoVdYf/QLMFIZ4Iwbc29OP63KayPjTCWacq2/ZnlgY
         /qvD6mo9Q8J97Tt4X9ouvWJWm96BqlT1/hbjwITQt2f8lpJtHTMTwqR6CjYaR+XSeHtM
         zKI08JVHT6u/pDeORcJLF9kaO1GVMVbREmBWGzeDspVMPqVLe633Rc3VUNPVZxb6Q5s8
         m0t/my+JcbYD0wBpCN6yA4IYnepeaRIo86rDrKRzBm5XrJwEXvNI1yl0KKNWeQ//Jlmm
         defw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764799017; x=1765403817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Saws8Y94qpSylG9D9HDPB01VzD98ZNCI0FRXIYw3WZM=;
        b=qJW+L9HFbCLwhK/mWLj5HxoBl5TuDiWL8lIm4y6Sy7rIbqjFtOD1S81v3nr4Auu7g/
         M2v0/dSdFiHZpp0lkK/wNR8/DVrN/3gyDYYXg/DZnVP156jZqNhL21qXWRX9V2CVji0l
         Qr/7D9r60J8jIwhDxyxASwghcRccVRJ7hjpedHPMaCZJZSidwTRSCptWK7lUi/5GWXK9
         b3Op9rslFNM2aNWb5esBFj2SRtKW7lIU1flc7qXCdUff6FHirScnbWJ78FPSF0aHOyGk
         z2cJqzSAlmwJTxrxYSI+nOyHWiySB6WpokJ2wpEuG3Wusx9RPUkSgW51/M48JugS/rx0
         U/zw==
X-Forwarded-Encrypted: i=1; AJvYcCWLOiJpYdEvZaCqg3fvnHh/V9N3ybNWyj/G/n61s/zZB3HmFOvuAZkUjbBbNizVt+zkJY2qnefsyAIDraeglYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyehnc0rKPXwbtuhfFK2uILXUdjZgpTAW2ZeCsZE+ouJM6/Ydr6
	EXy64xqbaMhNhj1E2kKJFLFKL3cRBorXhrCbcIWxkNxUTO57Tiv1hZrvD33+EFOJVuistU49+g4
	qRCxdcB8Xt1Mcvo7r+2UDpdLgbhCClZo=
X-Gm-Gg: ASbGncsjpSXWbECaTDkyj6Zr0Wn/mK/6U/XOElPxNdxjv6kkOoOWMT5GRhZF56ypAXA
	cK98n3GevZVy6MK2jtRVMAPpFwgqTSx718BQEU73l7RlJ5+t9dyxPHKi8dJM+NGE0QSupss++x1
	s46+zngn5mbyzDfPxZKrboB+pj+DuU1vaOBta0wrI1f9fbNYv/476vuWEcxxOAUYf3nmqp/3BQ+
	GXeDR/39yiL8BGb4Sw2H+3pTcU=
X-Google-Smtp-Source: AGHT+IFLdPoRYfYTvlEWLMdLLo36lk8cs7+WfkUclMO9AFimPEGln5SEMuEPo4tgnF4yZnE3aqITcD1unt0PYThN+0k=
X-Received: by 2002:a05:651c:324a:b0:37b:9ff7:2a1a with SMTP id
 38308e7fff4ca-37e6372e443mr15102691fa.7.1764799016683; Wed, 03 Dec 2025
 13:56:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764708372.git.pav@iki.fi> <176479740655.84322.12625187572932573679.git-patchwork-notify@kernel.org>
In-Reply-To: <176479740655.84322.12625187572932573679.git-patchwork-notify@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Dec 2025 16:56:44 -0500
X-Gm-Features: AWmQ_bn4NsBQeiDGlJRM0kXpfdnVjGAw_ZFbAPbo6rWxoS82N2Yu82bzXYgn2A8
Message-ID: <CABBYNZLuyQ9MT4u_bC+HsZg7kQoVx2Rpb-JJh2zNqV7J-W0Q1Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 0/7] Add TMAP & GMAP information services
To: patchwork-bot+bluetooth@kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Dec 3, 2025 at 4:33=E2=80=AFPM <patchwork-bot+bluetooth@kernel.org>=
 wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Tue,  2 Dec 2025 22:47:45 +0200 you wrote:
> > Add support for TMAP and GMAP services. They contain only device
> > audio capability bitmasks.
> >
> > v3:
> > - rename after_uuids -> after_services + make it a struct
> > - add tests for btd_profile_sort_list()
> > - leave it as the GSList version for now, tests use queue
> > - add commits to mark VCP connected only after its attach has finished
> >
> > [...]
>
> Here is the summary with links:
>   - [BlueZ,v3,1/7] profile: add after_services for ordering profile start=
up
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D5806271a69d6
>   - [BlueZ,v3,2/7] test-profile: add tests for profile sorting
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D37f1d5de78d4
>   - [BlueZ,v3,3/7] device: use after_services in service autoconnect and =
sort also GATT
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dcdcd845f87ee
>   - [BlueZ,v3,4/7] service: implement btd_profile::after_services callbac=
k
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D7f8ac0c1fbcd
>   - [BlueZ,v3,5/7] bap: have unicast client wait for VCS & TMAS & GMAP
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Db78808cfb3b8
>   - [BlueZ,v3,6/7] shared/vcp: add ready callback to bt_vcp_attach()
>     (no matching commit)
>   - [BlueZ,v3,7/7] vcp: wait until client ready before marking profile co=
nnected
>     (no matching commit)
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

In case you are wondering, I just had to fix the building of 6/7 since
you changed bt_vcp_attach but only changed it on 7/7, anyway brilliant
work, you really took it to another level with fuzzy testing on
test-profile.

--=20
Luiz Augusto von Dentz
