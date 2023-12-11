Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH+YRpxL"
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8B5A0
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 00:59:35 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d319a7a35bso6501835ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 00:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702285175; x=1702889975; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qKZsj4ztesGgExG4wQG/JFmnNpoIiLPqhLh9K1hKS9I=;
        b=FH+YRpxLZuHzxKoeqxG2ILazPmaxuZNlBo6HPPvfm4Ha448gTEBWoMZTX99R4zdRqs
         0FWeYmG2ylUihMr4EWWpQc+g5SzcljVo6f9K/0cqZMe3yIgqed26dONzCDu1GkHsiuK0
         +iYRPh6O2zT8tRAUEmyL3Wf0Ird7QBuVPTmb7pBdcAtUP1wnPteOKcOCOFbZ20HOtz7R
         ZxJe0gHdXfAOStAJ6bZs04AZmrgIKoG874TtAoj+osWrS4+IuWYbzQGTmCZK0dEqPJBs
         TEhG/zlGB2gY86d0u0IiR+yuCp3WIEtXEH2/3VtdiwoPgPOXNWDto3C8NKV0M1yzyAqH
         +deQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285175; x=1702889975;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKZsj4ztesGgExG4wQG/JFmnNpoIiLPqhLh9K1hKS9I=;
        b=tiNcM+OMNB2Wm4pZrp0YZTwxLbBfHk9gyI1h8JY7BewMmI6P/5vlQKSP882YaAbK3V
         BqDhpHuCMJGTbdh43NPoAtYLY5QMW9bQoDXsa01HdebxIvm5NM09CsTnCTqwmNe+zDf7
         Rzuy320CJenOV2spAnUQGjtrwIRUVcetz0HUl5Jchz5tgPOEYGISBYPi3KZgvaFMGvcc
         dOuPRDuBr9Rw77m9VZViEmwJxYGhRaqucYYafipaTd/r4h+E7m+MIw5J+qxIX09My31E
         02tEQ96qlZku8lxuh+/D19qJ4VPF/5kxTPrLNNWULGJHd+BZQSCFt6a3c1Y+LKijPeZQ
         aRfQ==
X-Gm-Message-State: AOJu0YzbhPUntL0Kc78GAeaTKquiGS0/E66HdF8F+0GCvmZVR4+MItRF
	0gKLna5rYnL9UQR8NqrCVojD8FzUfqM=
X-Google-Smtp-Source: AGHT+IEHT6GQA94bVt4s32oW4fE52//B1pQlYCi3E9Dzx16nsW5MJ9/CCYsiQuIu3ZuWVHZyi9hZxg==
X-Received: by 2002:a17:902:db0b:b0:1d0:bc5f:ce62 with SMTP id m11-20020a170902db0b00b001d0bc5fce62mr4138284plx.107.1702285174944;
        Mon, 11 Dec 2023 00:59:34 -0800 (PST)
Received: from [172.17.0.2] ([20.171.122.189])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090331c400b001d0c5037ed3sm6168195ple.46.2023.12.11.00.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 00:59:34 -0800 (PST)
Message-ID: <6576cf76.170a0220.a1291.0caa@mx.google.com>
Date: Mon, 11 Dec 2023 00:59:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4435674666118046501=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, alex_lu@realsil.com.cn
Subject: RE: Bluetooth: Add more enc key size check
In-Reply-To: <ZXbIWMZyZIYyetff@alexlu>
References: <ZXbIWMZyZIYyetff@alexlu>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4435674666118046501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808696

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      27.94 seconds
CheckAllWarning               PASS      30.11 seconds
CheckSparse                   WARNING   36.38 seconds
CheckSmatch                   PASS      98.37 seconds
BuildKernel32                 PASS      26.50 seconds
TestRunnerSetup               PASS      425.18 seconds
TestRunner_l2cap-tester       PASS      23.09 seconds
TestRunner_iso-tester         PASS      44.69 seconds
TestRunner_bnep-tester        PASS      6.99 seconds
TestRunner_mgmt-tester        FAIL      168.41 seconds
TestRunner_rfcomm-tester      PASS      10.96 seconds
TestRunner_sco-tester         PASS      14.52 seconds
TestRunner_ioctl-tester       PASS      12.26 seconds
TestRunner_mesh-tester        PASS      8.79 seconds
TestRunner_smp-tester         PASS      10.18 seconds
TestRunner_userchan-tester    PASS      7.36 seconds
IncrementalBuild              PASS      25.61 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/l2cap_core.c:1676:52: warning: incorrect type in assignment (different base types)net/bluetooth/l2cap_core.c:1676:52:    expected restricted __le16 [assigned] [usertype] resultnet/bluetooth/l2cap_core.c:1676:52:    got int
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 496 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.289 seconds


---
Regards,
Linux Bluetooth


--===============4435674666118046501==--
