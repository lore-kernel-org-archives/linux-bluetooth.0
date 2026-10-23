Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740681;
	b=eECiEnjlYJ0l2HPJNH7tdvQH84vM9ewS+1Jwv1DO+LqwBC0MQsMxFMMPnC+dC+1zoAAW
	 V5rW9DY0KGXdTF/iL2OIOySeq9W2uoiOvPJyUzMSa11AH71XLlutmH7qHixwiWXkRkA/Q
	 0PgNTmWyqjINfurJqpTUyhnbw2k2BlD5O7i11A0UZOaMHTRifO3GdNY4RqxuZ83dTur2X
	 emX3vYmyTIVk9Q5BUw1nro6j+YwjDBGwN1hsJaw/8ysEdd/PEY/SyacrHUiYpS8ij3AdS
	 lXf5NnHw4kgtGA6reg9c1mvhBMG9zgNUUnu6mDAoCEk2J2UNdeb4GM8AbJUPdlvo03A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=0wn07o3pMjLSFoQJmsfWLfRxUfCOA1vYP4v2JKDLecY=;
	b=pVamb+QZqKORgfVuxy08ctIT6I9LjfLEtRrQfPkoGZn9xxBUSborO0HzuImX1Silbl1i
	 jE0FNW1Snmn6EsyP4hPt6g6T0P3eulVl2ODgrI5eYyWvEzWqWLHoeHD6/9OQHK6maalmR
	 sKR/QljMic0uIE3Ds8U5zTZcRP2a6zikFwEcv691poqA5h7gPYp3DcdafYvQ7gy7jiA0r
	 uDx+gGtB9PVqiM4oPdFQ03P8R5ABDaqfs1rAQE2Jta64J9Gp/6fUjIQJGIJzEII9uzma3
	 n/Db0KVuSOKWyM56jVQDB6NlYtqZyXyRTHIlryeAA1yX9gJFyxTxmmcZgH6TgR4WOOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hHulZZRe;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FA3606A31B
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 07:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3FA3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hHulZZRe
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so974692eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 00:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740680; x=1793345480; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0wn07o3pMjLSFoQJmsfWLfRxUfCOA1vYP4v2JKDLecY=;
        b=hHulZZReequ6I8EV7dLLxZSUniPi2BJkoY7zHc7gmWx6sJ4LLgM07+P6/zYfujIaNZ
         PXCvhR/KuDuYsNZkGksAGim9PW/GeNsYPHSKfoEt3FE2seohAd6cbV0nIJc0qt9fxEPB
         TPmw1NNF4sw+tFv8Eka+XKqECVXZG2p+hlxKkyxIWiRzLXpPiRQeZlJdkLdQRQT/IKtI
         CHLScZ7byvcSapFiv6grCXJi/Q4Tqw2inuA8UWF0M8NrXb6JOU2nk0XerMdLkkfaKQXw
         KCfoxIJRuL7DITJxORG393dcf+lpg4szMZGDRlAbKCQYzwVa3PCWKCmqgwL/KRXY5Q3/
         zpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740680; x=1793345480;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0wn07o3pMjLSFoQJmsfWLfRxUfCOA1vYP4v2JKDLecY=;
        b=MXlrLn2/rGnlxOkTmwutYMxfu4F/yIIZbqoxbqjMkODMh8L/qpRAPt156gFUqL82OQ
         rQBJVFvIcH1HL5sXzbY1WlHNVppbZDDALOa1rQia93cSnJDIuLJIiZuEuTrBmJobgBUo
         4BzKLCVQAE53Sg94f1k5IDvJGWFUUsDgX6y+EboLMwtoDOzf6VyPTs+CEFYdtrSVwy0m
         8hor+xdVQLIAphXGnAUHDuA7fcQNvfiYYuFdd9IVaBnYTVSj0VRmStRTWrmmjkVBZd7A
         ays8yrrmhx/2VE6aQTX0wboTIpKSsc8IFgQHdgOZnkOHKGqRo/U6he6hSrvi/kdWUTQj
         9FEQ==
X-Gm-Message-State: AFq9FYJ1ALnLFZWwh6i878kHBxDSlMebqH0dSOtq/ywa3Xj30wxVrxGT
	Z0vHtrgV4Gw6s6xXiu6zXmx6bNl4SLrRmU9/3Fy2kmh9mbDqIsj++56xU/spYg==
X-Gm-Gg: AYBFou3x+RKcRTXDgpwRlWPffnG30LaFXZrMWJcs28ULJBMo57AnRnKkfIKEfsIyZny
	SRnsFuaoaU1lqcISL43JBJCvTNVBR3ADU6NjN7vkgZnB8lA8CMPhbKRoCwNOA1Ku+Z+UG+VKaWc
	nrjA0w2sOLTzbR2y4obDHIUejwPeF4BUhCFLGaNmMQfGT6MFrG5UXuQ6pzUgxOcWW3UOnQYVf4f
	qC0TONIoe/jplA0JMpkOpSpOomFr6UxSBKQWUzEBpWUdsqeUcKtVfS+Md4cRPXqDPmgQhmsH0CI
	fLemM6o1G7LwQvI4c7HSuLuUfZYsO9DhSlKZadOHh8tV6DwgJS/Q23BOjfjuYQpGkEVD4dTZGpO
	p8xQ9rpMel9n+25h0qspOgxyMJtzUPfBuiWWFUVJ9BI4yHooD0cezLLH3BVw3AHtc5DjN2Nu8Wi
	6HnYRpTfmP9m4d6mzPsWwm0TRaXvYhFmSyNiYgk1zd4kTXAPaHke7j9HhxBHV5c4x3ate1nHotM
	VFRTnv7qTLivi2gcUiag7K+I5LMJDBdamn/XPF1luyDPDoLoItx6vx7GJNbly29iF6JGfDrz0Lg
	FIZsRQ==
X-Received: by 2002:a05:693c:20c4:10b0:34d:7ae5:8d78 with SMTP id 5a478bee46e88-369d98b0588mr1982613eec.31.1792740679685;
        Fri, 23 Oct 2026 00:31:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.74.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9d5e9e2sm4100286eec.4.2026.10.23.00.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:31:19 -0700 (PDT)
Message-ID: <6adb0d47.72ff3aa3.174c80.bd1a@mx.google.com>
Date: Fri, 23 Oct 2026 00:31:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5253988385315512568=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, catherine.l@intel.com
Subject: RE: [v1] Bluetooth: btintel: fix buffer over-read in fw payload
In-Reply-To: <20261023060026.524147-1-catherine.l@intel.com>
References: <20261023060026.524147-1-catherine.l@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5253988385315512568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1191810/

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      28.40 seconds
CheckAllWarning               PASS      32.96 seconds
CheckSparse                   PASS      35.62 seconds
BuildKernel32                 PASS      31.70 seconds
CheckKernelLLVM               PASS      36.49 seconds
TestRunnerSetup               PASS      661.43 seconds
IncrementalBuild              PASS      27.86 seconds



https://github.com/bluez/bluetooth-next/pull/985

---
Regards,
Linux Bluetooth


--===============5253988385315512568==--
