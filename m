Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F00A29C328
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116085; cv=none; b=mH2N/6aLmAMwOs7BX98byibc6Y5GMWjWiwBRC7dATCoy3mTbvWiBBmjcBFfTdv6W8Ulg8SDJKRgJ0LTM91SDgyVPEZmsPpl7ev7roY1xpwSyVDjgCJB1glJmx+BgSTKHZlvWHMP71tgpTXT+Qg7DD1vBwgQyTvU34LuS9BDfWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116085; c=relaxed/simple;
	bh=Y/rIFuxx1nbZjK8a6SNRy+G2NRs8OGeAKkMQ/qxLLes=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DOc/mUY0HGNgDngg8+gsg/dwQGNK48WM+r7DBitzzYT9bG+ibQBjZn7+Szd7BllOtXwm/Aci2jONIOoR2bVx71XW9tRR4rMmEiXpIAK1HGTlRw6JNvE1Em/513xkngRiZ8oAsL1EcM+f4dwVyIuTGliizalTb46f54i3DL7KZEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGerkvXY; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGerkvXY"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-915ab38ac14so785100285a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781116083; x=1781720883; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FbDPGx9io9+AYH6Tlts+AHQ+pyiDepZKxPCBm87ik2c=;
        b=bGerkvXY7w3R/0OWgI28HkqbiU/kwxfK1LytRZFGb5/6tWqt2wOPIw6Zg0nQcbBN0Z
         eWBMayMsyhjw4Izcrqw3VpEA/nbCKQaJIGFTdk6w2f80UNW8h6ZtNAJuxvKSPu6LM+Nj
         9DOpL+Du98Q74QQ3SOeVmmLvmIdm3qqRWfwAoRTysRDOc8yAenMl9rPRT/myffKbUkAC
         Ta7/hoCYSCt7E6V4q1YTNTPLRLy8ZKI7mtDrB7n8T7W3YI6et73MqR/pVuWwaTbxT4sl
         agRNVhoVEZh4fhlKQRaLFHPkTYo82FriqDg3eAJY0pUoz7Uj41nNQ8ZRKk6q4jA9Bdh1
         XVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781116083; x=1781720883;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbDPGx9io9+AYH6Tlts+AHQ+pyiDepZKxPCBm87ik2c=;
        b=Wllu5nJ+WzvQyjkPnJym3WGStGUOJvugG+F/H6cOCOAMe8g2cXWt0cJ562LCkJ8LST
         sxxlceBMvUDCrROMH4y0hRcgcnhlzhqJBmet7k/kUnxQMCjR80bzFP7CJBgxNTKj0VPs
         PWRMVOnsn32BFkNYembIzrHc2238n0DqMdeV7BfFrRNxXJbpzoioXYHJmKK+xJ4/QBub
         1BCe6V2TMVT4XoTY4alIIKsFYb0AEJoUUEgqLhH7LHnddzUQeMyCB2yy5dMzdcd4rrC0
         iZMQCp2Ul+NSLXNebCT8r13igWt2doFWoL0dgyuYeEPtBd3Ko8p1IbKPK812KMEIvT6e
         r8vQ==
X-Gm-Message-State: AOJu0YxiBlB4zvZavxDH3tYiwsP/S2UWnqmNBOvoBvrzTIMJieCOLy2M
	tCX1cI31UpItvVJu+fTUUNjk4pHzmuXaQ2bgPlbSpjEs00rqYt/Y8gKzKb7QDw==
X-Gm-Gg: Acq92OEHYILOPfbp4YMIK+ThlGimsToE24rRyBZyNECJWcDSHtMU3ZVyp4qo7wpvddc
	jrE/cif3Pp7PzEeM0bd97sAurDaI65d6y0F2E8x17aV8wjl2BVvYwWPHsmXSHH5l6HJ00cD5FBp
	s8590g9nkmu7nBcP/I37pazjJecm8pcxIHvGJlHHfNg3xAnn73WLyrMhd4kFWby6xKyLNYVH4lZ
	5SBPDUvvwNluf4ctwaJgy24SRTJeagBGqOANI4lrS2IseyPhs6KZc0InOj8X3DVzpYVIb108lQF
	TbMSpdYKBwLDN5kPKY2hSi8emJjdOh9QvptB7OmzDPvYv4WP9loiiKOLrqBCRhTcsCyVf2g670x
	O2wJLhR3cLXz+StPD0SC0mvRGlXzSt5K31i4JDI17eL4y2cAs6wv+gdB81QVMSO8ZBNIMd3v3Dl
	tZmjCPBRkpyW2XzG7ALbZ18tZ8y10L2s19bBwpLd+m
X-Received: by 2002:a05:620a:371c:b0:915:c4de:7ab7 with SMTP id af79cd13be357-915c4de848fmr3028522485a.35.1781116082918;
        Wed, 10 Jun 2026 11:28:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.235.83])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00a4f4sm2680924185a.3.2026.06.10.11.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 11:28:02 -0700 (PDT)
Message-ID: <6a29acb2.7974f483.1a313b.19cd@mx.google.com>
Date: Wed, 10 Jun 2026 11:28:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8149207426643141592=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: [v2] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
In-Reply-To: <20260610150704.1234558-1-oss@fourdim.xyz>
References: <20260610150704.1234558-1-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8149207426643141592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1109363

---Test result---

Test Summary:
CheckPatch                    PASS      1.14 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.22 seconds
CheckAllWarning               PASS      29.76 seconds
CheckSparse                   PASS      28.66 seconds
BuildKernel32                 PASS      26.45 seconds
TestRunnerSetup               PASS      579.03 seconds
TestRunner_l2cap-tester       PASS      60.13 seconds
TestRunner_iso-tester         PASS      74.99 seconds
TestRunner_bnep-tester        PASS      19.60 seconds
TestRunner_mgmt-tester        FAIL      214.34 seconds
TestRunner_rfcomm-tester      PASS      25.55 seconds
TestRunner_sco-tester         PASS      32.90 seconds
TestRunner_ioctl-tester       PASS      26.59 seconds
TestRunner_mesh-tester        FAIL      26.13 seconds
TestRunner_smp-tester         PASS      23.46 seconds
TestRunner_userchan-tester    PASS      20.07 seconds
TestRunner_6lowpan-tester     PASS      23.57 seconds
IncrementalBuild              PASS      26.07 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.248 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.228 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/302

---
Regards,
Linux Bluetooth


--===============8149207426643141592==--
