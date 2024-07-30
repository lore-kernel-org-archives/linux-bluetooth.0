Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6FA1684BE
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722371778; cv=none; b=ki8UCHIovWPxSbox21vTA5o7+v/25o/Bz0ODeMTR8GyPfM3O2ZB2sjNhqWdJu1dUketRyqAibH/9ZLQgn6yhljvqGmE5vOFy8dC8jkj9vL+aIvh4ULk/oWhTyjaJMJtB8nG7Cqb7ZhJUNlAGSbHw2qqlMseU0gcj7vvCBmS8J6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722371778; c=relaxed/simple;
	bh=j+TdLQT4S9r8+4j99C6lYeAbiZRse9H5wZTNhIrObe0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lG9xKFCMGfl4Mzv2VsDtTMxC05ZtBavB6swU8GoqDz+MWaCoXhF0M3UMiwVts7h3Qioahh+GZAnnNbL5B7wVlAGg5W2gwkGB7brszRMTPRRgYHO8dM7OU9Dq+CNVr55qzWwWgmDBQnRlGDOz1pS/PeBSubKQiA5VXYSAmnUQ13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJMcJW8d; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJMcJW8d"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b97097f7fdso31410386d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722371776; x=1722976576; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bXkp3O/IN1OvOa9zMblhbEYVyyt39TfRCpkZ/J8+gtk=;
        b=IJMcJW8dHPESN4zrfg7/GTPZ3xacDhqqjkg4dWtfu1M0i98nQOXlRDK3099lxY1iTC
         Om7b3flCXIzDfN4Jh9Ezh4qvgGB52vuKMQGwdVlkrWYgavZAuApW847Pk/lYL5friYpx
         Rr6++V4MxL3em7r1gvLMXsF8W0G7fYCjmYfY4gxxfi6zgrpvidWlsbJUMKjlPqHXcgkL
         yKpajLKmUyPXpalfBTHQiQFC8UqYBvHKIEd6EJR2ktgjVAyidg975Fm6lnyRJwqawM52
         Lt86T9gQ1gpgoHUqw3nX4QMkwEP4dyNuknCeMZFQi9EtkxFHHc5J7s+JyWUHE1I+KZLO
         SAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722371776; x=1722976576;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXkp3O/IN1OvOa9zMblhbEYVyyt39TfRCpkZ/J8+gtk=;
        b=ClRi2y+6l6i5b3lZ+zTatIUoHotEvkchmCxEUVzhdc3AQH0i+CWxiBUJQ0LSDgMDB4
         PwLSQB1F4cAclveebMWcGXiGoDJagJ5YPZDCRmV5pM+rYnd6BdMcYvNgYK1t+TN61VnY
         w/fimt1oybuB3G9myvKa25BmyNATSshPl+lR7fj3FiW47EomL/0wHpzjTLLKjxGGy+PA
         jSUWVKuEYkWjuS9FoGrY+2g8cjohQdqPQ0IuzCrkxRwRWNM1LPA5z9uMQ2X9GSxNj0jA
         zVRz5/wHh9636VFCHCsu4lZ4LbdeYhldr58ZsIkGhH5J9i6PhBNXivKegzUqBDuM3UNN
         Pqfw==
X-Gm-Message-State: AOJu0YyKrCCCL8lbVWcYpYl0eCL28d2Qmw/TQPjs9CNXZoY1uP8j7Kum
	ZGeX9tC0Pl/P2jWmBJPxeoLKv+MXrtzB5g4ihSE10bLNn6cWGKZPtk6GTQ==
X-Google-Smtp-Source: AGHT+IEm1B6eFYL1JMdr3BfQCc5OmTY/l/4K2VtMvKSKipVDmFa1UaWfpmhgB/6BcvXJ7SBGszKOeQ==
X-Received: by 2002:a05:6214:f61:b0:6b0:7485:719c with SMTP id 6a1803df08f44-6bb5597d650mr123037556d6.2.1722371775561;
        Tue, 30 Jul 2024 13:36:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.214.165])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fb12082sm66577426d6.143.2024.07.30.13.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 13:36:15 -0700 (PDT)
Message-ID: <66a94ebf.050a0220.dc5b2.4b15@mx.google.com>
Date: Tue, 30 Jul 2024 13:36:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0303345925854803634=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bearodark@gmail.com
Subject: RE: [v4] Bluetooth: btusb: Add MediaTek MT7925-B22M support ID 0x13d3:0x3604
In-Reply-To: <20240730194342.129610-2-bearodark@gmail.com>
References: <20240730194342.129610-2-bearodark@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0303345925854803634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=875208

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       FAIL      0.51 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.92 seconds
CheckAllWarning               PASS      34.34 seconds
CheckSparse                   PASS      39.62 seconds
CheckSmatch                   PASS      107.25 seconds
BuildKernel32                 PASS      30.10 seconds
TestRunnerSetup               PASS      551.03 seconds
TestRunner_l2cap-tester       PASS      22.61 seconds
TestRunner_iso-tester         PASS      38.06 seconds
TestRunner_bnep-tester        PASS      5.10 seconds
TestRunner_mgmt-tester        FAIL      110.53 seconds
TestRunner_rfcomm-tester      PASS      7.75 seconds
TestRunner_sco-tester         PASS      15.30 seconds
TestRunner_ioctl-tester       PASS      8.30 seconds
TestRunner_mesh-tester        PASS      6.23 seconds
TestRunner_smp-tester         PASS      7.29 seconds
TestRunner_userchan-tester    PASS      5.32 seconds
IncrementalBuild              PASS      29.46 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4] Bluetooth: btusb: Add MediaTek MT7925-B22M support ID 0x13d3:0x3604

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B2 Line has trailing whitespace: "BT 5.3 M.2 chipset that I purchased from aliexpress (and which "
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.175 seconds


---
Regards,
Linux Bluetooth


--===============0303345925854803634==--
