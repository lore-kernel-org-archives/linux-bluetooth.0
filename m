Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B43C2792
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125078; cv=none; b=Zv8GPb5vg3U46SiyEjbzDbwcNMIPlaKPTEPuXIftbSFRnhaly9DvNwQmL6wi6XtVBGjnq4ZzDY4ESBBrDCUiDPwYMFCkJaBZlb3bZ0yRQvDnbsPUBMGlMZp6D7XjbYfO73Rnl+pmFWJovPeov6K9JisvOh/dA4LaT2+7JJti0OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125078; c=relaxed/simple;
	bh=jJnyQ5Nw44gt2lckIlwGxfOdDsoy3oaE0yrcw7sdMds=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HXx8hNhr9Gb4ivEKssxxALtEIRnumGSSaZw3Buqkr4bUWNrr3LV0ZJMO+qev4Ba0SDWiDdxx6cEy7IFjRGYdII4cTCHv+2qCDs7qaU45B/HKwg9j13N/SaCwduYjzdVaCHTFpv21IlyoGU6S/3iba73aSMaJPrD669xOojiupWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/Nql+xg; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/Nql+xg"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cd8576a512so207188385a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775125076; x=1775729876; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3Xs9k3Y9jLPmvgJzJ83J3psyOnBZ1zB3b9bWuDBhTA=;
        b=Z/Nql+xgXCuKm5HJwST2HRABbzH8zi5G/WcaCoEmgXOJYDH6b6uWkKPUgf4d+v+5o1
         RC0Zbq7quDfvpdmX6iJqgDxJ7d6woZrTzUtl9rBJRSRQX3iTEDho/czNFxRfGRx6AD8g
         srdHOxSzop8VxYuHImHvVFuP76qFRg8kzhMSAutMs079pKLXYsLH8GJBZ4k2PaTc03hB
         ci2VYySgsoI/o4fP5LxdfjEHtUaNmvO4PMQTrLcup1zWRiIr2TO9vd2dbNWuK4eqog9N
         YLEePPqU03pPjPf/JZbwpIAmSlyGkybIZhUYQjezuqXXnvsBLE1qxVbsJOgzcdImfhHU
         rM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775125076; x=1775729876;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3Xs9k3Y9jLPmvgJzJ83J3psyOnBZ1zB3b9bWuDBhTA=;
        b=ZX4qB8UieYSI1QTCXKF64ZduCRvRXsxthjTXMcj3YnaCt+zWeNQ/eyxQfxm8nNV4hV
         Gl1IeWp12bNAFs5l51kxqwkyqPpSnY7wlSOABFz15s9Un8n67/skiKeytFyokf5q8lAL
         zg8mMb+lFI1EfY0bpkhGpF4ePEL5Os4psy2E6ffyI5B3dbB4vbk626Dd/ubBzlllv8vY
         75Ho3LqwxWkUzfJcNcS/i//Si5S3Ho1QoGfmck6QHHUGb2cxfRKa+ETM0d88C0S1iHHc
         CU/gbhedYUMdjwqTZJ023AZUQMR0u/UfU+fnyvqj4mTtIJ63onr88Ld2281U29O0dsY1
         ZfEQ==
X-Gm-Message-State: AOJu0YyngY1wrL92ntwbN0Tl4WetMG/4OgsLyN/NKHyQPywI3fUFvp5/
	NFUwhK6opBsyg2Rtox+EZOKJuT8LVCeuZ1OSoC3mk+9fuogQ/wTDFB8ZXx3wfA==
X-Gm-Gg: AeBDies1KiKRc3BEqjkeIRNvgvhRFODin5PLR2yPBfAsahmi3wCYex0d6hxfbuMNF9l
	O0W4OOnoB4eHiXX7lFSj6caY6myLjfVzAs2xyipAEFULUtLsb+jehwQTzFVhssEIMfpfftuRazV
	t2PPjfzCZxfE2Kim4+AhA44MVLUheTjaU5WrkN3oCI9U4BjYARybSnFbD4SPwRgaz6GZz1XNV7k
	eCGaMUwIOkvCVqKLYcfzjjXMl77obnw747bae9qb3uG3GbpMOmlrkUd8ZOxTMMqeAMRR1ZEvKvh
	VP6x03r0UH/mi3gfDsW8wy7HFeV9S4WAlhI13ML1ZTH8G2UGXR4IJHdBb59mEN/0pQRQHNiWfDR
	XG1EgMlqpSG2jvSKX1gOB7BKl3RV+uPOVRtYj81kH2XklpWoDJAvtFckK1hZx6OBcoOSAnGvnAt
	/iZn+YCLb0R9cYWk/bZFua7M0YILnw
X-Received: by 2002:a05:6214:20ec:b0:89e:bc13:aa36 with SMTP id 6a1803df08f44-8a5ec5d0a3bmr20088556d6.20.1775125075724;
        Thu, 02 Apr 2026 03:17:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.60.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5969158ddsm19178476d6.27.2026.04.02.03.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 03:17:55 -0700 (PDT)
Message-ID: <69ce4253.d40a0220.75c34.ec1c@mx.google.com>
Date: Thu, 02 Apr 2026 03:17:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5684730330334317487=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan@kernel.org
Subject: RE: Bluetooth: btusb: fix wakeup irq devres lifetime
In-Reply-To: <20260402092704.2346710-2-johan@kernel.org>
References: <20260402092704.2346710-2-johan@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5684730330334317487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1076322

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.33 seconds
BuildKernel                   PASS      26.00 seconds
CheckAllWarning               PASS      28.76 seconds
CheckSparse                   PASS      28.08 seconds
BuildKernel32                 PASS      25.80 seconds
TestRunnerSetup               PASS      568.36 seconds
TestRunner_l2cap-tester       PASS      28.28 seconds
TestRunner_iso-tester         PASS      44.15 seconds
TestRunner_bnep-tester        PASS      6.58 seconds
TestRunner_mgmt-tester        FAIL      117.31 seconds
TestRunner_rfcomm-tester      PASS      9.70 seconds
TestRunner_sco-tester         FAIL      14.50 seconds
TestRunner_ioctl-tester       PASS      10.31 seconds
TestRunner_mesh-tester        FAIL      12.76 seconds
TestRunner_smp-tester         PASS      8.81 seconds
TestRunner_userchan-tester    PASS      6.80 seconds
IncrementalBuild              PENDING   0.42 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
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
Mesh - Send cancel - 1                               Timed out    2.662 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5684730330334317487==--
