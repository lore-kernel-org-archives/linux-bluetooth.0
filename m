Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483503BB9F4
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925680; cv=none; b=Zvb6E25hQ37TXTLuqGxy9cSfRgMVwtoMkkS+YKk6cOFupD+TUx9W0zAG1d93qRnkXTvXeP9uWkdUHivEoXonmA7Pnwf1dQVMgKpx0H6eYpO+i0683RC9szUmiMsU8LMKs8pmSHfrFpcqPdkynm6w0suHHlIEY0zyaCfBxlleJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925680; c=relaxed/simple;
	bh=QRhIgUaaM5EX7UQobrJg7e6ZpPFCLCfcZm3DZN3T0/M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=axJI1w+XUXkM7s43BHSKNPv8UTE+DP5eNg8YnbkaaHwCw0erbRCvy1e/rjcSOFzkZSGUIGy1irzjOrhYLJwt3xLZJJ1Trnk8zLQ405xp0efSSeYwFHVSAq8az8T0ChU7Da7avQTuyU/XJL95nSWNQCWfju1bgy8B1yIjGOFh1D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqWeX/WO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqWeX/WO"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so841246a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 13:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784925676; x=1785530476; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G0IJxYlbsU3ssPt7KlzpLQp7z9M+sUQO6zpmteFHyP8=;
        b=fqWeX/WOm10Iz/Trv1UGjwvUpXcfaENU9Ao1url7WQFH1pVGDhLA6zGUzFz6u66OWV
         MZuBR5oVD9vbDKhe6tQZWKywYC8M3I5VrZPr2HqZs00nXKaUoMbrAFV4R7GkUynaDHOy
         92kYIjcxSeUzUoqMea8If8NHSFZOn3Sb7UFt72VpO2Lx+QFTaE+W6hMOmb8GLar/QDH+
         7X//YNhNNqLl3onfdh2OPBgGcSjx2jQ29mZFzNShQHBhtw5axEcR5aU9b36qJG5BIdIJ
         YGL4U0f6MYfRugVG6yU5CgCLLfrAqage8nOa/GXLv7I/GoQgUsVvv8jPaDQljnVOQY4c
         x5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784925676; x=1785530476;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G0IJxYlbsU3ssPt7KlzpLQp7z9M+sUQO6zpmteFHyP8=;
        b=lLh1QZ5iTo+fInQVXV5IUtZtxWFm6pUvsJC7mmTtTmlpzzQqPLKEd/PbF+MHp5aDUL
         kLddT2E1n463Qr3Zzbg5hBqDOakf46ZnxFO386uIv9GJFCsttTD260WGU6tadeCvu5/H
         hwwXcKV4GIS96mXAfJclK+VuHGWqzfmrWKJNmFPiOdwoVk0arhUG5orS9woX+cot3RuA
         GwhdhOhIBG4rNItbUJ/hmqEpj1+A0GUZ12EWvJLIc+bSk9i9bedoee8JHvAamQSBO0LI
         hpWnGKTTG+gAbyMIXAngfzxzJS97pHbXPmwH0FEQ9DaHMDkGoHaH0j8F6XTrLXGyj4k8
         MGlQ==
X-Gm-Message-State: AOJu0YxKnocHaKWON351OuPioN0VtPoJWjRzyPYOTRrgncDfuzuca7o+
	rSLBNYXVrjiqH7sONAW4PLSJfqINJwLufAI7e+rq3/eeKH34LT2ySYY7gGvhEQ==
X-Gm-Gg: AR+sD12QkopiTLgVE/aSR9/C7dz9Q+M963WwO4umf9k1t9UyA5Z+ZtAZy0H54Zv628I
	pueHUdlo4QaIkWm+H66ftCHyM2MC7ja7tdIX9fLkis56dMXbKi2s9GnuSxcHHbyZM0qWxqzw5HT
	Elu7/oDNULWhtLMpa604LNIvfd/TwVP4puCRCz/mM+lM20yjeVFiZW5zmlqdJsn3fQhh/WVQiro
	Pbg+lPSIOOm5BG8MPRJ43ZNqLX5qlEaOi6kqyQbZG9MJ3InxezUxrC1tf5ayTKotA5XPrixwZnk
	AnM2xtCHptT8h/KgvZQwYWGt2UrsMqeyQF9qiIguGFqRo7sVFOTIHs1aaw27Eyi5I9NMPYlWPtQ
	7JzAMW24A5uiuIyPyLsQCZxOQQf/XAKJpf9Q0VNr7FPObBbFxq63POzPKQFcBU7M498iaiUbwPa
	ncL372Zdc9
