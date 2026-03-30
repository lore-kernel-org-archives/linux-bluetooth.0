Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070953B5851
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865766; cv=none; b=EQ7Vkz/lfzR0fSh4d1qXluJT2JaM37u5PsGz6QX9dBm5Fdeqj7ygwOAtlToxQVnsD3ATHRTCrFO60KXgKHyjiw3ooaE+rwh6IPdKvdmsNEntYov5QsSXVcQksKyFhS3AmcVJxvErdpSKnFRoBqkYvh6en4T6F3ckPzLdIbY6m3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865766; c=relaxed/simple;
	bh=s6Rs78s7QHBIbnQquYSseTkdkvUx3NGX1MkYm5hbNwY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gfRPnaehYmUj1g8W+xZ6sHPst29P900JOVk17s+i9M9Q9TXeHHBHC0AuJ/zmzpbkBQmOqjGn9XQ0HeASjOT1LfpFrr1uhmcAOtvMBzRt0Rsugb9lpoGn27Qn/ec6BTWjRwbe6TPSLxtUOWxFOsdm81LUi1oVm43UQzNU+IEll0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elrWvIoH; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elrWvIoH"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899a5db525cso35162366d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 03:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774865764; x=1775470564; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d5Ip9M9I7ZaUs0wFBQHgwpjrmCyZChCOA0gQFVE6ge8=;
        b=elrWvIoHv/wby1t0Yec1UBw+QfX6g60tJMKDmtm1yT+1xAGcvxOio3TT1RCcTjEYgu
         KuBE+Juh4wcI5yrG3k3I9SjMqkwJU3vQW0j1bCCkN/y+7/b1eK3K3G5XADRGsKhdQRPd
         ZXNtIy9ibgP7W8LOFNeXZPan/ShWZuANNJ1LSXQ2z39n2QkPZ4fnYjJvVnSCUFAgcOic
         kvMCNkO6pT+8jCvXFYY08zRLvW+aAP/rqiepOMH7/XBKExMBZNJZvVHr0thPdmSQ0m33
         KcTO2w4kBEPM4AprRYCxVnCGnphD7tVou0xAETs/4Ga2mRFUIoIRv8OBLIG792qT7m/j
         vxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774865764; x=1775470564;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5Ip9M9I7ZaUs0wFBQHgwpjrmCyZChCOA0gQFVE6ge8=;
        b=Bc0FivudUaEW5hScyk8F5ON1/9WbQgcITjrWFc8/Uta63AtCd2IbokQruU1IMX+K9U
         VkdlMubJrGbQKpewRECmufZiv8PffZrGkEmYw9ExaQRYAsAG+zOjZriVlLxDumbqI0Ss
         nOsLHyGewH3jHsPgetqEPS9C20LqG9pNwkNt3nk3FVOGXFkKEi+R/5l6Q9U8knU96pgv
         m51qCx7Kw7JeMw0DUafIPM15tv0/nEuazJHlQcspYSTbH9UFtQwNR39SvcvUbiQOA3K/
         Z4Hn4xXTAdrAqNXLan4v/y70VZOOz41BzXxiUwaGOukmsqA5OkEj97P1lqH4S8oznI5P
         IvrQ==
X-Gm-Message-State: AOJu0Yz9xLfFnmd5x9olWNG0Ci29SB8224IgimJAGzKnE2Hr6WGgLp/0
	Q107GoIjjkxkC3dqGyJXHEHYdJLbQe5acjWdjUNIAaRZOG+UxrDxSfU4YyljMA==
X-Gm-Gg: ATEYQzyri/CpSQeMOCWgjRuF/RasNqFlnAbq2pvgyMpUCo/bxm5VghcdNLGW/SrBnpN
	hYJzep2kfJy10tHPCEMjtDMzRqa2V7ofKG8EYGzebqYPGgnrHSxl5WR3xvgDG/HbbvQ1RAnTGFm
	d5m/eDjU/vnWYC554dN4kEtPbABQw3vusgRmrKKuNjk8D6/ge/J/jgdaURG5GruMLb6XHSNKGuy
	FfiaDq+B66R4J+tVdY2SSYV3ANCHszrnxB6NsJxyR1XsYCvzu94SZFxARGH3TFxAGVthuLXIKQT
	EWv6SdgvjuBIE53ZMHTe61xs44ODUI5WcjZYR2HEbfpBp9lPKCm/gYL0baU2zQPM2aoldCjXEFr
	HS20JcuNOveM+GTB/KV6UE530//84gXQsXwfyPUG/N+IG8ShU2OXB0Ov90lRuCBpG83qoWQS6R+
	wXM6tM0RyQa3IXmUALvvv/KmV7Y1C+
X-Received: by 2002:a0c:f08c:0:b0:89f:2fa:a9b6 with SMTP id 6a1803df08f44-89f02fab135mr94812676d6.37.1774865763692;
        Mon, 30 Mar 2026 03:16:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.28.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ed03333c7sm58260266d6.47.2026.03.30.03.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:16:03 -0700 (PDT)
Message-ID: <69ca4d63.d40a0220.138193.4eee@mx.google.com>
Date: Mon, 30 Mar 2026 03:16:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3143537221408914808=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan@kernel.org
Subject: RE: Bluetooth: refactor endpoint lookup
In-Reply-To: <20260330094134.1622788-2-johan@kernel.org>
References: <20260330094134.1622788-2-johan@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3143537221408914808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074462

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.40 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      26.62 seconds
CheckAllWarning               PASS      29.36 seconds
CheckSparse                   PASS      28.29 seconds
BuildKernel32                 PASS      25.82 seconds
TestRunnerSetup               PASS      568.19 seconds
TestRunner_l2cap-tester       PASS      28.30 seconds
TestRunner_iso-tester         PASS      38.29 seconds
TestRunner_bnep-tester        PASS      6.37 seconds
TestRunner_mgmt-tester        FAIL      112.29 seconds
TestRunner_rfcomm-tester      PASS      9.41 seconds
TestRunner_sco-tester         FAIL      14.48 seconds
TestRunner_ioctl-tester       PASS      10.29 seconds
TestRunner_mesh-tester        FAIL      12.47 seconds
TestRunner_smp-tester         PASS      8.68 seconds
TestRunner_userchan-tester    PASS      6.72 seconds
IncrementalBuild              PENDING   0.93 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 485 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Adv. connectable & connected (central) - Success     Failed       0.136 seconds
Adv. non-connectable & connected (central) - Success Failed       0.134 seconds
Ext Adv. connectable & connected (central)           Failed       0.172 seconds
Ext Adv. non-connectable & connected (central)       Failed       0.179 seconds
Read Exp Feature - Success                           Failed       0.105 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.683 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3143537221408914808==--
