Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB75FC0A
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Feb 2025 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825365; cv=none; b=i3ru1NIWrjNk4zpCitAXzO9YAXvyzJp1vRqRJmKRELEgokMnSut36XjDR5ZWTMQ+pbIJqn8sjkRRQplWUxuHkjuahD7cI5Y8dncw0q2g+A77er5+FdMpZdDro/P1TfowUj7BCo1nUyVObC+5YcyTgPlGoNyN8pKINaSEaE3iHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825365; c=relaxed/simple;
	bh=9qWiAaRzMNwpYSYJQVijuXVbKD8mGNuYf47zYCZCUBw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=X/xg3XR0Vzurdfug9MUgoUiBu+wzzDwun5k9+2wbF8HHS7tocSYAwzm7npFPA0ZFsbNOb2HBJaoLtuoR2pqShTK1ssCTs6toh9l3GW6qAqtxbgzvaZOfAMeqd/swYMyn8fh5kd3a8AOV9ktIPc4W7TnopXrkAJxGuQ2ek4iYBjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUyd4e2G; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUyd4e2G"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e432d88179so5471146d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Feb 2025 23:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738825362; x=1739430162; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rmRa8Ue8/ZF3kK2nBbeQSy5InBV3JnhFrkPuh/DrzHA=;
        b=YUyd4e2GMormBIh3KxRzZJ5gQzPWPu8Gw3H+mEjaKRxu4qiMp9N2JiTF4JYjjxJf6o
         ssK4vPAn7vkPEafzThu3+/oOTzTS/CnE2KM5sMdx1IL1nMizgbs+FdnS8O3NxFQXlcUW
         lG+9debSRX3Bx4WtiTGbjpFak725zdtFpnxnaC6NBJ9a9Msf+M44V9cAOSqp0eibqjrp
         C6bNjqruvxjAOH8axV1gnCIq2zKN0fOUyyCByYu4L9oY8bYkMN4tAreOaEtMHXWxju4a
         JUYjlZ4o8UO8ylBRbXi5ZqH/QWcQkVUv0oZneULoHJUOS1GV5jOMNeDkPHCmGAgn+QAk
         AwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738825362; x=1739430162;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmRa8Ue8/ZF3kK2nBbeQSy5InBV3JnhFrkPuh/DrzHA=;
        b=ld1QGnuRy8hEd923Wjy46bdBbxzru0AQMsJqcczmZVZZ6k6I9jQrPW1WL0ycN4CGwL
         hY/OAyo/LBeYM9qmb+LHWHHUxDwLQCtx+I1IaASy5d2BOpQpBUkD15of/TlR+YvPjUJr
         ZqOByf21d8KD72cms/ewChDEfRtGsI2IYMasqQ1lfv3sPhQHhdh53FvufU7fkruOXe2m
         YkzpSMBIZisCtOyH8NqBC+N9JoRk7Hnbcb1oL0nP05+YBT/HoGTRVeDD1x4t7uX0Jc8c
         F7OFLlcoQGYi47XlJ2lr2ep00W3XiqFtM9iXhIJkZY64ULdaAw0aWbE3LCc/x6baoh3R
         Waiw==
X-Gm-Message-State: AOJu0YyakcvDkbuD9lCarmCcGztTRViywC8/l21ns82OzXcBhlOT+LSE
	1g1KBCiotuFw3Ztz+dabdC4EoHNysnFrkXL8V7oMU7YkhrpncR2MzqpYdw==
X-Gm-Gg: ASbGncv7DoIgAQuDiCxgkNh0ZtdwnuAH9PLp2fSw5TxK6PDwMn1BMb2tjhF46kP/Kb0
	WhSbOY58WHvUCNOBy03X0wB0t9y7n+2a1banU6VcjnY8iPRmTDXzzwoYeff0ZUQNPj/uh4Mk8bK
	6WiyyVexSYmRaGcQT3oee7lFqaYszUmrU/+tER9foE/G6VSvRMdJhn+5DHj4maTsPej8sZI5b0V
	Wo4i3OUvBu5AV7OS3Q/5+mHPrPg8LwTsYnKwSOrSY43QC57sOwYwMKNgnBVV9gTDKLvNsIWtxaN
	yi7iAuDkMNObisnGqLE=
X-Google-Smtp-Source: AGHT+IGhOQ7wZwYJFI87GziD2VFrSz27ljx3lrIm2RkTwwyf1fGnK60Lyxk+CIwlfKxMiwfynF8q/w==
X-Received: by 2002:ad4:5b86:0:b0:6e4:2561:48a7 with SMTP id 6a1803df08f44-6e439b4bc59mr29459816d6.17.1738825362526;
        Wed, 05 Feb 2025 23:02:42 -0800 (PST)
Received: from [172.17.0.2] ([20.42.49.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43ba3ff71sm3384806d6.49.2025.02.05.23.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 23:02:42 -0800 (PST)
Message-ID: <67a45e92.050a0220.3a281d.0ab1@mx.google.com>
Date: Wed, 05 Feb 2025 23:02:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5604152172424991261=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jiande.lu@mediatek.com
Subject: RE: Bluetooth: btusb: Add 2 HWIDs for MT7922
In-Reply-To: <20250206061107.3541537-1-jiande.lu@mediatek.com>
References: <20250206061107.3541537-1-jiande.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5604152172424991261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=931070

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.18 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.11 seconds
CheckAllWarning               PASS      26.55 seconds
CheckSparse                   PASS      29.95 seconds
BuildKernel32                 PASS      23.61 seconds
TestRunnerSetup               PASS      431.34 seconds
TestRunner_l2cap-tester       PASS      20.33 seconds
TestRunner_iso-tester         PASS      33.29 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        FAIL      118.46 seconds
TestRunner_rfcomm-tester      PASS      7.57 seconds
TestRunner_sco-tester         PASS      9.39 seconds
TestRunner_ioctl-tester       PASS      8.07 seconds
TestRunner_mesh-tester        FAIL      6.26 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.70 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.173 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.190 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 34 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.120 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5604152172424991261==--