X-Received: by 2002:a17:90b:4c04:b0:38e:7446:d2b8 with SMTP id 98e67ed59e1d1-38f298b76b7mr3465a91.41.1784925675866;
        Fri, 24 Jul 2026 13:41:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.189.181.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d6ba579c3sm1797108c88.8.2026.07.24.13.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 13:41:15 -0700 (PDT)
Message-ID: <6a63cdeb.0975a56b.fbb08.e062@mx.google.com>
Date: Fri, 24 Jul 2026 13:41:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3006932473387248355=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Add support for Shorter Connection Interval (SCI)
In-Reply-To: <20260724191225.1815634-2-luiz.dentz@gmail.com>
References: <20260724191225.1815634-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3006932473387248355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1134176

---Test result---

Test Summary:
CheckPatch                    FAIL      3.79 seconds
GitLint                       FAIL      2.99 seconds
BuildEll                      PASS      15.82 seconds
BluezMake                     PASS      456.61 seconds
MakeCheck                     PASS      18.51 seconds
MakeDistcheck                 PASS      121.29 seconds
CheckValgrind                 PASS      172.27 seconds
CheckSmatch                   WARNING   228.67 seconds
bluezmakeextell               PASS      73.20 seconds
IncrementalBuild              PASS      571.48 seconds
ScanBuild                     PASS      675.72 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,02/12] emulator/btdev: Add emulation support for HIDS 1.1 SCI commands
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#173: FILE: emulator/btdev.c:8015:
+	} __attribute__ ((packed)) pdu;

WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
#210: FILE: emulator/btdev.c:8052:
+	btdev->commands[48] |= BIT(7);	/* LE Read Min Supported Conn Interval */

/github/workspace/src/patch/14709597.patch total: 0 errors, 2 warnings, 172 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14709597.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,10/12] l2cap-tester: Add SCI mode tests for LE client connections
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#247: FILE: tools/l2cap-tester.c:1607:
+		} __attribute__((packed)) load;

/github/workspace/src/patch/14709606.patch total: 0 errors, 1 warnings, 166 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14709606.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,01/12] input/hog-lib: Add discovery support for HIDS 1.1 SCI attributes

1: T1 Title exceeds max length (81>80): "[BlueZ,v1,01/12] input/hog-lib: Add discovery support for HIDS 1.1 SCI attributes"
[BlueZ,v1,03/12] mgmt: Add Shorter Connection Interval setting and Load Connection Subrate

1: T1 Title exceeds max length (90>80): "[BlueZ,v1,03/12] mgmt: Add Shorter Connection Interval setting and Load Connection Subrate"
[BlueZ,v1,04/12] mgmt-tester: Add tests for SCI setting and Load Connection Subrate

1: T1 Title exceeds max length (83>80): "[BlueZ,v1,04/12] mgmt-tester: Add tests for SCI setting and Load Connection Subrate"
[BlueZ,v1,06/12] monitor: Add decoding for Load Connection Subrate, SCI setting and event

1: T1 Title exceeds max length (89>80): "[BlueZ,v1,06/12] monitor: Add decoding for Load Connection Subrate, SCI setting and event"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:478:29: warning: Variable length array is used.monitor/packet.c:2002:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structuresemulator/bthost.c:703:28: warning: Variable length array is used.emulator/bthost.c:704:32: warning: Variable length array is used.emulator/bthost.c:944:28: warning: Variable length array is used.emulator/bthost.c:978:28: warning: Variable length array is used.emulator/bthost.c:979:32: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2347

---
Regards,
Linux Bluetooth


--===============3006932473387248355==--
