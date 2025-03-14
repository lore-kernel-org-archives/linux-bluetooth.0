Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDBD4D8D1
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Mar 2025 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741937535; cv=none; b=g8jFfRG6bNXCzR+axMkzVlUQgUUmq6gf6SC8HdW5ghAiX+pdo7XPvJ/5gghtS8El0K+hleL/fPqfqg+DfUxOh3vW1Yv7S9kMxwXa0ix8BfkIcdNDs1cIUU+ssPo6u5nW0S8W6F/KzDA6BG34zxQWaHQRlH/2oXoH4XPEAWvu5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741937535; c=relaxed/simple;
	bh=OKcLeTY2E1iA+UtIEJWW02oB3IwOtE/nrtKqUOIMh38=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=agciT4V1l7N9gz0qhjcb3tHN8DrQHosVyyadX2FjMqt6JJrNhK3fUflKiUP/M73nulyXKVej1QiRN17xA0JUBkAVV1OPMW4ycs7C85a76bNhC3IMlxYPF7PJwvhp4NmJonj/KVcP4Z+K/nxL+aOrloPxDKNirMUrHawirN8HmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tjzdph04; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tjzdph04"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223a7065ff8so49022795ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Mar 2025 00:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741937533; x=1742542333; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eh3CGhTJ0bO+1CrKP9eHcL6cxnBh9XdYIG4LfrhAWfA=;
        b=Tjzdph0458pLmao+MGguNOpYI9asdmcvKPdjfzO3OnDftPqjWa1OOc58dyvWvIi1yV
         4wQ9OT5mbrvWt+cq/drVU91gcZGUyNMluVCS/vpAVcBcR7leA+WKbQopR32uqwvR10w+
         JHAOnR2zPqxpsWJ3g7DVyyYYUGV3EEKHWNoDB9hOdkU9dX7i4amzAP7LSmHSviMPKsEs
         DheOtx01TsDyyjSSJLW6odvJakx8TG4Xmi3BtmAOY4tpaV6cF0kwTEXTDRhwM0M+718M
         t3QKRbnGYCehWEm6gS5D+9qHIgcyaPPuwvIfk/ibdSUgiuiLQacErmU98SgxFt3mKdh3
         KqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741937533; x=1742542333;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eh3CGhTJ0bO+1CrKP9eHcL6cxnBh9XdYIG4LfrhAWfA=;
        b=CVAmkYFGRKY1Omv6UlJDjBIswWPDuzH+rqkpefHkS1ABT2mtO1L+vxYMiCfKVUvbSj
         4Eh6LtJ/eEcMEYRVk8F2umQOSFKkPH6qjoG612pB/3OJrGgYlm2OD5kDOIQC/ttYyPGu
         MEP+WJriV5S3Bi2srd5vsTigjqdeyx4etokTMQmcJ0zWcj/EC+49aVBachTk5zeD+Tat
         2rrUONN2kxZ6vwlW636eAZ6Xt592Hv8ajMgVWM8be9AkeGNafzOOPIWDGxMezJmkAR38
         av0/bmJW1b+oS96XPFN0COP+S3yiaJ/pGujJSjB+xYk0YW2BDb8atqnPa86VrVKIdj4M
         xSew==
X-Gm-Message-State: AOJu0Yytqq/OHrXgnOxKW+wE4jQicjUvPCMn8fCxAajK7zegu7XB/bmG
	ITFZpE1Z2MigKuMrKRj03z2y1vvgQgHGoNG9WLtBdOfkUMe0S1qsFKwb9w==
X-Gm-Gg: ASbGncvBT0MoKxlOb6vQlPUTiFIhVc7f0ky4Xk98fJdfFPxGTcPnIQ9X5Rv7Kk5CqUX
	uqEMR4kKrL3pvYT+k5YGA44f+47AZrPzwgh+igBjLTdhb/CARndqNdvfPJKA++vTSc86xleO0BM
	pnbjZWMp/8aLUTniH/+GkaC1f3wOiE/8E11u8h+v9RX9voTdOib0TpKzI16T3OlXmuspbrfPkjf
	z2mr5SaFJL45tZc+lA3PvBHfYmn8rkrKt0BSKypBwMam0yoijNv0Rb+hScPoxBHTGcnBUHR6WBz
	foeQwugXdwKD4QqFdBrD52Vu2T7xbgcvK9HsmncM+/aFCryXHoE=
X-Google-Smtp-Source: AGHT+IE1BpbScjy/8HfuTgrQTCuGek+GligeTg/e+UwW7+1pAIzi38hA572GZBDdhGoDn+wa3Z4MTQ==
X-Received: by 2002:a17:902:ce0d:b0:21f:617a:f1b2 with SMTP id d9443c01a7336-225e0b4e4d2mr23843995ad.46.1741937532583;
        Fri, 14 Mar 2025 00:32:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.155.61.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a381bsm24003015ad.53.2025.03.14.00.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 00:32:12 -0700 (PDT)
Message-ID: <67d3db7c.170a0220.3c92a8.7a96@mx.google.com>
Date: Fri, 14 Mar 2025 00:32:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3566395064229178524=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Support function level reset
In-Reply-To: <20250314101613.3682010-1-chandrashekar.devegowda@intel.com>
References: <20250314101613.3682010-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3566395064229178524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=943796

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      24.42 seconds
CheckAllWarning               PASS      26.73 seconds
CheckSparse                   WARNING   29.94 seconds
BuildKernel32                 PASS      23.78 seconds
TestRunnerSetup               PASS      430.37 seconds
TestRunner_l2cap-tester       PASS      20.93 seconds
TestRunner_iso-tester         PASS      31.00 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        FAIL      121.37 seconds
TestRunner_rfcomm-tester      PASS      7.90 seconds
TestRunner_sco-tester         PASS      12.24 seconds
TestRunner_ioctl-tester       PASS      8.31 seconds
TestRunner_mesh-tester        PASS      6.15 seconds
TestRunner_smp-tester         PASS      7.40 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PENDING   0.59 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btintel.c:47:14: warning: symbol 'btintel_guid_dsm' was not declared. Should it be static?
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.150 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3566395064229178524==--
