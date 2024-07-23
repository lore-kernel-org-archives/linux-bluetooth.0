Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7213B5B9
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721729354; cv=none; b=IdioKq0hXCnLOag4bH1xeRc6nDsyDGDWYMgXFaO7RhhT/TyzUJr4oFbLtl5SPWVXLnH1aEvJrhirU8No8U656MQ63Nxp5Vk8lrheIKvFPfmPAq0DoHLXRQRSua5vzPlZSqcogWjCL3GpGmkIdpWaSkfEuGYJuq85WgdsRx7iDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721729354; c=relaxed/simple;
	bh=SDZ4lYx6syPCN9g42AHy1mZ1L8hz3JdQKGG4hMenY5c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=r2ekWT9N8wAFVJ7kuaxqmI7z2bJoT45EQ+QiFCAVgFkgE/KxC8JRhnWuNBmBU/va1PnCARd4dh9YRLYSVj+X8w4fekaDGh0rxKBqrmDek4Uh0abXlmZB9yaQNsBdWVvXl2etA4v4DH5IzKzmoWiydNng32Mdc09nn6ORZN0LB9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIza4S4z; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIza4S4z"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-664ccd158b0so52753757b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 03:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721729351; x=1722334151; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x3sWm5xPoPPPxE7gRPUDMUJ3NscDJ2yTZPd8XPnbvBo=;
        b=eIza4S4zdI7i9qq9INSD34tB+ZTSGvLAIhC87J6f32WGoIFgbKw37gnFN5KqOlVF/7
         7iv9vYX9/gpdmIp3w+iQjB3Hr2/ou161ad5udCSp2FpvidL0TCwjT3mXmEYWxGMovz7O
         50dEAGDOQv0GA4CEDjRBHCrUjH9zxIpr3wApD6De08IwYFPzoTbEJ8LzfDNUsEKmOXLM
         1ah0BPOl5L5cdduGwA9ECqbUea7zUaGr3jCsf1BQMEsCi1JVoFvwrhLVT7sQjXCK7Qob
         Cp3WudfDIhzPT2OZzk7hKe9vVE8b1ESCeTnBPVtbbwwJlsVdAI2njhBRuTrTrTYduSI8
         qfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721729351; x=1722334151;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3sWm5xPoPPPxE7gRPUDMUJ3NscDJ2yTZPd8XPnbvBo=;
        b=GC7aWdPrmdNXDs1ZiiVZ3+ygQMBV4XHzps+DA++AQTioKDsOOI1Yl6A/H57cLPhn8S
         UlByJPNonQuVnHOuwoSNiwe9oJ2wCp3RKFbIDQ0PCmVeBbsR1FoBugpJA75tswRy4rpi
         Hdm9hhHSGdjrS0YJMU3/PSZv73CJitAm4Sch5coMJsyywR3fSA5sAliqVte+D34AnBI5
         ejJTkqMb3geFX8fb7MJdhL0DaMcehX/0j+pY4MOMsT3Kl0HDfMWhHV5BKwpSiN1dtOa2
         RXwGUA0U8w0tuwd5wkpiAO8ie97xaMh7vlfZQPC7pJuULbtqoRKDSWrtp4qMwYce98B0
         JMfA==
X-Gm-Message-State: AOJu0Yx43MRE28t2utOrWYjJXDjt/lmRcZX+GSIGtKIxECHAhc6aevQG
	VtHoz9D7+sfDf1o2n1JOUq/z6iuBp19Z4n45PpJPoVBFaUhH77xwt8ecug==
X-Google-Smtp-Source: AGHT+IHS9lFHpNIRCXRfnrYaqbnQ4G8nVJQCvdy11ajsjfZjHVdPYZksOiQY8iyCFG5ezLB6HThf3A==
X-Received: by 2002:a81:b048:0:b0:62a:2a7d:b512 with SMTP id 00721157ae682-66e4bdbd3c5mr28212677b3.10.1721729351529;
        Tue, 23 Jul 2024 03:09:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.51.71])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-669540bf1d3sm19576297b3.131.2024.07.23.03.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 03:09:11 -0700 (PDT)
Message-ID: <669f8147.050a0220.a1f4b.8496@mx.google.com>
Date: Tue, 23 Jul 2024 03:09:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8446033070275257311=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yanceychiew@gmail.com
Subject: RE: Fix com.bluez.battery1 randomly missing percentage value
In-Reply-To: <20240723082843.184915-2-YanceyChiew@gmail.com>
References: <20240723082843.184915-2-YanceyChiew@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8446033070275257311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=873169

---Test result---

Test Summary:
CheckPatch                    FAIL      0.61 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      25.05 seconds
BluezMake                     PASS      1740.67 seconds
MakeCheck                     PASS      13.20 seconds
MakeDistcheck                 PASS      183.61 seconds
CheckValgrind                 PASS      257.26 seconds
CheckSmatch                   PASS      359.91 seconds
bluezmakeextell               PASS      123.45 seconds
IncrementalBuild              PASS      1527.84 seconds
ScanBuild                     PASS      1070.18 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/1] profiles/battery: Fix batt random lose percentage
ERROR:TRAILING_WHITESPACE: trailing whitespace
#118: FILE: profiles/battery/battery.c:97:
+^I$

ERROR:TRAILING_WHITESPACE: trailing whitespace
#123: FILE: profiles/battery/battery.c:102:
+^I$

/github/workspace/src/src/13739703.patch total: 2 errors, 0 warnings, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13739703.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============8446033070275257311==--
