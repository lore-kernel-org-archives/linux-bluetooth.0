Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD693128CC
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778066142; cv=none; b=OVT7PgUlbFiSzuOAJTOs3x6lU+ZysMK3lu3rDPmDPHqYs7i16nxTcQCdFk+gxbUovwgYSJ+i0MGnKyFt3dP9KHBXJXifvnt8insEnX1fW9R7dPt7CK4zRb2nx6BfgdqZdaPiE1fWmlbaLqnzuxnxqwLMGjAG1SsgeMmJSFsThcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778066142; c=relaxed/simple;
	bh=RxxNTNMcbTQarGLJ9i6TjmU3KtGiWDDm0aBuptTl0Jo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Fh3ISU3SO9EwpcsdtgEKblPAZS6SI6LhzuiRHcY3cEMRyGLYW6g6VLV5lmF/377OWRrH4f4RZVYp2BwGGzEXU3V6ht2/+rK/4JmxXkXkkl64IXqRCqKr4XAul10bz0tnW9mgsfqwYN9Uc4OScAD5FHCSWeWN3LlEZCuVXha3ZXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzyDKKdN; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzyDKKdN"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b4520f6b32so9742394eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 04:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778066139; x=1778670939; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kIMhmJVPRLuSaQZqFXCURZrIbp1U2sfqIn6jSFiQInE=;
        b=SzyDKKdNXA5tL0GZk3FQqdfP9Hnt0LCve/AB6q7rUcmzpPuVyfA/muRs7WSTj5ntqO
         9whXlm46ccMhqpGlRuPILtum1IKrRvt8AQvxc3Zf9oTu4oCRSBs3j4OAyGAL8rO9Awa+
         TrhFCYWhsR6T+nn3f9dxiQ8RaDStfCs2RBw+mO3FL4dCPjo7OLjbtYeUhcnYr5CaWoJU
         mE5vpkAItTkzKz8FDuuqYD7dh8GFodyvY4Rq7oBBg7KBi7NCy/46mP1teeXM3y2nHDbt
         2BP5pC2Kc2v5TV6zoaH059kSuNve4/z2CQaq2AkNSDeJjS7D8jmeSWIXIkz6wFtR0mLP
         lvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778066139; x=1778670939;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIMhmJVPRLuSaQZqFXCURZrIbp1U2sfqIn6jSFiQInE=;
        b=p04WeZWIHc/oRmsvvD7XKwrSO4qzSlPAFiXzwTz0SMC3hhNwoJHUKY/K3mRms7Yejs
         EA6tU3/C3lYmER5qQxWZVPhoKtTaYMADBEU+loAjlH+OUFqzmZkSOlLGjVvt52gY0Rk8
         N2NEicXGyovSIG+W6OXj4KNr4CZ61FwWZMhKKvVtJvYtjLRwKoR+3PcULsAbCrWKUJ7x
         1XW6bKiaxbD3QM7yMteRX4DdxeqsYW3vBwjIBTbQQxKNMXQsxsCRIa5o1d0YfL4RzLt4
         TaToSe2U3aU7rADMPZ5H6jGkNBpfmk9y8bpB7EK2Oki1zPwg6IhKs84rwmP81WbfbYo+
         GqYw==
X-Gm-Message-State: AOJu0YzXvLM4CZ1jeMP8vs/5G8W4fbnifI68uyeGdIik0adShRJfRThy
	gjmXm21ss5Iydbcx3cIAzhrBJ6A+uOtKN2KgUYEh0bdIs1NBv+UZas1Oh7JtTg==
X-Gm-Gg: AeBDievI/n+g5kSZ0vDGplSUdw2raHSXj9z0cV/Uq3MiLfd97IvUbbOi4llLfmtEc7q
	zIwvyhuEPC5wkk+q7RIYUZ4Zs53WNe1bKKH6B8x0KHxYeKWohBDtZJ5WUehPTCnhBIyDfiOnDB8
	+uc/qHWREHBTiQxLtVufLEoZnSkJ8jaSGZVFD6sRnebXsmsjEQsO8aEngImFFCVmoH05WAHjArD
	0owyj2wE2M4WvgHcYQaXv5+IT+SM4NB3k+YNNZiwIQ7J4Eq3LVTUUZ5CY6qE9bYLeiXNnU8nxhL
	EhZ97ZJ0ZDsL53fjMcVnzTsT69IBwviXThMg4b3BmdPjfBC140P2H5BzxTrmhYMgOFUvlqQIGCH
	cWWdvO5TxWvbbz0pA6dTiX/qMFPJSoTK0EVanqOQ1gPQkcv8mhOWhZBCcUrhbExusoRXXdqzKOq
	ezMtUMhxLeA3+zisyJLYyY7rpfgMOQV0uSGD2TvIA/Ei/fG6XlhAI=
X-Received: by 2002:a05:7300:a599:b0:2f5:3641:f114 with SMTP id 5a478bee46e88-2f55094d7a2mr1465039eec.28.1778066136680;
        Wed, 06 May 2026 04:15:36 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.60.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56cec58efsm2860045eec.2.2026.05.06.04.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 04:15:36 -0700 (PDT)
Message-ID: <69fb22d8.050a0220.1d3108.0591@mx.google.com>
Date: Wed, 06 May 2026 04:15:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9066851663434428570=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Add helper for "cleanup" variable attribute
In-Reply-To: <20260506091824.2920716-2-hadess@hadess.net>
References: <20260506091824.2920716-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9066851663434428570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1090349

---Test result---

Test Summary:
CheckPatch                    FAIL      1.57 seconds
GitLint                       PASS      1.32 seconds
BuildEll                      PASS      20.73 seconds
BluezMake                     PASS      654.60 seconds
MakeCheck                     PASS      19.06 seconds
MakeDistcheck                 PASS      249.78 seconds
CheckValgrind                 PASS      296.64 seconds
CheckSmatch                   WARNING   355.15 seconds
bluezmakeextell               PASS      184.37 seconds
IncrementalBuild              PASS      1277.75 seconds
ScanBuild                     PASS      1024.24 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/5] shared/util: Add helper for "cleanup" variable attribute
ERROR:OPEN_BRACE: open brace '{' following function definitions go on the next line
#74: FILE: src/shared/util.h:96:
+static inline void freep(void *p) {

ERROR:CODE_INDENT: code indent should use tabs where possible
#75: FILE: src/shared/util.h:97:
+        free(*(void**) p);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#75: FILE: src/shared/util.h:97:
+        free(*(void**) p);$

ERROR:POINTER_LOCATION: "(foo**)" should be "(foo **)"
#75: FILE: src/shared/util.h:97:
+        free(*(void**) p);

/github/workspace/src/patch/14557019.patch total: 3 errors, 1 warnings, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/patch/14557019.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,5/5] main: Use _cleanup_() to simplify GError-handling
ERROR:OPEN_BRACE: open brace '{' following function definitions go on the next line
#66: FILE: src/main.c:208:
+static inline void free_error(void *err) {

ERROR:CODE_INDENT: code indent should use tabs where possible
#67: FILE: src/main.c:209:
+        g_error_free(*(void**) err);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#67: FILE: src/main.c:209:
+        g_error_free(*(void**) err);$

ERROR:POINTER_LOCATION: "(foo**)" should be "(foo **)"
#67: FILE: src/main.c:209:
+        g_error_free(*(void**) err);

/github/workspace/src/patch/14557018.patch total: 3 errors, 1 warnings, 127 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/patch/14557018.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/main.c: note: in included file (through src/device.h):src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2101

---
Regards,
Linux Bluetooth


--===============9066851663434428570==--
