Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA81DE8A2
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 20:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638848; cv=none; b=khJWvXrUZ9PTqCd8NCvpQKgkaZ4Xs44TmF6A+LXwfCI9uZz7MyUUtY2jytSx5ivgpTGhNw/QliJmXOL3XrsS8S4lFi3JtiMq2SPzpdIK1Riex/hCc0d51WbbehudyY+t1bSw5MtgFcQCcR3XN3yFy59Hz5LW+Z1Rqg/G3Lilw50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638848; c=relaxed/simple;
	bh=ZDrhIx7iBWhdiM063wmlRlVqjooihC3ZLp778Y14jxY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WBfb6g+7fzvknUt/ZukYFBvBVWo9z8EM03knzo3cYLwt5aFQ3SenV+d/nr06DUyxUwzlLYBX3b+PQiir0Ct9qbDhwwyjf3lACUWiroMbTZC6z2ESTXvQLwzjUUVPSdwckG/GEoe8617j26OxoOG24gNzAL1EnFvN19ThC3LXYCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Suard9/Q; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Suard9/Q"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e89a2501a0so42641106d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 13:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741638845; x=1742243645; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D+FHqUE6IQvCOzmuB3rQmZkxibtuUCq1z6bUY3H+47s=;
        b=Suard9/QxBqgiCDNG1zoKU6+tZ2Nc0ZVvm7PaEGd7T0PZvv5EAcoGgPHmAwu0UA5PY
         An9pi0URQ4dk/NgPNfmAkiDw4d6UAzqf7ehLbNC+64+qeEXFPhOpSJ8PJxwzrjK+/zI6
         pkvzp0BhCXcJQbXDdtLeXiuDuovzbssbWt2/w4FsuB1tl+REOG7OYToGpMkZoHb9CcuO
         FBBJluq+8vFIlV0qfqafuFaHmnZ6fazPNQVejXwopk2hKJBdjPNIWDNww29T4lirplXZ
         RNVPoJ1c3c9XHhtNwS7h42cim/A6bDFyNxqjKoXpTvFGXefF1zuFaT1cQhKkK3WdMSjr
         8qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741638845; x=1742243645;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+FHqUE6IQvCOzmuB3rQmZkxibtuUCq1z6bUY3H+47s=;
        b=UAaCAX7eN7D0wsrZbgKov/bNuGgw8tN33svkSUaqvQzPdR83zSn2A24hyVxCkZR80P
         Ad5cZwQBF7mf2fd4bGYW3ZVpCobD3JwkwW2HFoW7Ndp7nSM8qmIN7Yexvm4vO3v/iGPQ
         N3AJ2Amsxs/xYW+Hck8F3Lt1vphvCPRFpBIUtIhT7bnOZW0h78ksdvv7onSzVB/Ma6fD
         mJCcvfUQJOOLE25BWSwfuUoVdmjcyjNAMHhB7qG45mKV9jUwBZOfM5OlZ9A8LFGEIp+7
         yYu+gcZiG9QKkv8KybcoSkEPkmjnPPKVxs0oXVv6N40Lcqduxp18R2j4MVQtfsxFHOcX
         1pgw==
X-Gm-Message-State: AOJu0Yw7SjN7ggkW2+3u2DFqH7cUtpMZYgDgmdRBZxmKUIbG1d3PhCtC
	sdk7goWNASZu/8CN34fOCIgxW8ww5oavka4qAIr/Qm7LYmrAvUdpChCqfg==
X-Gm-Gg: ASbGncsvcsKc4OsCEt/LxP5eZx8+HX2mONn/SnUky7G2aHafabu2oF7lyuICgfgLiAK
	T6BW2u2qy/HcI/fJYzqoNaPhrXgviG46762h0GHI60LynMTt1q8DqUzssl7KBZqC9q2/2hFJkVj
	/kxx60Vuj+4d9RC0rhyVBs1qNPFhPexDvgD+ZX/dlz7tzcpgD3pTgIRpqW+NBIVxI0AD9y8xldZ
	NLtYwXHGnsbbkhwB8uTRtU2Yuo+2iweIuVxQoswXhi8WMZe0X1lH0BOz+zPop3Mx6bj22LrTDGb
	8ip8LxQoo8i3ZJDQBiKVpcnePznvZnSJp+24a5gl1W+nvD8r/1I3wn8D0+Zb
X-Google-Smtp-Source: AGHT+IHzPGF1195JQAWN3gaq2gF7GbjlASGIpmqD4BW1IZS2egzHbQu5uLYD/pKWazz7BoIoYtwauw==
X-Received: by 2002:a05:6214:250e:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6e900693d5cmr234161006d6.38.1741638845353;
        Mon, 10 Mar 2025 13:34:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.193.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a44adsm61878996d6.64.2025.03.10.13.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:34:04 -0700 (PDT)
Message-ID: <67cf4cbc.050a0220.1f3310.4d25@mx.google.com>
Date: Mon, 10 Mar 2025 13:34:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4631610080006355415=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dan.carpenter@linaro.org
Subject: RE: Bluetooth: Fix error code in chan_alloc_skb_cb()
In-Reply-To: <2144b990-e584-4f77-a3be-5987b56d051a@stanley.mountain>
References: <2144b990-e584-4f77-a3be-5987b56d051a@stanley.mountain>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4631610080006355415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=942410

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.83 seconds
CheckAllWarning               PASS      27.57 seconds
CheckSparse                   PASS      30.95 seconds
BuildKernel32                 PASS      24.46 seconds
TestRunnerSetup               PASS      437.95 seconds
TestRunner_l2cap-tester       PASS      21.24 seconds
TestRunner_iso-tester         PASS      35.47 seconds
TestRunner_bnep-tester        PASS      4.82 seconds
TestRunner_mgmt-tester        FAIL      122.10 seconds
TestRunner_rfcomm-tester      PASS      7.94 seconds
TestRunner_sco-tester         PASS      11.79 seconds
TestRunner_ioctl-tester       PASS      8.44 seconds
TestRunner_mesh-tester        FAIL      6.34 seconds
TestRunner_smp-tester         PASS      7.37 seconds
TestRunner_userchan-tester    PASS      5.08 seconds
IncrementalBuild              PENDING   0.79 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.143 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 65 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.112 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4631610080006355415==--
