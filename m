Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704F95921F4
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067048; cv=none; b=XTBWEmkD7X7SVZttJpyabcK3CyjWABeoMCjF0ZC+Hhl/DdOCbG180xEXCtzTXzbPRB1+MD1ikGuTmq0fdloXuyOGqPq7SBrAi5FWxlvl1sMlgERp9XHUT58PBxIJg07l+A0qJ7eLNUNfv66/6C1iSrYRjBcY7+2Rnql+wthliH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067048; c=relaxed/simple;
	bh=A1ra1/z4ILDTPw4eE0v6T+86BB0+v3Q7zDXQXXvpTKg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GCCOgMEkdNHmWqxogUNWEf1LMLufUtTE6MTEmVS4dA5DwGOkXqNV6GOtQ4IkaSVzY8JB2GzJE8XtvS2lO97dpjXMJbvLIYlZG+uwYvip2b1HX37PFueHoBe666PRCgHSTD5eEo5n5wz80N8kTMWvvBplotos6mVkUcxCM1bmwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLRLUDvx; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLRLUDvx"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-398e9698a70so98431a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 12:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789067045; x=1789671845; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zeZq4zoesUdpI3bvY9tGs/WqtAC1IM6tB1BXgnWPquY=;
        b=FLRLUDvxlo3xjJAkLuuXzhXMYIG0LFzZPkB07JrXIEtre3IgbFuFIuiWvRhIFRawNi
         qU0Jhlt5S1WOVihSoJQIvlWDzKxcIxVRD90JLVcihU0Vq3P4wXR4zU3FbqxCOOsti5lM
         P8pKZiarrMEsVIOdbLEux+bo8PZ03RLmNlgWsrh7WYjUa2tEWepEqMz4s9a2EhkdjxEg
         mFHmSlqO7nXJ0lW+o0dtcpKOrgsbIlp4dUyRW4V22gHjWOtr4oUC/YhLbjjdUmh9B8WC
         IidDBrq2T2vphMMdzkNSkKeQZf0/i04YLy8Rl0Phibl1a4+DFaB9BlhA8Hd/Yd4EmDbR
         a/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789067045; x=1789671845;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zeZq4zoesUdpI3bvY9tGs/WqtAC1IM6tB1BXgnWPquY=;
        b=S8nCMdNZ8jUOcycBMBcIpjYqNfgCRN5N3fC5lR4Zw5FnuOdqFeC2uaNYdxgE3Z6Hj+
         zZ2GWpicWfHvQ2ZgY2hKnlcabnQaVshNepbC1NT/jO23SqBSgZ3C0L2pwKdgeY9btDmX
         LOBBLniSkMJL0MxlzBvdes9Qs6jch793+boqy9biUNl3eRexE4uetAIeTUjI+TcFR/NK
         C+yqJOI4NF2TpANdR+L0igBfaKvXw0i+tdCIyzwsQ8b450132ChyVsVteinItM+3VXlo
         TMyWBVs2Gtfia8bWMNOw9mZbcdO3LHFM6L1xFErUxZ3wugqB29j5CqFXG2TYHLmFOcUc
         Cbvw==
X-Gm-Message-State: AFuF++lsjIKf8b/KRdg3zDSuyC43gq7goLhetJPFtFSl4nPqlCEL44BQ
	u4KtEnvInlhy8tAVnde8qzMvz9+Lx86bXwear5Ge2aAYeHxrtAwU1m92vAX1WQ==
X-Gm-Gg: AYBFou20Y/Sfcu8TKsUReXgCiaY130QLkDcJobInlBzE0BdZFyoh1blwBsMptD3taqE
	puqt/c5jw5xB0NRKUbX3bsvvLAgr5bETlKCju5LzNbmGBhvj+Gb72yMpG94ywuGKCJfCA37tt8W
	7ZeYQYXrxx5whc5rCEHKnLlQo06dHXBEcWI7+si+z/HXcTA/XhP0UNqBCjP63T8mzM6AzpFPclX
	O8HtRVaCTXNSAnDjpciiIrRM+E0ka5ARW91itfwL6yEAqqaDy2hqvNSKRb54pnKGdSqDD+V6fsF
	W4sInwMxLlxiN/U/vOUtQgplxgbTJWeWDFTcCHaVsdM4U0FiNtm924ELVjt6LzM/Ml/JstQFiF4
	rLDrFqfejD7ZUHliBl0+6t7U4iXqi61VvdN4gh9263fMKWEUszoqWpcC5zFo3cdSS1cMg7BUYcI
	aQJXK2+AHQOGjVV7+lgEaLiz9iOiYnYVEJqI7GqfqE/5lFS4LQ7oOXDrmRA9J7aUxFleJeWt18c
	1Ty
X-Received: by 2002:a17:90b:2b43:b0:398:a2a3:b631 with SMTP id 98e67ed59e1d1-39d9c21f8c9mr160942a91.19.1789067045403;
        Thu, 10 Sep 2026 12:04:05 -0700 (PDT)
Received: from [172.17.0.2] ([4.155.99.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94744dfdsm986305a91.0.2026.09.10.12.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:04:04 -0700 (PDT)
Message-ID: <6aa2ff24.8f0cbdd2.15d40d.b644@mx.google.com>
Date: Thu, 10 Sep 2026 12:04:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8175529253838636034=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lidaoxun25@mails.ucas.ac.cn
Subject: RE: [RFC,bluetooth-next] Bluetooth: hci_event: Use General Bonding for ATS2851
In-Reply-To: <20260820140547.1148128-1-lidaoxun25@mails.ucas.ac.cn>
References: <20260820140547.1148128-1-lidaoxun25@mails.ucas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8175529253838636034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1149156/

---Test result---

Test Summary:
CheckPatch                    PASS      0.95 seconds
VerifyFixes                   PASS      0.05 seconds
VerifySignedoff               PASS      0.05 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      29.31 seconds
CheckAllWarning               PASS      33.12 seconds
CheckSparse                   WARNING   35.81 seconds
BuildKernel32                 PASS      28.48 seconds
CheckKernelLLVM               PASS      34.06 seconds
TestRunnerSetup               PASS      768.63 seconds
TestRunner_l2cap-tester       PASS      43.81 seconds
TestRunner_iso-tester         PASS      90.08 seconds
TestRunner_bnep-tester        PASS      13.12 seconds
TestRunner_mgmt-tester        FAIL      146.72 seconds
TestRunner_rfcomm-tester      PASS      16.81 seconds
TestRunner_sco-tester         PASS      22.33 seconds
TestRunner_ioctl-tester       PASS      17.92 seconds
TestRunner_mesh-tester        FAIL      18.73 seconds
TestRunner_smp-tester         PASS      15.48 seconds
TestRunner_userchan-tester    PASS      13.10 seconds
TestRunner_6lowpan-tester     PASS      16.01 seconds
IncrementalBuild              PASS      27.04 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.148 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.385 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds


https://github.com/bluez/bluetooth-next/pull/738

---
Regards,
Linux Bluetooth


--===============8175529253838636034==--
