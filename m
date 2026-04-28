Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7FF32ED2E
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374127; cv=none; b=P69fkTeEggq3SdkU+JkUR+YAI+Fh0EPnVSzdFJXdk8oB4CjFEKrdRXX7DAmuy4aG5E0bQnLfBKPg73Pbi13JHay4pqw79uw9AptZdZI8O455EVnTB28pMUvD3Rb946ZeAZKki1FEcDRkZCgDKJTivyQ9BCIebHWvRgv/2k/L84g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374127; c=relaxed/simple;
	bh=OLKe13rePFu1uCmkg845Qwi40BIlWs5wfe7wx3qYcvg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P3sqyvadsdtUIjUmT07i1HJjkPowEWlUxBMbqEA3m654obp+jVHhSU+44cVPhvuRoUcz7yqeErttfUYl3Ff5uqrLwbBQ2KTQdX4x7y4sTaPucGRAWIW7anTajlLQB2CYheG7qch1I50SJRQTzxcsHuKL1cfaFBTabpNgo1Di0mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdISaIX3; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdISaIX3"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7b37d84a6b3so116890767b3.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 04:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777374124; x=1777978924; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sp0bmxTUT6jLdQ+7V6Ar8IrndFV6Q38gG2KIKPLh8kQ=;
        b=mdISaIX3vG44sI0gnCU1/AGln0xnwuSpLlf+BO3XceXDiF8YytFgJvBwNWio0rpEmV
         uV3Me+fI6fjl9bEG60O0aRsZeTL2Q4NSHqc2yJ8QDzT/uncPW4YpINzkqtafa1qVjsKw
         Bw+U/OSCamp1WxQySi64xol8H8pmKoTgt5rB6F0uKAwV2ZBQwH3QwLvKdhLmq/G4Gryt
         D9AcY/k4OuIJWbW1DmKTkJy3fAKRwP9+cC4u0qq62BE1Bqet+uqtUCUDyOgm2XLBS4sd
         7EH5MFuM8S4s3mW2e6v4rL3zEKCbtlCZB2w7Bq73lovYf/fO9hFbAqCeIsNOjkw5nwx4
         UMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777374124; x=1777978924;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp0bmxTUT6jLdQ+7V6Ar8IrndFV6Q38gG2KIKPLh8kQ=;
        b=Q4NpVoOU1Q2UboNIsb7CnPP4FHU0qvUxTji2t32cJfxG88/HwvgQnnJhEfSE4HXdMU
         PDpwnxnZoAm6dmJbsVU5JwVIryL+9br7GQYLd746vZiBxQg8QZqR+5lB6kZADFQQMlNc
         LNgU9MxNgZwvWVGSFnMBQDOxZ7no4ACXm8/IHNBpwfbGkpiDCxNPp6MbloR2D4tWEQiH
         EfhQFRblxpGwjmrIF6dRxmWaKIvq9TnasM7UA+iaX0WvTLv0Un8jTyi9ITnXpSGZb54O
         4UuwNOVyPqECneLNtUeriGI0QrSqRQq2Zel99UDcgaUFWDJh0fNZ0lLiVDVODxuLN7Vd
         D8rQ==
X-Gm-Message-State: AOJu0Yzu+btZTb6laq+XcD3Axhoc8swvPw0CnE54O3V46PRavlYMqxnU
	JAK1BTgp+089KKKMfIddSHUqyfNkLS4xBwK8jjA9/QoM47j37NDqHSkoUfGWQA==
X-Gm-Gg: AeBDieuRY9gkBMh8E9hskCZCXVG/LDcAuSKF7Jp2uUbbGyGcXidcNwd5BaFguVfKhd3
	AIQjuxPGJyEpK6vW09O2yd5xTea74SvveaPPZFH7G6NJ0HMfHsNbSUsjri1KDC7XMXQwfZiysa9
	9lzhlu6T8BzDqf+L5HLkSgiCb7xmgGv5jD4nvO0XRMLDqBKioz0BTWj8OFcqpwLyDsyCjFY6eiX
	O9FXg82cLmzkQvXy+FNoxqQGWfCxJDiuUr6jQSpnXK2rcAfUJvo4Vq6oX/XELtU8MeCTvhJ/Ihg
	KhK410tx93k6SAReQ8LigfWwX/W1HmFUDPMv1E0hIHCGWTTVbaRzL+qCQeWqRQ6vJ33Qg+A844m
	sQgnLC1QBk3mC+APWRjNTfAiRmTNVrOmEpFUmVwc+9l7i8GnXtNpQeQK4l+sCJoLjC2JwBRvOfk
	bkuIfE6EGax7lIoNlf6C26ku/1w2qXEn7mF9ELTIMK
X-Received: by 2002:a05:690c:e3ee:b0:7b2:dad2:5dee with SMTP id 00721157ae682-7bcf4f8c18fmr23583967b3.2.1777374124406;
        Tue, 28 Apr 2026 04:02:04 -0700 (PDT)
Received: from [172.17.0.2] ([40.116.73.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e2996d9asm15972576d6.49.2026.04.28.04.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:02:03 -0700 (PDT)
Message-ID: <69f093ab.d40a0220.1e2b5a.ee9f@mx.google.com>
Date: Tue, 28 Apr 2026 04:02:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2685590292947931642=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Add ability to desynchronized transports for PTS tests
In-Reply-To: <20260428080314.180777-2-frederic.danis@collabora.com>
References: <20260428080314.180777-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2685590292947931642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1086648

---Test result---

Test Summary:
CheckPatch                    FAIL      1.47 seconds
GitLint                       PASS      0.88 seconds
BuildEll                      PASS      20.32 seconds
BluezMake                     PASS      655.21 seconds
MakeCheck                     PASS      19.02 seconds
MakeDistcheck                 PASS      245.44 seconds
CheckValgrind                 PASS      293.23 seconds
CheckSmatch                   PASS      349.70 seconds
bluezmakeextell               PASS      181.22 seconds
IncrementalBuild              PASS      659.72 seconds
ScanBuild                     PASS      1023.01 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,2/3] doc: Add documentation for CIS transport Desynchronized property
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#73: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#73: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14543205.patch total: 1 errors, 1 warnings, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14543205.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2080

---
Regards,
Linux Bluetooth


--===============2685590292947931642==--
