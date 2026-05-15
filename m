Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405A43F8710
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859748; cv=pass; b=XC51NffZwaerWuXS3bS7yYEMPS7nxy0vXijMCj4hT0c9yIFSgF2Z//asnAeOYTXvjFsl69nKKTCUerKPBcMzTPHqS0Ahpqt5eMd4oZSI7EbBESJzNGh6VgwGltDNsyt8SCDfsSVWFkZTDl3HrsbVOaYZojcPDptQ+Iv9ZZ9T/OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859748; c=relaxed/simple;
	bh=Q8Xe8mQWu9eHzyfcxTpEGfluguYurrQUL+FoyUxjORA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjGZd1dxcTCrFTKokMXjM6kvF5TuDXX6mfam6OnDgo3XfjVchrgO43K0IyTT6adcrDICIrC+0S5xqECBzFfKreGem0k+7wqo1A+X+BxvuzL6nlTd3O2TM7djFLP0unYfJHpTch8RWkCVevqXNrG+ngTvgtqQWU+udn3yPROslK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLU2aOpZ; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLU2aOpZ"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65c37eafcbeso12630781d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 08:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778859741; cv=none;
        d=google.com; s=arc-20240605;
        b=PtobIJsHmpwm7TJJe30Ed1np2/dBIm9tEpHGgZ/1hUOdrRi/HfHOXs7VTpCfuaHjbx
         6KV4oCiw+8ZyjXo8Dwzn7xip537eE+kV8A6sk3m1qRVbkfEgDTQlpxj7BUoV8EOgejNO
         MUEPvYaDKUnSxPBSy4paGftuLLMGyW+3/HS8SSC9vhrbb+VVZsdnBf1FApBQ4J/E9kea
         udfgmoNmycARRZWr2pqTnGLGKkw66IwMF8XI3tSRuthxQiZdL6CY2McrBCty4FIDqqGS
         lh7PPmcsvpFUxkgIrteR1+YVBriRJ1acb+v12cV1Jld8gJgoIhv0t5FayXhaxn1++iFM
         Bmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4DSxGtdtwhq/wwRzu6h0ytyeZ0LEpCgd8VLGR+YOVZA=;
        fh=f+1EwU4EEYKjWihoqhLYAkIyCmWXXOaiTzVkdrZFC5A=;
        b=lwUcBuQbau5GxGZB1/kGZdcBFIwM19zEZFNtHSx75p6P2lNqD7BYY8F13iCV4x+XsK
         6jV3GfzaChjpHGrhzqRx4A9PBPfcPkX8V8TzDnEtxJyvF44RTpYRr8noZ+wiAaq2g3lh
         y4lYMqNfeZbxMVLFY5k2riisMtcohFkXl3O1wEPrUiwARDSV+LT4tIeOIl7TXpDwd+ZM
         IbOiWf/TbNIkJMBSKgz0Jo8r9oTEM8SOnv9Ab7bI/KvqrHE4mmC63j7uqNdgAeo+6Dmt
         6dNu/S20B6ZEW8AGD3bugwUeLIzVDfV2YWa/T43toqi4RDKmXM59tlHPgu7oOfpW44LM
         8lQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778859741; x=1779464541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DSxGtdtwhq/wwRzu6h0ytyeZ0LEpCgd8VLGR+YOVZA=;
        b=kLU2aOpZWii78rQql58q/ilq3TMUk7RHOgRstrS4hUeprItitbtaWgfJdAwzEvpVv6
         AuNvl9OllVImBy3WMgYBJBE0YQqG6M9DwI5eW+TgSasmZYiwV1BgsIO/KRD2bpRcdwB1
         MW40LBZV8mDXm/Uba0dC3d2p8WI4sor697e7ZTw7z8i33uDJwigcIrDAnFZt9V2J9pzo
         2Bq0Hlxltbn0Pb6EvI8QpeWJ+emasOrAF/xB+CNMxfu2LxYn7pfpMj1zvVYEGT3yYQYY
         B/8d5bVjcjlVx5tvsOusRTPIJSuX/gSC9qmV82yknxtFT3KQ67OTQAk9uT+AEOv2vgKZ
         OXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859741; x=1779464541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4DSxGtdtwhq/wwRzu6h0ytyeZ0LEpCgd8VLGR+YOVZA=;
        b=T6/3lCEiosdcGLMzdEwfZXDppwsN6yVxgnhtP6UKsc8qSzIoSp6YE2ueGiUcbQie0W
         QqKuv1Y5/lZacWDfuc3Mgkunza8MUqqJ8bSd5Pv8nCxsx2CV0Do+JFM6g3rp21K2SafB
         +u9JZmuGV4tPmab5R7bsLMgKzhMKGqVjjNavftXRn+KM9NDpcBIU94n9Qqjpy3OcnDh7
         p9cBNFkxq4CgJRMcX19NLkQS7e0qzD4XK6Tdzgip+J7maFZZN4xY9690RR2XN/xKbWjn
         s8YJYkSTKPQiSp7BWZYGj3gqqRtv2QRDk/LzHH+qfThy1X00zhsP0Plwmyb97J6hxCU7
         uISA==
