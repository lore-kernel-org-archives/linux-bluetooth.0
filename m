Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8801FCD1F
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 04:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752726681; cv=none; b=mqaGT07FY+NtbZtulBugA4R0ukAG94ZAQhrIZPYnkR1WkzxIV5dMbCassqAFed5UCPn4lkCjiB8EGMJwrbLQgCcC/qarnjExDtxWaIYSk5J+0MZ5M3f3XG7UyyF2HLWLOA11ncpWWN6ZOaHqbceNL4EhfhGh3HHAp0PJ50I6lYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752726681; c=relaxed/simple;
	bh=CPkKuG5KWSTjKxYmzzpusDnvIZoHrq8DDEOhPPDCEOw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tzqb4OrPaJ6tUQUa+s2fdZbUD7txwThxShnvoyLI+isnyD2jA9Fmrd11CNpmbsRFqWoCZjVNJwa+ynKTfui6Zl6divNnujeiKeLgib2EdBgkY1UJbI2DR4hHjDAV0JDPuNWpL+9W9RKrq2i186rYf4/faGo3dW2WXRrVJ5rPcSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9SzCbU+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9SzCbU+"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-749068b9b63so441388b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 21:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752726678; x=1753331478; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hA6tQAAV/N/AbY+Z7p1er3IyjMon8aRWyuZ5m2BjnSw=;
        b=f9SzCbU+90JgxaZTdw1boJPMBA5nomOCt7xOCZFNTkNVT9JoEsaUAUBms/JxZklaDW
         cq8H7tp3cbVQkD8eptSOLE9bn3tIOhDfofme6MmAh0x58INJvY79Se1oekE78bMPYKLs
         31c9AeUmp0ddKNak9mYkJPLF2mKgz/S+V1qtf1vdDWQxpPGfl4aF0On5G1FHxZW+Os9J
         yVp1g29K7Rm3yB/cFUI1xvyDDoiXIE9chI3051J/IXK6jKKAOBtbtA1TNtIJLPLG/pM4
         A5FfaqhlHP+BMBJbYIqIQDzyksPeQZaCgAB8e9Nrd9g698oh4pxRSkMWlGrxwKAxBM5R
         YtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752726678; x=1753331478;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hA6tQAAV/N/AbY+Z7p1er3IyjMon8aRWyuZ5m2BjnSw=;
        b=s+1lIMcxyQyRVrcau2FqJjQcZSHi8DHh+iEF7VOI8WSFOqtasfdDS3XMl8RNFk9Ffo
         +Hb0iEgkjBEXfG1V5duGiWA0LjP+w6xc6wkgFUzFQzWh6SUhBbk96M2avh4kGh/HKgGe
         rGzG6k/+fDYPyJHvZ7yJxiCagbyIEzyf/xDlkVg8kajavfkb4ZMGm5t3i3UFnZlCKkie
         O/o6P1pFQ52K+1oW4QFmr52ARG7v+qzFESIWG9nNXsUUQxejxFfZjvidp2mL/hlrqhbX
         VBc2wZOINdXVhdY8AY1D8tbgdTa6QvQGBvk9nfuZT+56c6/6qtULVJVVTRLtN6BdoRWK
         Ayvw==
X-Gm-Message-State: AOJu0Yzny1K6MX0ogBENdgfzBPSerI3IWANR36ZQ0h21V0vP3mvt7e1J
	59gTduH2WBcgjvmbpd7pkpWCw4+yoO8Egvldjd8PHPR3Hh29QhMk3gkEsP3Fag==
X-Gm-Gg: ASbGncvpDakipeQe08rhTdTBqOOz9prRJ17/KR60illhPMLx79mjN/vfsjxbwmubTMm
	J6ipMredPM4QVTbJCrfr0wqptKBU2HPdQH0Q1Oepd2M1Yb4WvJVnm3TnWINyAwQk91ohwZFm6m5
	RxTNz1Sap21eZ1bXItvc0n+MrHPkA2DCO9Y3d/EyJEZKTO3wSiCNGv9HYGq5B3ycIiNAPjavygg
	BRblbO/U2cN+zXHeYqwAeS5y3ojvTHNFoWJIWhAgdlAdFm23a3qqpKMwV976+L21SsVeGZgVijt
	JdATIPdowWLIG6ZUXUp80PtR4meWmTJ1754S89lueu6Gi9xxobM7K3sqpg+kLqrucrfko5IRJav
	ohRmcx/r5dDzk554gGF1occQ34dkW6BwuZYnbuXY=
X-Google-Smtp-Source: AGHT+IEUhMrkcDmEBbmUJhiGS9yL4akLFcOsFSp3SjUt3ffZSzD8AXxLOkPHvyAce24xSBK+Xvahmw==
X-Received: by 2002:a05:6a21:1fc1:b0:226:492:3f82 with SMTP id adf61e73a8af0-237d701a6camr10788594637.22.1752726678462;
        Wed, 16 Jul 2025 21:31:18 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.141.35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f841csm14421269a12.57.2025.07.16.21.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 21:31:18 -0700 (PDT)
Message-ID: <68787c96.630a0220.afe42.7228@mx.google.com>
Date: Wed, 16 Jul 2025 21:31:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6977518472337622277=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, salah.triki@gmail.com
Subject: RE: Bluetooth: btintel_pcie: Drop pci_set_drvdata(pdev, NULL)
In-Reply-To: <aHhtIL3jyVbCEMqh@pc>
References: <aHhtIL3jyVbCEMqh@pc>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6977518472337622277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=983173

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      23.84 seconds
CheckAllWarning               PASS      26.62 seconds
CheckSparse                   PASS      30.36 seconds
BuildKernel32                 PASS      23.83 seconds
TestRunnerSetup               PASS      471.64 seconds
TestRunner_l2cap-tester       PASS      25.18 seconds
TestRunner_iso-tester         PASS      42.60 seconds
TestRunner_bnep-tester        PASS      5.92 seconds
TestRunner_mgmt-tester        PASS      132.54 seconds
TestRunner_rfcomm-tester      PASS      9.34 seconds
TestRunner_sco-tester         PASS      14.70 seconds
TestRunner_ioctl-tester       PASS      9.97 seconds
TestRunner_mesh-tester        FAIL      11.37 seconds
TestRunner_smp-tester         PASS      8.51 seconds
TestRunner_userchan-tester    PASS      6.17 seconds
IncrementalBuild              PENDING   0.61 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.068 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6977518472337622277==--
