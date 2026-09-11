Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18284496D41
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144296; cv=pass; b=f+vKRoKkOYwyh0c+e7hHdmecaCSqLmfHjjHToyI15sIgay/p7xmGllf4H0kq/cONgHp6+zH/Wi3EI/jJhIoxRxXcyQ2jlNQJb5ypgRXiZjunXw4bfzQo+7fs9/5JqmDtaAAFgbWqTQ8shTmtp+S+ND0sNFJ64TXgLeDW8XiHVjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144296; c=relaxed/simple;
	bh=fEV6VS4AEMywdizFgURv10DoaS62RvZm4MAMMUhcmG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zu0dSRnsqW4/fBZnsavnlnBK0R56/Z5vv/2c7ysSSAgT56Vstbk+yhze6bg9w3yw5dsg2rzDrSncfR4vIPqUO14WzRzm68SRpJ2EfGdW2egOvHH8SRzJOkiwE6nYQX1UWsb6QmAFU+zVERH0aLKbzWISd36XvM0A/LTkZ4h3gog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6hAOPfV; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6hAOPfV"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43da99ddso1947917b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 09:31:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789144294; cv=none;
        d=google.com; s=arc-20260327;
        b=Yk1ymEtu8PUD6aiA7LPVk5XmmWyQHyvXEp7pfJ6i1Nt04Wtdg7gtP743lbvV4ux56q
         TEk9NW293Ej7grkNWPuoD7VsHLEdnKTuqjlLnuFIQ/2I2dKqW22Y4jh66Bnzj6qJ0Odv
         AH/GENslQALRPh5HqVy3/mWRmjhgnAXQN4LfZV/8qRH2VFoWbEUwtcZiba8TfhwiNeQp
         koscAFOqHdGeYIyduqfVyUHfc1XrZ6e38DOixDAKu1hEYZnuLfK2R2nyojlRZItofhgz
         w5yWub3wvSR7hPVn+1DP3jzcNsm0BUCinwEeqnLWJ+yHK4zKEM2H80HRS1APbn/fWRly
         X72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fEV6VS4AEMywdizFgURv10DoaS62RvZm4MAMMUhcmG0=;
        fh=wGNP4AVAvahmR9ehjh0uXZ/wTIUd+2txcfnCPWlCHR0=;
        b=ZNpD1jqy7jtfuvN2YWWPQX0uETowpxcuaBzlWWnPj7a8bY1p0XG+oKg6/CDPUALypu
         WEZ7QBxq4J8V2fdstbyPG4WSXJxZKKxh0G+07h8Rjfym+Fq/wmNcyihS38Eu1fTgDATY
         m1QYi0Sl8o7ze1L/e3SBoh1CWzGURUPB6xW7lzE3k/ovwxpgTSfU23l2sE/nA6VtbbEy
         q/AwtNh/nd70kjlf8MtgY3XF53vKp8R8d64MtxJchayNf2yUqAC3o9WP8OzMxHF9byLF
         X+hvB8S5+LEDr3ynIxoNs+YJuORF14rr4SQvjhg2Dxs/RTQM+zB7vJR8QDKfP3D0zf9q
         GkuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789144294; x=1789749094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fEV6VS4AEMywdizFgURv10DoaS62RvZm4MAMMUhcmG0=;
        b=K6hAOPfVxcnmgbdEgG9oa15mJ9by2E4uqZTE5zL3LoBX9le2JRNfaD3kR5KAT2Z4Xx
         6cczlCSjSChQzLiuz3fxFEE+HtTdjwagFXrp4yAPlHTMXTxL+gERMQuhHLGoXAu0zNp8
         vX7up2k1NkUGsuLczozjkw9opAMqHWA3HEuv5fon0OvED8kJDF9ToWlkleYSk9/LLncf
         KlUsjK7x+5ELSfcGES/sx6GQqnbA44wxId3E0XJsZLENXyPEPE+4vI2WRp90bxLdGT95
         UcNQ3QFBD332QlsjbjnPBupc8V8oMePsjmHy0FkzhpWZOOBSLQ21jDt//fuwXL89vGdy
         bWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789144294; x=1789749094;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fEV6VS4AEMywdizFgURv10DoaS62RvZm4MAMMUhcmG0=;
        b=UE2VtMeQI9nPMUixFWcAbn9Y4i2JhZjwz36SawKShWA7BPbAFDFpri/gp+c5Qq4JAy
         XwZWI+aFQhe57829DdWlVH6dW2Ge07Hy+4fPwLTZ+1CnVIdxjDSzkfvEQ0ojkXKJPur4
         CC/cECF6Dmq/cr+3xv+eGkliONJ/sxhZUOe4netYZiKEeCN4slAzZK9F0w8EAp3mNlRu
         uoROtg43Kl3IUvUBVf4V/tK1ZNpxQqa14e226YxaNHztLGoIvVK3IlW/RoAdwIyi0HP/
         lrZeZjiD06lkFxSoepsdIadorypFkOCzquo8xTwwADCQ6i7xTAVZclvrrljXPfAiMvx+
         W13A==
