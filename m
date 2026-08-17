Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA36224AFA
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976474; cv=none; b=KhnP+BTsFQszs60F+wzd7Tqvja9L5wDkj12jARugEWAUUQOTDJ4xXZKwt5CBJhfr9WpZ1WxOlVZIJbJdBsuT6QwC1Ayf82rqjlqifDzAgTxo6jimirgWuZBd4+U3/LBvdLKgQlCeiCmjq+cpSvUNpMwVw1HznU2zR3DdZ0C55Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976474; c=relaxed/simple;
	bh=7cYr+l5k+UEETdkQs0PTFRAdpYpmFSASAAKVT6WvQzI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qOf5m3+K9V+AMZErXCQJnGtQmXzYBuFba26Ic43z5G/PQsKAPO7gFQ37r8hGeodcGPVJcbWmR424SDvdWkRdsJlH1nfIwIK9sK+Tng0TgY5haVPMRjFaK6MTzLlr33xIsuIij+jBdXPZNh7LZSL3A/bxKr0ex7OcGgvV1RaLxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcSR4wVa; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcSR4wVa"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf52d15d88so33264475ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786976473; x=1787581273; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KC58FExRILXKMsxITm2Em8XB4TDCesqXjUhx4PWBFK8=;
        b=hcSR4wVa2Sla0bjsWYzQYVB1PNPnh2FEXGI6VrbIrxQxfUAepW8HmaIIru2qB+1B89
         ejdpxwCFBhdJePCFmWV7I6l3oRlDAO4qSL5FLiuITI9aJZkLzn70alQ4ktAjNtWhosaY
         Mz0XmMp7GGFXnSK2Im3EIIHUWmxmcHo+3AV41aBWOvst1H6PZne5ZoYlrEuXA1n2o9AY
         9yUlgEjQLYFTb3W60HfykHIo+pfISYt0pnflwz6eLPFkvNhkcnMDswPM9Fk2c7K3j63W
         aHc0dM4U4XtttcL2Pr63p0ObMqeuwHUYxjcS62zWVO0qc41twmyL9KpKiyqZUxTxSjto
         Kahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786976473; x=1787581273;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KC58FExRILXKMsxITm2Em8XB4TDCesqXjUhx4PWBFK8=;
        b=nl+p34g+lNqFz0uRctH6TCQIYe8U04ifim5RENJepoXhIYR0t9P1PaIladyu0p/LYO
         H8+qAvsqyHHfwGm9qMr+5J0WBks4iSItQKoCjHSdKv/LqN2B3iF2XLB0vJiMOnGjufeJ
         N+CK9zQCRIbudtYzB7ttcmsQwnQ8afXJhN32SLjnas0gjyXx+wPzmbTCHFgba7GxyoBy
         nmsJcP7Ab803VLBceEEa+Nh7xfxw7Y0vxSiGfdnhAObqWuuG74595WfkYuLFD9k4RHbA
         8nsy0lnvSQMoKLJwVF25MvIuiXqxXbo94XadocUBQeaLA4MidDFY4LQ8lqeguD4sVy2o
         MzRg==
X-Gm-Message-State: AOJu0Yww6mt8ocXzlYucqpQkLODt5eTWM6/9qGHIkWI8h/VrRl3ZGKaf
	6Z30JXtMUYakuDJMIYuSZ9J8D9fPF5JCP0/AKzT28PLTAzEipGCl1A6eEe4D+g==
