Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D689013C3F2
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Nov 2025 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762682214; cv=none; b=aoRo6WGayhFIzwi85xoB2cxJvMOCJ2HOhcGn0ohUxZTaWOGBMe/7d2bRPi1B0rGolLyXFsHhnnoGXvRJUgcWKjw6ilvoHickbZLtMrhH2hOIFD7QZGWxbdY2rRY1ywjTEI9dQTqYci/gP+e3E5YNz671wJZBbXGTpwkpakfcO3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762682214; c=relaxed/simple;
	bh=p1fSQVF2O0oUYxUqMezXgpPhq/6Q5j+jrAcglZptYSU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Wfxl0NAWORKdvCHjNzZrl+OeADFz+pt5Pm217a0gPyeBoprG5XDZNZERs7EciPv4FYoMV85r9x0OR9sbMhAh38o2OW1riqBLK81itBqSq8lJpuI8PiUbA/ncDTiOIyku/d1WawlyfZgNQBQ3+P8J4teGFJrVQzGgdFUIPqiozXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThZeU9Pz; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThZeU9Pz"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ba488b064cbso1394255a12.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Nov 2025 01:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762682212; x=1763287012; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pSHpxNMM2MyIoXDsxEmCb2DhdY+GJUeogBeAIM60IVc=;
        b=ThZeU9PzN6ILzJeWea2RLataLC70pazE8hIafuPyEQ8hSdoErWWmZgGgPeHI2eca9K
         VLRLulDbvEKtN623/ltBny8QY72V+H+LDpR5elwnAiw7XL1TK8nmNJdOW4RibP0YE+J7
         E7myIsiNMm0MDISmIO56dsEQh/tXd7niJ7t9XNdn1N2ds2aUbRTIxwwi6lT4jHOkNGq+
         NJ+/0Ar8iODIOWjT2VYI9eYpsTnd4qFbllDIM0Ex9LDRNFXeiyt4znFoOjVxHXluYDA6
         jlaD1OMpiu39xNDX7mH5n+K0bweWxrCoJaFPA4ONV+MzXhZb/V5JP/Cwm+hB9OhTXzkT
         GkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762682212; x=1763287012;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSHpxNMM2MyIoXDsxEmCb2DhdY+GJUeogBeAIM60IVc=;
        b=vcaZLRCefk1gxDZn7yXV/ejqiAqOu05gK+WHQl2Sp6/P/swhnx5N0Ri4nRJDWcZaNK
         WhiM8P1iQW5kItsewXro/HZ7XyNHYK+zxCgdwZBXxXAu50t97W6us5qdOwuia+SkquEc
         1IHz5tG2750wdl2XbzxRf1nL2k/vsPg938HF3E5+FvrtKfr/wi0jf7esAB1Rr14Ilw3R
         8FMwXDovfFVE74lIyq6fzSiqjsVrpLlLX79DjStrHYua69olKoZiTqr4iZqhzZwTfZd4
         QW/tu5pEs5TARteva2RcFmLLSZzd2I15k7/WMCp2dVWZ5ZV9rNjmoc9o7NCwBzTVEytr
         PHVw==
X-Gm-Message-State: AOJu0YyefllFcADw3PZZ99YrMmWeZmkU7ekXp6qLxXGTjpdtTJqWcny6
	6wu4jzOAAe7UDAImnHfHHykvlFVyY5Kgfvk8d2pgEn1kU8UnJ0T/ceiGqd0fpQ==
X-Gm-Gg: ASbGnctgymFjrTcBtPqIQqhVY0wFI+utKOPw6m21tK99sbwLDmR4jXqMBGkN3Gnyozx
	ROR2xXi4O570pgMvW7PQkWdANrTZjOrLNa6JYfVV++kES3hpiLTSPrQlYdbTIaN0eiU/UO4V7nx
	j+k+QzgHzq+2VszMScJuPcDFoIqOaLa8U/8PCwuGTr2i309BPolGLPTbnJD3NGBUANsxP0leu+F
	yJOMP7g16d0j4KCE/qRqF/ub//XOBEIYoa4H7GF0EUR2rj8ge5cS/EchL8FdNoADY9IXrjW/8S2
	x11aYOmG6fDydmMqJHEFtKcNAsEseXYP4XdEQ+B4D2Jv11GA0aZ5C/MA3IV85J1l0khKMmJ8D0h
	oToaTQ8w02vfAx54q7DZWZB2AWPMuHvkRIu9HdpGyclCU6HtepLG3u915cPmGJ7Y8R6yQAv7FDe
	zr7Oqg4YO9a8N/6NHJ
X-Google-Smtp-Source: AGHT+IEL3Un3q/xZsCPNg0IbsnckXQ1AMoVIXiWe/7BuujtlLBxTSF2HY7yUt/+l51/sVhDlryrakQ==
X-Received: by 2002:a17:903:283:b0:297:dabf:98f9 with SMTP id d9443c01a7336-297e4bfc3aemr69477345ad.0.1762682211857;
        Sun, 09 Nov 2025 01:56:51 -0800 (PST)
Received: from [172.17.0.2] ([52.159.244.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b90asm109891215ad.23.2025.11.09.01.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 01:56:51 -0800 (PST)
Message-ID: <69106563.170a0220.14025d.9036@mx.google.com>
Date: Sun, 09 Nov 2025 01:56:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7783499455520701365=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: Bluetooth: btusb: add new custom firmwares
In-Reply-To: <20251109092437.252022-2-quic_shuaz@quicinc.com>
References: <20251109092437.252022-2-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7783499455520701365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1021275

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.78 seconds
CheckAllWarning               PASS      28.01 seconds
CheckSparse                   PASS      31.55 seconds
BuildKernel32                 PASS      25.25 seconds
TestRunnerSetup               PASS      505.90 seconds
TestRunner_l2cap-tester       PASS      24.04 seconds
TestRunner_iso-tester         PASS      88.15 seconds
TestRunner_bnep-tester        PASS      6.08 seconds
TestRunner_mgmt-tester        FAIL      113.05 seconds
TestRunner_rfcomm-tester      PASS      9.18 seconds
TestRunner_sco-tester         PASS      14.30 seconds
TestRunner_ioctl-tester       PASS      9.97 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.34 seconds
TestRunner_userchan-tester    PASS      6.74 seconds
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
Total: 492, Passed: 486 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.165 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.912 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7783499455520701365==--
