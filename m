Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F83E493
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 04:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710824226; cv=none; b=ZWzLSCkxKkXkY3zbc80JZF/QoHTkts2vO1BlK657IshLj/nqyRrM5Sb/hDIOBXA5wMdJsAbGA3ZxAT9Sgu0V+rcEq2GKZ9Q7GL8869vK5/UD2s5uV3QxvXZyGu0vgfeLgdboMg7yHNo3pXXqxCJFR1AzWoaAIQY4TT/Zi5hwE7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710824226; c=relaxed/simple;
	bh=SXq8wYJcrKQWavShBNnKYZcEf0yVspUO7x+YgnensW4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JWFBNX1gCe/lbOk5u2Xtld2fObeVmk0lCYfKfopu+zNw6B50OGxRdw7o6ySHPXDoy4K7KfMmZr5aW7Gaww+WnNv7+d+42sYRnKruTcH5QYJkGEHOZrJewEQmoxjonsyGWguvEL0hXHDG25IzAyXj/05cUuQCuUE34yWkiMv3Lj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foKW47I4; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foKW47I4"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-789f3bbe3d6so157960785a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 21:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710824223; x=1711429023; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w0vjvyWpIaDFE4kX6ZAlz4owmScGUuvCcQyP9EMtKoc=;
        b=foKW47I4sqASAtB1YaF0e8PCVjVH9jM5HlFrs1tlfbA/fb0S69unZ1QMlOHZ3V2R8t
         U2gz3IO4BxbO0yGRredyJhRzbTvAFVRdeRWsuF1JH1jethT5u8e9qQXYWZG0WQ+ClkND
         0tdug+nxLq+XCzihOwUBOG8H3M7lGyDl4p7Zl9qwU+40km3B9fzkHP6wFkfVlygaFMlc
         YPHIPYQ7JXTsBXKbHCIjtlXR2pajrdFvk0O/WgIwh8A/wY5pkRJxRaR6O9MWy69R+Jaf
         bV8mMvqCawPR7OLF8dDqo0DgFvmItHh1IUQfYdiPFau7+E8nEwq8lsZaSvS4xV98B8L7
         4EsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710824223; x=1711429023;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0vjvyWpIaDFE4kX6ZAlz4owmScGUuvCcQyP9EMtKoc=;
        b=Gmilz8TMk+a++034hweI7fhP2ljttv8YBY4P6ucTNjBRG7yhCBlkJidMEdtdcUXToZ
         NZdNMJFKoOcwVTNS+xZWIXiqZTU4C5a6WFHFDrdOV9Hd/Ojh85AAUA4Fj97IRw6WX1b0
         GyKFd+IWOaskNQmwQYjCrXJNxEov4G1CWvXLNJI9reibQMc/DFNlEk04HMB4g8dZ2YlP
         jDWaiq0ai1h7WKN5paT++iEfA7le0HFfnPRQdeKNR68DrNo12Csa+baFzC7x6r/4e3xj
         qHGhz4maEG8D4vAERZZbGPN4zZtR2oL2af9UqnNZciaaJRxmvnlpt1447vVBLeu9MStI
         3cCg==
X-Gm-Message-State: AOJu0YyUWKFC2NZc4jS32hTbj2G2c/BSh0IaVJDCPEXLHtP64g1tzwfX
	0JelF0wcOjTo4vqIfUq1q6y5VJH+z1kMnKtbTa8S7oKgPhuFKqEGXMx7xcc+
X-Google-Smtp-Source: AGHT+IE9n6XKKkV6xrb09vrAIgCfjz30GNi/kLas8WdEWxi3XIX3bwzKWujtsOO8czJIrlR8cTvg0g==
X-Received: by 2002:a05:620a:16a1:b0:789:fe83:c601 with SMTP id s1-20020a05620a16a100b00789fe83c601mr1802004qkj.53.1710824223512;
        Mon, 18 Mar 2024 21:57:03 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.74.2])
        by smtp.gmail.com with ESMTPSA id u15-20020a05620a022f00b00789ecd8e2absm2834022qkm.5.2024.03.18.21.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 21:57:03 -0700 (PDT)
Message-ID: <65f91b1f.050a0220.98dcb.a9ab@mx.google.com>
Date: Mon, 18 Mar 2024 21:57:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1649350809563821808=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, marex@denx.de
Subject: RE: [v2] dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT binding
In-Reply-To: <20240319042058.133885-1-marex@denx.de>
References: <20240319042058.133885-1-marex@denx.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1649350809563821808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=836295

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 FAIL      0.31 seconds
BuildKernel                   PASS      27.55 seconds
CheckAllWarning               PASS      30.43 seconds
CheckSparse                   PASS      36.01 seconds
CheckSmatch                   PASS      97.81 seconds
BuildKernel32                 PASS      26.87 seconds
TestRunnerSetup               PASS      504.25 seconds
TestRunner_l2cap-tester       PASS      17.87 seconds
TestRunner_iso-tester         FAIL      30.06 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        FAIL      107.57 seconds
TestRunner_rfcomm-tester      PASS      7.29 seconds
TestRunner_sco-tester         PASS      14.91 seconds
TestRunner_ioctl-tester       PASS      7.72 seconds
TestRunner_mesh-tester        PASS      5.82 seconds
TestRunner_smp-tester         PASS      6.85 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PASS      26.18 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.221 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 6 (RL is full)               Failed       0.187 seconds


---
Regards,
Linux Bluetooth


--===============1649350809563821808==--
