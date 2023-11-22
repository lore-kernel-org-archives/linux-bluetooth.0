Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxZ25wL3"
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACECA4
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 14:56:45 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cb4d366248so324238b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 14:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700693804; x=1701298604; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WpfN21bg1SfkTnVhqCebEK9Natr6mZeqweTJ5LpLnt0=;
        b=cxZ25wL3dkHP13xo1usLlQSmL+JwwUhhj1m7DoO6PD3Htk/z2AMg2NTlXgEUs7yweP
         GQFGG6H4hFtcBeDB4vq5yjl/G3oKVp/ePoi9dWc6Pwqx2y7gGn5Q/GaYdzoFZeEEmU/c
         JDziO/JvAeh9nAS4we9p3nsLbFFnxUOo611eRtRyHkVfW+6yF9I8+TF2lyWQNH6xIeI7
         HQpv7szjTUp2KzzwLTf8OuZFfXU6RGbpW9ePwRAQOqUZraQ/lgtlvNB0b0XKWX8w3rL+
         bRDqDRWyVECXFAaqxyOjSji1eLWO+mrqLNTL6zMqpYTqoeAbdq1/x15x4cH5ThiIVJ5d
         P1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700693804; x=1701298604;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WpfN21bg1SfkTnVhqCebEK9Natr6mZeqweTJ5LpLnt0=;
        b=rmHBfc17b9dyPJ7Wfwum7sQfgh5jSYn5o0XRDLunGARY3pc71O0I1ApZ3k+LWB674F
         AR6zcKy5l6qle8eLMyqO9gTwrSNnHMFFKnBR8NF+oaAENbdfy+JemeVmYqHX9O1bvHyZ
         tZZ6EphWowU+j49vPfkbIgnbrxwhuWzwtdf4oU3a8a9pjE2gu0QMgwl3BtFW0egr4VQ4
         Rcs6CFwzRksoZhtHTIYoUqntl987cplpHTWqpw7mUQLmkQD9LxU6DS2kywF83VbWh4Hq
         BfWllTq7HUTXdXfn//ZAtDALLnzlWqOkOMqgYMdDZasaY1h+vfdvNk0S0TXhlMvsIrHp
         rfTA==
X-Gm-Message-State: AOJu0YzcwEPRtcU4SULj6kBa5c00jbai3dZKqpQO1rqFABfEo71jsxcR
	UcpsEMH16Dd9dVc5VnTuX4UO1PrEYo8=
X-Google-Smtp-Source: AGHT+IGW7JBizA6lkjimMx6XhetvmCJ9GX1LzvHFDonYOMuU1axjvBl0vHNawCMNPi8Dvjzh0Tyv2w==
X-Received: by 2002:a05:6a00:2314:b0:6cb:a1d1:ab45 with SMTP id h20-20020a056a00231400b006cba1d1ab45mr3634912pfh.5.1700693804607;
        Wed, 22 Nov 2023 14:56:44 -0800 (PST)
Received: from [172.17.0.2] ([20.172.17.132])
        by smtp.gmail.com with ESMTPSA id y1-20020a62ce01000000b006bff78b7526sm12639pfg.20.2023.11.22.14.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:56:44 -0800 (PST)
Message-ID: <655e872c.620a0220.f2a0c.00a7@mx.google.com>
Date: Wed, 22 Nov 2023 14:56:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4242339518572462693=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arnd@kernel.org
Subject: RE: Bluetooth: hci_event: shut up a false-positive warning
In-Reply-To: <20231122221805.3139482-1-arnd@kernel.org>
References: <20231122221805.3139482-1-arnd@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4242339518572462693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=803455

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       FAIL      0.55 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      27.95 seconds
CheckAllWarning               PASS      30.80 seconds
CheckSparse                   WARNING   36.13 seconds
CheckSmatch                   WARNING   99.31 seconds
BuildKernel32                 PASS      27.12 seconds
TestRunnerSetup               PASS      418.45 seconds
TestRunner_l2cap-tester       PASS      22.80 seconds
TestRunner_iso-tester         PASS      44.52 seconds
TestRunner_bnep-tester        PASS      7.03 seconds
TestRunner_mgmt-tester        PASS      162.09 seconds
TestRunner_rfcomm-tester      PASS      10.98 seconds
TestRunner_sco-tester         PASS      14.46 seconds
TestRunner_ioctl-tester       PASS      12.36 seconds
TestRunner_mesh-tester        PASS      9.12 seconds
TestRunner_smp-tester         PASS      9.84 seconds
TestRunner_userchan-tester    PASS      7.45 seconds
IncrementalBuild              PASS      25.87 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_event: shut up a false-positive warning

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
9: B1 Line exceeds max length (143>80): "net/bluetooth/hci_event.c:524:9: error: 'memcpy' writing 3 bytes into a region of size 0 overflows the destination [-Werror=stringop-overflow=]"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============4242339518572462693==--
