Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF55540A1
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062503; cv=pass; b=ED0CddkhRPb6GOT1RgZly+jb3Jc1e/YlpaAsl4Jq55oOM+0X8589yD6V3Z9abXWMqRMqhRxm8Ymg2duhZ4FUnsyfqOWP/6d3e6Xw9E+SraP1J0KWWBKGXLWT7KfBlu5dtawEQTLs3k5TZi3iePTD60cHMMsSS3k6xr9UpCccS6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062503; c=relaxed/simple;
	bh=tx3Y3alrqI6jPejN5lZ9tcILcc0aew7B3sz0gKKwvBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJl0svvPmEssOqcj6wiTA+9wm57mtqJf5+BuqY3H0D+n2ZAl6/9i3a4GULZ4/w5VqZN+OTSylwg8slJd5i1zSa41o0Qc7ZFv9XrFKhFNVjUtPTfilpvvUTPj3ap3eV6hHRMwr5YnUiWjpfsXTPsa9jwDbIF3EwS9oWrcQRRoPz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0wrbkIj; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0wrbkIj"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcdso29652857b3.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789062491; cv=none;
        d=google.com; s=arc-20260327;
        b=frToYyAMOdJR6rXfmBvp0yOnGTFwsqP7I9NbusbrUZLQ19AWh4TRZEjMPkdX61QD8H
         F7Hi3dgxZFthCcuAKOY8Tn47rUYJANO74uzG8v2u4D+ESwRfv75LE0Q24ha4i3FBDwEv
         SjjQM1m8ByPqiSDbyFhdKGxrZNHVhB59mZeqt4SNJosbLJAkwHHB97l9qWZsMyYGOR+a
         rd3Z0t63ye02TcRCywSvEMA3ae2a3vnPrK3czkps4Mmnn6DrkJn0CLdUWtocBIXQxkfJ
         SeAJa+/8coHghJZVi83vBJjAyRV3f9D9/abZD07WA55AW8XxgY02onqT/Fc3cBjVAnzC
         mqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=InmZal8KWKal2JbxYZ25UpNWZL2HbEHUHMQu96CR4J0=;
        fh=ckSHMYMtIcmNPRkkmbLsU8b6pTZKbO9dMA63R6z5nG0=;
        b=OIr05XGik6atAi7Sf6X5zgonQusak3806ydFGMFelC72YICb8m7tP2QeGRCm3BBlFD
         jcwTtw/rX6R5K5ngIFXOgxNCTvjcTDQFa23GO6sq206zaRIrU9NQTPygmxoVRw1VLXXf
         ifKqpVJG6ajPaSq3vNhgsFMt/MWw0KFBw6fePwtoDx0qOQtVN5LJBlEPVBlg49Viffos
         R2wJ0LCDauo9zYo9UYa5d3FfExtl/mXATnaRXVL/wXAA7ahT1fcCzKLWhTK+C//rCP8+
         OFIKe67+Xf6Vf0bF1lFM5REt7eL1GR+5RjwCdZTyUWPUkUwcxHsiqyfzUwstdy46ZR+7
         AzXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789062491; x=1789667291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=InmZal8KWKal2JbxYZ25UpNWZL2HbEHUHMQu96CR4J0=;
        b=o0wrbkIjfAhdsz5KVm6pLXO5IPTdn27CXQ6izHJP2Tt7hQhfSD3AJYIBC5UR4JF64y
         HIuH/+wCDit8VWZYsIk//hEkeJohNMHl0+GzlKSDUhE+gP0S7LxbLpBCEMG6C2/WPS9c
         trHOcge4CjG6SnaRJk5mNZRi2K9ux5iJzFnS2xl6Sdy6wjCh55Tk8AEz27UxBHvQtDcR
         NrhHhk2+hi/7mGwlqNOEeg9k/6RTDv7QzUA/P94ZS7SgAZGnPiZrXuNBoQdoNDmv67CI
         PcD9zxgxBhfsAKIuFmeuzdtbrzDt5EHqfNrPqyDUaOMoGph36NWYCqv556RlHrDLFHeo
         wOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062491; x=1789667291;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=InmZal8KWKal2JbxYZ25UpNWZL2HbEHUHMQu96CR4J0=;
        b=disNmBYdfHDz6g90niW2f7VK/Buf/SpTq9sfHqdAXXO8MFtpI8y6gzsYiL13O5MJjV
         NS9sZl+nObk4giFpcUeCau+r/UBYrzTd2WeB1+s/EyfS0pQN1Ev3YM2Vs1W32CH4CEVl
         IOuFncwnSFDOGWvVV7dpGgMu0eNRI1pYruMhSoaXPDMLJ9aXoqrSaVBVXL9+JQ0RFa4h
         3CCkN7cGlpJ2VwJUMpv3egJ2IXUEDTWNceC3jgYThaT18TT0K1NYdgs3KsBQDazOzoTi
         I4Fgd3Zjx0rpLPJ1t/i2ZOsy/AaFHmZXoeWYNGMM/ffC4CNWaMquzOKOzxvBsB/S/AOu
         k4Vg==
