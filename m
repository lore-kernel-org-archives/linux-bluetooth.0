Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD029CE9
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774325948; cv=none; b=SHpeWLYg6D26nPuuXmnaWQcygvMdLudqPKnLtuZVeAJDVW5xz01lNwaW8JY3uEiTeDfnWo3xc56nSgdTdV4NlaB/NkdMSdNPWRDV6+SWs5NUhavYaTQ3c2btOAS4aJEFAjTTnuCbg6KEKmDLeHxbZLG47mOOCoBXzWhC1Zeko+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774325948; c=relaxed/simple;
	bh=Scdx6sobv3qmjsS4GCc+pRUyRqd/UWZTa0jBklSxKVk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tlUmnZX3nu+bPI41g4r7/4n2PcXuFCX/lO3DwMKR8jbRV3MHLKya4hWh2FLcekBPLkfUKaryO1rWdFM54woiE7RUwuw2LjBHxgxFv1ekrLaeqjh1iFLRusfHEuX+f9dBWUgcfRhA0VS7MPtAmm6MMHHT+FkawpG5IOeafBm+qMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0r3CRG6; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0r3CRG6"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d7653db148so2806847a34.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2026 21:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774325945; x=1774930745; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JxJ/9enxZ53w897kfqfHirw7hzvjDuVChoz1Qwr1nOQ=;
        b=N0r3CRG6cuqBxnHy6+kirmN5qfcfragPtYySMEHlpzuazVWf2Me47P8MteJzvrwpGd
         OZmK2jk1aQTs0nWPQUZHz3ZnhpUmRqSCR9LpIcKe2Q7lCm90XVsrtrt7P8ADJ6YpzDCW
         PqZN9SOy6sif5KVda/XNHWPnPIe7gkKOUBZRtjNYvYRyB6E6UYXCBgNwXzADrexW6TJJ
         n05ctq+SnpYFAtXz3QiF6gFdr+aDPduXRYIuZoOXI2Ig8/AkVw15ofHQ2MMjbpKkKmtW
         oGWTfyugy1eqbbq89p2PEOxzqf7vHnZJcwAAPdPJ3BQUqgVAXnpRAhgM9gp/6KQ4S3jf
         64Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774325945; x=1774930745;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxJ/9enxZ53w897kfqfHirw7hzvjDuVChoz1Qwr1nOQ=;
        b=Wa30ODtS9FSrp7jkWhvXYoM3XmYJOGHPB8E2hjPBHo61ZHfqfm6nFZx8ARqQISEmhK
         T2bIvEzVOUK7id1t26gpF6FWjWET6rfT3luOv2rgGYvC1CNLx8S08/sMbyHyvWBt8odb
         5Hs38w8GTPgm54VL79bjFPUOZdXm9+fHfNzvbcJiUOOh6F9aq6uOS9abFcO248KpgqbF
         Zz91CfVwnfcdr6bXU6en5L+dHOPI9X4j6ZOl8ubgcCnrO/p9GCttfLVcTzrsOCNkNECb
         YAjz8NkFZlPr8dBfNAlzMePZdSWv4ZGCuSoXTym7gPcZ2z4eA8IfBJOue19q8fz3vIit
         JYyg==
X-Gm-Message-State: AOJu0YzAAzHoqJhHlLqgZlvPbPi1SAdaRP3X9sktpsU7pQYqq8iuLpbP
	5qcvbxoR7NZOAAQvMIuH3Q2WKju3TfYWhgmbq2xRYkGAbJ/aA5WEaKUYsC/xKw==
X-Gm-Gg: ATEYQzxnCcjWZUtGGewzWZ6BoPNB0nyg2rairX1pAnXxksYQI09R9kcczjUPvULN+z3
	nfK9xVOP/rPWH7bVjNYP5vEpdZZsVAQ+q3+D4Sor65hXutfD9uEY8/4iLXiLxefJYpLRRYMQvEO
	G4IL/mKrBuwQ60qHP3bdhI2lSDUCkqZ+qQZu3GV1fG423cdvG0jjA9nzZm/MTJkZJVPkDXlFrBS
	XbM67ZAgvrjJYpEBStxmjwXSpeASRyvtWzqsSqix65senTae4NFHuj5OhRC7twEfB6q9/IDnLgT
	dF+wdJA5Io1mBbSMnMTl78Gp8vvmepAkNAbeORCEdUj2edfrFeBVi5Ip6wiRWZL71lu9T72xMQn
	PrwbVgFBaCNGIj6YqTdxUH9Lym7SxZepMRqzdZQgD9KMUF00gN6VT1RexNg9xkSsewysMnNkuje
	JVvHWTeSQcY76ufWvsxYQXzSX2aF7/3RDtWNEYUxon
X-Received: by 2002:a05:6830:6a8b:b0:7c7:62bd:7fac with SMTP id 46e09a7af769-7d7eae785d3mr10724658a34.9.1774325945401;
        Mon, 23 Mar 2026 21:19:05 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.165.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadce2e4sm11029662a34.17.2026.03.23.21.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 21:19:05 -0700 (PDT)
Message-ID: <69c210b9.9d0a0220.1d7ab4.3099@mx.google.com>
Date: Mon, 23 Mar 2026 21:19:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7545178868596151139=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v3] Bluetooth: hci_qca: disable power control for WCN7850 when bt_en is not defined
In-Reply-To: <20260324023016.3889062-1-shuai.zhang@oss.qualcomm.com>
References: <20260324023016.3889062-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7545178868596151139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1071339

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.79 seconds
CheckAllWarning               PASS      31.96 seconds
CheckSparse                   PASS      28.09 seconds
BuildKernel32                 PASS      25.93 seconds
TestRunnerSetup               PASS      577.67 seconds
TestRunner_l2cap-tester       FAIL      32.97 seconds
TestRunner_iso-tester         FAIL      35.05 seconds
TestRunner_bnep-tester        PASS      6.59 seconds
TestRunner_mgmt-tester        FAIL      120.45 seconds
TestRunner_rfcomm-tester      PASS      9.56 seconds
TestRunner_sco-tester         FAIL      14.54 seconds
TestRunner_ioctl-tester       PASS      10.50 seconds
TestRunner_mesh-tester        FAIL      12.55 seconds
TestRunner_smp-tester         PASS      8.72 seconds
TestRunner_userchan-tester    PASS      6.85 seconds
IncrementalBuild              PENDING   0.75 seconds

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
L2CAP BR/EDR Server - Set PHY 2M                     Failed       0.122 seconds
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
Read Exp Feature - Success                           Failed       0.110 seconds
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
Mesh - Send cancel - 1                               Timed out    2.757 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7545178868596151139==--
