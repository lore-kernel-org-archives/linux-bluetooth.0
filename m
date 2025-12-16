Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD5C30E0C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765928610; cv=none; b=FN2mlFRYyS0c0QDu3CDJUUR9WYPz7iB8M7DieTdZ3M2xCF52r1nTs/Q7NkZo2Q2zls5glug+mm9l7osnRWkJb7MaFxprjwh6kr2K2zGL/ytMkr0IhFPWWlS4rvA0B2nKORNAH/5W0/twn37V+qz1Q6j9sOn35qDKZWFk9nr+0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765928610; c=relaxed/simple;
	bh=wbUJekkGa4LIgKwMd6IFAqfyHD8bLgo7e8SX+l7l+5E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a/lg1RbAddZyEtigaP8G9TtVpcoiQ++lsqBppY5Jh9jsBrPZzb42TVPvy+bxDaCwrKPvUg1mEw7W5reMUZf8gS+VW9WXMCsWU2wIyI1w36RigJ0D8YHfX47hegVrLJiOQHFr6CJOKedbvj2ke6A41QmbW0egLgD69Unrw8OX1R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2rCEZku; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2rCEZku"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso5573295b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 15:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765928608; x=1766533408; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7r6n44pS7AVIa3D7FmNg3SfT3F6COhfptoSo88fqYV4=;
        b=W2rCEZku7dPYwLlmqNTzVFOo7NWNS9CMjjQXfKO8vZL0yy6rgw0ydbTPoj/z0AmhiH
         AkSqqq/IKFV0HYEvtCx21mHBIkdbyg8hIEoXP9Q55HvqOivaE8znV2LJ8pmMm69tte06
         hQiHm2QdRAXYj5YcLXQkWoFlt4/NgAvQE2irvO/FhGIFphUH4Yj3ozArPPQmI88qC6kt
         ub1TfGxkq+O8nmPICkmX5MEV8PQhcLUnEaqMtHIDkNTVxE1Udsxlz9F7t0e6jFWYxpNA
         CTu/cE/r5GJz6hbOoQ1MrZNhaPrVrY64q/IsTyDW7kxgxcr0iV2D3yR4VoFX9URc0tbq
         ySdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765928608; x=1766533408;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7r6n44pS7AVIa3D7FmNg3SfT3F6COhfptoSo88fqYV4=;
        b=jE8a8S5XF1UdO7x6S578sngxI/tgAwo9uJaTs9VL6Dn4672CAoItYhG+ftyHErthiJ
         kgvIKbg/gBy2jPiKb4MenBhq9R//Xd5QgHlmrcf0T3GmBxH/UjMK/AGC7yK/UVkS1jZs
         9vBkqVGz3nwjhgHwG8Cyst8H1P3/Ek8jbYYF/g6J3auHvT2PY+0PBOuCAf1ZD0weKbgP
         txhxLOMATQY+6225Yu6uWnl7kkFeTXtA6pThc94ZCXLvR33vxI3DWP/pRWlguOy0XcXv
         fjn4iJUpmNl2IGajg2vcnaNYlHGQPbH2MiucaJll5maa815+fOF+61iF9xgkT7ZP2Sv4
         xVqQ==
X-Gm-Message-State: AOJu0YyyHqgFT6mT0YK5uvSHuPALtPXp+fLOOa1c6M9Oby2a0UxBKAal
	KaqtidrVIthgwWf4ZxH+2VrjEmzPM4cYTL+k8nQ5rH/kmRDPaGJVSp0z9YCpGf88Cek=
X-Gm-Gg: AY/fxX7l62b5+vDsSNtnU683RPlArRuQu8r+pqqwG0iVGlUYSmKYyb37V/05/ebG1Wg
	rJ2QeZbftU0+ouRbJq5WOEGfA2XC0GqpXcIc8FhdektE1hgRv1r1U+wxrr78Ir5CyJo2ELDbBUs
	Prd3xSLTFuO7UgVgquMHGhCDbzYH2+/ue4sOgHMfLgFm9QMXC7Qa+IOceiFJ9v3S0Xhi9WqhMva
	zWAqkeoSAzmgcGH9Mv17Mi07tEEZBLJq1Ip08nRalB0VSCBclM50TRv2Gbq3FRVseBKYUVR7igP
	vS91rkXL20ZsUEO3wzO9+kXpWEkcym7h1mQK9uJWyEejG5KEtu9V/F41mFkNDldiSzLl31Y8awU
	G/qv4NmrADe53p4HivatLh36ZsFhJDQLnLMalFepa8NFTN8KDSVWI5BOFjh+/jfPqlKjwfc5PZb
	eT39mhlOMnt1TlAOFQOw==
X-Google-Smtp-Source: AGHT+IH7aeIE6IWFOxbxuLwovfC7YQLrchB2myNsULJKr/cCB3YDYvrPIk6r2whzy2l+zntedxV2ow==
X-Received: by 2002:a05:7022:a89:b0:119:e56b:957d with SMTP id a92af1059eb24-11f34bd9053mr12452398c88.2.1765928608046;
        Tue, 16 Dec 2025 15:43:28 -0800 (PST)
Received: from [172.17.0.2] ([172.215.218.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2ff624sm59340341c88.12.2025.12.16.15.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 15:43:27 -0800 (PST)
Message-ID: <6941ee9f.050a0220.2dace2.baec@mx.google.com>
Date: Tue, 16 Dec 2025 15:43:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1396687717568327540=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: mcp: expose org.bluez.MediaPlayer information via GMCS
In-Reply-To: <d4ac03bfc787c773e6b28b99067e5bb363605b27.1765925485.git.pav@iki.fi>
References: <d4ac03bfc787c773e6b28b99067e5bb363605b27.1765925485.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1396687717568327540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1033942

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      17.79 seconds
BluezMake                     PASS      654.69 seconds
MakeCheck                     PASS      21.73 seconds
MakeDistcheck                 PASS      223.10 seconds
CheckValgrind                 PASS      290.97 seconds
CheckSmatch                   PASS      316.32 seconds
bluezmakeextell               PASS      168.35 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      942.75 seconds

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


--===============1396687717568327540==--
