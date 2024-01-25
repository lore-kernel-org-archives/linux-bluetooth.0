Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A237212FF82
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200336; cv=none; b=JEl+ynrf9w1tbH5iEk1aYXuuojW2/CasSpWjXUMzWvI4YywypMjlIfT2XL+9G66dEmFZj55X3/iPNETZ/YVNsxFtRzOmdS2Bxv+y6UdJ52vx/H7FxVJWGKw+bF8HsoWfyLVuX1Qngk1dlu4xhDqiXeIEBGdlmuxH3YIh+LKDfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200336; c=relaxed/simple;
	bh=vi17eGlYGK5gxBXDaGOakSoGN5OSnwCEMnpIRleq39E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo4t4gWefrTQVPa4PhCimwEo7jjmaCs2OyFmJfxN1rUgABbM/X1lZSWs2QU2udirJbCyW9rH6fwRq9cV8leuf3q0pfTG+DQbLLha88uuuivvu467i5ino4LN98tFXONm9hmP48G2UB7OY4se7timyJc7aYVvsy3eKTpLCoZBBFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPRqLsj6; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPRqLsj6"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc2308fe275so5963570276.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 08:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706200333; x=1706805133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fkxbe4mj6NsVXRxk9k5LnWCXRoB7FiLVu/033WSZin8=;
        b=OPRqLsj6mY93x1rIwPAaJRCohu7tMPppQRoU6ajeCyzJ99NXwHheBYxD73zRrgjR6o
         pJx2SQDjWUIsuaGfMGeMHm1shnSeg+wWUQX2scvp/1HEhDswV/ncZrRuRmutNqMifOAw
         hHxrzX6unC2UDL2Q/Mun32HYCJXsPzU2uFAZU8EEZKJZG/aVnKinDV0HgUQaUQtjXQnY
         EWWuidP4e2Dvsg1Ju/txda9mTpQZyB/6t/Si19zC0PchWEg2scQyhjp6znqbzmbFlxbp
         VR/qy9Jy7XulaOeV92hR2RYeC3Ib9CQRQI8aXn+XkVGcClkwpsNr1JAcb4p3c4bJ+mkP
         FiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706200333; x=1706805133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkxbe4mj6NsVXRxk9k5LnWCXRoB7FiLVu/033WSZin8=;
        b=E8NOIZLOF2CTjN8e+9zaNPmU8iT6Bbm9OIXzW4y+K+GW/HTME1dpkiVI8VkSZFsIGb
         Wce2pxNaszVoVkzbgZduHYbbv3BWEnaJF6egWKDRmgVgUWFcKtWiSMwYbJuuzJHn/nP9
         UOqJra7EyM0bmsPfdG4bhgK7OzlbKQAC8vf/mIoGENnB/0rZki0aJzyUPP22hCaGLhZf
         Uh9u0LGwb+MGoKmIoBo4uwRMh4yL8ou2y543VyKoXU+LcpdujmcGhw4vPN9HVGNgIfhN
         JxCPwhcMhWx81O4pq3oO7+08VwyYFVxNwyVjy+l5Ma6TVKrxBHIAR7QhiTJf1ISsG4Jo
         jJwA==
X-Gm-Message-State: AOJu0Yz/7hfgHUfg0pLZfhhuCtmPT5MLzgKGuTLIUBj9au/irdKyt+qV
	p16i2eMxjLe9yo2CD9sjXsNR/Pm0Tdk5xBp/TubbNoQ8gzWU8Skv3xPvKvY4d4oAD2IKf9WV7TB
	AEun9xf3791r1qsG0snuawyoFMfg=
X-Google-Smtp-Source: AGHT+IGX3kvQ2gtvK/hRHLSLW0TEf6hywUYUkJK/JGRIsg89eVUu4H+ufHf4lrZdZ9sEwuoUlmt4RGQSyTDLGvXab/M=
X-Received: by 2002:a25:bcd2:0:b0:dbd:5a5e:b1cb with SMTP id
 l18-20020a25bcd2000000b00dbd5a5eb1cbmr47709ybm.89.1706200333616; Thu, 25 Jan
 2024 08:32:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-disto-patches-v1-0-97e0eb5625a3@gmail.com>
 <20240124-disto-patches-v1-1-97e0eb5625a3@gmail.com> <CABBYNZLibBw-_SJ4wpzF-r5cDPSds99kShO9C3v2FVNJ2Um9vg@mail.gmail.com>
 <CACvgo51BHdhdzhPifJjuz66Dc2vJ1QEvCrkxQwQnC8dNWC8nZA@mail.gmail.com> <CABBYNZKmRsr=i4zQcqw8ofs-yrb488FVm8pu5XcpZerudcBGag@mail.gmail.com>
In-Reply-To: <CABBYNZKmRsr=i4zQcqw8ofs-yrb488FVm8pu5XcpZerudcBGag@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Thu, 25 Jan 2024 16:32:02 +0000
Message-ID: <CACvgo5120w03bgn8ZYeVPVcXh-mU1KWSJYJSTPN-6PfDb2zJzg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/9] Enable alternate Bluetooth connection modes
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Vicki Pfau <vi@endrift.com>, 
	Rachel Blackman <rachel.blackman@synapse.com>
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

On Thu, 25 Jan 2024 at 14:59, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:

[snip]

> Hmm, are you sure you are not missing something like:
>
> commit 288c90224eec55d13e786844b7954ef060752089
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Mon Dec 19 13:37:02 2022 -0800
>
>     Bluetooth: Enable all supported LE PHY by default
>
>     This enables 2M and Coded PHY by default if they are marked as supported
>     in the LE features bits.
>
>     Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Later one we had to introduce HCI_QUIRK_BROKEN_LE_CODED because of it,
> but so far that was the only drawback.
>

Hell yeah, that commit should fix our problem. Fwiw we were on the 6.1
stable tree where the above landed in 6.4. Glancing around it was not
picked for any(?) stable branches, which is why we're missing it.

Thanks a million,
Emil
