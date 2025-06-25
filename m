Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EF520F098
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750886950; cv=none; b=Yl2CrEwCHRS6RHoqUMsvEF3twjzxcUDewHkfE6Y6aFqVSHutf68o0M7Mb3LuxyKf/xrDGHnrAyh967cc3BQTwJ8ehF2/LMvknNbxGEHgu3gz6K/jB5xBz0sJtdzRA1Acbi6OxsLZDty4BnIdx5q3BywxMIaBBb3F46iUp5Qi1jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750886950; c=relaxed/simple;
	bh=a1bWDVPH6JJc6FIkCzsA1IjHoETLTv2ybfMV2NNtjMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GxAWnjVFNyLC3T0Pawu2h22IbZnpUjXrhY3wpL1QjBbf3HZRqVR99JGwsdiRc64bgn/YyqIurqvjKsgOwIf4pLKWGD2D59ZZzDbw9TzrMuWvaHXReAoR8fT+eBoQq2fswlBoN8s984zZTIdAh7nGYu4lE4aZ9cW4ya6VMfRcyVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZA7kasl; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZA7kasl"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so409251a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 14:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750886947; x=1751491747; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVdH8yKBz0jZfArEpKg5npuDdaFrtm5jzQHPpKmFt2s=;
        b=FZA7kaslTjTY2a1T+vsmwV5XiTO04w8i71Wkabt0DAhS03sk+2bpCGfr7AaZV+NtHV
         iYVTJKlfWWkZsftWFNaLiC04qauKpv96rXzxRMjiIJGdiZhUZXcCe5xgIfQuImRodvKY
         01CiQeGLttNibraugXEsnFLyiwN39Jm1wyPPfUU3R3mWXerkZzouUM9B96vqFpn+mCMw
         rsGJNMcGBqKY6ub+tSrRCvt4qL3c5cnf4Lwv0JmivyPccXgYcyoxU9Ykvyge0UyyI40v
         sF6E9t32HcJE/JkMs0oc4Y793d1XsRmMCOlRDQnFVw0ETg+KeNfc2TJWjvoMg1AUL0RC
         hD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750886947; x=1751491747;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVdH8yKBz0jZfArEpKg5npuDdaFrtm5jzQHPpKmFt2s=;
        b=FxoU5l3BjLD8gcy8XsoSALWV4zSgDfGCuqSAWWBMvQlZ7KIko0woxgnYul/ESc4MbZ
         j2xmQALdtGH2iU0XbPw6sMBlCGzw9qqWJEudytLs9c1FYNPvsxd7koZkqf/kJPE9dfrq
         js7dvxxxyQqvbIoP1MvJPA5lrnFTmE5z2VsuZgG1CYwP56VwjFm/hsXp9GqVjgVbbtby
         hdCqJzDOAob3CSZBY4UHom6Jv6mS6AVyRxF0BQ3HilfdzUg/SjynupUIcSc9f3F5JgmG
         GzrNEjY/24KnF6wswMdS8ufhi1QgTpxrDYpGTFZYJOfF0IynYNrA0Qs1i5AGBu5A0qvo
         GN4A==
X-Gm-Message-State: AOJu0YwPbjVOybZTl5YVbbqsnlfXXCL95Og5fF20Qx3fsZVX2Lj8yjPM
	eOtfQJw+V9KyHmTEfrROF9U8bcCOPZ9g8kn1MhkNX2r9Wpp9HwS5ZjYmQtZle0cnuUbHLWNVF85
	Ei3fM/PsmWLQxWK6gMYSWmVbesKBLEkUKqdDVuNY=
X-Gm-Gg: ASbGnct+Jaq6A+LvBVZs5HQBbWC85rezMxaNr5n9PwF8ye59OaAZpeLOm3bBnR4LSjM
	pUwsNnViwZB5F3DdM921ys8Yz5SB6mL+CWSSuNnmNho44ck+F2rs7DQbhcl5UmJ/Z/FvZDqpySJ
	Qyh3CFFDy0bS3zw/tAeQBgW0QJCbLlXK4+rElBI0BjLJgy3/QXZ0R2fw==
X-Google-Smtp-Source: AGHT+IGDcINNY5/zDjmSg7NBPpIlb3RZbGaQKQsUxwIDSz8dG9iWnCYxeWB+MvRhfFyH7DEl01opAlubpIQA4dQrq5o=
X-Received: by 2002:a17:907:2da9:b0:add:f62e:a300 with SMTP id
 a640c23a62f3a-ae0bebe8ff6mr498391566b.2.1750886946560; Wed, 25 Jun 2025
 14:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABA=pqdhsBeabrxHvfXx-uWzSq_-hs9OR16NSs1xuc6aB0s_kQ@mail.gmail.com>
In-Reply-To: <CABA=pqdhsBeabrxHvfXx-uWzSq_-hs9OR16NSs1xuc6aB0s_kQ@mail.gmail.com>
From: Ivan Kalvachev <ikalvachev@gmail.com>
Date: Thu, 26 Jun 2025 00:28:16 +0300
X-Gm-Features: Ac12FXynncTLpOzCKogN9Wcqi-ySWjGGPz0bnk9TlZOXZOjjfmpo3ijmr74P1Uo
Message-ID: <CABA=pqdUnLwPBUjSCiwTDUNaLJtz+hCxAP2--uG_d-U7pHQszQ@mail.gmail.com>
Subject: Re: Bluez-5.83 is crashing during suspend/resume.
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Apparently I've missed a mandatory step to reproduce the crash.
You have to stop pipewire before suspend.
So the step to reproduce the crash are:

 - Start bluetoothd;
 - Start pipewire;
 - Connect headphones;
 - Play something (!mandatory!);
 - Stop pipewire;
 - Suspend (pm_test="freeze" is enough);
 - When you resume bluetoothd has crashed.

Pipewire often causes hangs preventing suspend,
so I have to stop it upfront. The hangs don't seem to be
bluetooth related. I suspect amdgpu-audio.

I found that's mandatory step because I hit another very similar bug.
I also get a crash if the Bluetooth USB dongle is unplugged instead of
doing suspend.

Apparently stuff is properly freed on pipewire shutdown,
but is still referenced somewhere and double-freed on
occasions.

The bisect of the new crash landed me on
05f8bd489fd1fbf27dfdc4828bb15aeece3a50a3
and I don't think reverting that is viable workaround.

Best Regards
   Ivan Kalvachev
