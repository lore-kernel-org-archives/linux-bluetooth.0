Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883B72F8EBB
	for <linux-bluetooth@vger.kernel.org>; Sun, 16 Aug 2026 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786878960; cv=none; b=XxzE9B43gidEO48MEHgRlYWXHATMlRoPVPYVMMRL7edYPdnFvVZsrhkFn5iBrFP3nSg1HgB4mF8ea68AwPlS5knhKsnhmzhGTEX0QlnpTk08YvCSN6/QUCbhu7HFkgp5WxHrhsLARBiScNT9XEK13JzyHyuI6FwSduQgTUqsybY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786878960; c=relaxed/simple;
	bh=cBsUgZXRsj5yt06glmdomALo0hr54Yv8ikDJCqhZVf0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=V910kIfjilrSBWlq9GJFBUK3Begpfso9eglTvfhuVEuG6dWH3ANSkcLlEY7NEWBznf7JZP8HTpja8McPfDuSePJ3S8/RUkL4AvHGUdXMkRDLYcqTV0oeEe0I/BkPS+WzOcpcL/FvZvNZtv6/Xh5CLHKL+bO/vjBDGOI7XWUJSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbN4X0vf; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbN4X0vf"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-9030f8ea3b3so21670476d6.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Aug 2026 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786878958; x=1787483758; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=51UfuI8iE2iNqvvo3Kz19XszGE3P24V7oSvyov2DlsY=;
        b=nbN4X0vfohhK25v3nyYtg6VsyjjgjCzQz1uGytZf4NkEj4Igf3NsxI5VLm+8nib/9h
         kiBoWvWsxORw9p7mRF+8tjlTrXcbBS813lebd8kvJyU3yHvQMjsOMGxZC5MhDYc+cIGQ
         D4yqJyQH8l53TnuroC4VJIf5OSJ9QQFIkouPmVBFw5UawmTaW6yVF49ttlba3dEo7vPY
         AHd+fmc9CrgCPQ8CQ5FeWJ2AlwZ3jhWY6gOHT/VLjnjba2Rl7gl0vcuB/Yi7mY0KDU0U
         vzCUl6WKBfohOA+cDmt8PION9VXiYplquQw8EUSoyL/JARL6mFTdX0NDVUfXTsZlO03b
         z4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786878958; x=1787483758;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=51UfuI8iE2iNqvvo3Kz19XszGE3P24V7oSvyov2DlsY=;
        b=LwSVnf/hAwLbQEuibCU9V4N9GK4l5Hwdhtjf7AZm30YYO97UMQjnXcVpxe+gvh26GY
         VA/2hd/eCMU1t4tKMnif0zGkYrjGVN75qFOwwAcx9/F3l/AZ3QMu/EsW2JqKNMRSozf4
         nj+4eufIixAcH0gxz22yUvyMDjptN08vy0QVgaWgWeXLWaQD1nR7XZDpBcLaYi6fIH6r
         YwNOHgkgqec5FSG0mSfvJ80LijrkLbo8s9Axo5MtWO0dvtXELL1A1BdRO5+4MbBT0QRI
         PV3Tgu3/k9n4G+LvePPYGRjA/7zcL1YN4XHERlnwef7kStL0N7sgoxJ8xL0xZIOZgALA
         WQ6w==
X-Gm-Message-State: AOJu0Yyp8FZNWSInAj6r/MpYXaJVZ30EVAaYmS4V2LWA/Nhw7a7aFT5u
	dA+BlzIZNPvkOHIEaBZxu1xmpIOl7v73hlkEm25rNsmmCAZlYloA/Oo4pIQhNQ==
X-Gm-Gg: AR+sD13SJnf35wVqlr0qe+M9TBzsedzMTtu+MJu6wN+WQzmVbuVlF7IAXI4xso4LUDn
	jqLiu8VaSqUVG35aah09eR2BOh88lHae2+8W8J/ViCcFUOyL9SGQM2sL2z6BElLSQq9MDkrePq7
	qLn9Jve4c02HDYE3TZSVGnSxTAY/hNhIFZoErv2489cjjgXulEfNxfOAh//8EIIjta8YhqHw0n1
	PVFawSVn2DZ061RAKnHs1qimdIwYNFy8g9oUD+xcv9m/riNwsvOSn45BAmgxoMC8jvUqaurxjPO
	TA0hc5JKr9DBhc8y5hzzxq1M/1rTJ9HUzXIYoaDoMRNtv+VSTfst839AYfxDS/GIik6BFbwJbDt
	N5Ih9QjApKNj/V6IADkoAfFiX1qK64Oi0u1wDVle6nwvbR2JmX2SPiaQ9G0ZhBcteKcGaE3pLeu
	GVCAUH5t3jtvoK0REmMkmid/u1ErKlclhUxAn9ccn+1CXCiqOEYIJoEjdPZu8bHpaT9Pur
X-Received: by 2002:a05:6214:2f82:b0:908:8f6e:52be with SMTP id 6a1803df08f44-90a91de299amr245397806d6.15.1786878958435;
        Sun, 16 Aug 2026 04:15:58 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.126.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935925b4sm57958156d6.43.2026.08.16.04.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 04:15:57 -0700 (PDT)
Message-ID: <6a819bed.0a531e61.8306b.6a25@mx.google.com>
Date: Sun, 16 Aug 2026 04:15:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5774172274336788049=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [RESEND] Bluetooth: hci_core: add lockdep check to hci_conn lookups
In-Reply-To: <2be38d111362590f45776a0bc114f7890906ead9.1786875148.git.pav@iki.fi>
References: <2be38d111362590f45776a0bc114f7890906ead9.1786875148.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5774172274336788049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146718

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.27 seconds
BuildKernel                   PASS      27.43 seconds
CheckAllWarning               PASS      30.53 seconds
CheckSparse                   PASS      29.28 seconds
BuildKernel32                 PASS      26.86 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      508.42 seconds
TestRunner_l2cap-tester       PASS      66.05 seconds
TestRunner_iso-tester         PASS      83.58 seconds
TestRunner_bnep-tester        PASS      19.20 seconds
TestRunner_mgmt-tester        FAIL      225.44 seconds
TestRunner_rfcomm-tester      PASS      26.55 seconds
TestRunner_sco-tester         PASS      32.08 seconds
TestRunner_ioctl-tester       PASS      26.68 seconds
TestRunner_mesh-tester        FAIL      25.95 seconds
TestRunner_smp-tester         PASS      23.70 seconds
TestRunner_userchan-tester    PASS      20.34 seconds
TestRunner_6lowpan-tester     PASS      24.08 seconds
IncrementalBuild              PASS      25.72 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.252 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.920 seconds
Mesh - Send cancel - 2                               Timed out    1.981 seconds


https://github.com/bluez/bluetooth-next/pull/593

---
Regards,
Linux Bluetooth


--===============5774172274336788049==--
