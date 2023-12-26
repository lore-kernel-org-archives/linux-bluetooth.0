Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AF34E603
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJi79hIJ"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67f6729a57fso41733086d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 03:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703591831; x=1704196631; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2osmJIQFm4v7AQW1pXV7vcrKz1tg0MbX8Riq0YFR/oA=;
        b=XJi79hIJIma02Zbq6N+DQQsp57e+Ob0VE4ByifWq1wka7J8V2hG24iMPs3IvHuHD+W
         LdKpqffbf0lBTHuDomZ/rymA/QVFfbiFGSWeLhXGBJLY7vMFrZnYbMlrXWnRWV14E8Nk
         tU3dbUUqQakR5Fx6bhCWBBPUVVMVC0MCkEFBzk9hO+1ZDEJVr5Gji69yammbZsxrWAf9
         usikhhY1+TJRt5hpSk4+rzB/KVLPYByhwRv+gGWWrF5m7j9pobnASIjfkVbtOD/cr7Zr
         f0ghDMb1ElmUIwCy/B+CbBrHN9ma2W+Wc/N5jIBNA7178WJ0zUJJ67yqseIOEh4W++Lb
         +3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703591831; x=1704196631;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2osmJIQFm4v7AQW1pXV7vcrKz1tg0MbX8Riq0YFR/oA=;
        b=gIcVMYBy7oL2tt7Npd+hSUeFndIMdV9AN+EHnINL857YdK7c/KG2RS/sLZxIKiB5a5
         z5CDsws8U0C31esSyzB/6mA5Fv6sk7R3fyN3pL9FMv+OSFUeRofjdIyABikTrJUye2Q+
         f3Idu3eNnHsKTxBHJsA/VLqm+a6F5eYTppiWuoS/CkWQOeqR9Zom3HQEpDbpbXL1KdMr
         HWGX5Qr9jvFa2K8LPO0TV/IorXTa4fTNSq5KpurSWOInwxUjIOsPjBFCWipt86i9Q5Rk
         aeqGR3UchTm4QqkKnWGbQ1/UuX7Zb1eb9ZViBMG0/VEt5mvukZrwgMRZI0WgHDro0Akj
         QbLw==
X-Gm-Message-State: AOJu0YwDs9eglKYIGao1oGyXgLGiGGtodJc5hYlgmmxInpJHRBxXtajy
	xcWlwNJtGD6PrSsR4GjzLttRV30MlVE=
X-Google-Smtp-Source: AGHT+IGczq7EW4mR++ZUoqeLj3JgCmNROMXY8CgeU1nzpDnhQ8xckU556gECP+pTYSdZUkUl4E2Jlg==
X-Received: by 2002:a05:6214:da1:b0:67f:2f9e:5184 with SMTP id h1-20020a0562140da100b0067f2f9e5184mr12382135qvh.15.1703591831328;
        Tue, 26 Dec 2023 03:57:11 -0800 (PST)
Received: from [172.17.0.2] ([20.102.46.212])
        by smtp.gmail.com with ESMTPSA id hf8-20020a0562140e8800b0067f6f8c2a66sm4533564qvb.126.2023.12.26.03.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 03:57:11 -0800 (PST)
Message-ID: <658abf97.050a0220.68fd6.e39d@mx.google.com>
Date: Tue, 26 Dec 2023 03:57:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0377712980559736037=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2] Bluetooth: btnxpuart: Resolve TX timeout error in power save stress test
In-Reply-To: <20231226113110.3923962-1-neeraj.sanjaykale@nxp.com>
References: <20231226113110.3923962-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0377712980559736037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=812886

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.90 seconds
CheckAllWarning               PASS      31.18 seconds
CheckSparse                   PASS      37.96 seconds
CheckSmatch                   PASS      100.66 seconds
BuildKernel32                 PASS      27.66 seconds
TestRunnerSetup               PASS      442.29 seconds
TestRunner_l2cap-tester       PASS      23.08 seconds
TestRunner_iso-tester         PASS      46.32 seconds
TestRunner_bnep-tester        PASS      7.15 seconds
TestRunner_mgmt-tester        PASS      165.35 seconds
TestRunner_rfcomm-tester      PASS      10.98 seconds
TestRunner_sco-tester         PASS      14.47 seconds
TestRunner_ioctl-tester       PASS      12.20 seconds
TestRunner_mesh-tester        PASS      8.82 seconds
TestRunner_smp-tester         PASS      9.70 seconds
TestRunner_userchan-tester    PASS      7.32 seconds
IncrementalBuild              PASS      26.95 seconds



---
Regards,
Linux Bluetooth


--===============0377712980559736037==--
