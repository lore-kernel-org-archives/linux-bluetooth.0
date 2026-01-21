Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FF4313261
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966708; cv=none; b=iPZzGEqrJKG8A0BFQzsbENyJiKqAO0g+5MP54KiqEJeJXbSRB/DF7sMov1/fgny2j6PEtPYdIoAf6Hf5rCwoQZmpTe0qZFaiiJe/GSkenT6tb2vskWBleRPRwQjoUk71+xr6u24k20EGsEXkVBG7H3ma3Jl4llyiMGGynNbrOrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966708; c=relaxed/simple;
	bh=Tn+HVWQBd6f2LKZsR53Rx1CxQG82OT1gqOmzjpbR+l0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TYM2PQDEXu8jvNWHjitd4TP4C1Ng01J1w5+/3ySxSeb5aTs1eqtm3eOOtp1jhicbi6n8sUmMJXv1BvawVodv+7/SApowYMseg5D7hKP4ezO+pO1dvtFAaW5DRkDut9xwd1TOWbWhRlN0zAVlTWLUdwH/8q9aQHEjqbHPxv8a6bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZifkMDh; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZifkMDh"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b1981ca515so6631864eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 19:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768966706; x=1769571506; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s5jwbR7kJSWuxilee4l101xKkynMRaIA/k2HpsCXo94=;
        b=cZifkMDhDfFQtjsKrgCz4DciWWF59OavwzrNGKBLo0H0fILaJSFDDiUQZ0qzDZRWpd
         9rSlfX5IkLgkkEjqQwMwSG5ZvOyiPBXfLurROMijIdpjEB3RbCGCIeQn8EMfaaQFfYas
         tKVsTOB7f/RBP0K+u1RwaoTf1MCXBFFw3mDNTHCSQOXTQempP8EDQygOr8nE+jsRp+mM
         HbdGEZz7HRzZ5CPubdsrKwlyxSYBzBlEBp9++ul5k8p3EB9M/4EHVDZBVtCCzBHl2QYw
         RTDg0xasK4MK1xvJ7xiU0wqIhPd8ZL34BbjBGqB4yt+FplPaCxRR2ANTYxxMLAZQQcm9
         DGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768966706; x=1769571506;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5jwbR7kJSWuxilee4l101xKkynMRaIA/k2HpsCXo94=;
        b=Ik8/QQtifn5ID8bTe+4lOwF8MCIATRtpY+SwEZg+KNrjf4paSDhsAiYS1v9u6S8y4g
         ByNfFgFVzIx1pT4rGgf5FPI5JLkzFCjev4h8rKPy+vqn7yP84k6eydlMlgr5EXbzxQBD
         uPIeAEpIYvRD+3uBXnER2fUI/APCEkZtcbw9ft4HsxfFI1Cifas2JQuTE9A7kqWizlIl
         FW4Dzp5I2U5XOgCnNKIixlTAEnKIB2Gv9MywWDa8t3nzKNyKgB5eXBynDhSSNbA41lA9
         NemCIeHTI8boZHbIRDH8f4l2KnGP6Jn5QEBXB5n+QAtaxArwfZ2vsafsbQnTUKlXAmCh
         wRWQ==
X-Gm-Message-State: AOJu0Yy5wk7DzrUXVZEa1jE+B8V/M+qQISZaX0h6Q2HdOuUnaJ3dwXwC
	w/JRejGHcD0Bdovry8B6T/lv+D75zDuRodFcomicOn4Zi0itXH44+r+E9jREqk71
X-Gm-Gg: AZuq6aKXJw0D6fex5M1hpFucwNPA4TTC6c3p4zzxdccG/mOx1Y5PKhy0zKQw4LY+Ph9
	ZmaN0Sw/yV/G5ZrR1vOXiqAR9Ku2XRFnyq7ljHSzBzWsJE1TM/7BrQQGc3is/FZu+Tce6SIOB/W
	mngLl6Or+Q4qaaTTwWQY5DtfbiaZWNpZkXsm6FDMq9FHQOZh37OCyv+fEBUJfQ+wKpEmjABgxaQ
	dRrYcyPzUoW0nn7gwF6OjZ0KqjMcPZ7UNFAymFmo/JI8rdKVyyWEpPWHBbTqxNJIJhziQrlm31O
	hdPAdv2ciKHbZj7wBf//PqsTRpsuIC3lzzBu5wAhjhUidq7/j7hy5V4WednL++3Wck5gc5490hG
	u1tImShx2Zz3C6+wN5BMWbNuJU3X5bdkOX0Rl8eV5ESnzPuq3bHBPiIkyXGy1NdRnixsPtgDyom
	q2gwE9HSD+yKSPVA==
X-Received: by 2002:a05:693c:3005:b0:2ae:5e93:b69 with SMTP id 5a478bee46e88-2b6fd7c5863mr2535588eec.29.1768966705966;
        Tue, 20 Jan 2026 19:38:25 -0800 (PST)
Received: from [172.17.0.2] ([13.83.162.1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7171be2dcsm169676eec.11.2026.01.20.19.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 19:38:25 -0800 (PST)
Message-ID: <69704a31.050a0220.6f5d9.8548@mx.google.com>
Date: Tue, 20 Jan 2026 19:38:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4288342938691042600=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lilinmao@kylinos.cn
Subject: RE: Bluetooth: btusb: Remove duplicate entry for 0x13d3/0x3618
In-Reply-To: <20260121025220.2827845-1-lilinmao@kylinos.cn>
References: <20260121025220.2827845-1-lilinmao@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4288342938691042600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1044940

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.36 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.48 seconds
CheckAllWarning               PASS      29.14 seconds
CheckSparse                   PASS      32.36 seconds
BuildKernel32                 PASS      26.18 seconds
TestRunnerSetup               PASS      572.05 seconds
TestRunner_l2cap-tester       PASS      28.56 seconds
TestRunner_iso-tester         FAIL      48.88 seconds
TestRunner_bnep-tester        PASS      6.43 seconds
TestRunner_mgmt-tester        FAIL      124.80 seconds
TestRunner_rfcomm-tester      PASS      9.49 seconds
TestRunner_sco-tester         FAIL      14.62 seconds
TestRunner_ioctl-tester       PASS      10.41 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      8.71 seconds
TestRunner_userchan-tester    PASS      6.61 seconds
IncrementalBuild              PENDING   1.03 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.177 seconds
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
Mesh - Send cancel - 1                               Timed out    1.831 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4288342938691042600==--
