Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496B3E5EC4
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788544298; cv=none; b=XfxfI2/vFg3MHtwCeK+goVgNm8MhHDIysEGhfvRrl2KJvF+SbkNU3+dIrKo29e5ZiMS/IUY2b3B6iSNrYmoewxOzUV1U6k4nXcyH6ggN8KoY6VrKTnsRsCYlYTeIAZAigiD56E1LiR7w+H+kJVPeOAhNMKCC9Ch5K4AYFHpKY0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788544298; c=relaxed/simple;
	bh=MAoDIdN/zWbzPe1//ZZQ+J5zYyZG1kXGx8C5g508PCo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rT5yiQefFWfbZCCtm/WySBNzJ+pK6FOSkwhUa/TvTpM1PFDCfv5/u8tfX0tFe3MzeyRYvlIfoVYdcSnUGDHp7lXDfUzbBJrSfiYdR7t82jWBH3Liwh8rs1nbPPsQTBRhdRCaJfl9lGYy+/yNwquBGn08Rzr/l6aMvvY7g4VhjTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=prjRRH4a; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prjRRH4a"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7f432ac553fso1125371a34.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788544296; x=1789149096; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HGJ7V0SKUc+RR4TfUmZ3GG1XqXBkFfy4OM9wHQoh3+w=;
        b=prjRRH4aTYe0vXz8YkEcDLQTKMKhp8PWH3zloR1aEPT17dtCo83ppFyfcmkU/zqeYw
         1qNCUWPHRPN2B3S0vioB/36SeG66UpBaBFvNK5afjniUCPyhIegZMzSIxxIRm6LBmJEp
         WddnDeQrq27i26Dd5YZulLMpOpgZGNVcb6n9Eicn4P3h2v4S5Byh/3Ce7eur0YqCQxMB
         UFeK2kdeenvcDLChD3HZN+wScsGm0KrSVP78SBNoNt384fpsBlep/27IFdHX0fel85mb
         YFP+oJAhjSoff7t+d3NUnZ7YlMhsh00c7WaB+xavxipAdJepLEsn+nLE3EwbYc2+RVvv
         T6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788544296; x=1789149096;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HGJ7V0SKUc+RR4TfUmZ3GG1XqXBkFfy4OM9wHQoh3+w=;
        b=oNjS38eO37dDVmck2dHpqBtnwHwnzhsHlXiEdg80LdhZZt83MnmP3Lq2iZne1ByhaB
         P6c/z3K94juLjmRKPFV34rzwETCYHqCF2SsqAz44scGDynxLlJtfRjDs3JMAcRHQzM/w
         0b/Ra+pH/j/tXonnEXPu76zoa2qbgK3aoCjzzNud3roEYZjzbmREHBzt47AuzuMmelhH
         CsqZVSipj6uLW/6WpUd4Z3qjq5HRQky54StNEJh8DAmP81T7vg274QSswTIASjKTKBP5
         EUC5XbHaJzLLLB5RBDjdwtsu8LhPKTgouScLae2B2yFcmaKrTvuScv7I7LmfFW5C+wdt
         Ji2A==
X-Gm-Message-State: AFuF++kXW9+z+LyPdCfHXumWqAK3yk985a0MtZjKbvDAyRn3nXegV9+T
	PWB+FAG1IpVEZELNNkKzWG0Ns+APLx0a4no4PnF8bsJEGeieEJWqIr5moaT9zQ==
X-Gm-Gg: AYBFou227n2MjquFekNxnG8f5GI8w4rl8Ktumn3BCjz0Y07HNR0gg501MCmsb7dsSnC
	WAPEZOGhCf5c7zLQeTFOStlkTNhZZCcSGJxGpxOmmq/jDFfUL739QGG64Sl/4tPmDM8x3GOSUO/
	04A6mf8aeJSKbF3uTp1beq8hon/ne9K4LXQ8HAzaPctObnnlmPbYW0dNYEePJQmx4mfwO8KNTzF
	hBrIBW+5lmePMXqixin+HvnsNzVEMlS/dHut6jcp90K/7jQeJDPknlCFOgPSytWEoNphfK3ZpcT
	vtl9A/xAB0DFQrsmBIzYblVIL79dVMHeV3wwsMh0bqZSqqZB2zDDoEkKCpYD+881C/atgahgM71
	AJY3NTWngCC2Qvwx1ZgzaV0t9q+TeglEm+GcfAyev9UFCY4AkxugAr6gzQYWbyZBSO2GYGPfC7e
	0NjqVfudgXAYPN0Nvh4rmrGC7g2iMNLl39a9D9E4I6Qu6kft30pK6lrB5zEOTmWEcMdq5I
X-Received: by 2002:a05:6820:2204:b0:6b1:b33a:db69 with SMTP id 006d021491bc7-6b6fbbcbd7amr7019404eaf.15.1788544296012;
        Fri, 04 Sep 2026 10:51:36 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.202.10])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dcb85657sm3481280eaf.7.2026.09.04.10.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 10:51:35 -0700 (PDT)
Message-ID: <6a9b0527.77a0a7d7.27355b.2433@mx.google.com>
Date: Fri, 04 Sep 2026 10:51:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8568235933404733897=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raghavendra.rao@collabora.com
Subject: RE: Add MCS fast seek and track position write support
In-Reply-To: <20260904165332.42046-2-raghavendra.rao@collabora.com>
References: <20260904165332.42046-2-raghavendra.rao@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8568235933404733897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1158246

---Test result---

Test Summary:
CheckPatch                    PASS      1.58 seconds
GitLint                       PASS      1.05 seconds
BuildEll                      PASS      16.66 seconds
BluezMake                     PASS      500.28 seconds
MakeCheck                     PASS      17.84 seconds
MakeDistcheck                 PASS      136.29 seconds
CheckValgrind                 PASS      193.43 seconds
CheckSmatch                   PASS      230.36 seconds
bluezmakeextell               PASS      86.95 seconds
IncrementalBuild              PASS      613.86 seconds
ScanBuild                     PASS      759.13 seconds



https://github.com/bluez/bluez/pull/2492

---
Regards,
Linux Bluetooth


--===============8568235933404733897==--