X-Gm-Message-State: AOJu0YxiI/i2w2kMzO9WTeO3SxoEuAt8mGaueN6GWD8smKqWW/s7oyfs
	IvNMaXjFg03lE5RKG4k2UZree+Tyh4lz43ewMU7GGAiddJi0kHQl07xVMNdgKyw8yDvKwdlu4+A
	EN43h6GNhr50HzPTYsbjwE7rM3rcjpT7z0/od
X-Gm-Gg: Acq92OGid/Tpz7lwVVIboAmJw0bCm87LRHfpoX8MnyV7UI1/3MFsYTjahld1Hc1QKba
	+NU21zv9vXJj5/vV17r4Q0vbtrDHgeuizCXZ9i6rdPw5EtsgI/jC23jFVxm6ZsX0aaWTZJddInU
	efGoeVK77W/B5wC9NeTMHL4dFZIqbkyXpd3CibC5tLqJjM2UtiSd64/Ae2LdampTgztLr4wAXsL
	aEDp70sbsOoBo5okdZUclyR2RtgcW5Uap9e9mraAVQVDQYtI/CwO/lcJT4ueQKucl0KUcQ4jpI7
	em9F92WgpvhpU1Hq0b53C+Tb2TsE3xHNb8jHdGL9kmThvamp1dK7SlXAr5D8D0DEIqrGOccjZn0
	FoA==
X-Received: by 2002:a05:690c:60c6:b0:7ba:f712:95a9 with SMTP id
 00721157ae682-7c959b9748amr51397517b3.7.1778859738037; Fri, 15 May 2026
 08:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513022008.3238060-1-kaihsin.chung@synaptics.com> <6a0400bf.0c0a0220.340460.a21a@mx.google.com>
In-Reply-To: <6a0400bf.0c0a0220.340460.a21a@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 May 2026 11:42:06 -0400
X-Gm-Features: AVHnY4Kv1Ngw_npiwEIGdYm7FJeenxGD8eUULcq5bVMWny8GGQycKEOFaUkH3Ms
Message-ID: <CABBYNZK4ndUzO40VduS76FeawyC7XtHbGCHLGK0HCq7WKMkpGA@mail.gmail.com>
Subject: Re: [v4] Bluetooth: Add Synaptics 4384 Chip Support
To: linux-bluetooth@vger.kernel.org
Cc: kaihsin.chung@synaptics.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 13, 2026 at 12:40=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D109=
3859
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.05 seconds
> GitLint                       PASS      0.33 seconds
> SubjectPrefix                 PASS      0.35 seconds
> BuildKernel                   PASS      25.97 seconds
> CheckAllWarning               PASS      29.42 seconds
> CheckSparse                   PASS      27.85 seconds
> BuildKernel32                 PASS      25.96 seconds
> TestRunnerSetup               PASS      537.07 seconds
> IncrementalBuild              PASS      25.45 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script
> Output:
> [v4] Bluetooth: Add Synaptics 4384 Chip Support
> WARNING: DT compatible string "brcm,bcm4384-bt" appears un-documented -- =
check ./Documentation/devicetree/bindings/
> #160: FILE: drivers/bluetooth/hci_bcm.c:1612:
> +       { .compatible =3D "brcm,bcm4384-bt" },

Hmm, is this warning something we need to take into consideradion, or
perhaps the compatibility is string is really wrong since it doesn't
match any existing chip?

> WARNING: From:/Signed-off-by: email name mismatch: 'From: Kaihsin Chung <=
kaihsin.chung@synaptics.com>' !=3D 'Signed-off-by: kaihsin Chung <kaihsin.c=
hung@synaptics.com>'
>
> total: 0 errors, 2 warnings, 31 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> /github/workspace/src/patch/14570021.patch has style problems, please rev=
iew.
>
> NOTE: Ignored message types: UNKNOWN_COMMIT_ID
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
>
>
> https://github.com/bluez/bluetooth-next/pull/180
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
