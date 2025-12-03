Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759926561E
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Dec 2025 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764735226; cv=none; b=kqf2FPIzCceYFB0Q83HPb+xPlKIGO4XQEA4tnaL90GGypQ3PkrIurOqdEVu6oToY221qUByBYiDyLlx9bvbcEnDkuZIoLxtf/akNXfujD2/kWFV7p9Jghp07jBZqlEtz5OjKw2vG8zT5HfCtDHlTsUm8ymwVAzlxEDBZzZ4GRZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764735226; c=relaxed/simple;
	bh=LRmjzeZVcN8K9y88M5Hwf3j2XedHoEP9a6rxEXx7Jjk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o6dieOeRBFy5ri0rhAT6jR1Fc0G2kLYtvclQSeCUDvNaNMagd7Dr24v5JPuX1ScXePrm7HPfwiXAdrqgOFYw+LS6f1NYpCA5bUOI+XM5tlWZsaVpKnWex9C836VCYsK8GFY4LSA7eL0lIFi/h+da4P11oZ/CgY6lgtTXhjh6FKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JV7bU968; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV7bU968"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-450ac3ed719so3561997b6e.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Dec 2025 20:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764735223; x=1765340023; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=scnJG4R5yuVuNq7c7ECQmBVU8tjWi+M/lMUhfciawJ8=;
        b=JV7bU968ZBywkp0Inj5iMTmD1/suuYkRp65AW70frkeZ6Yki0A0HwRQRLzozw+7w99
         eaxaBN7PC4odBjIM9SLnI6JBVXZDUPWl0SS+BjpOAqFgPMMHRcIpYHCCdLH1GP6RD7ce
         ppBjcdbonKWre0g7ks6jMREe3fcKspLiVRjTKE0nkpJnSpPR69ft5gAqf3Bhd/+ax/9s
         zms5/jEFRhNAD2w404CUSDXEJL/r7PDr+bmh0D9uxIpDrJAHhE+/giSpaWJwF4CIkdss
         X9HCqCZlQuksMPHZNlWC24XuDRo4KrdgL9XMJG8JP8fChj8oBJJb2jlLJU0anHMh7cif
         gC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764735223; x=1765340023;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scnJG4R5yuVuNq7c7ECQmBVU8tjWi+M/lMUhfciawJ8=;
        b=V2wMfzzUPFlozRuboJuec7kEkGgK7Q68Z0JwJzo380B62S3iE+e+2iTBS141Ud7u38
         ywNAzvxB071vAkA8y9k9/EYqfszbcx2+puwNbuqNDKr+A/jIu4Kcd6NRAcubAEIf+miP
         IceLcNJs1127zWP7xje01xj5qsnTRmEqFXt1T8Nd8GlaVKRmaMiNPfeDhyc9cNme2ky9
         FAHogkFpL8hA46rqIIDuExW6OS/etSNLNZOj4BCRaTyCQGtPlXlrKpU+C0NF27oweTUJ
         uiMq2mflsPCHigGjNfuetT9+kgEBBWjdtZmkxwKHieBy+VyCOAkkzjbMf86glXpdwRRb
         glGA==
X-Gm-Message-State: AOJu0YzSxkNOWh+kFyBr5LkQEWFqDr5YZGxTi9Xmn//m3560kpp5Z6od
	mnTSdyJjPx0qLW0hmCa+UMONEadKHxxVLEA8ZLXuJeN4eQrwHrux7gFSn45mfQ==
X-Gm-Gg: ASbGncvtEKfTlS+oLSsjieEEv0ah8iIzZNVf/TIP26elZBtW6P7z/wJG34ZVdKep401
	vJFD8YL1R2BiYi504KfQWs83oiiSn1+AhpWnus1Q6M/BhTObHkRMANK89VBon2J6MYsEyV260sY
	47uWOtgMqSI7PtoP3Rfkn3nCcXvOF4aSZXDPj63PekSu4hNQPSwxTcQI1Taz55C1TSGfH75bUgZ
	no0Z5PPUwIKmr+UCl/oieAa5mrN6ahrWwdAghbJXpOnpF7BNsiF9rGc2wWmqLjaynBQbGZYa30Y
	fJz0QStx+J07/mmQY98hDcdWNKYTYl39wI7oimhTWqRjXhQnHM+r035nYawFhSFJIZZjnDT6Z14
	K/aRAXYujnvOUIV5BDrHr7Xwpkr4l3dC6MwP6wPm4crd2znBp8qwNq4YqreuRsnBSlmP65MdoA/
	3tVs7vff1uBETjyCCSJQ==
X-Google-Smtp-Source: AGHT+IG3rmf9WHjL8ULzySgM3HimmA34FEb48+WOUHUHNelMIZAuQZdOFgLEn1ieeaZ9QlDT3rN+TQ==
X-Received: by 2002:a05:6808:1927:b0:44d:aa8b:58f6 with SMTP id 5614622812f47-4536e396cc2mr414280b6e.1.1764735223447;
        Tue, 02 Dec 2025 20:13:43 -0800 (PST)
Received: from [172.17.0.2] ([52.176.124.178])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933df2d66sm5084974eaf.16.2025.12.02.20.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 20:13:42 -0800 (PST)
Message-ID: <692fb8f6.050a0220.1d2a.4f02@mx.google.com>
Date: Tue, 02 Dec 2025 20:13:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8415388980135974827=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail when BT_EN is pulled up by hw
In-Reply-To: <20251203033712.446632-2-shuai.zhang@oss.qualcomm.com>
References: <20251203033712.446632-2-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8415388980135974827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1029950

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.34 seconds
CheckAllWarning               PASS      27.78 seconds
CheckSparse                   PASS      31.12 seconds
BuildKernel32                 PASS      24.85 seconds
TestRunnerSetup               PASS      548.21 seconds
TestRunner_l2cap-tester       PASS      23.96 seconds
TestRunner_iso-tester         PASS      88.23 seconds
TestRunner_bnep-tester        PASS      6.17 seconds
TestRunner_mgmt-tester        FAIL      124.77 seconds
TestRunner_rfcomm-tester      PASS      9.24 seconds
TestRunner_sco-tester         FAIL      14.24 seconds
TestRunner_ioctl-tester       PASS      10.01 seconds
TestRunner_mesh-tester        FAIL      11.40 seconds
TestRunner_smp-tester         PASS      8.48 seconds
TestRunner_userchan-tester    PASS      6.53 seconds
IncrementalBuild              PENDING   0.88 seconds

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
Read Exp Feature - Success                           Failed       0.106 seconds
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
Mesh - Send cancel - 1                               Timed out    1.929 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8415388980135974827==--
