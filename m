Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4C3AA1BB
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882772; cv=none; b=jpUJOBpxAIQIOQWN3k46KMu19HTvYwgMd4CuZhdYe6sVvqPt9DXrvx7fZcU/GY/WXHpVIfU6gBTZZmIoAvRwJVXOl3FDysz8Ob9Un5Y0NVnWQr96zXfvoV2j5A4K6GiTcsvNBTEnpzOXphGfdtl4NLVzQ9ywjmV03pGpcVWCzbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882772; c=relaxed/simple;
	bh=hzhrEGDle+FdAeZLU3aRhv3Hdbj1X/G+ApWHZDDF9pk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=q6icxDfoSfFrOEt6OmXSTBuh0ZhrHbg9JgQ7eg62z+4ZR2EFWD/J7W2+pMtpxsnyoJpMNwm457MaXjDT/ZJjg834jofvp3/B+8HAZZBDsadMCYefEseCRlI5cJV3EwdyDfOu1jTu/bN8kvXQ5wLwrwhqimlhgLXLMrUI21/oEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqwcOI2p; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqwcOI2p"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so2277586b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 09:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762882770; x=1763487570; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/cJSbp5Q5Ij6wROQtRK0FjOEkxi0+Kx/EbvPaub56NE=;
        b=lqwcOI2pDVHYeef7SmAzWec/OlbpQ9hWFpTAJysmd5/T4rJxtBOtjZuXbMbxCpSJoT
         gjWN2mQwIgEBfYqPPMyoV86zGpBRJSRlLp9isI51gDdsLduPDwB0Hw6a2Pp7Az2eYKbV
         U/nDy4onD23XBMuGrJk2424xDRo8ztrbFv9X49XCB2pXhixM5TUzua+4LuYrocgWSh8P
         kYD2Vpd32TgtK92zsAi8Fjs7FJNolK1Ert5TBkb7F3AP9HLkGwju+u37xK8qRGGuhu5V
         lufeuiVPXtov9h+wfzopHd3xuimgKUSOpRliqF0WQjLJtvv9NftxuYyIB4YAAzsTyxcs
         kTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882770; x=1763487570;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cJSbp5Q5Ij6wROQtRK0FjOEkxi0+Kx/EbvPaub56NE=;
        b=d5taMLKTFKktmvaiYCBJIPqd45sIrrqojsBYs0INFSdF3/SbCQSSQCr8roqJCCrBzk
         sZy3l4OVbQKoukILM0eM3kCNC9f4O4TNFsWXTSLRAOPZfmplufgQJ5FyQw3l+vtC/zAi
         cTEoCV9D4VNhM0ruS5JCoEaD7v2I+l2/JzY81310UpdAXjibRnYtaTyg2DKUtGm3ivxM
         RgKjvXSSzQd8G78QoqPYIrVTmD3rFFnlBJMHpPChcELmlXgbmL6TyunA7uv823GjWun6
         dqg/0VEPSGAazO9SYRI1m0ohrsUYHS33uiBLDWuThdc7uUWTK4j5yXTBB00aQtcn6C5W
         ACwA==
X-Gm-Message-State: AOJu0YzITaH0J1Xh12t1Wc11jXYXXrB2y6q2BEfJo3CwlZ8GjWgGX94d
	0OHIg2TNhmqFd8lJz4H91+oO2vIaGzAv/jWYK44utzgQMetQspEnU9Uv4H+KazSn
X-Gm-Gg: ASbGncvTYfc/klMqZf8WoQj9vaJFah6for1Lq6H/AD7QJXtUDIv6VZQhcpygCNI2A6N
	7ElZDRpkSFptsknlmY230gqOPdhSRtPOowGO6F1j9bINEZ7XCVRlgst5lk/30ZhN4hLTGiEL9Jp
	JQX70ROVgWu9Ih3TuK1fhYnxzbo0rP4Kh1GvME0Jf1/2DS3iQo8VMYeFtaC2eC0B/gBItYzfkzj
	aziT5JM5Y5YSfyWwWwxKYPZG0nJZ2YnFcMaUjt+NBaSOedyQRJTLwmoPARPB7+FHwEQUt95SHEG
	+SUPNX/pstHfsolULtOFjwe7SqrIW+3Ujrbb4vzKYhJfkm4fte+ttGpp0lV4hJghgqbI4LLyKIR
	Ob0vRNTFhGfJgMwyYkKJ9bUnrxV2psP6RUstyKDgc+rWwKnEjGQEuBTorFhavGBM3Faq3kPGZ0U
	99+mM6Hw==
X-Google-Smtp-Source: AGHT+IE/TTGC85MYxlajZOssdXYKrqj1Hqhb0EPEVAuVLKGMy6RogSv1WMnqZDkSzb/ATjPNquKZiQ==
X-Received: by 2002:a05:6a20:7fa8:b0:33f:df99:11d8 with SMTP id adf61e73a8af0-353a11b16efmr16873182637.11.1762882769700;
        Tue, 11 Nov 2025 09:39:29 -0800 (PST)
Received: from [172.17.0.2] ([68.220.56.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf0fc9a162sm213308a12.14.2025.11.11.09.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:39:29 -0800 (PST)
Message-ID: <691374d1.630a0220.1ad757.0e6f@mx.google.com>
Date: Tue, 11 Nov 2025 09:39:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1706608951733981345=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, parona@protonmail.com
Subject: RE: build: Fix distcheck while installing org.bluez.obex.service with --disable-system
In-Reply-To: <20251111155644.11675-2-parona@protonmail.com>
References: <20251111155644.11675-2-parona@protonmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1706608951733981345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1022135

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      20.22 seconds
BluezMake                     PASS      2950.57 seconds
MakeCheck                     PASS      20.34 seconds
MakeDistcheck                 PASS      188.98 seconds
CheckValgrind                 PASS      241.26 seconds
CheckSmatch                   PASS      316.65 seconds
bluezmakeextell               PASS      130.91 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      949.34 seconds

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


--===============1706608951733981345==--
