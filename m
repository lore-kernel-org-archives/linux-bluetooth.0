Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC01DFD96
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774484380; cv=none; b=p0ZlsVmyD1Qxp2VWzO3Ljg7g5ZUUVI5Z6Y8ZTMCTei77vmWt4oSTfcn1PKpqPLze+49/ox3NzBGHtUE9YTVlQk2pK4Qq1DtnK0Sxm7kvW6G33LEX2KsPT2h7ZXB2MN7vHleKT2C5A33YlY9jADcsUZV/gSHOS+ubQppZQgaDqNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774484380; c=relaxed/simple;
	bh=hmV5NJxkI+sXhJY572Iiroo6P0iGs40ESMZAX71smG4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=W400HYrOa82rtyymNigb3b6eMsregrWQPMz2cKECmaY6vERyjmEjuH2xYgZ9T8fFCercNNBRqXnU26Wv99YNvvOhS7OuPPYPN9DRO0dyE2kIGTkzfJZrUM7rnReyam9HzGg7KFiQq2NgE0mN0rItExqILfdhI5anUJc6p34GqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nay8OWrL; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nay8OWrL"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50b2ebca625so3193811cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 17:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774484377; x=1775089177; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q6xc7UxzMxCp+L8D5OCdfdGn47XlXMsJvhhg0VkF8Pc=;
        b=Nay8OWrL/SL3vUUPb61k/nmxg18XZjYFpVLvWK6k64WTBDnuobeERpb9AgQLXje1rW
         SjmnEEdI8lOkI3Fa6ylkG5kPhZYXBThfPtwmCiJmGrfAhy7H18cXH+XyM4CmThhOXi3X
         yMZ6ByYyTtmhbgdgTSY1a87E34mDS3rLZyj1yczooc9tC5xotFRDJfcerssFvvmyZZMU
         FB9PSGS9Lr0pbdcuM5O61Jkkt95ekJaHjckFakfP4ff80R4uX4upBZCp/l4ve043sNqE
         G6GscTdkO/fSYzSkHmeANzM/L30bWPeBpDVhBgWkOOYTfQtSsRdlZ9JoBS34pb47CEpQ
         9/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774484377; x=1775089177;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6xc7UxzMxCp+L8D5OCdfdGn47XlXMsJvhhg0VkF8Pc=;
        b=AR75nnaLKPS00IZqJslfAv00xTbtnwuWCLwZyNsjpc+m0dgug13MMlsTtcWy5GJ0DE
         wKDHgbFT3AakWl58OdYV7x5goo9XmiekUM0EJ4ulMIYgnbFI/5SXlHn2bUk7Rm5wmcEF
         MvfK/eBcBkzL2oOPFBE6/UzqKwCT1afL9bhtILdGgrb9y7CWzrIgIDjmFjuzUZjxRIVu
         DRSmtdlTEepeyo6HI3hCBgZy3HviBP3TN+eCBq6q5mdjzWgCc3YourWzLXsyJVmcEopM
         Gc/l0jLGeSEj+1Ht7xy0ePjpE/QIOA5zOzm5iswlDboXeOQ0SUhEO4tPLXwZSofz7fR0
         oYEQ==
X-Gm-Message-State: AOJu0Yw/owwSLU30pahHsPqgVeTMtIrHwIOBSDSvhgxFUPdBuHbA0sER
	EVhy95rHR7NFT3c7QDoDgjbyt0YcIoX/vSgSggb3f1wYRfvjbtiF4DurLtdk4A==
X-Gm-Gg: ATEYQzwNoGh+7TOcFLF0sReboEzlyxTc9GATJ251VLvX4CMgtbQx1VTI9KWtl9FBovz
	rzMyq8upk39Lg94/g6meuXjGVhKbRViZNMzOg+993krdZ3y0eI6qLSuzI/SLSPppZ42CRh15ZFb
	SfUzAhqhGUeOqx5Xr2ijNLA+rNKowdeU3/IdnGygHdROfJs702HhS0lRPkgg+jT2bUIvXzVZKRI
	69ubZWyp7g2MX6hffZgXiAsJc2gUh8/IsDFjAZ8GzWOHOD2agpwEaTpMQVPhqY0TmV0HXdYjYfP
	BMqZ3U3OJUvsF3jaeuuppvhI9YQ2yg3YGhQnunB9Zl9Knt0D/d4dplhCEUafS2PI5wrVEAP5Tsp
	OBW2fK/MpReUH/Fb5naL5/Wrf1E2mqy1LVNP/o9a/Qu6Y3vUD3U0OGpjlsxUO34cJSDCrthNoag
	/T0RlkNYyKkqE0YU3H1GIzQ4lNo+MTx70=
X-Received: by 2002:a05:622a:5913:b0:509:2135:ed59 with SMTP id d75a77b69052e-50b808e24bbmr71305831cf.36.1774484377343;
        Wed, 25 Mar 2026 17:19:37 -0700 (PDT)
Received: from [172.17.0.2] ([172.171.254.149])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b9234e1dbsm10601641cf.18.2026.03.25.17.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 17:19:37 -0700 (PDT)
Message-ID: <69c47b99.050a0220.397eef.4d2c@mx.google.com>
Date: Wed, 25 Mar 2026 17:19:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8689224001804463429=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, floss@jetm.me
Subject: RE: Bluetooth: Add MediaTek MT7927 (MT6639) support
In-Reply-To: <20260325-mt7927-bt-support-v2-1-b892a3252880@jetm.me>
References: <20260325-mt7927-bt-support-v2-1-b892a3252880@jetm.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8689224001804463429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1072604

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.94 seconds
BuildKernel                   PASS      26.23 seconds
CheckAllWarning               PASS      28.82 seconds
CheckSparse                   PASS      28.82 seconds
BuildKernel32                 PASS      25.62 seconds
TestRunnerSetup               PASS      566.89 seconds
TestRunner_l2cap-tester       PASS      27.97 seconds
TestRunner_iso-tester         FAIL      31.99 seconds
TestRunner_bnep-tester        PASS      6.26 seconds
TestRunner_mgmt-tester        FAIL      117.55 seconds
TestRunner_rfcomm-tester      PASS      9.47 seconds
TestRunner_sco-tester         FAIL      14.20 seconds
TestRunner_ioctl-tester       PASS      10.32 seconds
TestRunner_mesh-tester        FAIL      11.41 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      6.65 seconds
IncrementalBuild              PENDING   0.52 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
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
Mesh - Send cancel - 1                               Timed out    1.858 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8689224001804463429==--
