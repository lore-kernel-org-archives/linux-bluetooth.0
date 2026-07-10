Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7F33DB31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674927; cv=none; b=Sfws+US22ZBdOZmncOvF6ckErrTdqYaxLJfYVwzdxHiNtQHgZBHgKLMEkszJNp1dBPLhZ5u7tGUfx/9pf7L5WwH2sKhAtHB8Pe72gztQR8DW0cq7gsEMq/GXcNmD/66W0ZRb2A8NTA3+AEmJ9siQ7rv/SO0WxGRqOQX+1SBP92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674927; c=relaxed/simple;
	bh=HjXDWk3MKBpRnjJ0Hc7ui8/t4Sd/U7arMoF7/wKjNIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQVXElyD7hTBPU3ilQY1czJ2nGuvYMyUBxp3K9nXHsjRIqvbGpZTlR43MCFMN8V7bWkjCf2u1dd1kgrtsmFTkR0JRIFGcNgfSljbIFj1jZff3nUJO0EkKE6jM78SPPevirwDd7udfVwQTprEB1Hng6ikgeslLm4bnd5vBXcGN+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=b+srlDwE; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="b+srlDwE"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so707374a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 02:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1783674924; x=1784279724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HjXDWk3MKBpRnjJ0Hc7ui8/t4Sd/U7arMoF7/wKjNIw=;
        b=b+srlDwETNSMS9bi3YHpUsAUUohmyLqII3DNd4Bi+LfVeF1GsvLskpvVJwe+3Mngbs
         KanvOBQbnZT3n+kL1vVtl9mPSOXCQ2Zv2fNzWJ6eUu9R194gU8lhgh8ELPQqMvkvVPpF
         xdTtvWO2FVz+eNbf/N3Vdy8Q1+ISQhvOvCNwOwO0pD8k4u1gwSKtCxBRjhdRadiJG9o5
         ad7HdrRIEty7HgXFlPI2aZlr6idYSsc3a2133ttO/BJtUmvb5cZM3YzU0jN21fMoxaQo
         geaqo990FA8/ltmY7tazosUPrCgXUtYSMr7l7FnDkEvcjqBs1HyuvGCiMMxUapK0U4jq
         45MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674924; x=1784279724;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HjXDWk3MKBpRnjJ0Hc7ui8/t4Sd/U7arMoF7/wKjNIw=;
        b=WTTIcbb33jSPn1bnnPjqhg5DV2VLgNrLhhtdQm8q4kK+KuNedQuFNLYB8KphzeZ/Pt
         MwmS6atCPHYHTx8R/mp2iQ9zQkYWk/uv9wemyMBNoTv9LhtNGQeTkPP99ZdpIzewKKsL
         ncx8OAfmHGXR6aMyF+R3SadR3HLiQMbwCI0dw8zwDYOLd2SGoTWP9ZvUp4iW8tFOcqMf
         j1TIiAJvTbP9n/GCiSTc/3uJQephq/85aNSwLLHbBeNc7S9ojQfz7mnpYQhFua2fG50y
         ScjIejQr0d5k2nHWSHwYYu6RrRaaPvPuXxOdTthJCEY1arucFeuvMispxeJOJbgq1A3p
         ljjA==
X-Forwarded-Encrypted: i=1; AHgh+RpDJkeGDFh5S2C/pyKKd6kFxF3lfS8mjgI6Hj+fXor6fMebwRZmm/U24WPkpeI9XPRav7AoD4hZvWjtj36aDDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwodVplu2IM2SQq8mMJWuMFtwKhOWqzwxX3V0O3a8+dYQiyNL0Q
	GnJ7Q6mXxvWHEUjq6MVMPoQhLhpcxj5yyvK9Rs+zVHoeDP7udC3k3ekzHI3VkGvzFyk=
X-Gm-Gg: AfdE7cnRzVuBhMx2gigAoscR5wi6LCmQn+DDkGhdT1c6JZxUVQ8ARLjpUVfjy9LnObi
	ws/z4z2Hysi3RxbWwXx9z0Y2ADDAdw0M4leQ2OtG9q+efVJeu44ZZF61HTbwF7W6OACpEsGR/DO
	jiQdFAmd0t/ektioJy2rwzeFvxnRdH3AfNI1WH01oRqdTSH0V98sTDvjhFCcldlaeLCEIH3Rh93
	GYc7sj0rnZJzsikd/ZLnK10dqToUw58c5EX82xVvGZu1FA1CEDm4Ucn4HnmVgzW2hVpaondgmRz
	qMW5xraPKt0Ji6YhfVzZc2fM7xtKGQnD9PIgpblA4g78imml25HRE74t8a7p15xUoGq3Ecmr4Oe
	A66bdZDljIg0UbVND+G7isPrekxXl4ARiftmP6l/a/LUI70ybMDJwvaCDHf7FUEh7vtGYFuht++
	xyTXE/m5XfajjYG6097GfSfJkltewuW3VtAzd3ggXv55QuTcCKCZflvoCowz7rr8v3lD+pLNar3
	AMMcI6Zh/eMvU5ZBHgVEE7HUOqi
X-Received: by 2002:a05:6a20:72a3:b0:3bf:b9de:8570 with SMTP id adf61e73a8af0-3c0bcfe37d0mr13262984637.19.1783674924356;
        Fri, 10 Jul 2026 02:15:24 -0700 (PDT)
Received: from Metius ([103.158.43.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm68691402c88.14.2026.07.10.02.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:15:23 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:45:17 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btintel_pcie: fix memory leak in
 btintel_pcie_probe()
Message-ID: <ugmtkr7xseugii2hectc6lqiy5jkl4jtb6ry7zcydgkh5kyvgf@jaiaju4ctucv>
References: <20260710060334.136987-1-nihaal@cse.iitm.ac.in>
 <718783b3-89ea-41f8-8eb1-48bf0876281a@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <718783b3-89ea-41f8-8eb1-48bf0876281a@molgen.mpg.de>

Thanks for your comments. I'll update the commit message and also fix
the issue pointed by Sashiko, and send a v2 patch.

Regards,
Nihaal