X-Forwarded-Encrypted: i=1; AKwUvBzFrF22/TOVTLvZp8g3/OmXbHr9mvOeUjdC/DHvQIvrzi1NG6asobGhfFYQskA+3c0zkLlxelS6UVOaEUkfdYk=@vger.kernel.org
X-Gm-Message-State: AFuF++nT9ESPrBTTb+zjSB3KSp5EmFdoFWhx2sW8oCs03hs8OYBJmgej
	AHAr3uP97VvxgB8rm36d53209WNVhMJWcfzd/JmVy6EZHZz4z4boglCebfoAAIrUoHfFtLzP0UL
	bOGUp0xVLBc05TXylFZvsOm32CVjipuk=
X-Gm-Gg: AYBFou1UiSGCY5mRDKA0Itz5mm8uPU5i2Kf5ABCsb9TQOWb4gNND800AOLfe3LW36rS
	RtGKwlmXe3bwp0uw5SPp461Hb/ei4gYJ9ygUGsUxCsOusVvcaneI/0b5HtOLaYg3+DysmkqW2cW
	0uJEcPqiYuaECG89rN6aAKaaSdwzyEM/rByMN0IM3uVysy24VIOxf9+/RMQCltrbolJ36Ly2Mjj
	xsbIje6rBnGZ7yrwV0nkAIj+6VAxmBp1lJXr8hVVlC3nVcDHbVtdPCm0Snn1h3ZvfTA3Tf9U94c
	4qQ+R/LBKKLfcxgofceAzCGZuAhhzFSyqfoefoW4l0nejkOT+7xay0m6O1qCWawIz/OgZxSlnUB
	lkDwyHG/qLy3RMFyyDb1+Y94C+OZ8rWGGitxWJsGM
X-Received: by 2002:a05:690c:a7c6:b0:873:5bd1:98b8 with SMTP id
 00721157ae682-884b200e5a3mr14970567b3.42.1789144288827; Fri, 11 Sep 2026
 09:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788712996.git.pav@iki.fi> <178889520963.3704993.9911217550470009790.git-patchwork-notify@kernel.org>
 <CABBYNZJmYqh6ZJ2wAjauP5mkK5gxgyRY8-EnKZ6v3tPNe5=6Ww@mail.gmail.com>
 <CABBYNZKW=W8_Q+KXmGmn9gt7hN74H_EO0mSd2vOzqM64yoGWmg@mail.gmail.com> <32f2cdeea1561dce8a974196bebbdd1b688e4542.camel@iki.fi>
In-Reply-To: <32f2cdeea1561dce8a974196bebbdd1b688e4542.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Sep 2026 12:31:17 -0400
X-Gm-Features: AcwNN1WiJ7er_LMEQXEJ_O-UHLuSQ-Sg4qHdG9z8l2vPenQSYLAU082VLCnb4ik
Message-ID: <CABBYNZK6UVawo5+2y+OYPa2F7q=k-3GnWUcVMX3CGLutdL6Hcw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v7 0/9] Functional/integration testing
To: Pauli Virtanen <pav@iki.fi>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Sep 11, 2026 at 12:08=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> to, 2026-09-10 kello 13:47 -0400, Luiz Augusto von Dentz kirjoitti:
> [clip]
> > While chatting with @Bastien Nocera he suggested moving
> > https://github.com/pv/bluez-ci-image/ under bluez organization to make
> > it easier to manage. Perhaps the same should happen for
> > https://github.com/pv/pytest-bluezenv.
> >
> > There is some documentation on how to do it, if you agree, on:
> > https://docs.github.com/en/repositories/creating-and-managing-repositor=
ies/transferring-a-repository
>
> The plan was that bluez-ci-image would be moved under bluez org. Image
> name needs to be updated in the workflow scripts for the image and
> action-ci, see
> https://github.com/bluez/action-ci/pull/7#issue-4699895038
>
> > There is some documentation on how to do it, if you agree, on:
> >
> https://docs.github.com/en/repositories/creating-and-managing-repositorie=
s/transferring-a-repository
>
> This appears to require I'm member of the bluez org, as it complains I
> don't have permissions to create public repositories there.
>
> ***

I've sent you an invite. Let me know if you still can't transfer; then
maybe I need to create the repo or give you more permissions.

> pytest-bluezenv would need BlueZ organization account on pypi.org so
> releases can be done,
>
> https://packaging.python.org/en/latest/guides/publishing-package-distribu=
tion-releases-using-github-actions-ci-cd-workflows/#trusted-publishing

Ok, I guess you did this for the existing tree, right? Perhaps once we
transfer it, you can request the update under your existing account,
or are you saying we should request a separate account for BlueZ just
in case we need to publish more packages, so we can reuse the BlueZ
account. Btw, once you are a member of BlueZ you can probably submit
an account request on our behalf, anyway I can submit it if you don't
want to do it.

> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
