Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E7C2D3ED7
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361540; cv=none; b=r/VcIgsl4/7z1q2/dAyYY12spVvBz+7mm/YVj/Vrjxah1SvkorWh456sbKG5aJDOLZBQIo8cA1moT56P2JbpDo3BertO6smnBZO9UZ/HTZBEelwsvVl7gFIC0aQPQ0XlmxEfMQDUzID6MvVYLhnh+82jmWyjbf7/9LOgz+89tMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361540; c=relaxed/simple;
	bh=dr6JM3jeXw/RdI9AFtgnlMm213giTFm7FwwukfZ+B1M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Wj6hNMYOKXAoWIKPYYb+ASaD5U1i/P3icQ2oBDcJCXP9ZJfEGcHHR3Hela7Cozj2xg6RrAeRvKbEbPeCt78BNmqk//6an1ZkrAZUktPWNj4aB6xeb8eo7LCNhEYPzxGJfb5lMc90KGHVVZ9uHvg5G5t+4uS9Vgaiog63jfEIeho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVRNnlu1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVRNnlu1"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235f9ea8d08so7050485ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 05:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753361538; x=1753966338; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1V/d/UnHHbMeCejrE2EXxMNq376QNMxalEsgPPOwfgY=;
        b=GVRNnlu1JwIFN5Jx1ZtyM3quayb/qoiGVrKDf9/SXSu15O08oqDtuXGNaNtD8WzrQF
         XL2uapfI1HtZVXQuqwU+6IQOZ+hxkUPMMLITR6zjz9J/v5U5BAnHwxJzkB3WC/bz15ZN
         dpvp8Nksz6mRkVgE1G19g+UG8meb3mxdZ2/8afzzQS3PWNFSAnBFPeag6xox4riVhK+Q
         2QRhU6kStqcjSN8bUYSI6JTyPsEio3cezG0/Zz/JES94AP72bEuQOVNj10bLjL898czQ
         35mbQTw1TY7MqI3GJOltKfw5O4TLiu2k52qkjdbaPh6OFcpDJVQ5e6F4R1W6Bp4SbJSG
         Fi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753361538; x=1753966338;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1V/d/UnHHbMeCejrE2EXxMNq376QNMxalEsgPPOwfgY=;
        b=ZFcu6KYJVI1yBPIfQKFJTV5zMM6QEiO4iuAi4mi8zrWM9IWdJsngTmT/ISrwirB06h
         GwUIgCzhehhRwp7nmQ0is42vBIe5w7Y9+A/pDb9c0NJD+6+E5JMFy55PFx1OA9Fjyl/Y
         46svQYDM3ATurP+TokhKjrbBoeJIoe/lY0wb+EmQIklDral8+6286XWlkZH91hjfVS0n
         jNBsW0FkOrRpOY61djgkurSb9JZ6NjCJpsQJsNZ9Vu+W7oevMVsitfZh4P3+od889itd
         sc2+3KoUyK5QpZmlX5g/MGqZUnQUF7p8XtHFJDpTfUiOjVADcEFbg7QAGKF1XJdwDAt0
         Ciqg==
X-Gm-Message-State: AOJu0YzMNwAqAKWZZ9AR2LKGLv8442mEOfZtSABnAekJRO3uQqH90P1F
	DnsnqOFaENaWnVRGM3ZjpsNwRzeQfRT86bK84U408m0oRmyaFMShBuxobvb/6Q==
X-Gm-Gg: ASbGncuE3gePWt66+17/EIXH+zdXWBvEVSx3iCGVVFAvmeXA/1Ibz1/xwXn6w37ih+p
	KGjmUe8SqutMkzkeYBhyBvGLpWamp1V7jv9OABYswDS3I+TWP3A7VagId38zwmP2tdFmJYkSX0x
	SlFv1pl6KuwnHg7u7Fxg+kxh8HtSJFx0Deg/FlJXuux2lQCFNC09Nd1Eksz5Ie9u1Yr/rgrByoP
	UPMk2qLPT41vpkLtVWIUvZrTtrR5xj4i71KDBjPgpZipwTbXNwX4PsUYliOMk+mvR6Wzg2/J936
	hXLLyUE+KcokJiwAqPgrgdd07s1GygU3nAaEa5s1jaCgHISewXW8a9vBoYYhZ2mGaVoI4q/0OAs
	+IFcVwZTjiE6E5faGPV/uomFb7Q==
X-Google-Smtp-Source: AGHT+IHNxtiUz77RPdVirLdtvQRlq7b1D6GB5cJ6mHmLtV+k6Y+2baFrO0vvGlNt8aMROOCzI+sOSQ==
X-Received: by 2002:a17:902:ebcb:b0:23c:7876:e6a8 with SMTP id d9443c01a7336-23f98202dd4mr100041865ad.51.1753361538175;
        Thu, 24 Jul 2025 05:52:18 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.58.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476cb6asm15429775ad.50.2025.07.24.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 05:52:17 -0700 (PDT)
Message-ID: <68822c81.170a0220.3b5aec.399d@mx.google.com>
Date: Thu, 24 Jul 2025 05:52:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8886720926701508612=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3] Bluetooth: btintel: Add support for BlazarIW core
In-Reply-To: <20250724122824.1347428-1-kiran.k@intel.com>
References: <20250724122824.1347428-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8886720926701508612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=985533

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.18 seconds
CheckAllWarning               PASS      27.88 seconds
CheckSparse                   PASS      31.11 seconds
BuildKernel32                 PASS      24.94 seconds
TestRunnerSetup               PASS      485.62 seconds
TestRunner_l2cap-tester       PASS      25.32 seconds
TestRunner_iso-tester         FAIL      37.31 seconds
TestRunner_bnep-tester        PASS      6.01 seconds
TestRunner_mgmt-tester        PASS      130.57 seconds
TestRunner_rfcomm-tester      PASS      9.60 seconds
TestRunner_sco-tester         PASS      15.18 seconds
TestRunner_ioctl-tester       PASS      10.50 seconds
TestRunner_mesh-tester        FAIL      11.59 seconds
TestRunner_smp-tester         PASS      8.74 seconds
TestRunner_userchan-tester    PASS      6.39 seconds
IncrementalBuild              PENDING   0.71 seconds

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
BUG: KASAN: slab-use-after-free in iso_conn_hold_unless_zero+0x76/0x1c0
Total: 130, Passed: 130 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.044 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8886720926701508612==--
