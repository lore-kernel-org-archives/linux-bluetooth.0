Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930AB176240
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721990159; cv=none; b=O3N6QnZjIk5QZpr0D5az5uXC+tSzJXzX28nJCfdEs2/n1bzbCVEBo++/fxH2AhcxWKBEhc+3soV9lxmyJFoOxSMZcisxBACJR/4B4EC9S8O3ipoOJ99gt5ej5FabbCTFHjwcAFFifLhWjCTdxpr9uhg0JvUMosBKqyoai2Pqv9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721990159; c=relaxed/simple;
	bh=qFpdMSuvnqrRTCQVVpzAmF9SRadec0Za91RmU4tpxQg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VLOqgBGwAFikneObOKmUDk+T7hwALeVuPpRtsH77Bb/7GeRCxQbL+3/IBHvT1sfYaXjO48oEChWS83YIvp+vuRuuN6InWfJQCrQhIdFuf3qU3JA6HOeCVtKCJYOsICKSsQZ+zKSFPoLvF+SaplN5s6W7Q8qKpaYYAwP1C8/KpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiAI8cmT; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiAI8cmT"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7163489149eso666642a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 03:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721990158; x=1722594958; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UXnTFy0KiiNiwXTFoHI82DCqStcyoJWXVkEqPz8GEnM=;
        b=QiAI8cmTctWZj04U4e1nRIyL/pPfEyMj6O5lxjP7YXnRgZzdAOscxXW+MZEnxBkKgU
         NMmNM3dquBhj9noL0d9lMR0C0agtoaY5QluzrSITiosZdLhJw4AEh0r81jQfddNDZKZG
         gzhU94H5iWSfrNJonFQOaKUGlBwV3kYahB70EIXVVEMJToJoo7thVGnUHq4Pz16txa8A
         w+MpYFzeiNnqoN0TxafUG0LFVNK/ZuDctLEaiMItLYrwRWhM2qPKyntSrXPhLRTOcZ1D
         yVgsE+tLRLEvXs3S/HtNLhAh3f/aXjpMAF1EsAaMxKDAM3CiQZ4tFLJrzM00Pi4VyHB0
         2CZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721990158; x=1722594958;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXnTFy0KiiNiwXTFoHI82DCqStcyoJWXVkEqPz8GEnM=;
        b=ntr4DRSroqzSC1rX2ynN8TmcKUMPl/mo9HxJUnTd6Rpmb+poSTiW+bmumlg4J+8AkG
         brtT3pAF70gF7N5hxHr3z60bGwEKLocfl/c7+zB5om5Xw6Ka/DVPQ8a/eZ4AniWkcpyf
         Iezk6Uy/iTNXOOD/6xfA9pJEkqhOSv5/CLSSGSLIk07n8bcrlzGgXeNB9MTc+UgozTBD
         gMN4CYKtzlgmXzqEVVvcfwUBd0M/sbmBWrjG8GHmR6UEtOkSWy2naytvO+UsT1afznu9
         IF0fnzHe5qLfmAFVMFrpv5l225aR0tBuDlNUSzBEmZNmioQjWgn7F3xgOsuM6nkrse/H
         hFGQ==
X-Gm-Message-State: AOJu0YyRLH9CVxHBQ/cyqp6QSd18qlH7g4SiKBTxHg9UV52a+pN98HCu
	iaQU0eMZRANFgV3T0vQgMr9AGetHCt3jVAX51D4owSFqRvYCUybWUI1HIg==
X-Google-Smtp-Source: AGHT+IE9p4Vx8+u9pVLI1fOsX2hgfw6AClWaAfxhjlcgcWvlnSymLuOs6lEAcjbOPtj1LeOi3sRIcQ==
X-Received: by 2002:a17:90a:4814:b0:2c9:9f2a:2b20 with SMTP id 98e67ed59e1d1-2cf2ea2767bmr5404897a91.22.1721990157633;
        Fri, 26 Jul 2024 03:35:57 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.3.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c55b35sm3090160a91.9.2024.07.26.03.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 03:35:57 -0700 (PDT)
Message-ID: <66a37c0d.170a0220.b1b8b.7ff1@mx.google.com>
Date: Fri, 26 Jul 2024 03:35:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1747679910712639941=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: [v1] Bluetooth: hci_qca: Drop unused event during BT on
In-Reply-To: <20240726095828.2707111-1-quic_chejiang@quicinc.com>
References: <20240726095828.2707111-1-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1747679910712639941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=874041

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      30.47 seconds
CheckAllWarning               PASS      33.56 seconds
CheckSparse                   PASS      41.00 seconds
CheckSmatch                   PASS      103.76 seconds
BuildKernel32                 PASS      29.81 seconds
TestRunnerSetup               PASS      539.76 seconds
TestRunner_l2cap-tester       PASS      23.00 seconds
TestRunner_iso-tester         FAIL      39.30 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        FAIL      113.26 seconds
TestRunner_rfcomm-tester      PASS      7.45 seconds
TestRunner_sco-tester         PASS      13.08 seconds
TestRunner_ioctl-tester       PASS      8.00 seconds
TestRunner_mesh-tester        PASS      5.96 seconds
TestRunner_smp-tester         PASS      6.90 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PASS      27.51 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       6.191 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    1.841 seconds


---
Regards,
Linux Bluetooth


--===============1747679910712639941==--
