Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683F31E832
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859404; cv=none; b=Vf5P1nP1g/Mj06CbtUCDCBfLSAOnlX9M9rdOgnTqepS+7t4No6r05DiA8SfWAvzUF3/82A0WR4MMVaZIKXa+IKlODQ3s6ChGyIrOVG9Y8bAdZbCwYCTjprxEODUYWoyz752bI1WBOWIr28p4jBMJGx5T7+/Z61oi53Jvt1/cmmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859404; c=relaxed/simple;
	bh=ZSUw2E6HIEj4khtwnP8RLnsqOI6Gv49W3jTye7LNHxg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=febGbr2THwQ0gIbT0mdLR//TMhmOiWeVF2+OM0YUk6cPNhB7jh5ztwrhEod8Xto2IAAhR6mQj82VmF84Rbceda/6gUfa7Unws3rTx/HtU9sP0iE1eG0iT7zo0ZGgsMupwtKm0cgNxyUppIkee8YTzff1hvpQaxk1OPO67Lrt2B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7P6zarO; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7P6zarO"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50b69bf5638so46677081cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 01:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859402; x=1775464202; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wMnDAdcbiBk1tATOCqFYBWYucZMEBDrp7PkASYTdl00=;
        b=P7P6zarO2Sfu3bsSwrhS3Xcr3xlqx5a4WzpsM0dgxWiBBce4hLbT3BHsAc/jKd56DQ
         MUg/4kYP29YvZvYtevPvBg4TF5kKQC49iQlBb1p/us+vvvGsklH3Z4uLnHlgfwRux8aW
         mrQ7WoQuOqTHHXKHcAJApEs9ofSWJkQkL8WIp8YSPDXu04e53hK5eMFuEdXvS570mdAP
         Edl7xUsmTsbnYVk7FQ6DPT/NdWJuqbY0hA00/q8emfZPlEFS4ICm9/zRcOq5vaHJpEeg
         ctxR1yz39bX2P0HUnE4mL5sK1JGW8JhxrWnBhEaQid2GBM7/W7TuV0f4yHf4zsKhiS6q
         A7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859402; x=1775464202;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMnDAdcbiBk1tATOCqFYBWYucZMEBDrp7PkASYTdl00=;
        b=Ne08V4nXQWq14G7+5qgi7PMB/Ks9L56YEUzVocSzP7rVlD5sEwyE88Y6pTyJ03vz1G
         NRUQz6e7OHbOCCEBNToh4vkA0OrP4MknGlE/oTYP7l9QCKw3npHw7grh14NBv7bLwZzs
         Bh57N50G0PGqEMDvidonTQ2XxFk0ApkJH0XJOcYV5kR4mxD/Ys2+YzLds7T//c+KrwmO
         K1ZTCSFH1LCbRcV5ECJBrYKtSAwJEqaEbrw9aOOY3Ak3CXE53VtbSQXdY8XJypqsIxDX
         0trpgFOLxg/lyilyCp9Mglg8VvEHbgQA0syJiA13P31dsUraQjYUJyfmiN8y4wtGYl85
         x85A==
X-Gm-Message-State: AOJu0Yzyn+vzFeCZsPRFiCI3VoH+0cDmR2Es3ZiphjUdCYOVaPzloNqk
	Mni4ZayZagoLI2/P6XA8hbdAioh6ieJmuaw2UiloMvcil/vG0kmyEe2TTUh7Jw==
X-Gm-Gg: ATEYQzzmJgWE+GjRvLnI6G5TVGIiUENb7EWd49p/6kWeMFWvfZ31K3a+YwgYuBkH07w
	msnOM/K4VwUx6Y9GqA+aiGdNNPRwhi718xzfecC/hIzPVvvYhjSZ/JJojXPwgugK/E724qsx+k5
	qUQf0tgpOdpY1T/dWKZQJ8i+P5b70mzilNKgSDy2J9juMM9cIhPQxiJjS2gGSy9NDlxbmah415i
	IjtygZBwh2Xb2JTeh4gH8xOK9iwvIxe/Zq5EJ0E3KXfyq7zn0UlCrnsxbquRVCOc40Tl7xFlcVj
	PdkChgKzgolAwx1vVgOy5pRQwZi0y2u5Ah1ebGOu60Mhxq5/tsdR/GrIO+EOcRPwZrhAZsTH4uj
	egcTxXcVtZlvyNU9PgNUIZh+39fSCv1lI1kC5SydAFhEPjIxBDqtt2Fy5BKtRnG6txGiRriqyrJ
	KylQ22wh+rdDJ0MEKFaUDBk568kv7emQ==
X-Received: by 2002:a05:622a:8:b0:509:2f5f:a178 with SMTP id d75a77b69052e-50ba3836481mr161771191cf.21.1774859401722;
        Mon, 30 Mar 2026 01:30:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.223.210])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2dd8d8esm59344221cf.14.2026.03.30.01.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:30:01 -0700 (PDT)
Message-ID: <69ca3489.050a0220.1c1d3f.dbc4@mx.google.com>
Date: Mon, 30 Mar 2026 01:30:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2471014707581400424=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie:Support Product level reset.
In-Reply-To: <20260330063842.1121545-1-chandrashekar.devegowda@intel.com>
References: <20260330063842.1121545-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2471014707581400424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074376

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.97 seconds
CheckAllWarning               PASS      29.12 seconds
CheckSparse                   PASS      27.49 seconds
BuildKernel32                 PASS      24.99 seconds
TestRunnerSetup               PASS      565.01 seconds
TestRunner_l2cap-tester       PASS      28.33 seconds
TestRunner_iso-tester         PASS      40.82 seconds
TestRunner_bnep-tester        PASS      6.28 seconds
TestRunner_mgmt-tester        FAIL      111.50 seconds
TestRunner_rfcomm-tester      PASS      9.43 seconds
TestRunner_sco-tester         FAIL      14.10 seconds
TestRunner_ioctl-tester       PASS      10.12 seconds
TestRunner_mesh-tester        FAIL      11.44 seconds
TestRunner_smp-tester         PASS      8.45 seconds
TestRunner_userchan-tester    PASS      6.61 seconds
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
Total: 494, Passed: 484 (98.0%), Failed: 6, Not Run: 4

Failed Test Cases
Adv. connectable & connected (central) - Success     Failed       0.128 seconds
Adv. non-connectable & connected (central) - Success Failed       0.120 seconds
Ext Adv. connectable & connected (central)           Failed       0.168 seconds
Ext Adv. non-connectable & connected (central)       Failed       0.168 seconds
Read Exp Feature - Success                           Failed       0.100 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.152 seconds
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
Mesh - Send cancel - 1                               Timed out    1.901 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2471014707581400424==--