X-Gm-Message-State: AFuF++lhWQK6jOsYfJ54+65v7Yc7cqOtNVxHXmxln8ZsMyrQHRsztF+a
	I84Xe1GHVDLueZrQeiKDrh7I9weN6he4U7FIv4RuWaMXPV2yitDP6aWc6LAzK/NPtSgePXf1B2Y
	2EhQd9rzBte51FJ7DPndPBgJNKXMu59TEYobWGBA=
X-Gm-Gg: AYBFou3Ae07aZQqx1DG4c89rIJwbW/MYY7wF9djQDj7nw8zkzTJI1aICXGXr92IqCIS
	vFawgkgYxdpiq6U/v7h0kyNysPyi1PVGKhleUt2zPa74TrSzFV3sXM8PPwaXNv1BI997teBuiLT
	iF49ROMr5T/51oIjLCCbKeYey+epsxTSVgrAAlKFF0HcfTGGvcYyOcunoNKW1DQgMs1N4Ao/v9z
	NFufDcz2DSE5HkGKh5039fjO2RtMkyh9F5njtkd3nKn25Yi0QafPyrjecZDQfuQ0af5xHGck0BB
	BmkGd9AVOgfiXWN2s7Y766GfX71wyT/44D5txoOGylH0IRTN3REzUB78mKjLRPPrnLQRAE3cELe
	UB7/Phwsjy3fdiAouGQzsyJO/ra+g4DslCVvcZAK01A==
X-Received: by 2002:a05:690c:e1db:10b0:87a:db19:ab5e with SMTP id
 00721157ae682-884afc193ddmr1525287b3.10.1789062491140; Thu, 10 Sep 2026
 10:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788712996.git.pav@iki.fi> <178889520963.3704993.9911217550470009790.git-patchwork-notify@kernel.org>
 <CABBYNZJmYqh6ZJ2wAjauP5mkK5gxgyRY8-EnKZ6v3tPNe5=6Ww@mail.gmail.com>
In-Reply-To: <CABBYNZJmYqh6ZJ2wAjauP5mkK5gxgyRY8-EnKZ6v3tPNe5=6Ww@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 10 Sep 2026 13:47:57 -0400
X-Gm-Features: AcwNN1VvuTD6d2he4rwie0zVGKYpOzpIUmgYIakOcTtvU072O3Ts9FA8povW94Q
Message-ID: <CABBYNZKW=W8_Q+KXmGmn9gt7hN74H_EO0mSd2vOzqM64yoGWmg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v7 0/9] Functional/integration testing
To: Pauli Virtanen <pav@iki.fi>, Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli.

On Wed, Sep 9, 2026 at 2:56=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Pauli,
>
> On Tue, Sep 8, 2026 at 5:48=E2=80=AFPM <patchwork-bot+bluetooth@kernel.or=
g> wrote:
> >
> > Hello:
> >
> > This series was applied to bluetooth/bluez.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >
> > On Sun,  6 Sep 2026 19:49:42 +0300 you wrote:
> > > Add framework for writing tests simulating "real" environments where
> > > BlueZ and other parts of the stack run on different virtual machine
> > > hosts that communicate with each other.
> > >
> > > *** v7 ***
> > >
> > > * Bump to pytest-bluezenv=3D=3D0.1.9 (better core dump / oops reporti=
ng)
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - [BlueZ,v7,1/9] doc: add functional/integration testing documentatio=
n
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D19a5bbd7ee=
e2
> >   - [BlueZ,v7,2/9] test: add functional/integration testing framework
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dfa9390b5ce=
e3
> >   - [BlueZ,v7,3/9] build: add functional testing target
> >     (no matching commit)
> >   - [BlueZ,v7,4/9] test: functional: impose Python code formatting
> >     (no matching commit)
> >   - [BlueZ,v7,5/9] test: functional: add some Agent1 interface tests
> >     (no matching commit)
> >   - [BlueZ,v7,6/9] test: functional: add basic obex file transfer tests
> >     (no matching commit)
> >   - [BlueZ,v7,7/9] test: functional: add tests running the various kern=
el testers
> >     (no matching commit)
> >   - [BlueZ,v7,8/9] test: functional: add test for adv_monitor crash
> >     (no matching commit)
> >   - [BlueZ,v7,9/9] test: functional: add test for AVRCP crash
> >     (no matching commit)
> >
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
>
> Do you also have the changes to https://github.com/bluez/action-ci to
> enable functional testing? I was going to do it but if you already
> done it please submit a PR.

While chatting with @Bastien Nocera he suggested moving
https://github.com/pv/bluez-ci-image/ under bluez organization to make
it easier to manage. Perhaps the same should happen for
https://github.com/pv/pytest-bluezenv.

There is some documentation on how to do it, if you agree, on:
https://docs.github.com/en/repositories/creating-and-managing-repositories/=
transferring-a-repository

--=20
Luiz Augusto von Dentz
