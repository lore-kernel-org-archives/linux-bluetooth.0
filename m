Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5D91DDC5
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621055; cv=none; b=dmhBNPdw7TLgrSZechqKV8IzdDAj6Ur2KB5K4+EtTAtZk5ZzwltuzM9glURzNTZdpAqh06g8JgrShyDGoBeb5KYU+uM6k0d4wtv4kymk57NCwl3nsWpgk8L/5ATrF+Wo9ru7/yPZ+Lg3FlF4V32/UbSexizkM1OATktmEnzDekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621055; c=relaxed/simple;
	bh=AmUhXPTgI+5JLdCP0HFFQtM8J64TPvudC9+Ymtq4Tf4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lb1v3KFbvO474yxMmKH1wGHtX/QMOCuZ7XOOv3icI60bkuXNgDwi5kotUmQjE2zAi+bymb7bAYmgmB2EW7hLHy6p8vKil7cRll2isZokAhFRqGqq4HmomZFrq7uvfl7zLq1lyRxjRHMlSw8jlImkWViyXeykculgc3Bdu5DPSPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWCbx6pL; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWCbx6pL"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-447fd75f9aeso10553901cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720621052; x=1721225852; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DUjm8XrfYZageADZxnviPS7qUZFVLDQXk3BYJBbLx6s=;
        b=YWCbx6pLoXOjRS22VKZeRSQJAB2AuXW/1smWFMALVlDtxDlu48zoafAj7WJf3SUdR2
         hQHiGyKBu73Nx2NJzqxdNhd1QNoFEuTg7DzKiMWTt1JQIAA/e2tlg+WIjE1fS14r4J0l
         LrHvK2B7GgRK5A0jUck7/bUzjyEfrpILN2oBXf5RmxIQa1p2G5+fDjYPQfDHXJCAhuy8
         7oPyaD8JqNnbB7rGc9W1J+/76F8ipzdt0ZdmNa4QTLDsY+4OOcGFOjxu94TQSVU6A6RI
         /9r92kqYGtMV+zOKSn3hi9gpV9cAoziYRahdyUHAAwCkS2/QI6FHVFU7O+jD3vmoJ94K
         MJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720621052; x=1721225852;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUjm8XrfYZageADZxnviPS7qUZFVLDQXk3BYJBbLx6s=;
        b=UmSeD+L9S29s3S5OPNCvCz483Lc3JzpccGlZa1EfdvEbD93A+/Ewj+6hS7bWQNStTz
         RvdE2c1qJBcfEkCbbtZ1K+g6xa5lsYMZNi1KwoH82NeHi4adQ3MBUE4PDyJL9VpH9Q6/
         nd/tgwwSV7lwDoAYBtNEYChZMKuVJj5cqNc+T9l5I+KahMMrv7+gi8aBSm9YFW5NI/IM
         YLCpUrLLDBoG7rnfzBf3+IMirCxyg3ZEtcYrW4igV0MJ1tYOMcD/Wsap3cKmLMOHpA4t
         /8X9N53Dp8pOEdqyyIySHm3ynkP43iqGj6XjzjjOCFRoks/xtOeWo8ZfBrrcBTaaxB8E
         bD1g==
X-Gm-Message-State: AOJu0Ywz3fgCBm9gxz9Z1Msop7BIgjP8kFWbB9/h397PG6r5I2s6UxnY
	MrUi+MVWe7i11FIg31piurrerV7l3jvZU1yz6cX+gHELMWMk7qgx7QgL8w==
X-Google-Smtp-Source: AGHT+IE/3YO2xXVAuDlrPQAJe7UWLeur2fbocDSjVVjK7cXDQ6I5eXl/YdOkDwZkVaEtfMYNiDOwAw==
X-Received: by 2002:ac8:570f:0:b0:447:eeed:5e9b with SMTP id d75a77b69052e-447fa9083eamr75557861cf.49.1720621052003;
        Wed, 10 Jul 2024 07:17:32 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.196.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b5267esm20917491cf.43.2024.07.10.07.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:17:31 -0700 (PDT)
Message-ID: <668e97fb.050a0220.3132a.8a25@mx.google.com>
Date: Wed, 10 Jul 2024 07:17:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1388128887676087265=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rahul@sandhuservices.dev
Subject: RE: tools/hex2hcd: fix musl compatibility
In-Reply-To: <20240710123002.5639-1-rahul@sandhuservices.dev>
References: <20240710123002.5639-1-rahul@sandhuservices.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1388128887676087265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=870104

---Test result---

Test Summary:
CheckPatch                    FAIL      0.71 seconds
GitLint                       PASS      0.87 seconds
BuildEll                      PASS      24.82 seconds
BluezMake                     PASS      1589.95 seconds
MakeCheck                     PASS      13.30 seconds
MakeDistcheck                 PASS      178.09 seconds
CheckValgrind                 PASS      254.21 seconds
CheckSmatch                   WARNING   356.62 seconds
bluezmakeextell               PASS      120.00 seconds
IncrementalBuild              PASS      1372.16 seconds
ScanBuild                     PASS      1008.59 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
tools/hex2hcd: fix musl compatibility
ERROR:OPEN_BRACE: open brace '{' following function definitions go on the next line
#64: FILE: tools/hex2hcd.c:288:
+static const char *helper_basename(const char *path) {

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#65: FILE: tools/hex2hcd.c:289:
+  const char *base = strrchr(path, '/');$

WARNING:LINE_SPACING: Missing a blank line after declarations
#66: FILE: tools/hex2hcd.c:290:
+  const char *base = strrchr(path, '/');
+  return base ? base + 1 : path;

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#66: FILE: tools/hex2hcd.c:290:
+  return base ? base + 1 : path;$

/github/workspace/src/src/13729245.patch total: 1 errors, 3 warnings, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13729245.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/hex2hcd.c:135:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============1388128887676087265==--
