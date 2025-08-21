Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD2E27932F
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785956; cv=none; b=BNrCW3RxTHGH10WDUBd+nANCqSMvVIgv6AxyUW4N+cJsNrBQ8wJigsagbESO/3mXsjY3ZmZzkpi0GwohlGO4JvGw7kGxfTUjqZnYUd56qxnR1bZq/9+WhkOPX8xTsLRuxWHPNaAyp0OhX6BEq1C7pMRd+vJZOOeFS+r/VFAUNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785956; c=relaxed/simple;
	bh=mNelbnifxtgAaGrmRdlYUYJuy4bYmpfmAlnEnNONKmQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NJnI0W6gGtZrY+KzjcPEpoE+t2y/M7h73lDWTJIcFpX8MTCro7Uq6IFoBlmPueA530oo1vG8GYLIdog+PjOREkOLv1P4HIKUJMNiOmxXQKImdjtNC6t+uZCNNRZHZp6d8B5yDT3LoiKz+2Tds6ZQvY7DrID+qkvhNwdx6+MnJzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8+yuCVc; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8+yuCVc"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1039229b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755785954; x=1756390754; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hHrT4ruKfx9w9FwemkwbFGdgcArvTqutXsbtt77mpj8=;
        b=C8+yuCVciCrlG+VypcI0huvzB1Z9hmPJB75C27PCCgfGPJFvET/gFISDFSW7bJHOQd
         RIGI3YBYEFWjgKPWcdP8dkefN0Z0PjkMUf+2d5bM+Fbyv3vyi39t2QcU01V8ifwG4sjX
         Pb1qQcxB2igNLRWhgaMlLCzQG0l2GEYjob5+6A8P/p3Lr9VDZUFWMnto6J9zn1px2kvM
         K4l+GPNj9FttDtp4pt+JzXY14ywuDcVd3W0SgslhFWcTYRFuzW8cN7znMaHlwcnw1Oop
         /ZyYLerMDav8e5w4lQPcseFkvARlC56vKMruOhl05DHUNXNfTXLkoQDEVjM04o4cdWhx
         wjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785954; x=1756390754;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHrT4ruKfx9w9FwemkwbFGdgcArvTqutXsbtt77mpj8=;
        b=QrF/8dHmsxYwYLrLDHRFPwXhFNgTfGVUCjiMKXOzXWuq1NqSShBfqbUqUNfPQ9gxoV
         0V1MAw8PxXoUj9x9jDPW2p3b1P+81Dpt7Q0gZSO25gLDo6RLL8fv2cAz94YlyDf8ZcXg
         TvSTyWvkBx75o6psWIQrcGz90VBuXfmjQMYKuefEMXiw/cmdbTkqGKvJkviG5QuZP4dF
         Of1wa4xFLDjZAOd4GQ9C8EX5Bj3eGk4D9Gh0z22hx/r1a/uVnPwzaoYRyQa3zHkzXfmw
         Bi8gxCZ8Z8DcMqzVkH9UbySefDRBfvWivOGfRUwwnHENnCYA4Jyh/k4t2bXw3nkjdW30
         ig+A==
X-Gm-Message-State: AOJu0YyCmBi6MtMHcFcNTrKUE7pYT5oAiKWQyU9wgglx305kpoaf/m9k
	pMwCo0r2K8GcK7W6ErX3uOehBxGdpHRSQYZ1NzwPH34RfvoBcUiCAqOVVraa6w==
X-Gm-Gg: ASbGncviALW//DB6VszDwQOx+kGewz7+W6Qk51u2GKeqDUiT+Xrrl3LniSE/0rLCDQg
	OhX59Zo1Ihov7wPbr+9h4akCKdHGvLc46ZvwIf2JkNVZ2C1KQxCEuYrbeXb7NsfPVnQ5mnuACEE
	gR/82m63Cio3WgklF+R+9W2ClOAWY7aLwsxpcSXA9+ft89t0roOkWZDGDlQoEDorHubgnhfjVta
	MU8cScp0iSsyzvi3eSHbpjSmXo1KU6cjJtPzius948Dk3G2Wd8RKxtOEeXdszvfg7ldyguyXUKu
	H85dqiS/zKdNVs4eIDPb2nVn1ioSBDaHxWrTLR0qWz9obqD38Ro1LezW9i7Y53J01wJkjvPwdoh
	G6QZXk+k+4AGOmeJgDa42c328rxA=
X-Google-Smtp-Source: AGHT+IHFLSFVfyYml+syIkkPfCg7+6jkeccUfN0J0hRldGQKH9RcKK0a+8ml7XWXtovk76aQ6Iybfg==
X-Received: by 2002:a05:6a21:32a0:b0:243:25b0:232b with SMTP id adf61e73a8af0-243306a8286mr3765450637.9.1755785953488;
        Thu, 21 Aug 2025 07:19:13 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.161.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f2c4970fsm2062667a91.27.2025.08.21.07.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 07:19:13 -0700 (PDT)
Message-ID: <68a72ae1.170a0220.fa77f.78ed@mx.google.com>
Date: Thu, 21 Aug 2025 07:19:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5588888182098087994=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_event: Detect if HCI_EV_NUM_COMP_PKTS is unbalanced
In-Reply-To: <20250821134714.2032684-1-luiz.dentz@gmail.com>
References: <20250821134714.2032684-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5588888182098087994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=994058

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.40 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.12 seconds
CheckAllWarning               PASS      26.63 seconds
CheckSparse                   WARNING   29.93 seconds
BuildKernel32                 PASS      24.29 seconds
TestRunnerSetup               PASS      485.93 seconds
TestRunner_l2cap-tester       PASS      25.76 seconds
TestRunner_iso-tester         PASS      41.22 seconds
TestRunner_bnep-tester        PASS      6.21 seconds
TestRunner_mgmt-tester        FAIL      131.90 seconds
TestRunner_rfcomm-tester      PASS      9.67 seconds
TestRunner_sco-tester         PASS      15.02 seconds
TestRunner_ioctl-tester       PASS      10.43 seconds
TestRunner_mesh-tester        FAIL      11.63 seconds
TestRunner_smp-tester         PASS      8.88 seconds
TestRunner_userchan-tester    PASS      6.50 seconds
IncrementalBuild              PENDING   1.01 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.112 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.893 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5588888182098087994==--
