Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F8328E12
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jan 2024 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCf6OmWE"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7815aad83acso32658385a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jan 2024 02:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704450799; x=1705055599; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=asYX0bNyIZbeUji1pc3h+DSq4zA5e5prHXD7psIOjg8=;
        b=dCf6OmWEK/NUFWGB/+xqd/t5qsHcc/iiMgcRv52xNJEJv7QD78g++OAEC0a0rbaTqz
         zeAGKr3XBCG1W2j8V2FmnnXVsI1ZXJADcgU0zg78crqPuko4oBF0GZI1M7AVfHD14Kpj
         se44yjUvbzS/02feMZrbIgM69m/8LqoWrxJf9RAD2u4fyXVsAqprP8VEni0hyslSJtVz
         CxRKCxJQyx4hZanqT4DIIiSc3ougbWCaCRgbsryKVyfoK5OHATduUhHm64WIj+Wk9U8L
         BSwFvPl5vt5oov6ycWSmWCfE/k28SgKAg15z0K0nWJY/+Qi0Ql73TVFuPpRsAkITP9+8
         QbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704450799; x=1705055599;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asYX0bNyIZbeUji1pc3h+DSq4zA5e5prHXD7psIOjg8=;
        b=PLLsGt6Oa5B+GO51nYk4KtsGy03If9ZciUFwTII+xIT3AlgDQrCyXOYuzdVbKg6tdF
         lom3TaLcJYQcqKKUIeRMIMDolqyVID72PHBksfo/JaafofdRjBk4VAcAWOXDIsouczYS
         no9RbGJsDLkPR/bI7UabQuJQ1P0kE8QwFQn3G8KPQN0vTI4W2pwXTfeesc576LgPEe/p
         p6rIkiSY/OiE6QN2UdiibChTHXZyG7eqwVsRzdXA5tjvgkDvOGDfh6MsQKpqwsbqSVd6
         2Biepa6/Hsh83xR01hFqeBBHUBKLrtZi+1FmG8oBA9yF8QUecnLhbo9kfhn/QY5ChsQJ
         DHgw==
X-Gm-Message-State: AOJu0Yy5Ui3sniUBPw1kWtrgbkDblzbtvVSW0EcxpJnyPk9Pm7hhpMpR
	U/hpuRNyBMJto0fZyF6GaYOgqITPw6g=
X-Google-Smtp-Source: AGHT+IGGB2RI9ofg3RYAqGXeGoACmTxy9Nws9398HLJpTU/b5QvdNVFX8SxA0Lu611BgioM+wwbvVQ==
X-Received: by 2002:a05:620a:6124:b0:783:52b:204e with SMTP id oq36-20020a05620a612400b00783052b204emr2302599qkn.4.1704450799223;
        Fri, 05 Jan 2024 02:33:19 -0800 (PST)
Received: from [172.17.0.2] ([20.102.46.177])
        by smtp.gmail.com with ESMTPSA id qp12-20020a05620a388c00b00781598c5e9csm469980qkn.135.2024.01.05.02.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 02:33:19 -0800 (PST)
Message-ID: <6597daef.050a0220.5dde5.1552@mx.google.com>
Date: Fri, 05 Jan 2024 02:33:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3399209974080560876=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, clancy_shang@163.com
Subject: RE: Bluetooth: mgmt: Fix wrong param be used
In-Reply-To: <20240105095228.279247-1-clancy_shang@163.com>
References: <20240105095228.279247-1-clancy_shang@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3399209974080560876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814609

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.02 seconds
CheckAllWarning               PASS      30.53 seconds
CheckSparse                   PASS      36.29 seconds
CheckSmatch                   PASS      100.05 seconds
BuildKernel32                 PASS      27.21 seconds
TestRunnerSetup               PASS      433.78 seconds
TestRunner_l2cap-tester       PASS      25.88 seconds
TestRunner_iso-tester         PASS      47.64 seconds
TestRunner_bnep-tester        PASS      6.86 seconds
TestRunner_mgmt-tester        PASS      165.62 seconds
TestRunner_rfcomm-tester      PASS      10.84 seconds
TestRunner_sco-tester         PASS      14.47 seconds
TestRunner_ioctl-tester       PASS      12.04 seconds
TestRunner_mesh-tester        PASS      8.86 seconds
TestRunner_smp-tester         PASS      9.66 seconds
TestRunner_userchan-tester    PASS      7.27 seconds
IncrementalBuild              PASS      27.05 seconds



---
Regards,
Linux Bluetooth


--===============3399209974080560876==--
