Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D51A1946DA
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057743; cv=none; b=TYQFzz7R5GAznmq4WgG1Cdm+4CBbOnlzUAUHvFm0Dl2EGX4sK+lhiiP8tQo2p4q1uaQcMToFwFt1mzn+p8d251a5YrRNgxLpdIDG2pOeddK0+jsqQzaS10Rr8e0jy4LVddsWmCOBl0+0NnDPuH42QPTP1QeB7O3yQpYM6ZcxJFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057743; c=relaxed/simple;
	bh=NJAoYVxKUcsDEYoOcVS4fHs33jBf7LpYwW3cSm5+MJ0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YdgjJ4eTOkroLm4AK9jyueF6WUSHV2MuYEmJgnPG+rv+9SMLMjK+bsJ2ICfU6y1FclCPrJB+T/XyzaWfRHvIHG8rreemv+0J7gb60sBvx12aGg2uckGJIjSYQ1DJt5pNq3j9qiV7wj8g8H8skBjnxyAUsaCN3CP0gJaBVe7hb2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTdfEs9/; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTdfEs9/"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e5bea4045so108248591cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780057741; x=1780662541; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6M9adQzv95RVs1beIUy4/Gmc7yDO8xxAfLmKOGpTnsk=;
        b=ZTdfEs9/fMsegg7kUwVSzaDnZr4lFU1h/uGRX/L0A3O029YJLBR3chS1xZUxc1k1Gy
         1L28r1Lvagr6NTemJHnFfG5lCMDXmCvGSwj0SoJvi8x+OpkKjnME0WjuE8qI7mg/G4l+
         SUOYghtenm+AofcDN8X6Ah/7zPlsEVBTqU9uHXMjgc7JW5MoEAYUcL6YeIbtJ63hnxi+
         HGLVrVmABjWgItynQLtSynzsiLIkV3k8pfi4YKcZWenEZcZXVr45893M8I3pr9sNId/1
         7DZVeyml8/U1+KK8JpbfHt4L5PQ3FJlw9ToxDRSkPrp5t+DzWkgEppljhfXa1Uy8rb5e
         ZbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780057741; x=1780662541;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6M9adQzv95RVs1beIUy4/Gmc7yDO8xxAfLmKOGpTnsk=;
        b=scHWCkg+Ieu/zKnsZ14Nj+HrrOQQOHDwf3ivjyJu3aljE3G0M5qz3/VVoualR0izhs
         jSGgBuy2hlReEQOSiRJy1RLwpUOvUzkk/8ErKVNmTIlKO3YERW7zCy8offs1qAdhobZf
         agfA4Dcy0Al1LNHf+9gFDXxJCFpGywiotQkFkDzRxujuLVXDZnHrmSiRMI0T5vBGqgfc
         B7Fl7fK+VZYEU/Bdoip1Uw296A233y8dITWQhbq0Fj8Ohjy/W3dY5AE8C1Wqlo0IEizk
         9OsbB+zsokM945NwB8rM2TS/dgQFr+AnRKYHyZv+VbR8oztyiTtYyXJrI6vycDQ1l7v1
         ETNQ==
X-Gm-Message-State: AOJu0Yyl05DyxmEWo/HGJ++MfflmkMyWQsLcNNAxT8ge+UX/XXJ6oGLL
	GHTbitVJSoRX5KGuZifAt5Zz+zQ2wYo0Q7wkKIwHEVT0Z1vbVFu/B/EWOuCcUQ==
X-Gm-Gg: Acq92OGBzKrgdYUsIZjISdjrLrInlZisguiudAySi7WevWMRr/pKBBDR9HPxcyoQpQj
	aLvkOicVA9w9m4bayr9zpq3NcXS9gH6t7EO5bAkFhVtfl/qFXQac4uNmAznwUwWs+Imq0mHWHex
	QLxMEBUJm3G1aOeR49Cyle+CzqPuSuYF2eiT0T+8fYIyI/ovjT+0jfUbmuVNs5gvg4STfS6pDhO
	dIbQpJb4RPyhjhG7mW7K5bCI1N/ibqYnj7X5290q4R6UyeQ4sr+/h/xAeaXL0MYGfOkZvus/xxW
	YZ8NOhxlQcryUlfK2dOUcSRNpHcYpKqtt+muytw+u+TJy4f7vXyQxpdAPGxqvfUPmg/PUalQv7S
	xiJyNICglwvtTUwRvyds67N7iPC/SRvPaLn8w04ZUyrRY90GbSX6WOmcsS3XA09mAbAsFrliVk4
	RC4Ytd91QNApqbY4gpGHJJv859dFfk4t8LP4cWfYQ=
X-Received: by 2002:a05:622a:2a14:b0:510:1b61:d103 with SMTP id d75a77b69052e-5172dd1c8e6mr29231311cf.36.1780057741135;
        Fri, 29 May 2026 05:29:01 -0700 (PDT)
Received: from [172.17.0.2] ([9.234.151.19])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5172e9a5158sm20937001cf.2.2026.05.29.05.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 05:29:00 -0700 (PDT)
Message-ID: <6a19868c.d9dd1dc9.10cdc0.d453@mx.google.com>
Date: Fri, 29 May 2026 05:29:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0291735375615022321=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, n05ec@lzu.edu.cn
Subject: RE: [1/1] Bluetooth: hci_sync: reject oversized Broadcast Announcement prepend
In-Reply-To: <9089784d08f1afd038b4ce0df1fb89904f4879ee.1779634468.git.xuyq21@lenovo.com>
References: <9089784d08f1afd038b4ce0df1fb89904f4879ee.1779634468.git.xuyq21@lenovo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0291735375615022321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1102742

---Test result---

Test Summary:
CheckPatch                    FAIL      0.73 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.45 seconds
CheckAllWarning               PASS      28.02 seconds
CheckSparse                   PASS      26.96 seconds
BuildKernel32                 PASS      24.84 seconds
TestRunnerSetup               PASS      525.00 seconds
TestRunner_l2cap-tester       PASS      58.33 seconds
TestRunner_iso-tester         PASS      78.65 seconds
TestRunner_bnep-tester        PASS      18.91 seconds
TestRunner_mgmt-tester        FAIL      209.39 seconds
TestRunner_rfcomm-tester      PASS      25.43 seconds
TestRunner_sco-tester         PASS      32.59 seconds
TestRunner_ioctl-tester       PASS      25.65 seconds
TestRunner_mesh-tester        FAIL      26.60 seconds
TestRunner_smp-tester         PASS      23.35 seconds
TestRunner_userchan-tester    PASS      19.80 seconds
TestRunner_6lowpan-tester     PASS      22.87 seconds
IncrementalBuild              PASS      23.48 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/1] Bluetooth: hci_sync: reject oversized Broadcast Announcement prepend
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#89: 
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#90: 
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#91: 
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4

total: 0 errors, 3 warnings, 0 checks, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14600598.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.238 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.580 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/254

---
Regards,
Linux Bluetooth


--===============0291735375615022321==--
