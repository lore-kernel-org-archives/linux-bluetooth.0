Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB8156880
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498383; cv=none; b=RlBiUKdGHKqu+VWmKhDevwe1Tu7MATfa+YQsF03rmgljnAcVFXGBA01y6jXPlgJf95goA3ww5JA8eJ9BoEtE6HeF6jQWzTWvMvc9x+GBby5FHaMreINsgslQNkuppfu7iLXo3E/sDSLWoOjBOto5JefQR8TXSfJE8BO28p4maGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498383; c=relaxed/simple;
	bh=/hAMlWEyNFbtvb8r7KHWT3f67ST0Uv8vss+t79LGAbE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Lonqi3jao2vXfhQgjHsWnxsWW0YYYSbVjZQM6LG48WgO0s59nbBumweowD3t/HVWOla3MIaO4ICsW9zdCcH9IIefLH+vzUp2cXb8BHBLclhKTeEb8fuEZYplTf0gqFM1XHbgYq3cfwD6MrPi3jeVPNyVYp8VekRv5uL+HbFvxVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVPXJP7q; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVPXJP7q"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a9b3cd75e5so476386085a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726498381; x=1727103181; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C4x0ogAV7sg2GQzOTntaEk24bTCVjuT0uOH9rjwbZHM=;
        b=GVPXJP7q/tIyl7eko7d2+N5+BeDqueKjMkvhDZQvcEgpf3eqdOvyjtA9DxQ4vguhC0
         YGz0b2bTckVgWGIWAAObdtysUKcSzMujg/HVpeT4LKAh8oqyDBFWU0g5va89KolFpn4+
         4sBOHtkR2GP1p+V3xsMjFvJT8gy0vMSAWShJeiV79zVPjdBQLKyY5RC/kSQE+GRr4S6b
         mPHANQpNHXmg4XKbyRa34hAIo9ZBPlkXaG+our6HI7m126MqC0JaC4nXs62lRpC2tNSd
         2Q+j1b8N9w7govqkVV3A2MgOT0IH7Ob1DXJ6TBZmAXz13TVafBD7Pg4lyU2/2tXHbkfV
         Ml2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726498381; x=1727103181;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4x0ogAV7sg2GQzOTntaEk24bTCVjuT0uOH9rjwbZHM=;
        b=eDxhxNMpsjntz4DWKi+dqIsNlWMsAGHvssavgdN/tn0VyZa67NygjlrzoRULWBTpDz
         nSFeGLa4NNmleJmlgKRf1nHq9UC6hCNFOobWhhCXDsox3bT2u2p637Difo5MBO9nS+Ml
         LN2/vi2YPO21Epc1lvLcn1EmNy8RUKUHPMoEoadFLkM72W7v4LulaZvAzkmNDKtr6XQ2
         Au4nX23fbAOwNcSi9t8EFcaVWZRVX1InS+OYNblDimAnVDLlPSqcysAvxUuj8lGR+41u
         gpv9ky51r4nv6+0j3kK/dft3SEzfz2eZFjqdT4kmeClehd9tr2VHNnunLxrinZfrVhi/
         ylVA==
X-Gm-Message-State: AOJu0YyzEN5bMLeqZ0LgOJ5XwbzyMd80ZyoWGZQwLPaSj8HJ51Dy7KH3
	3Gh3uaEIZYK2algReHqEzkyUypavZ/A0qqLYMoqi2up0z5NIxhAsaePnUg==
X-Google-Smtp-Source: AGHT+IF8E87bZzywssphBQwSjLmnzrbwOO9eNyj2OngnCfVHj2RfuW3Nozo1FDmsl75y/9Ek+ZvKFQ==
X-Received: by 2002:a05:6214:449a:b0:6c3:5ae8:9e71 with SMTP id 6a1803df08f44-6c5735725bbmr230428796d6.41.1726498380613;
        Mon, 16 Sep 2024 07:53:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.223.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c7d9f0esm24908566d6.143.2024.09.16.07.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 07:53:00 -0700 (PDT)
Message-ID: <66e8464c.d40a0220.1a1404.8022@mx.google.com>
Date: Mon, 16 Sep 2024 07:53:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1656702221373099636=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ismael@iodev.co.uk
Subject: RE: [v2] Replace the usage of non-standard GNU-basename with strrchr
In-Reply-To: <20240916130824.11246-2-ismael@iodev.co.uk>
References: <20240916130824.11246-2-ismael@iodev.co.uk>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1656702221373099636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=890677

---Test result---

Test Summary:
CheckPatch                    FAIL      0.68 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.71 seconds
BluezMake                     PASS      1744.38 seconds
MakeCheck                     PASS      13.29 seconds
MakeDistcheck                 PASS      179.14 seconds
CheckValgrind                 PASS      254.61 seconds
CheckSmatch                   WARNING   362.17 seconds
bluezmakeextell               PASS      123.51 seconds
IncrementalBuild              PASS      1574.25 seconds
ScanBuild                     PASS      1021.39 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Replace the usage of non-standard GNU-basename with strrchr
WARNING:LINE_SPACING: Missing a blank line after declarations
#100: FILE: tools/hex2hcd.c:307:
+		const char *bname = strrchr(pathname, '/');
+		if (!bname++)

/github/workspace/src/src/13805416.patch total: 0 errors, 1 warnings, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13805416.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/hex2hcd.c:136:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============1656702221373099636==--
