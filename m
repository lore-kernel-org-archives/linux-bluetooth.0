Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD8D13AC1
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 04:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760589465; cv=none; b=cgVQAwZEcCdAfIqE61WsQdGgtXEoRUlcLtaREAVFO0EeE/h4MkRjVGdiLbaFHgOLVwN//sCJj40WII1Bx9RFlamgEpzuglsVTVb/QZMG5fcxnCvLfzBe5kj9QwDqYlg4wW7G3zauz6zsbggkyS6+T/IRhlGHIQlDIxkl84N5CmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760589465; c=relaxed/simple;
	bh=lECOeypc0XfhwJpE/LoMcIG33aU9h48baG1lnbPRnPk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UaWRlDUAaILequgBF47mPcRTBv2sqZFPYrYkKIUKqAi7YpRBROoBQy5+Q5hNXFHpGD6LInEvwUQFVbpEDN0gTUR5qR11H0EoGYUETZIX/MVj5YHGv1p55Ge3hzuCQK3RCGSYCw8svbgZXGd1lRVwD25pNfSAX6wH149pNAR4EUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndWT1bzQ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndWT1bzQ"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-87808473c3bso69586285a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 21:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760589463; x=1761194263; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EDKiybD6tqD2kv/H3ti/ZYmMr4jPRb4aCdSuPEKH34s=;
        b=ndWT1bzQEyCSGXuNiM3ZlSedc67Hbu4NMgf6TSUUoarsJmnxY9tIo1yhKlYeKoqbIT
         2hWqu30bSR3Q0m8Tcl1Uces/69F+ZCh5PWFFiuFNYNU1IyOcvyit0TIcFxLhccNhci8Z
         p9+Qo5OlDshIsT+LrOS8Y2KLWOlGTx9pl44jWoam4sjk7SnbUAHdIXJEvz6z3dbet05H
         nJew7PUJqrELEBzpqv5m9os3lm7zjwg827vRKkWK52Y2JDhExAo5h0SAildEP7/DbU08
         EskxlPtNRE6nWe/qtVrALkHnC61jZwJw0ivCoVTSqowsrCYYxdmuv2I0tRkeK+n6qOYg
         qenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760589463; x=1761194263;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDKiybD6tqD2kv/H3ti/ZYmMr4jPRb4aCdSuPEKH34s=;
        b=GwtIOtnV7WuQ1roiOoB3KoDOAuNTP8yAoAKy4PXD93mzvTZHwZBU26aqH0JhAgcjbB
         SQBUJsD2hJuiUrqNNjcmjTIDAfOdUvMCgoDKB+eRy87BMdEQRG658lykSQ2PJVK73zat
         gWKrbWJHRavkzIGOVPR8h7RyYKeOFaBHXSnVPPlpljmkukeY0OGq+oxJgY/DKL6XJaL2
         UM4VBCpFs8yWtbd0r6bc47pPBG9Wgsewit+I73DZL/cpA3Y/GQGNKfNGi1TbnQtdgW2Z
         psZkHN1B+TLrEV98X/p9kU7q8Iuwvs4kM5CmnGWJbfs3Xo8kNEEOt0/Eb+l2hV/vTNqT
         ENAg==
X-Gm-Message-State: AOJu0Yx+N5imEzlwk6koQn3rof3wKF+UVHik77mF16sOV0FZ4/baQgAd
	4/9v6u/bPLiGYh7nngWSTwAxu/2yYCGxTEzio+L1hn7dLSUgF6eUstG0udOMwA==
X-Gm-Gg: ASbGnctvSQl2FHdbvYFc2K2ASsHZ2PdAsYUHddlv4Kp/Yb4kXxiBUiDWKG0rXsIsG9g
	oY4Hjw2PBlyIqagRs65R5s9Z6gbE+udnm1D9tD8vSZ8uP4hQThpZuLvQr9KgXEnodTFWb0kqhvF
	HZirrXQY6rEyhSq3wpOze7MNiNvW4wDvS30bZHdJvCIdLvmOTVfJxJBUXIFKFeQiOx7guEgrPsE
	tBv73hayYLlQ/u+svPmbd+rMXilKHq3TQ3nOna2R270X1wWW2eios4Il6GP+GQVWaLBMzp9Xuuc
	Lv/XDOB/CdXqwz6vpC9bKWSwq0U5Yf8WShvP+BfTJg3WfeKB2/yK8TZVE2rNrnE83d3tSHeLkBA
	oYS3DziQPuSUnAVTfsxC0JKY1gTdYFvQNxSrn/LHyaukTNsNbLjCPWsvjzjqUDVyi9lopAKzsqw
	pQ7S5IYCDZORnOxJBtiKwIOlmnltQ=
X-Google-Smtp-Source: AGHT+IFF+KRFasIjzVoCTU1udT+9ihlH1ABcEWN3JHaPDeRvaEY8SwJPRhxkddpVkbmSue1obesXnw==
X-Received: by 2002:a05:622a:593:b0:4d3:a453:c503 with SMTP id d75a77b69052e-4e6ead7c972mr458949641cf.84.1760589462687;
        Wed, 15 Oct 2025 21:37:42 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.87.82])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e88c63c8fbsm20367761cf.3.2025.10.15.21.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 21:37:42 -0700 (PDT)
Message-ID: <68f07696.c80a0220.1d0562.6619@mx.google.com>
Date: Wed, 15 Oct 2025 21:37:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3379913203492721458=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Fix event packet loss issue
In-Reply-To: <20251016043043.2582230-1-kiran.k@intel.com>
References: <20251016043043.2582230-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3379913203492721458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1012156

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.32 seconds
CheckAllWarning               PASS      28.24 seconds
CheckSparse                   PASS      31.36 seconds
BuildKernel32                 PASS      25.55 seconds
TestRunnerSetup               PASS      506.24 seconds
TestRunner_l2cap-tester       PASS      24.56 seconds
TestRunner_iso-tester         PASS      80.19 seconds
TestRunner_bnep-tester        PASS      6.32 seconds
TestRunner_mgmt-tester        FAIL      117.96 seconds
TestRunner_rfcomm-tester      PASS      11.16 seconds
TestRunner_sco-tester         PASS      14.53 seconds
TestRunner_ioctl-tester       FAIL      10.42 seconds
TestRunner_mesh-tester        FAIL      12.34 seconds
TestRunner_smp-tester         PASS      8.58 seconds
TestRunner_userchan-tester    PASS      6.53 seconds
IncrementalBuild              PENDING   0.97 seconds

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
Total: 490, Passed: 481 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Pair Device - Legacy Success 1                       Failed       0.199 seconds
Pair Device - Sec Mode 3 Success 1                   Failed       0.169 seconds
Pair Device - Legacy Reject 2                        Failed       0.151 seconds
Read Exp Feature - Success                           Failed       0.110 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.214 seconds
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
Total: 28, Passed: 26 (92.9%), Failed: 2, Not Run: 0

Failed Test Cases
Connection List                                      Failed       1.068 seconds
Connection Info                                      Failed       0.150 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.692 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3379913203492721458==--
