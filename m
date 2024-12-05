Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D547517E473
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417272; cv=none; b=GdHxErJYJdF1jPi2et2ayAcdjHZlELRFYmRXqSkN3hS8o+9x+/TO4S/a7uptTprnLw2cxXJsVSNYIfONKnIa9DC6oSGFiQzFAXdFNwed0wmnZB1yOTyANvmtULOUP3ed+W6HDQrWWoxUllGkw/9oakq3zNyQ/43qA0Yr0QXF+Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417272; c=relaxed/simple;
	bh=if7Gc0ZRMDkreBytscLnH57nK9vIGVSbvMINi3o/PhY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Vnev6C2xVxdfYvpldj4nzfezeo+803qChoNSkj83vm7jhJWSvA8ETC5oWzkKQu8Id0br9fa00xV45e0Rocdj4/vM8/3BCdDScnXWHwBTW/SQbSnAYWCO64y/Tai8AYFB8ectg29lNfVHcwwAZa3mhwaE/i8SonnYgfLX9aBxerw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Utf/A+/+; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Utf/A+/+"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d888fc8300so6076466d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Dec 2024 08:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733417269; x=1734022069; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2if8mM5m6RF51dq3zBLIXsLK+9+r3yP9FTbjvc8g7uQ=;
        b=Utf/A+/+9RScB8Wp8lcPGrv+tI5qo0xSL3/6LexmQLPPgWEeS+pcbz7cWWpFwVpuHV
         9SdUqPJdPoENnFwLB1YQLd2lDVgX1gVciWtuZQO56GByftRjTFGNXzKUXx+xKhOWXKCM
         xOpf3CYUg4MxxTVkD0NjrSTadP/AvSlwY0B6jgYxryZFcA0OKPNMV25uuQtv9xFNjnjY
         5cZjZ0sOMlTT2B/KOvtt95e3k37u8oSEeVfUGWCf7zNN7ePB52emc9APWrJVTskstIqN
         OdG5uiVHaq7JidTCKUZ4tgglUk0VFYarJu7qdD6RjPlk57pDoxg+8Q1icSjcxFO3IGrm
         V5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733417269; x=1734022069;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2if8mM5m6RF51dq3zBLIXsLK+9+r3yP9FTbjvc8g7uQ=;
        b=dMW0SwvdmqIyWywMZXPzjg1XgERaHZKpZmir2mzvk9x0lWjAtNrX1hmX5IXeEoILLP
         UK8UXHqcx8G6PoTiyRUU7pmkS5XvCJN1mqGDEBkVt7L2YPtq84nzjfvG0NJHWBYVIGBZ
         CApF67i/pWqTyYOo6Ci1Nbxjj/OKwdCc+MqXTfej19nJ3DcpsCndLY8ozxjf8mZA1Zow
         eWtTRmPCDL2yOTdfEMePjDi9fKp7CLCxjX7ahBHXRebrHfa50sX22U/jzw1xqAN3Q/PL
         xi/K8Ku5vuHZA4IAVy2AsbG6RNImfiTOEDuWm9LTzpGdetLhq/+m/CMBDCsdS8Cd6WbA
         Bg0w==
X-Gm-Message-State: AOJu0YzNXus7YWePZpHHwGedE7cVca3VG+Qixsjlbt1p2arasOoJx2a3
	kHzbZ+uED5dcYfJdku5V3VXgReROnqCR0qVGMEYTq39Yw91iQwOFCKSXgg==
X-Gm-Gg: ASbGncvSVoGmKCTOI4V6xHvhXSms6ETs6c4TvRVvgnQxAHj1Iu4+spDCt2Y3SZqelXm
	s+wZ7v3yOu6GiGEv6k/csTPVBzkifNGI5Iz/k+M95TEelHfgcf1bPvCXZ0k3arb4DyLuFJSj23K
	Sycg9gSbNeAlbx2ybPrgG/QYVUKvqtTsfNrHjNOB1ls/Ihqw2sCIm3ZnlX21Gb0ntgN92bA0Bor
	Bo5c+1BPvxqOzUsxzSa6vTEikEazaZ1JDRiEMe5d8baUpKFmXUMTP4=
X-Google-Smtp-Source: AGHT+IHo0DTRVKfxGAhg1tHtJzqHC6PDsRmyBOaImSbK3NAWgh1CLAf+2hU+XCAald+a/Oa9We4QqQ==
X-Received: by 2002:a05:6214:2aa1:b0:6d4:2131:563c with SMTP id 6a1803df08f44-6d8b7387ceamr136076696d6.27.1733417269216;
        Thu, 05 Dec 2024 08:47:49 -0800 (PST)
Received: from [172.17.0.2] ([20.81.46.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8dabfb7afsm8168606d6.109.2024.12.05.08.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 08:47:48 -0800 (PST)
Message-ID: <6751d934.0c0a0220.241109.337d@mx.google.com>
Date: Thu, 05 Dec 2024 08:47:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1100197116891524465=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [v3] Bluetooth: SCO: Add support for 16 bits transparent voice setting
In-Reply-To: <20241205155159.461032-1-frederic.danis@collabora.com>
References: <20241205155159.461032-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1100197116891524465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=915024

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.68 seconds
CheckAllWarning               PASS      27.47 seconds
CheckSparse                   WARNING   30.97 seconds
BuildKernel32                 PASS      24.80 seconds
TestRunnerSetup               PASS      438.49 seconds
TestRunner_l2cap-tester       PASS      20.50 seconds
TestRunner_iso-tester         FAIL      29.48 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        PASS      117.29 seconds
TestRunner_rfcomm-tester      PASS      7.70 seconds
TestRunner_sco-tester         PASS      9.46 seconds
TestRunner_ioctl-tester       PASS      8.05 seconds
TestRunner_mesh-tester        PASS      6.06 seconds
TestRunner_smp-tester         PASS      7.03 seconds
TestRunner_userchan-tester    PASS      5.04 seconds
IncrementalBuild              PENDING   0.84 seconds

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
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 125, Passed: 121 (96.8%), Failed: 0, Not Run: 4
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1100197116891524465==--
