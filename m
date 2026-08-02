Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E4263C8F
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785657852; cv=none; b=NhihD2zqpSjGGgiAzt+pJqfUFlpc/OiLMbUoQLDVS1QTbmwnNBm1TVEQuRj2o731BJGMcJxZZtWY5zqdhHBf9Iyq9KDDmQv2cm1y9TKJLUKsvP2l2N4Af7iJzMvKxMe3hRN/VM2XiGtnb3ieS02hENHi0Xc0YZIUXv5AsKLSET8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785657852; c=relaxed/simple;
	bh=G/ynQ1pTOmCjfi8VSnFiILHx9+NkGAxSw3D1HkHYqdE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XPGR8ZKsTJpYDvvHpQWoyVPgZwy0711w2UMOA2ULXtKZT1adg7YLg7Epy3B3eubJo+UbDRvEs4sPQVX6sfMRB5Bn/CtEuqJeE9NxAisXhppQQJomSClp4Ak4SjoxFN9HYKc3h517EtIFI9Hgs4a+v/Yb3gUG0JiIDKjeqicLl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lxo8pjmO; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxo8pjmO"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52b6543169fso2942991cf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2026 01:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785657850; x=1786262650; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=96/OpAIM2FPKNehXp/Cf2XHQYXHFzRVHBsAp5PKp9mM=;
        b=Lxo8pjmOl8w/iEZjamgg/gKkrfBezqsug3JebP4dTmwq40Sc3DkVBj9HxIFqAAjVrY
         lThNY7uaYbBw7kCaRk+rOhtWjOOt8M4vhKgURSUgT+GaeZ3aPwQZp7Iwmy0AUk9xYM5Q
         I2a6RJ5M1LwH1DXgZfvGBIAt14E0Tfonta8HmWrbWD1h8P+sm76cxpkqyZf9UGJROEBQ
         /jTHNfYeCm3+RUi5fq8TLwCgqdB+tNUnubFH5ateGpZKm317pifZVGHIvNJ/ViwBB9Sk
         VzN2h8w5EYFEvLata6QSkQFjwGUw6ySyjnTq6XyWB1TA4w4G/U13QVzaxLsJ4nhse5Gx
         tXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785657850; x=1786262650;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=96/OpAIM2FPKNehXp/Cf2XHQYXHFzRVHBsAp5PKp9mM=;
        b=Ax7ghsE5RP0lPJsvbFxPQ8xIbXinKAsuKIbxmE28KN5cpn6li2+NEynCiOrW8B1bzP
         Qrpl5XpsitRxZXtVmJj4E0rTa52vmlUOV44AoQhQOtdQGrCVc/NmlVCF5z3K6lVb5lXd
         I3gsh/ju8Tk+8cFTGsJ8ZugQrNyE3k/dsA26hIzjgmzXle43QcqKDSVGNi5V81coADxA
         GOYRw8AdPSe8cSfKxjq49c79ncKe1TdxZC2N4IYTAQLWs7unj0+M4e/5a2v7m2BGPEEk
         nAQnGe/gUQ1OtLtu+w7DLdiOhFks7/OOvDZpQJJ6sjcnvy/QstI296is4ichIWlirtNX
         U61g==
X-Gm-Message-State: AOJu0Yxtq67PeGsWHsSllakFyE7OMPhpnyM12iZ0Whgb+p/4R7Yy6QgG
	yb/rcx8ZcEgNPaOV34uRdvgYwCaO+fFrgjGD1l4u2GqA3FKFio5mUZM7CPegfQ==
X-Gm-Gg: AR+sD10Wdr3GbKz/+NjsBZS3dAfGbo21d18xhJvV6FOgodnMjcbN4zJw43YuyjKbx6c
	gbaELJulaLN1p0ySCL+eZ+SHXSBVJRWNJUKIZu5ocnM+PooRvZrfju3NsaNau3n37Uo4gmKP10n
	dc1wNy8eiDBdt5ehdDyBGldF89Q7RYbiWaQNdpduhc5PpRNw9Onwe6POtzygqxnDr4gK3nvXAVQ
	jacyVSiz96xqyZhrvAqb7jBEVJYHRuUiORfy8zYPSJJs+oXFxa5Mjnw0EGa2iXfNkmHuzVb2drP
	YC91VEf7Ldb6UuGdlVY62LusWXixmXEXnuLrcBk2sjAUU9krI7eBQRX/ihDvpYoJsi1zoYhL2Us
	SaBqJZ/diW8ejlm4PImThj2YNf2xZf2uz5PpS84r3+gXmDzQ+OBafadMT9M3k4I2ArI4md3ienB
	csOCC+6bIkZZ/I4WWfKi63quOuK7PpYx0z0yqa/o6iXmlcJa53YIWdb5eNPrWNEUchpi3B/0Uqw
	UM=
X-Received: by 2002:a05:620a:8812:b0:930:a635:a76f with SMTP id af79cd13be357-934a0aafd36mr1160181185a.44.1785657849709;
        Sun, 02 Aug 2026 01:04:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.9.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349bc252d8sm420816185a.8.2026.08.02.01.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 01:04:09 -0700 (PDT)
Message-ID: <6a6ef9f9.1fd19957.57fa9.95fe@mx.google.com>
Date: Sun, 02 Aug 2026 01:04:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6392578163458664120=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: Miscellaneous fixes and cleanups
In-Reply-To: <20260801-generic_fix-v3-1-efdd8dcf3430@oss.qualcomm.com>
References: <20260801-generic_fix-v3-1-efdd8dcf3430@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6392578163458664120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1138830

---Test result---

Test Summary:
CheckPatch                    PASS      5.70 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      2.23 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      27.00 seconds
CheckAllWarning               PASS      30.10 seconds
CheckSparse                   PASS      29.11 seconds
BuildKernel32                 PASS      26.19 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      496.41 seconds
TestRunner_l2cap-tester       PASS      63.07 seconds
TestRunner_iso-tester         PASS      87.34 seconds
TestRunner_bnep-tester        PASS      19.34 seconds
TestRunner_mgmt-tester        FAIL      220.71 seconds
TestRunner_rfcomm-tester      PASS      26.15 seconds
TestRunner_sco-tester         PASS      36.98 seconds
TestRunner_ioctl-tester       PASS      27.46 seconds
TestRunner_mesh-tester        FAIL      26.94 seconds
TestRunner_smp-tester         PASS      23.73 seconds
TestRunner_userchan-tester    PASS      20.53 seconds
TestRunner_6lowpan-tester     PASS      23.56 seconds
IncrementalBuild              PASS      101.77 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,2/7] Bluetooth: btintel: Remove redundant (hdr->plen > 0) in btintel_recv_event()

1: T1 Title exceeds max length (85>80): "[v3,2/7] Bluetooth: btintel: Remove redundant (hdr->plen > 0) in btintel_recv_event()"
[v3,4/7] Bluetooth: hci_core: Introduce __hci_reset_dev() with a hardware error code

1: T1 Title exceeds max length (84>80): "[v3,4/7] Bluetooth: hci_core: Introduce __hci_reset_dev() with a hardware error code"
[v3,7/7] Bluetooth: hci_event: Use 255 as max event payload length in hci_ev_table[]

1: T1 Title exceeds max length (84>80): "[v3,7/7] Bluetooth: hci_event: Use 255 as max event payload length in hci_ev_table[]"
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
Read Exp Feature - Success                           Failed       0.245 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.491 seconds
Mesh - Send cancel - 2                               Timed out    1.986 seconds


https://github.com/bluez/bluetooth-next/pull/527

---
Regards,
Linux Bluetooth


--===============6392578163458664120==--
