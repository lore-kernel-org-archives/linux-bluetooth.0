Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTtOKvC2"
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839BE107
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Nov 2023 12:32:29 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77a453eb01cso195199285a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Nov 2023 12:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701030748; x=1701635548; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+mET1ExVVT3x4wjwZhRRyM2qgL5Vq6I82FgKd8ekMLo=;
        b=bTtOKvC2LRDb2RARi9svJ1k0Z4mmfRddrLdkE79/SdYUyCSAxE4/nMsUqXHLn8kIq1
         CZIG2IBT/M9JX3BJz8y0hOpk4zrQd3NEVG6VWHxZb+Szhrn78Oq+s8LwtfQnOmF77mYt
         KUUbCZ9TKe1OIJWXslJatVsLqzOg8PNPkeONkx9E6ComLQj6QSzPc7gzTha6bP0PEk5W
         m1iKmRkYxoJS8TK1eqd8xDpv/bpDQUEbgbEcSL6bACf51PYciGJDvuDZ2jEb4EuWTycr
         aykmPCISA0V21dmUejGqqaO1ufVbZLwXsnwVRXlvXkv4SiKEBdvRj21yd/Un6h6+cYp8
         g9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701030748; x=1701635548;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mET1ExVVT3x4wjwZhRRyM2qgL5Vq6I82FgKd8ekMLo=;
        b=YIjpvRrseZMeO73sfse6Qz/qwCdKdeWDg8PVioVYnUtyF8s65tz6aA6tu+Q9vsxfu/
         lQB0R3o5Jdh2sYOYGMP1UbBL1Y662xul+Out6UP5DINfx7i12CALlDCuG2lUReQF1UlP
         B5x+pLgtAHWUAb2uGhcAhLHYbvCrFHhZAmERbSI0B0COBRArzup25pDHM+p8yU7JLgGT
         IPRiuAjXfn8LduZi1Qs6lRviGeh7vKSSL+NoVufOEzmhF7H4jIZVR3mX1ym1yt3+wViK
         ZMqx7SFjEhTn9GuxkbhS9JWuFET1lGF2evPNuqym7FF6Y8aYiPEdUg7YR84o0sIPRJ2c
         YmMQ==
X-Gm-Message-State: AOJu0YxpiiAj48yjxnHbSnrnuyDNOax4MMeQ+C/KWL98I7T++rEQoJDw
	RdctXdU497yOl7NGLSkWVtczAcO/X2E=
X-Google-Smtp-Source: AGHT+IECEWpIfRPLXhusACrG0hMNKV5uMQFAfPcXN0+MBLWXVelMoDwU+kXJS/v8m7V4LV6xDqq+Kg==
X-Received: by 2002:a05:620a:6014:b0:779:d143:c1a7 with SMTP id dw20-20020a05620a601400b00779d143c1a7mr11531311qkb.26.1701030748374;
        Sun, 26 Nov 2023 12:32:28 -0800 (PST)
Received: from [172.17.0.2] ([74.249.13.177])
        by smtp.gmail.com with ESMTPSA id bi40-20020a05620a31a800b0077da68b8801sm492147qkb.65.2023.11.26.12.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 12:32:28 -0800 (PST)
Message-ID: <6563ab5c.050a0220.57cde.0eba@mx.google.com>
Date: Sun, 26 Nov 2023 12:32:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8935369758536486680=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andreas@kemnade.info
Subject: RE: bluetooth/gnss: GNSS support for TiWi chips
In-Reply-To: <20231126191840.110564-2-andreas@kemnade.info>
References: <20231126191840.110564-2-andreas@kemnade.info>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8935369758536486680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=804327

---Test result---

Test Summary:
CheckPatch                    PASS      1.97 seconds
GitLint                       FAIL      1.16 seconds
SubjectPrefix                 FAIL      0.59 seconds
BuildKernel                   PASS      27.72 seconds
CheckAllWarning               PASS      30.52 seconds
CheckSparse                   PASS      36.15 seconds
CheckSmatch                   PASS      100.53 seconds
BuildKernel32                 PASS      26.99 seconds
TestRunnerSetup               PASS      419.70 seconds
TestRunner_l2cap-tester       PASS      23.19 seconds
TestRunner_iso-tester         PASS      41.07 seconds
TestRunner_bnep-tester        PASS      7.19 seconds
TestRunner_mgmt-tester        FAIL      168.76 seconds
TestRunner_rfcomm-tester      PASS      11.13 seconds
TestRunner_sco-tester         PASS      18.11 seconds
TestRunner_ioctl-tester       PASS      12.20 seconds
TestRunner_mesh-tester        PASS      9.08 seconds
TestRunner_smp-tester         PASS      10.00 seconds
TestRunner_userchan-tester    PASS      7.50 seconds
IncrementalBuild              PASS      34.80 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC,1/3] gnss: Add AI2 protocol used by some TI combo chips.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[RFC,1/3] gnss: Add AI2 protocol used by some TI combo chips."
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 496 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Pairing Acceptor - SMP over BR/EDR 1                 Timed out    2.260 seconds


---
Regards,
Linux Bluetooth


--===============8935369758536486680==--