X-Gm-Gg: AR+sD12w/9n1a4Ca8mhStbg3hSym2DbzucuHqq9Ltvw09aDRwKLmbkyC7YK/0VTz9Zq
	g3pR6+dlgfog4FxKZ6IHAKVj2CzlHcMZStaIkoYDzZFSo+eaB99wdFVXTj0L4p3pn4vr4m6N1T6
	jdboN4nFmQfebLJ10ha6T6e1NVtLFmr9BZBVM49TWaNfen7vE1z/UhnaJG7vNsebJs563Ym3DLd
	eBF1znLZ9/TAnVpnJ6fTwKWefMKW7Wh+RwMRbUl1ow/IvO11XM/7zAkcdfun7r+UJb6g56DjRV2
	Y6k6laProN4CmATwF9sw5WyVIuUkKBHVozc+ChZv6KLj39DYydlRmBV5rcxpW0bOJ8uA+qZy00k
	gwAwigaRrXqGAUmIi4ef63Z5Qgivud86eAOaFaFifqZvlcWfgcP6iJ67kvhJtbzRQ3gkFDXY20U
	qjM5gs3g+EeGkfsaD85bSMS2LD9fdAjIUGvckvQzk1A2U9kuk32tlGgkiHL78/gY/j7kdU
X-Received: by 2002:a17:90b:2891:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-3933b916f3fmr25189127a91.10.1786976472732;
        Mon, 17 Aug 2026 07:21:12 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.31.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267cc91278sm6667942eec.31.2026.08.17.07.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 07:21:12 -0700 (PDT)
Message-ID: <6a8318d8.436e7ae1.2a65b4.b0de@mx.google.com>
Date: Mon, 17 Aug 2026 07:21:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2503114661610178409=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, valentin.kindschi@fiveco.ch
Subject: RE: Bluetooth: fix a permanent LE Set Advertising Parameters retry loop after a cancelled central connection
In-Reply-To: <20260817132449.509304-2-valentin.kindschi@fiveco.ch>
References: <20260817132449.509304-2-valentin.kindschi@fiveco.ch>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2503114661610178409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147230

---Test result---

Test Summary:
CheckPatch                    PASS      1.11 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       FAIL      0.42 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      30.86 seconds
CheckAllWarning               PASS      29.99 seconds
CheckSparse                   PASS      28.66 seconds
BuildKernel32                 PASS      26.43 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      504.11 seconds
TestRunner_l2cap-tester       PASS      66.41 seconds
TestRunner_iso-tester         PASS      92.33 seconds
TestRunner_bnep-tester        PASS      20.05 seconds
TestRunner_mgmt-tester        FAIL      227.27 seconds
TestRunner_rfcomm-tester      PASS      26.15 seconds
TestRunner_sco-tester         PASS      35.67 seconds
TestRunner_ioctl-tester       PASS      27.18 seconds
TestRunner_mesh-tester        FAIL      26.36 seconds
TestRunner_smp-tester         PASS      24.43 seconds
TestRunner_userchan-tester    PASS      20.67 seconds
TestRunner_6lowpan-tester     PASS      24.35 seconds
IncrementalBuild              PASS      28.77 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/2] Bluetooth: hci_conn: only re-enable advertising after a failed peripheral connection

1: T1 Title exceeds max length (93>80): "[v2,1/2] Bluetooth: hci_conn: only re-enable advertising after a failed peripheral connection"
[v2,2/2] Bluetooth: hci_event: keep HCI_LE_ADV set when the host cancelled the connection

1: T1 Title exceeds max length (89>80): "[v2,2/2] Bluetooth: hci_event: keep HCI_LE_ADV set when the host cancelled the connection"
6: B3 Line contains hard tab characters (\t): "	/* All controllers implicitly stop advertising in the event of a"
7: B3 Line contains hard tab characters (\t): "	 * connection, so ensure that the state bit is cleared."
8: B3 Line contains hard tab characters (\t): "	 */"
9: B3 Line contains hard tab characters (\t): "	hci_dev_clear_flag(hdev, HCI_LE_ADV);"
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
Read Exp Feature - Success                           Failed       0.256 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.508 seconds
Mesh - Send cancel - 2                               Timed out    1.984 seconds


https://github.com/bluez/bluetooth-next/pull/599

---
Regards,
Linux Bluetooth


--===============2503114661610178409==--
