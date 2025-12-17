Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F8526B2D2
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995850; cv=none; b=h+ym9cXvecKXsHlFCMN81eH5PcRD4O0fu9r9joMp9KeCvjeWYYcTR8adIxAK2xcHqe09b4qwhbdMvMdfiJ90DjTHhuvYyB3rEFdKAUzzm2ro8Aax8uUANMbNzZQwkgt89Vgrkkq+mzFFjJleeQ5Ayz7DhBre18F0lqJN8ks/+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995850; c=relaxed/simple;
	bh=NtyzpRsxPz9miZfMPb8WAKj+s4wpSM6Hu0FzopzpqUQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZLO85gnS02PfZ422QD+RPEVbVLjJVEaJDWI9fPhZp+YtiGXgINJZdPikfz7/tfkaR8dFYs7M3PjYzL+EtTzeyoT5bBxRwEXngQNwLS2PximshJVAPOypXqIWoGvBKGVTm4tZt8OkQU6wo5mv+r4H5VLj8pUi9hBmy3XIXBYeFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1AzuqRg; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1AzuqRg"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8b2ed01b95dso625435285a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 10:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765995847; x=1766600647; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iPS6tqMUV8wVj5tpWegvOW7CgnfuaYxDX+gaA61svQI=;
        b=R1AzuqRgzWmXFtqrsf1JngOA54FWzEyMelAxxvKo0LkSePB+Ze8TvNTahfc/T5RcYt
         OG+DoMGgFa9O+aacE0QCfHMhZdxYsYa6ilw+kTE4wCzdZpF03WdYI+BTAOdWhr04NDJ7
         Gr0LzQng1B80ZX+3oRrvq6knK/aHRVA7s3aETyB+TjWn+cp26u8sLLY9cptMGa/cP3n1
         D0dzZWab9gy0tl9u39oSBfeU7eVCpBpFpALMpqqRU1G0PNaxbNyyDaN2J6AoK44T3tbU
         thbiP1YuKIsA05Z1FrJenJu5KkSxtDmjtt2gjaSDPfccNmIBfNyjpaiYbeAURSNC+pZ2
         wEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765995847; x=1766600647;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPS6tqMUV8wVj5tpWegvOW7CgnfuaYxDX+gaA61svQI=;
        b=LttHsUNMl0UrOPmkzaslDn0j1B74afLXoCssKV6sbDdm7LwQvkHNHH6f8dN7AYaLZA
         ErRgrqjvPeLZnscKXAYxnhYIeFpatcMmpQ4qJKgnJ4PPv7QeM/f3DUTECLRK8Pg7jpIY
         ZxGADwwbMAbD9s07rmprKiK3v745wWGrHys2QVNw8kKVUQTQ82nqU0+Sa32y4Cn42kGl
         jyB5VU7cN7R/2gTDfMJSjV7DhGUVHX5k6ouP6ji6DwTYZUczW4tHryz1fOydZrOMt6dh
         1m5c2SkrbtB6vfbeaUmoczh6axwtLFgspxGlmKDmJqd1y/lmk+z/dvXhGxjY8Bw9JjBj
         B51g==
X-Gm-Message-State: AOJu0YyVQ+8zgjAYnEWhsGH7g91d9JK8g4tPZI/C6BPOjGxKr64ZA4GT
	XtYBNGRHuMv5mEdQI0cx1M8ozUsKM9SsLjdgtniPD9uq21QcSSJExZdqcRIITw2I
X-Gm-Gg: AY/fxX6quuqziL/jYjzSTpTJMdl0hlFDraqzmvGdYzLZImzwtkPb+fu/eM3+Z5HejMf
	jcFLRIugDRHnVXQ2gq6NSXaTt75xhuVWrdfyrdrsA9J1/yEfyVlFgBwppmoEMzy5lLdmVufh/JY
	qpqAl9yRZyG+gbiLaQWBMfOoItjo1URs4fafiAAnhnoNDy6tazddJyA5TRp31XH5lZJPQWNwtuQ
	Usr7moh+DwbR654DGBiF5+VWXHzr5EFYbP3K+Vh3cNT9siW1KBJTHU8KMqPiJtXmFA8zOL09kaj
	aRpeMG3bxJAXHzCEFgHBPHTcdwofnINfSaSkX9F1MsW4UFqq/N3X3lCoK2+iwynxTXe9MxFQJFq
	HpVYuPFhtXBvoKH132zc24MszduLbOCXnOnfBBqzNe9HCH5V0q22L9B2WX0hChNh/urnPKRt4fD
	c0Bbu8oVwC6nlOYMzk8EM=
X-Google-Smtp-Source: AGHT+IECRIqK5z09PMjAOJoKF8H1GhyjZgqgx/U+fm6dJieXe43bDtNzy7h4fVgcs7FcbNcOxAuxdg==
X-Received: by 2002:a05:620a:6919:b0:8b2:d6eb:8203 with SMTP id af79cd13be357-8bb3a387a31mr2536743785a.69.1765995847319;
        Wed, 17 Dec 2025 10:24:07 -0800 (PST)
Received: from [172.17.0.2] ([172.178.119.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31b53dbasm459271485a.34.2025.12.17.10.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 10:24:06 -0800 (PST)
Message-ID: <6942f546.050a0220.1acf9f.6402@mx.google.com>
Date: Wed, 17 Dec 2025 10:24:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9205455391026610708=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/3] audio/hfp-hf: Add Operator name support
In-Reply-To: <20251217164820.277845-1-frederic.danis@collabora.com>
References: <20251217164820.277845-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9205455391026610708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1034282

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.52 seconds
BuildEll                      PASS      20.07 seconds
BluezMake                     PASS      636.11 seconds
MakeCheck                     PASS      21.62 seconds
MakeDistcheck                 PASS      242.05 seconds
CheckValgrind                 PASS      300.83 seconds
CheckSmatch                   PASS      347.94 seconds
bluezmakeextell               PASS      181.95 seconds
IncrementalBuild              PENDING   0.39 seconds
ScanBuild                     PASS      1019.08 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9205455391026610708==--
