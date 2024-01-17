Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3B928DC1
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531340; cv=none; b=Rlj8UgVMFLw8c7/mjbk4FO9Y4MQix6USipF755IroaHs/9fV/dYEwpqnDhTnLtZNDyiG7k7kWu7W5mILULHlCAnH9nsJ3Yll/ehB1p6qr5UNX/hY4UYRz2O0hp4MSUOFgwJtE82E98HwsWkHvpScl4qYcNi8N94jTKo5DInzmVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531340; c=relaxed/simple;
	bh=YZFLLGGrYHRoJBKXhch9Oo3BhZ1NVR9M0U+14BLm3MU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References:Reply-To; b=UF8O0yybbxfQ7ngxMj9wHiAwbo0TpwfZdyBjmaS0xvVzOogtg38YZiKxX+CQ6rtgvyghtWwNQDP4O36lIsLwKx/TDNnOY+dHPA3/hubhTO+LZAm7QC/oCFcqI1iZK4fEo+N7ByIoY4oIO6sjHk+7tA9aUBsf5E2VBl3QazUG85w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc2/msVe; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc2/msVe"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7831386ee01so1173967985a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 14:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705531337; x=1706136137; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tQI2FfXMw+KVxgKLvy5YS0eu+cuvjWmROORmATw7EJI=;
        b=Hc2/msVeT4W+dV8y7xJP4kntUOXDRFtsFOyLw1cKM9rfuxJHITZuI4S6hPEku/Ba3e
         02kM1ZiV2W8nvLEjmBTX9RrDVek8aIVsGkVyno7aUpiLSFW9zOdTUpIXIlfCQNiFuzsO
         jyu4S6JUqb4v29BeNeK2BjbLVYc1YeE/wXOI6eT8kHLFTUi3pTVB/K8j264L8rGlAZ4O
         FTOONcnfdcsqYZvNzJtmyjD8/Vgq9HVEis4HQNY94kYr/4egDI7iDh8WMAaVREwcDOUA
         S1KLTK4lV9dl2Tuw/ygXcNuf6+15XtGdbIOwEtN/yXd+CZfPbIrFtIg9VwaKC0TXSijR
         osmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705531337; x=1706136137;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQI2FfXMw+KVxgKLvy5YS0eu+cuvjWmROORmATw7EJI=;
        b=ibD+lcAKrA+IIihxEO3Lf+BIlmAZEl1VbO0ylYHewhMmU9EDQrSRuh/F2rhRxp9Ld9
         5XbQCd3cHRj9VfMskjKP6tSBJbno+p2z3QhDxuqT+EQo5ZfyBFInw7mjc4GHaJxsJc3n
         2HM1PcSmFiIUwe6mOBHAPRE3Fk6DkWL2NpAs9z0+KCIDppUzxeUl6+IMCCSCYL+D/HBw
         plBe4h/39HLmOzul9OryAYbFMCgyfHhEZmqYUw2LTrVnduzEMSawjS7DM2Fx7dLS4I58
         wTdXWCfYRo6hHTLPsznB5R55pVH94nu428bivNa+4tEOojO/uHqJV5dY6vSAUzKGfpT0
         716A==
X-Gm-Message-State: AOJu0Yy3TUgU0eVmHg+7T9A3kWYEQwabggbHvg3eAMqU3UiKWol7le6C
	mvcqHqSVsakLfmD7kxKJy9g9ctxhedQ=
X-Google-Smtp-Source: AGHT+IGdjLL3T4+OKHGrtfIsvCAkmcCa/b0thO/Nyinvx2U3GLC766iv6DpX+CV7iWy+4ixNGcHDfQ==
X-Received: by 2002:a05:620a:19a0:b0:783:71fa:5366 with SMTP id bm32-20020a05620a19a000b0078371fa5366mr2266814qkb.92.1705531337308;
        Wed, 17 Jan 2024 14:42:17 -0800 (PST)
Received: from [172.17.0.2] ([20.97.189.21])
        by smtp.gmail.com with ESMTPSA id c6-20020a05620a200600b0078314a8190dsm4836698qka.25.2024.01.17.14.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 14:42:17 -0800 (PST)
Message-ID: <65a857c9.050a0220.32c0c.804d@mx.google.com>
Date: Wed, 17 Jan 2024 14:42:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0949948692663669988=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] client/player: Add support for printing A2DP codec details
In-Reply-To: <20240117212811.1784326-1-luiz.dentz@gmail.com>
References: <20240117212811.1784326-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0949948692663669988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=817650

---Test result---

Test Summary:
CheckPatch                    FAIL      1.53 seconds
GitLint                       FAIL      0.89 seconds
BuildEll                      PASS      24.06 seconds
BluezMake                     PASS      731.70 seconds
MakeCheck                     PASS      12.04 seconds
MakeDistcheck                 PASS      161.08 seconds
CheckValgrind                 PASS      222.98 seconds
CheckSmatch                   PASS      326.67 seconds
bluezmakeextell               PASS      106.27 seconds
IncrementalBuild              PASS      1370.09 seconds
ScanBuild                     PASS      936.51 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,1/2] client/player: Add support for printing A2DP codec details
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#139: FILE: client/player.c:82:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#148: FILE: client/player.c:91:
+} __attribute__ ((packed));

/github/workspace/src/src/13522175.patch total: 0 errors, 2 warnings, 599 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13522175.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/2] client/player: Add support for printing A2DP codec details

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B3 Line contains hard tab characters (\t): "	UUID: 0000110b-0000-1000-8000-00805f9b34fb"
11: B3 Line contains hard tab characters (\t): "	Codec: 0x00 (0)"
12: B3 Line contains hard tab characters (\t): "	Media Codec: SBC"
13: B3 Line contains hard tab characters (\t): "	Channel Modes: Mono DualChannel Stereo JointStereo"
14: B3 Line contains hard tab characters (\t): "	Frequencies: 44.1Khz 48Khz"
15: B3 Line contains hard tab characters (\t): "	Subbands: 4 8"
16: B3 Line contains hard tab characters (\t): "	Blocks: 4 8 12 16"
17: B3 Line contains hard tab characters (\t): "	Bitpool Range: 2-53"
18: B3 Line contains hard tab characters (\t): "	..."
22: B3 Line contains hard tab characters (\t): "	UUID: 0000110a-0000-1000-8000-00805f9b34fb"
23: B3 Line contains hard tab characters (\t): "	Codec: 0x00 (0)"
24: B3 Line contains hard tab characters (\t): "	Media Codec: SBC"
25: B3 Line contains hard tab characters (\t): "	Channel Modes: JointStereo"
26: B3 Line contains hard tab characters (\t): "	Frequencies: 48Khz"
27: B3 Line contains hard tab characters (\t): "	Subbands: 8"
28: B3 Line contains hard tab characters (\t): "	Blocks: 16"
29: B3 Line contains hard tab characters (\t): "	Bitpool Range: 2-53"


---
Regards,
Linux Bluetooth


--===============0949948692663669988==--
