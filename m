Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD584A35
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 03:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743563080; cv=none; b=JNF3W3Av2S2lO7F6n5XYvdgiNWAIw38vYW/deh7EozqwVtTnL7W8zhaqubA+gjFiC3+A9DB8CG39BQLOX2MI9JvlPmBZ+KDh6qYX0HmjmBIo83xoIITUOkt42U08S855hg0Tcpj+jYotFGLS1pqnUTezWNPiulmk7id1iV8Dw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743563080; c=relaxed/simple;
	bh=fQ1KBTciV605RrCEmSh8yp8Weq6SD3dVEs5JzPMJm4M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nXck9WEooAxi0b7BgwLUt0NW2Q25HmznIm1iegNWkvc+bjIZTaFJw2qlEAK5vfkTNhCkPcvaQq4NOzAYae+yS9VgZqT7hIH4pyeYBgQAMwwSev8+GEox51Txp+ClEm5mptsfeGpmlQBQ8QFM/A2l4MZIQlB6pfcxV7cbla6lPmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ld3Bkz1r; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ld3Bkz1r"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c55b53a459so646472385a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Apr 2025 20:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743563077; x=1744167877; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/aTB69JQAvF7T5PCiDg25xIqkMSd8D0Z+YZCySjFqUI=;
        b=Ld3Bkz1rmLh3u8U66Z5J7JSCJGPchz5D2XxDm7bJaXjWcI+AoM85bpYKrQGwOrDwpr
         l2vJ/Soh3CCfcBrgqUgmhRKZwunXaj3xC4vvCvayKqOHs/kFE2+4UjGK64dYBsfLmtVB
         bvJDu/UMHE3+8vy2kafl/kVkclFPP8WTSbfU+NOsWZ62QkLZXD7nZ+9P8D9U17NQIw6F
         91CE8PAFPD2+v9ug//GBC7bq9Qzo8AYL0/cjeg1CUaL80B/WhZLSh8jyfoNZOzrtG76/
         BT6Sx7oLz0oorA+gUtOUqWNwkljyvRk/ZX9cQ4vlaVzZVkWcwkNMAWB2WsFWklBKveOl
         T+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743563077; x=1744167877;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aTB69JQAvF7T5PCiDg25xIqkMSd8D0Z+YZCySjFqUI=;
        b=GeSHC80bJ4kHGXca9uATsFl3hhS0FvmyewMeubjfzxmxZKcZM6PdhDkEN23sg7vveM
         IBrHty1K+OPRHiBGQCpDTQaLsYG+LeaPGEFuyYElGT8Wuy/AbrKWN/eUsJU/4OAbjrhq
         KSuzY9omVuspZlNcJQ7Y5z5ibZB2gdVK2H+FiRbpVmNB1Uj2c7SWE3fBHZK/YQdRCcfW
         bFG34vDcTES4fXcDJpaVZruyU0EdsiPWXjBGZLiHu0hvAOeja9ED94YQuKEKM+bYiPhu
         xJfpfJDlntEjaz05T/HF63y+2XQAK+GecTO3vUDbdl9/vBhgOT9KAho+nvQcHp3ln7Ul
         mzWw==
X-Gm-Message-State: AOJu0Ywg+VxVoIPz8p6ZamshGxzwjG+gf0KlGSSyQ00Wug7i4paZvP3d
	JDUJ73+YkZnT2/h3Fga0YYKLLG1mpSAKtow3d0Ino0X6hc0t71EnUWIDIg==
X-Gm-Gg: ASbGncuQtMWAbw3NZvgK71y23ajCKiInQxhJSuIiGUlU2V/v1pkJW3AbS27bI9PEUPZ
	lghr8cpXZW1lAmGEVdFqZNkdAgIoj/3GnP31aEDxib3LwRcvPSMe9dSfbOWTuqtz4QVts0Pv8bM
	C9xJ072W6bsfOMKQuLpRkTVQDqhUdGkzhkuMVyigv3rmiXruCwxlQ1nguSefe2LJsCThTPVqJiR
	WciidPLVexA4c6c58CEX3quIf+hnnWwf2OI1QhHJ2HUAY/dBIW7nhtEgdJeRLzLv2Q6XgZVHFuq
	G6d7BIdj4mLmCpPShzwmM11BkrjeQhkR6QQt41U1CNnROQfIlg==
X-Google-Smtp-Source: AGHT+IGINm7kC9IB+aZyBOc3DQlfj+yORTjC7ndIRAxJ1RhN/dXpSMHu5Lra3FByMYLWVpATvKcuRw==
X-Received: by 2002:a05:620a:179f:b0:7c3:d7ef:f7f5 with SMTP id af79cd13be357-7c6865ea96dmr2308151585a.18.1743563077311;
        Tue, 01 Apr 2025 20:04:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.75.92.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47782a7fc4dsm76409381cf.40.2025.04.01.20.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 20:04:36 -0700 (PDT)
Message-ID: <67eca944.050a0220.291206.96a2@mx.google.com>
Date: Tue, 01 Apr 2025 20:04:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0357750351161800027=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Avoid redundant buffer allocation
In-Reply-To: <20250402022054.64501-1-kiran.k@intel.com>
References: <20250402022054.64501-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0357750351161800027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=949144

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.57 seconds
CheckAllWarning               PASS      26.86 seconds
CheckSparse                   PASS      30.99 seconds
BuildKernel32                 PASS      24.06 seconds
TestRunnerSetup               PASS      432.91 seconds
TestRunner_l2cap-tester       PASS      21.22 seconds
TestRunner_iso-tester         PASS      39.09 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        PASS      120.00 seconds
TestRunner_rfcomm-tester      PASS      7.84 seconds
TestRunner_sco-tester         PASS      12.58 seconds
TestRunner_ioctl-tester       PASS      8.33 seconds
TestRunner_mesh-tester        FAIL      8.25 seconds
TestRunner_smp-tester         PASS      7.19 seconds
TestRunner_userchan-tester    PASS      4.93 seconds
IncrementalBuild              PENDING   0.76 seconds

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
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 36 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.116 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0357750351161800027==--
