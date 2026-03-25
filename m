Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2CF2D978B
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774462717; cv=none; b=kW5nIYeVyKbmLTf+zwQWeaXR/9yB0gW0wNcwWbTk9NTjSfYQayu44C+AB+v+tzWcSP1fj+WQk+EOHnZa5rcbS+swbtTwBch27Z18wa6RQHF8iGEIMyjNI2vEIJRz8gI0n8k/MXTbyruR/72fvKR3cQD0t/d6pIH70oNg9R2ahq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774462717; c=relaxed/simple;
	bh=WMbW//sEwVAZ8SbvPf177sU6uT0QvWUPYShQ0g2rWxE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kQZkpjRVmokPAGI44HVHq/JZVaJPK0XUEon3AyAZiNO+DEBBwks2z0QU1I7kAdDziPd0/5ha03rpF4T3kJiS7e3cnuoMIJvrd/gkwP8NGcbHLlrGrMxyBoMPMcz8vJOvdBkNNmS4sYaVRvfKvQf/90Q6EZKaukeKeZPvTOHkPvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFqKy+XE; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFqKy+XE"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d006a80ccbso28766185a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 11:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774462714; x=1775067514; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4RI3rCyW2PnuzIMCvmdyR3YtpqCYM/EHjS9BY1uEqGU=;
        b=AFqKy+XEs32PFZB744IDOb97o19a+de6MgEqSAhcu35uRWKaVqS+IAIwAR73MNTkTb
         WdXfVfXsbLitte3iHoi+Hqp2aKsZFD53jcnqgY6q+PU7RrewjsmsWkcHsk7VkySlBv9R
         gPJSiW3bZpU5MDieFCrMtPQuezSGtSD+ExfNXHIttbd9/BX4DsnRcIQiVO5daAjiwVx3
         SDSxEm9MVzmc2qyGP3IwoQzWayiPNgErdVt+feFzPO/pptshpaJ4NCQwwM5ltKAh+UVp
         PyqtBIs01obZpJLArxLIPeyz0Sa4/E+TYeXmRvelboydnSnMw7oUZwpctXiM2/LmFjBy
         ItqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774462714; x=1775067514;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RI3rCyW2PnuzIMCvmdyR3YtpqCYM/EHjS9BY1uEqGU=;
        b=qrkWqgVj3j0NpVhSjQz+dENu+p0rmEQT12W2fjwW5mgmhctmYdUzdC/wlMQocQHrDP
         3XKCC7OW2VwMryUXsv5KUT3tyR/v7Qrl8XHiqHWR0ZsG0YEkCxcDMmy6BWfRCpo366Xw
         q1xy3ZuiihfM1GJoyg9espYzLKMGUFjP8+X5ZxDAnPURINUc3EUTK8FsG3ABiUF/WYvv
         qcCbgnUYDBQk2j8kDECny8OeD/QgQjR4YQgeYUyCeK/VPz0Yrg6H2K2CzbU7vlBSnWFd
         gHy+ibLrHwLuQYjW2uH3RW5aXUf9IFdE2jfM4/MMg5Er4Euo1ASXXhRxRKIEygZv6Qdq
         0Ydw==
X-Gm-Message-State: AOJu0Ywygvz80IRIoORkhzKxD4zsn2dgqjmntQEqvU2kHjneQN3UQdAo
	Wpnx7fOjuVtQ0cQj3iKBN2ukuD8TQuCstO53KX7/S0WLfXd88yaQFSw4yvbWrw==
X-Gm-Gg: ATEYQzyuHM0C37gml6rpRJkBaCdtUXMvtUVvmBhNp8Hv1HR3ksGaQOuCdjbmYUtwlA0
	1V2qCBONFhuIpGJpYBfm5QKXtkxBCUCogCmCZfZaQoNLVCyWT9IeznwHxuNw29SgyIFQwMHqA8B
	5I5T3AEP2nmEl+q+8rJ1Z1N8k+9c+CB1r/9Pa/JGjzKAVhUxrms+HGm/gFfyyEownXj9N0tAbhW
	abqY53b1Vkm9dTyDJYSpN7GJa+ahHtmx5xgXSTHh1VG7kLIOzzQENqduzFqxxS8HTe0sRRqxw4M
	SESlMlgkkmNPYV7a1BErLd14C5rICv2+mhb5Tw1RAik2/G5i1rz48TfkDC3kgElQCG9sly83Su5
	SZnSPW985U3xCshUFlIQmBnRRUj+L30atD6IPd9s2HyiINNoaTQZdTAhr/0ZEzF1RC5aipFg5xC
	RUtoUl11AcvoV5jDBae766DiKhAXjh
X-Received: by 2002:a05:620a:4005:b0:8ca:a950:238f with SMTP id af79cd13be357-8d000ed0642mr640532085a.10.1774462714422;
        Wed, 25 Mar 2026 11:18:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.127.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e39fbb0sm43878885a.8.2026.03.25.11.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:18:34 -0700 (PDT)
Message-ID: <69c426fa.050a0220.b9068.4233@mx.google.com>
Date: Wed, 25 Mar 2026 11:18:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8470665839066801223=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [1/3] Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
In-Reply-To: <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774459946.git.pav@iki.fi>
References: <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774459946.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8470665839066801223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1072457

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.36 seconds
BuildKernel                   PASS      26.82 seconds
CheckAllWarning               PASS      29.66 seconds
CheckSparse                   PASS      28.46 seconds
BuildKernel32                 PASS      25.85 seconds
TestRunnerSetup               PASS      574.10 seconds
TestRunner_l2cap-tester       FAIL      28.23 seconds
TestRunner_iso-tester         FAIL      36.55 seconds
TestRunner_bnep-tester        PASS      6.35 seconds
TestRunner_mgmt-tester        FAIL      116.86 seconds
TestRunner_rfcomm-tester      PASS      9.44 seconds
TestRunner_sco-tester         FAIL      14.48 seconds
TestRunner_ioctl-tester       PASS      10.38 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.62 seconds
TestRunner_userchan-tester    PASS      6.72 seconds
IncrementalBuild              PENDING   0.90 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 2M                     Failed       0.116 seconds
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
Mesh - Send cancel - 1                               Timed out    1.821 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8470665839066801223==--
