Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B338C418
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549854; cv=none; b=pvvlzmgWocWsBWhtFQJ598mXkymNzTppFaMqCHxCAGqz68pcOPdyFnGqxvWDf/df9uJZZd8XybzyAOWnmZBPA0FShi2+su3JOA2Vlf0nqLZQpEhPTrdtxFSlyqRTf6b7N9seLzn8Ng1qe0XQQllMNV5ROPbbdAQR/ANg5TNxvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549854; c=relaxed/simple;
	bh=0K590GKDlX1hbhr8U1hQ82tFOSE/2faacKAKznPFjkQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UkzH/WQWoBHnNLhjFKANXl2AH+gYMMly9X2zTcFspRlyTQJBUP0l9TXD44TTqMGW9xvU+j9ZO7REKGfypPDImTuaQfT2P5A6NXlFpQrEVurAUqzgtsogQMGhLGazO78nBksSUIz6/0SFgeXeOrPjZreAL+di0KhjJLxXb+k+/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p86czask; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p86czask"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c736261ee8dso1518130a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775549853; x=1776154653; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/E1IF5JW5+cn+P3cWCAExKJyUAcYvMhA5De0KFasGAc=;
        b=p86czask6eoSMKmEA46aZFBPKB2HWSM+ZlSuqIbZKtKrDTT5s445p8QwUp9MvGX+/G
         guQnmK084IfTR0JF2QWw6aKzziOO4td3aYkBi92eXpzNyx7w6/BIiQMQBOmO7PWwWI9r
         oCZajs5QODiPo8/mzlahEszFdecwS4JSm2Y0WQKVFtty0NS5IA+aM/F1WBUlBAx2JaK4
         XG1ZzBgHIqVFlx+RV3Ge98MshtFR4rqhUnkJbDruE63xF938mBHbHILAQz7mE84glSPq
         ve28RrKHJ+b117Yl6ByPxfCralxSh/4QuaOToloBELP3Z7MVrU/ndYT/2L+LqPVAFh3W
         QvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775549853; x=1776154653;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/E1IF5JW5+cn+P3cWCAExKJyUAcYvMhA5De0KFasGAc=;
        b=nhRaCgPLcNmJ6WR1haPS+inIS6JirxVLLm5mlYWR7X+GCAHclM/cR7zUkaeZ40pYqs
         PfC/H64cT9hxJ6Qyp7pjUkQIZCbv9xrijRvZEUDC59mLpY+lupX2ZT56wrRVetIXDSiM
         DCSBsE1IzNJQj3UInIlYH/1Q5FE6oSM/UnB5Mgvkepzc6An0GaBmlEjZR4Ll5QoRUTZE
         qaTdEZlAGKZwpQ0p71mirmCq6JC30X23VsCImwVMZ0ZobBDyLE80cAJwu83nFvRP3/xZ
         N0hbdY/OgvEHUtp6pRNZnPs1hel/0XFPmDy12JJ07VPivsjfZoGoTucSYza49Q9S2/k+
         /hsw==
X-Gm-Message-State: AOJu0YzieCyAO3sWg+Mu32ezyHY2S0Ekiu3IjHQ29+rw4PSOr+C2elpQ
	ZZuz/JZ6nJeQ5INKK1ltW0DgVKgV/zIo627rMXfXevYtWNRjaMYOBON8fLnvKg==
X-Gm-Gg: AeBDieuqC3lEpF8rpGrIaUwXYsqosVvraRRL0eieEjAq6mv3sl0AK/pekYP4iEBBkEW
	6SHb4LOr37IRX8FLhssvic2dGdzWfYLlykTCDIpdxGpd3f+5gaIckOXRbP+Z0fI7bUj44787Uy/
	QH4jcFVCK8SA9CeRKbzS/BQeKYoi2/fZNilGbjx2iehaXDBNRkz8Br4HAoPP2s+AlVl+q9a5iBm
	YhbER9znxfmkpYNS2J4TghKkSoA0BLYUCQ9kfp4dCfXUBKu/wBF38x0SjdqhFgNaT2mETROUghj
	9LyC/6RO10LikEGCmRefJNHQ//+uzEFcUbvavjFGzbwDpvHnwLhMrmz03wetV6RsEtqzyRHpLLO
	w+jKJ8m2uNvCYpjxEJs6U03gr3oDq+8u7sXI86D4Gnzm6uDERmP0ZEmVUff2Kg0r0zquyaMCpJF
	/gXo+zqdbprmeRIoEMP3w2nSQOgls=
X-Received: by 2002:a05:6a20:9144:b0:39b:e40b:fcae with SMTP id adf61e73a8af0-39f2edffbbfmr16438108637.10.1775549852611;
        Tue, 07 Apr 2026 01:17:32 -0700 (PDT)
Received: from [172.17.0.2] ([4.155.99.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6475b56sm15132295a12.1.2026.04.07.01.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:17:32 -0700 (PDT)
Message-ID: <69d4bd9c.050a0220.148f5d.4ad3@mx.google.com>
Date: Tue, 07 Apr 2026 01:17:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3279380764044077133=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [RESEND,v1] Bluetooth: btusb: MT7925: Add VID/PID 0e8d/8c38
In-Reply-To: <20260407065110.3037135-1-chris.lu@mediatek.com>
References: <20260407065110.3037135-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3279380764044077133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077969

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.41 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      25.99 seconds
CheckAllWarning               PASS      28.40 seconds
CheckSparse                   PASS      27.29 seconds
BuildKernel32                 PASS      25.17 seconds
TestRunnerSetup               PASS      568.26 seconds
TestRunner_l2cap-tester       PASS      27.83 seconds
TestRunner_iso-tester         PASS      37.00 seconds
TestRunner_bnep-tester        PASS      6.22 seconds
TestRunner_mgmt-tester        FAIL      115.15 seconds
TestRunner_rfcomm-tester      PASS      9.36 seconds
TestRunner_sco-tester         FAIL      14.31 seconds
TestRunner_ioctl-tester       PASS      10.23 seconds
TestRunner_mesh-tester        FAIL      12.57 seconds
TestRunner_smp-tester         PASS      8.72 seconds
TestRunner_userchan-tester    PASS      6.62 seconds
IncrementalBuild              PENDING   1.02 seconds

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
Read Exp Feature - Success                           Failed       0.111 seconds
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
Mesh - Send cancel - 1                               Timed out    2.654 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3279380764044077133==--
