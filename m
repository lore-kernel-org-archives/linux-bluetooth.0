Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C0C12CD96
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Jun 2025 07:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750489600; cv=none; b=eIzUd4geGDRRInywmfaUtyN+6XWlhYIiLZmn2agmpJks/LV9GLfBNsOFAFdjOfP400uvAXBb1iAqMWDQCgsT6lvIJu3IJhgyC6jS/1HaejyDgK2VKAowEIL0xgPaWGisgmfV1wVQUz8iGHBC/JGJiAgQQkhq1VAQsBTuhyt5ORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750489600; c=relaxed/simple;
	bh=I+ngb01LnQjrhpfa6koUwI7TZTLkPag2FotbmhTgtgM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oevAGNSbH7Fj83v0+O3ocRgrMDumupzhAeoWbJNbJAIBiz2/aR6J15jrVPpWZ8xGlBnG+76MzPO+/OkecyooQXrYx3dQGn7vvglipxOnzcvnqwvu8FLFiqeTbMSeQANkytOMMqxulng87tFKEY0SIiBBar3L68Tp2v3p9tOuc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKME+Fm5; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKME+Fm5"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fb01566184so21524906d6.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Jun 2025 00:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750489598; x=1751094398; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6HK8uU6iqfavyZ2SrQqd/o90EQISpAAtFwU2KeV6YAE=;
        b=TKME+Fm5693zGRnAslpKmtFvqBSlMi4cDMeJOJTXSpZ7r8oiwBi0wpcxb+s2+ofjS6
         Vsy9nJxxMvq+8EknmCQxeLhwqBz+hVYXUB8ecYvdvVfcX+7MSWhAsoGJLG0JAblRtd7o
         oLafM3fU9glNNsxc7E0jkHtcdMJFoWexaNCWj1LSECG/vfb+3faC2r7Ga3UX6IVdZizz
         YCRDYv1nbm/ZiQBzxuousz9WwVBxF+yNtIHDQNCvYUMdel7LK4PxnojXoRyzIcyVGe8l
         zV3sJPkGbsu36UjxZK3ieA1Bhlz2tWYFxOh26n30NrTx5ljqVwNRTAjbbFxiM92YMxb3
         RKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750489598; x=1751094398;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HK8uU6iqfavyZ2SrQqd/o90EQISpAAtFwU2KeV6YAE=;
        b=lYID0ZS7dKW3BZAnySXOVAe8jQt/sPj3o5FHo8RC4jZ+sDeuT4tAmIitEIoq9vuQZI
         bx/xrK8VemWCiTNvjHJcLJrrRkyg5Sw+lBR0dY4IjlgonYeXB7Ym2P4xZDLiobA49u/N
         dResBvQRTVbFa58xlFtuhN4yMaY4lKSe2QjfX7mkNx3Koxb2T4Hu3JR4cesvGwLskcbb
         D5byy68qDy9cPFc39iL3h7BYt7PIh6dK9lCOVH5/5zh/La9i1TBfbkv6n6bDo1UO5ZCA
         PZPmqPUOFsitVX0hPbwl8g23ovb0LpnnlRzvU8PjiFOm1GS863v3pKnnazZZO+IgvBUv
         3IgQ==
X-Gm-Message-State: AOJu0YyTXPvyz6I2XzrwAHGjE2CxaS3I6NkVX6XnLr+pgJVLat+rOuIp
	q8zU27Nh2Sv4Wuz60MJQ6UxDkU+YUvpq1LQBkNq5X84LvNspJB0tkco3yIqIKw==
X-Gm-Gg: ASbGncstQJTSY1E4d18TGOU9C/tl5nmOP447qHInnNqO5I1EhA3Ngs2T0SaTa861PB4
	6blUGOzViD/V65x59NmwrAP6sCzD0JNwBCzqgZMjC0zIKP0VEfEpQtoH6xn6qFThqtdCgpUHN2h
	MoCnL8QS0OfvzqWc9od/dx7r/7nPByOuEgTN6AOu+Op0XlbAmb2QZWefEi8eN2ozPOMCgu1xlGq
	0HKZm+GNtlb/ELmtXO9zTFeQdhIVz6Spi39GoSid72Gory9u53l+Sk7pviqcH+keqGum0cosazp
	G3mQrzaVQGih4WmasFowaj2P3lVzyivQuMCJ9BDU9i6yPBkGW9zbs6t59uMQd/PhWn0=
X-Google-Smtp-Source: AGHT+IFzmLmkuDczG5mpBwc6AcVhvJCqh/+tF/sv51Ahr/W2Yrt0Pdk91I7gAeseMNFliY3ki8/gEA==
X-Received: by 2002:a05:6214:2b94:b0:6fa:ff79:2cfe with SMTP id 6a1803df08f44-6fd0a49cf89mr86698856d6.12.1750489597814;
        Sat, 21 Jun 2025 00:06:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.50.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd095bc554sm20571896d6.117.2025.06.21.00.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 00:06:37 -0700 (PDT)
Message-ID: <685659fd.050a0220.23a611.79aa@mx.google.com>
Date: Sat, 21 Jun 2025 00:06:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6409422623306341557=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3] Bluetooth: btintel_pcie: Add support for device 0x4d76
In-Reply-To: <20250621064631.781861-1-kiran.k@intel.com>
References: <20250621064631.781861-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6409422623306341557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=974467

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.18 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.06 seconds
CheckAllWarning               PASS      26.67 seconds
CheckSparse                   PASS      29.80 seconds
BuildKernel32                 PASS      23.73 seconds
TestRunnerSetup               PASS      465.14 seconds
TestRunner_l2cap-tester       PASS      24.99 seconds
TestRunner_iso-tester         PASS      39.69 seconds
TestRunner_bnep-tester        PASS      5.93 seconds
TestRunner_mgmt-tester        FAIL      130.24 seconds
TestRunner_rfcomm-tester      PASS      9.16 seconds
TestRunner_sco-tester         PASS      14.79 seconds
TestRunner_ioctl-tester       PASS      9.81 seconds
TestRunner_mesh-tester        FAIL      7.50 seconds
TestRunner_smp-tester         PASS      8.41 seconds
TestRunner_userchan-tester    PASS      6.15 seconds
IncrementalBuild              PENDING   0.47 seconds

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
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.200 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76b/0x7d0
WARNING: CPU: 0 PID: 36 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.136 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6409422623306341557==--
