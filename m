Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC990284662
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784573710; cv=none; b=nyC0hEPoMdUd0R6JFbpJf1T8imF6h9a3o+3Yy7dNXY1kOOiQE5pbzaY2QBiUFwn3u6jmiq6v0L+y1f/C6EUVnz91tEvEnlpgcdJ6KJ7ieca73keh2VVzhwcE6U2sul2lq4DUhbKRwcBdhEg0bMn1Ym1yyxTOC5OeVnC+eE9RGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784573710; c=relaxed/simple;
	bh=Qyim09Wvdu168CEmlEvE8KjeWeGxoEtH44eTnw2IIXQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bBOmZurJUnQPCHOAYQW5LuE4Nymsl128TSwD1y64ugqiFmf7FNZNHQgGo89ZULRRpIAIJ0hKGijcBi6cOOZIEhIdCWxeEkBII6d2ZQ5Q00IqTPuJMc3t8ISDKpdVwng0NW19qSblSejwGHDdTReWv/dZCeLNzPlMGBSIeUedAr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUYJIn3Q; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUYJIn3Q"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ee88fce572so81762976d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 11:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784573708; x=1785178508; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EqNBr05kCzjaJuDg9U5+39oEyAvuMQldbZH6pdnaRBI=;
        b=SUYJIn3QHnbxK/xidQ56swbnG+MADCB8duGvvpfZf2geR1w7wVnb9+6F87A1oA0ZJc
         /fcO9xTCRyNt3cQ5v4TxlsOLHZyBWDRdXV5Y33M2iRsp1qI66JSyLs9W6jlRSWwP7KLx
         xXXZDZmDsyn5inHMUGpaxC7Ul7oSJxlpztRG0HFcfVOP3zSPJEmSpB+MiRRbEUPXkqWt
         eBZECSOf2QBIdLPOXM0bukBd1JWKeKZ5LgDFITX/Ehw+rOQy/u9Ocjk1tK3fdjJysO8a
         6RdLulwwj+WQhsl8xs1T+QU5ldINIZcUMAnSd1+uyNWwidZjMO1kugM+w7N6Nm7ncJQU
         7mqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784573708; x=1785178508;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EqNBr05kCzjaJuDg9U5+39oEyAvuMQldbZH6pdnaRBI=;
        b=cDKAPWGG6ighOxW7ChWLRPf2fLWg3zcfMv5kutA/Di303TenPHJYB/Q2Bvx68+oLga
         coXmdCGaqKSDdIZTwbWjW/idFbZ52SXxm224UuSPiCAHgKVJLUmzv3mDCxivaqY7ZZUU
         /JOOOX5OPmGNIa43Aa+qvlgQSCYp6Q5pPMITXMucezhsosCtYAXBZMsQh9nUerTlRG29
         fnl/IEPVCaLDlT2sbhoUacecdeMAe4OTfFUTOrSU6uZOIyTO/bzwuqE2cLY9bdoKKXRU
         qjacLWl8pVAKUJ3QpEdE0CDPhLfVAhWF12zlOjSDSfPhgT8pOyqra7WM0ZTrckiFjP4l
         XAPw==
X-Gm-Message-State: AOJu0YyYMZYxh7OBiJTltLquJH6XufbdXigH6qqinwCRfWie+aPxKkUV
	1vYy9oYjJET48C5sI9xzurnjkIfORtPv/QPIyyXtIMY6PW7XGyva4k7ebhfwgg==
X-Gm-Gg: AfdE7cl5mmTtnBCg99zqq2f63R9SJ9O3E6N3wEGU8ZngEnNTEZZjmDIPlkpi1sfCUah
	0pKHB5/BoN3B+54vafMNgt1n9HO/bB6drgxZztkN3cg6UHlnJwHoWFpPjgfpy9Tuxr75/D2pZRp
	d5we2kMdiJw1BjmjNEeBFERjjt877huV2vhHEGyeaqc45mReJfADOqft9UtPdHDwJUc6qy8jqfz
	9eCV9H9QJOWvwvFh+PAlWEyaV3Y+cl2r+ud6bU4AHMbdnLeJtpHhgyw0HkgkQ4xEbcEg+I0jUdH
	1yKl2QVe1oN2gclPLzIxb1up5tOiFtccOK0TFD6HI6wcX+VRKF/q4gdEucQLR8Gdv3nBXpR4DAc
	W7xomhk8ZaXfuzYJJAzIdLISXG11aIB08I/zObVSN/rbcz04roD0OL8dJUGOw9wkWKD5GO5az4Q
	kgO2jF+PQ5ttA=
X-Received: by 2002:a05:620a:46a4:b0:915:79c8:ec92 with SMTP id af79cd13be357-930b3ecb1ccmr1457533485a.37.1784573707525;
        Mon, 20 Jul 2026 11:55:07 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.253.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52ddbe0sm980047585a.1.2026.07.20.11.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:55:07 -0700 (PDT)
Message-ID: <6a5e6f0b.27211789.391898.c11d@mx.google.com>
Date: Mon, 20 Jul 2026 11:55:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0315828429258882539=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: hci_sync: Fix scan response data UAF
In-Reply-To: <20260720164738.2921802-1-nicoyip.dev@gmail.com>
References: <20260720164738.2921802-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0315828429258882539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1131053

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.83 seconds
CheckAllWarning               PASS      29.18 seconds
CheckSparse                   PASS      28.05 seconds
BuildKernel32                 PASS      26.12 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      494.85 seconds
TestRunner_l2cap-tester       PASS      59.19 seconds
TestRunner_iso-tester         PASS      77.64 seconds
TestRunner_bnep-tester        PASS      19.49 seconds
TestRunner_mgmt-tester        FAIL      209.24 seconds
TestRunner_rfcomm-tester      PASS      25.07 seconds
TestRunner_sco-tester         PASS      31.10 seconds
TestRunner_ioctl-tester       PASS      25.70 seconds
TestRunner_mesh-tester        FAIL      26.02 seconds
TestRunner_smp-tester         PASS      22.95 seconds
TestRunner_userchan-tester    PASS      20.46 seconds
TestRunner_6lowpan-tester     PASS      25.12 seconds
IncrementalBuild              PASS      25.36 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.236 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.584 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/464

---
Regards,
Linux Bluetooth


--===============0315828429258882539==--
