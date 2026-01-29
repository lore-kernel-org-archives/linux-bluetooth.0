Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D15332A3C5
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769717647; cv=none; b=Egz7/Fr6kJ3IDmNBMB1BePNYYcRp721QaeBtPBpRliVF3XPYLvEe7LbFgolDdRBiyvwOEKjRDNqiSp3KjUqUjQUPaTln9f5I8s/uICOTR31T0O0+SuMmBuurimlesRBmDpJTWgVHYg6RLbqwb6gFae/vnEkqJi+yCNODp+OdDIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769717647; c=relaxed/simple;
	bh=7+Fi5xZs/fWvY5op3EIamZDcMOoWdOVb4YKU0e4OAYE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nwAkYMHn67ilNb7GXJlvkTEdwBZX9yfkxjK31jNymSgdM/LX45dBS8IvXz/Q7K0DQHLPeg4Eih85aHXLXkcJkyAVAE295444G0rJc7h+fhgJwqnOHeWx975nJjrzQ9q9/H1xRv/AYp7cQwQ3eUoY4C7/pBhUk4Y74vKFq5xwpo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RToUnkLq; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RToUnkLq"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c70ab3b5fcso180334785a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 12:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769717645; x=1770322445; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ah62uVII4bpGINCtv2EecA/fYEjxfB2Q3uY5lFqDvXs=;
        b=RToUnkLqaIMlYydIi9syQrQFLik6Ghy6imigDwSDOQZalYTOOP6uO5h67BDr9F1qmw
         zqqyT3T3jOJmjoNE2fWwFFG8dupKtp7k42nPvaRLqtKWUk2TaYhvLR4OPU8NY8gIDdcn
         RNK84l/a/nOcGTISiUNWElml8UNaiyDKWC6bn8G97w6rhAe3yYhea62r6Em6rVqgv6qh
         fdQT8ZJ5P9in9UmHfUfD0tGbc0/ZbGIzvT7JFslxSzxadCyB6yZfugvlNiKy/8SoP0Ni
         yqADc1nE6ypt9hhTJYGA2HBHqo5Ai+Yelb3dZDJKNEtwEhlz/wZrgXwFTG70hjFrffGH
         8Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769717645; x=1770322445;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah62uVII4bpGINCtv2EecA/fYEjxfB2Q3uY5lFqDvXs=;
        b=T7dXqtTUzx+YU9GX/JppXbYsZ8Jhcnfaga6FgwRfL5w7jfQaKFnmTkqb6WRVTVIgMT
         6UbpGf2v8ve1Eymej2JueZA2N1pr2jnhXVhf+PokrCkwck927bhebPpLs53ARXFvLCbP
         JEFVrcGCgwMIhxLa0qRgiO/ISh2t3F0DsWZmqBevHiJmsMu4d1asKNDjK5ZkZN9uDG/I
         DQacCzJJiWxPVeZs9L5eCJYGG2CQXZSm1yPSQBbYm9MEake+8wAiiJMz+3VQnOpyp7hp
         HFA/iGFkmvKD6f8WnEOIVzS93MCzb4be4B6FfIXqwvFhe/F1ItGtm+2evEF+Bk2w9QXz
         GuTA==
X-Gm-Message-State: AOJu0YyNdGaKLWikkLHop2fK85kos1kqXfE70w7XeZxtVFBMx64lBeOX
	pakmiTwI6VwryDeS2zIDTG3hhnJARogVx4a+hwyGvPyPVMDnpOQsdwOnxPx9kinr
X-Gm-Gg: AZuq6aIaFjHAI/Bf2Z72j1IWgJ4VMy4W6ANqMSjby2MIQL3xigkHCPrYNea/XA+0OEU
	U/mICqQWswUmz/xDrAdYISreDwANvGkPnFKx/Z1vX0sAyL7iYR3jNhus5iLY4Jgc3Fz3Mryk2PM
	2xs0ovfZQ+ijg3FBLVnNJ45U6KX92YFfvXC7MvsxJagnz+ZphG9hdPQhUqncMdViW19T6zsOBzv
	oitKDfHPsusBZZjQD7OAEhQHc+RCEuPBbNOoL7CTOHdI3Xb99JjzqfWCHHD/jpOJiOJNq0ZW9ZM
	VoleVljLmE0VrDRJXoLBvLsbgPz7/90FSkFrTao9d5qN6Fq23Kof3rtpIRUQvW0WqP0Qgvhshjs
	04oolNx4uvwwPY0NUdaBnglwLWZ1N0/ycWYHL0e+UuH5QLEY3pFVo4CC+xlCIbWk7AHDuKbbJcd
	2mkkbazk+3urv21w==
X-Received: by 2002:a05:620a:1a8b:b0:8c6:b14b:8a71 with SMTP id af79cd13be357-8c9eb22eefdmr132769185a.14.1769717644887;
        Thu, 29 Jan 2026 12:14:04 -0800 (PST)
Received: from [172.17.0.2] ([4.236.151.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c43besm45222466d6.23.2026.01.29.12.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 12:14:04 -0800 (PST)
Message-ID: <697bbf8c.d40a0220.620a0.da36@mx.google.com>
Date: Thu, 29 Jan 2026 12:14:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0217791061018761322=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com
Subject: RE: power: sequencing: extend WCN driver to support WCN399x device
In-Reply-To: <20260106-wcn3990-pwrctl-v2-1-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-1-0386204328be@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0217791061018761322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1038744

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 FAIL      2.09 seconds
BuildKernel                   PASS      25.68 seconds
CheckAllWarning               PASS      28.17 seconds
CheckSparse                   WARNING   32.60 seconds
BuildKernel32                 PASS      24.79 seconds
TestRunnerSetup               PASS      553.52 seconds
TestRunner_l2cap-tester       PASS      28.00 seconds
TestRunner_iso-tester         PASS      80.40 seconds
TestRunner_bnep-tester        PASS      6.29 seconds
TestRunner_mgmt-tester        FAIL      116.50 seconds
TestRunner_rfcomm-tester      PASS      9.58 seconds
TestRunner_sco-tester         FAIL      14.40 seconds
TestRunner_ioctl-tester       PASS      10.21 seconds
TestRunner_mesh-tester        FAIL      11.51 seconds
TestRunner_smp-tester         PASS      8.58 seconds
TestRunner_userchan-tester    PASS      6.99 seconds
IncrementalBuild              PENDING   0.54 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btqca.c:1044:1: error: bad constant expressiondrivers/bluetooth/btqca.c:1045:1: error: bad constant expressiondrivers/bluetooth/btqca.c:1046:1: error: bad constant expressiondrivers/bluetooth/btqca.c:1046:1: error: bad constant expression
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
Mesh - Send cancel - 1                               Timed out    1.870 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0217791061018761322==--
