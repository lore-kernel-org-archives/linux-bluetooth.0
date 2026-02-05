Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6935132E758
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Feb 2026 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770324617; cv=none; b=WnX2A8xlF6XBkxWgtQEeeqqukKiIYT28ssw0TTtTGILdXPA31nLbn70RPIRSp20YdekI1iXDrrbH6CXV9jw1/kzrptodcu3VfqczA7FjWv6E0XVwr4sHp8Apka2KtEz3BsIonq3nLThmIPKG4LOpU8dDnwppdf9pPrOWmWG3974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770324617; c=relaxed/simple;
	bh=XUPl2BMmzywntAcmMs9FkOJn26MAUzZtVTpacrMVTGc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oIYiIN2pEKkmVvljJA3dn13DOpp6UeCmPVwGnaGCLzxI8Uu3PixuZKhJSrmU7ubA91LzzPkGJLRgvBMxsXMiaN9exrDA7rsdF4Ij43+24UUsSplL+Mln4/VRoUC7TGX6d01J9by5BXo5Qhd3IOieuFcuItvi7JUpa7hlZVIKxwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxXpcWS0; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxXpcWS0"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-89505dd3e24so19218756d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Feb 2026 12:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770324615; x=1770929415; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ei3478/JI75G/Z1Gf3sRMNQ/OwLWwkikJCQAl7d/ILw=;
        b=XxXpcWS0G5hxrUkvlAQ7mJvLx0pJFFxlpZxIi3SkUWofuFTRWGhkoimU6icgduyncx
         t7uuMLuklRxbTv4sa/yq3qY+aa2FdUtOkm6ckyo5q6XRg5wn2kADZCGzX5C5McMdQnjN
         /ljknKWBAD8zOAE1/oEJsHrfPPpVzT+42gNXylzPG41dZaorVy+P7U9xMfB4PbRYHnij
         a28wS/GBr4xKiw/mCnBQRng9yOLBqzdtdh0vg0C7r0lU2bw/siWEp30nMqfwHUxrOnJY
         rx8UxE8asrwx/Ch3YMvIMYfpm2wJiAQqVgye4PNgiS/d6883/RlPg29rkvqu27T3hWKl
         fuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770324615; x=1770929415;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei3478/JI75G/Z1Gf3sRMNQ/OwLWwkikJCQAl7d/ILw=;
        b=qNV2XdC4eb35olUgdSczbAlomvIL+uNH+5qblktmbRY+/b473Wmf7uEQEqXg4dJU7F
         b1hzcy2cJm8p7gNiMzy5Iu8WFue+MH2E/dmlSTIR0BYKKlilLlxF0OI4qp8VtqdnUg+x
         jCdY4cAM1EJUy6o15iXGebqk3k363AvERV7rr/7PlfUqDVfl7sWNE1q1lBboU8NoJCUn
         KFuQRgjlI33cDQ10hgdsEp9J7JXPhhphgWK94J7TVM+J/x8IOSbgbc4DwN+s9CiY/egw
         pvWRM7NFoPQv+LCEV4rur4qf5T+7F3SpFpe1w3HlnPwXZDqoKOUs9CToBVcy0+aNTfJg
         giiQ==
X-Gm-Message-State: AOJu0YwI9Z3gGd7hzLWVHXpl289TRJ9ATwRbQMh5kCmHymBX8OdmjvR9
	pvp0FYz+bALGqejaO/eSJ8GqgTmEN3ZfyaVosD1r6lpBcKO4wumRqIO6//Em13R6
X-Gm-Gg: AZuq6aK/Lra+ZZNY432SdwF5uDkImgn+L47t3BMLnpht3VOdZbpzPT/UXCVcETbrvrO
	+RjQATOdsg93zgbiqcZGemyIID/38/PrFSCr6hRRheBNGXAqn9gs+tdELhB4WuJBTGOk1P98XAS
	XflqUdzh3xlj+4bXPAkC6Wj9CJcQfn9t5GrVhUhnibCIjhmSFoqxJQkc0MTO31J/hqQqjzKZm+V
	WpgouUx40J/3AFzllz91mKUgP9Rhmmb2oYFmNAz+4gGpQlsj4xj/tv//pNysx+uue8OJz5DYXHN
	3JU0HrXaQts2YFKj+a/VQhqHuX8bRI5/cqqGxka339rEnoAriVli0RtTvI8IuCWs7jL1QKetHPf
	U1GXhnViF/zazfCPcXjoKx/IXiI/j+Q/RnYJAhoPxFAghPDLviT4KN6PNqInppsiCsYqWCWg0eV
	wypcgttj2rO/Z9Tvbm
X-Received: by 2002:a05:6214:21c7:b0:88a:568b:f4af with SMTP id 6a1803df08f44-8953c82d3a8mr7251646d6.23.1770324614998;
        Thu, 05 Feb 2026 12:50:14 -0800 (PST)
Received: from [172.17.0.2] ([20.55.126.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c03efbasm4329236d6.31.2026.02.05.12.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:50:14 -0800 (PST)
Message-ID: <69850286.050a0220.71b0e.0a5a@mx.google.com>
Date: Thu, 05 Feb 2026 12:50:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4372296248204016142=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: L2CAP: Fix invalid response to L2CAP_ECRED_RECONF_REQ
In-Reply-To: <20260205195742.55530-1-luiz.dentz@gmail.com>
References: <20260205195742.55530-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4372296248204016142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1051296

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.23 seconds
CheckAllWarning               PASS      28.92 seconds
CheckSparse                   WARNING   32.28 seconds
BuildKernel32                 PASS      25.41 seconds
TestRunnerSetup               PASS      568.01 seconds
TestRunner_l2cap-tester       PASS      28.46 seconds
TestRunner_iso-tester         PASS      86.33 seconds
TestRunner_bnep-tester        PASS      6.42 seconds
TestRunner_mgmt-tester        FAIL      126.37 seconds
TestRunner_rfcomm-tester      PASS      9.69 seconds
TestRunner_sco-tester         FAIL      14.67 seconds
TestRunner_ioctl-tester       PASS      10.30 seconds
TestRunner_mesh-tester        FAIL      12.52 seconds
TestRunner_smp-tester         PASS      8.86 seconds
TestRunner_userchan-tester    PASS      6.75 seconds
IncrementalBuild              PENDING   1.00 seconds

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
net/bluetooth/l2cap_core.c:7762:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7763:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7765:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7766:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
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
Mesh - Send cancel - 1                               Timed out    2.733 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4372296248204016142==--
