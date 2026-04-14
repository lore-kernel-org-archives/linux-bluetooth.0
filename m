Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2C32FE575
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776169480; cv=none; b=MffQ8CNxLuBzIupUrknQUCWUUkn3byhD3Za8T/hfmMwiet91AUexlaBv96PP8wdNhzgiz8tO4BPgknX2BBJvF/jW2rHWVRVRza3AB/D+Xk6B/2sgBPZn8gEAaxwcaMD6Rx4qOdr1qiyDVGgmjDeIEdeAPg07Mn+xzqNBy3+sNNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776169480; c=relaxed/simple;
	bh=rqdPDIlNFmDugikYz74V9QNSdJgJZB3IMcVQKHBwhCY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MBw9sYnlirPPI7K4BklXUaoppoOc4AJMFHY2cP2dMXWzf3Vo3XllLhlUopTOv9dszZs7mwnDDCd803xyHAdw7r1OAJKZGBBYZHNS2Qhu8VohNKut0VtNkVdD7LF0V3Co+v5A1TCASBEjlJFiet5HTmr+zHq4gJSOqNX2pwMHfi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQ+XWxGD; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ+XWxGD"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8e0a768331cso228736585a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 05:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776169478; x=1776774278; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tc3jd8tIg1j1Ipoo7t+MsOrKEngLEJeqG4K7HJACIgU=;
        b=lQ+XWxGDDAda0wk9kjApOxqbviR+DTED+kMgTveMi1lT5tiL9mAy9Njt5pJ8azqxMa
         s5RaKIzu+UjS/wWGtGfqmizV5/v3bCpEFcMub56mD7QmTnZFrTro4Ny3kudU/BIONnNb
         g9aphK1MeIhwXAJw/zIuISIyFdEebXR4acizvWUrl5zwxwsM4ANiB9UFtK5Lzit3AKF9
         3kLdABDXI8zL/XhyLwRiJ1wSydyIH+ceQm+3SbJOMj6YFp10u2M9Awewog88xrV8VyrP
         wpbFvHKS5GP46xEBCUiQlFkdV6cnPpcObrfaEBmeHfRVnA7NW6luOSk0WdQelXGrwgA4
         4Qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776169478; x=1776774278;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tc3jd8tIg1j1Ipoo7t+MsOrKEngLEJeqG4K7HJACIgU=;
        b=gH0BJsYQ0SSgqEdkNAF+QnJInlQJFIkT5zXVvrCgmLYWJ1ARLm6M9Njx7B1i9qeBjO
         s0qIAzM+/ca7GQlpUikKDLszyzvKGa+Eb2JUQXAli/8U6mwKk6oIN55iLX1ZXDBaLxtJ
         xhtDwYx5H4vqTmTWP1+th8gjzNC1EjFQ1Td/Npk/s/9wvqimumn6l2WyhfiXX1QTuGYx
         1RYz1E5D4erdV68XtXdDhW5J8wN2YDdLS1hXpfG/UIJjXYAAR/q6ceSikVVGN4/OLGLv
         T/0VyHnKfOncVZoUqJKRLf/QsWFEU2qj+w0U9t7Wpaf26gEOeVvGIE8JNpesQmewLB7Q
         Jd0A==
X-Gm-Message-State: AOJu0YxsbY+vYi5Vbg2jaK4/vD9X3KTormY6YLD+a00GEfjRTmQcuxpb
	rH7rOb1RJaUcWbZw+RP/W+A1gnh39wXNLJZVz83BwPOOCTmDT4xA09owS9SMRQ==
X-Gm-Gg: AeBDiesfyhDu+iFN+UDV/Z99hNgscIZnnLyHJxu50tPP1FKE0jp9zpYaiSwv/PhFWdP
	6AInmSKPB7dPh/hOyO3lM0TLeMrIntIZkSfb3KJNnIqOuzXmAodQxbfedHzGHFWCwlDfUtdl030
	U0E4QV1zPfDzAgfFg8nPnWVyszGfu6eGmeKj4xwi2gPBQKR3vzt8dEN6O8/ScHefSnK3LzsZ6fa
	2CnbkZnL75iFBPLXzmRj4jC/BzAx9oNQ3cNkbwEwpmHvWE6QRbMLjqBTYDdPp8tq4kkR8EHqPH9
	LvVah72327PbSf7QpQglXuuVsQy1R/dD8pZmEx6mtkfGKfAM6wzfzL9Dj3Qn2a22NiKURSsV88V
	N2tV1LiuOT9yBkSzOOYBjNjM+5+KV7MhDoMsiAOVzlGJRnaxbCQh48/udDnHbP5Ikv+/e/2p6SY
	lbgvgSrKg2nZrV/Gzd7dk+NizbB+AVo3Bwyima4QTw
X-Received: by 2002:a05:620a:2848:b0:8cf:c4e1:9761 with SMTP id af79cd13be357-8ddd03a2c72mr2212555185a.20.1776169477560;
        Tue, 14 Apr 2026 05:24:37 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.89.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8de6553c460sm1114975285a.43.2026.04.14.05.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:24:36 -0700 (PDT)
Message-ID: <69de3204.050a0220.3567e6.9897@mx.google.com>
Date: Tue, 14 Apr 2026 05:24:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9199618175859754061=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,1/2] monitor: define manufacturer company IDs
In-Reply-To: <20260414111307.3725821-1-apusaka@google.com>
References: <20260414111307.3725821-1-apusaka@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9199618175859754061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081093

---Test result---

Test Summary:
CheckPatch                    FAIL      1.22 seconds
GitLint                       PASS      0.54 seconds
BuildEll                      PASS      17.61 seconds
BluezMake                     PASS      603.42 seconds
MakeCheck                     PASS      18.55 seconds
MakeDistcheck                 PASS      220.26 seconds
CheckValgrind                 PASS      273.63 seconds
CheckSmatch                   WARNING   305.22 seconds
bluezmakeextell               PASS      166.13 seconds
IncrementalBuild              FAIL      0.25 seconds
ScanBuild                     PASS      902.35 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[Bluez,2/2] monitor: Set msft_opcode on read_local_version_rsp
ERROR:OPEN_BRACE: open brace '{' following function definitions go on the next line
#108: FILE: monitor/packet.c:4362:
+static int get_msft_opcode(uint16_t manufacturer) {

/github/workspace/src/patch/14524190.patch total: 1 errors, 0 warnings, 86 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14524190.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2000:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3866:52: warning: array of flexible structuresmonitor/bt.h:3854:40: warning: array of flexible structuresmonitor/packet.c:2000:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3866:52: warning: array of flexible structuresmonitor/bt.h:3854:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:

fatal: previous rebase directory .git/rebase-apply still exists but mbox given.


https://github.com/bluez/bluez/pull/2031

---
Regards,
Linux Bluetooth


--===============9199618175859754061==--
