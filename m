Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAEB186E44
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578744; cv=none; b=Dcoywtzz8hmAbHKuuprrwyaAUMS8ybC8l0oAXbBIHO72QFUqituC6uZokSNu3skfqnf+DC2p6C3Yrh3PJfKqR4XCF7fOKGDM+rw7+hRcffGhDBIIcHY5EmnahKx8mrUxs8yMf8nsRjV7TtTfg6kQQlCn/gd9J2RxV3NkByEbjCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578744; c=relaxed/simple;
	bh=lNYV4FCrzX44T1CbkbB89vAjVvW/9woFk1DqV5dVbT0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D82XDLU5ILkXuiesTHqJk3JU+vqq/jsob7fk65dKk4S58RpllbZqGEqtkw3Bnqd1RRHWmAuPRSyZCeIyOGXnCx6gC46PrygWI9UsyKRYzIV+lkfwuqBrVil1YZRiyfh+aN+OvvkS3AgGlTJiF6wuYNNxDiXx1VMrugqN6z70/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0TwuwvD; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0TwuwvD"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79c076c0d83so31637385a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 05:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719578736; x=1720183536; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Eosabc9THXFroTvjebXDLUfPEX0+IztJZVvpIDPwoHY=;
        b=k0TwuwvD4N2VRhmu+hrxgMcfjFzqGMJaacHg/bdwOkbBSjuLZC7955rMrxatODwLOD
         UmgqW/aLsx2zrhbnj2So3B+OZ3hG2rB9CsF6xb2DueMq+udDsWOjGxVcy0XHZT453UUl
         WPtAWeQgQlJ4ztbQ0v0jHygsZuQIaLea3nolSP9cKGzoYph/jTfHWb8w43UO5hpWVbzT
         adOgCBUSYgCVBM+1I6X6Q+TAasTsn5tm2eI8r0myNrtFCTASrvff2pO2FHXyH2lrrkln
         lcTqW5cwSRJKT6mtZxzEL96xC4fyDLMe6ig0fxgZohuZglQ5HreqHUBSMbv5FvPel7pb
         HONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719578736; x=1720183536;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eosabc9THXFroTvjebXDLUfPEX0+IztJZVvpIDPwoHY=;
        b=j2C+E8Q8gHZGPdX8wy1Zwlv+gg04+IPXVjjabmnj7IPjGFQi2hnRPQdBQ+mh9DXHX7
         PmoiQEFoXXco9huWrmppsipjpY0Vg+txsn8SE2PZP9PtE1e9UtAUD7dae1P1X/bpZoPO
         C72PH81FYQT77O2e0Htz3OKLarq8s2UWsNjk6IqxZ4NIFa5qB4HOgG7UlUIArVVnI6vl
         N4OOU7YY0wKNt+Nqnr9sHFri/P1ZHSV8iujMnCOI3KLo0gtFq9nsQtKk1YrrMpEAdlWU
         mHb39cWsDYcg/X/kQnfbCEivfI4/qC7cj9TfLh6WdSUYbbhr32+e9X5xPSxsf3B4hsFx
         DXgg==
X-Gm-Message-State: AOJu0YzML6u7tdUffQ1JVcJnNkemHLma3yePVYPx/LUNd84R1TCis7Mk
	/nn4akBKLXcIqiUdsGY9bJ+YWHr7F12SgVMM3ldOaIkIYNot0wunV0WgGQ==
X-Google-Smtp-Source: AGHT+IEVb8XwcvVhof7sDp6YrKRn8PAvruzvdejqv5eTqZ37HXJFPL5QwN/fH7/wb6gWntgHwqmviA==
X-Received: by 2002:a05:620a:372b:b0:79c:103b:af44 with SMTP id af79cd13be357-79c103bb106mr1018137785a.65.1719578735587;
        Fri, 28 Jun 2024 05:45:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.47.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d6927a5c3sm69338885a.45.2024.06.28.05.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:45:35 -0700 (PDT)
Message-ID: <667eb06f.050a0220.6e30f.2e6a@mx.google.com>
Date: Fri, 28 Jun 2024 05:45:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4132922732786948303=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhaochengyi@uniontech.com
Subject: RE: adapter: Add retry when bonding device returns connection failure
In-Reply-To: <20240628101348.16820-1-zhaochengyi@uniontech.com>
References: <20240628101348.16820-1-zhaochengyi@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4132922732786948303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866519

---Test result---

Test Summary:
CheckPatch                    FAIL      0.63 seconds
GitLint                       FAIL      0.58 seconds
BuildEll                      PASS      28.40 seconds
BluezMake                     PASS      2669.45 seconds
MakeCheck                     PASS      14.22 seconds
MakeDistcheck                 PASS      201.46 seconds
CheckValgrind                 PASS      287.73 seconds
CheckSmatch                   PASS      390.07 seconds
bluezmakeextell               PASS      140.54 seconds
IncrementalBuild              PASS      2641.40 seconds
ScanBuild                     PASS      1202.42 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
adapter: Add retry when bonding device returns connection failure
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#61: 
bluetoothd[1539]: src/adapter.c:pair_device_complete() Connect Failed (0x04)

/github/workspace/src/src/13715936.patch total: 0 errors, 1 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13715936.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
adapter: Add retry when bonding device returns connection failure

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B1 Line exceeds max length (106>80): "bluetoothd[1539]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr DD:EC:0F:57:A9:2E type 2 status 0x4"
12: B1 Line exceeds max length (89>80): "bluetoothd[1539]: src/device.c:device_bonding_complete() bonding 0x5591f87230 status 0x04"


---
Regards,
Linux Bluetooth


--===============4132922732786948303==--
