Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2BB15AD1
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4z2cLDF"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dc36e501e1so3546434a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 04:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704976918; x=1705581718; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eq/qxyPHhfvMdVwlA3Pj3KHcFBI4thohRD8j53KNVCQ=;
        b=k4z2cLDFjp/QTcGAo2E5D8xLXcv6MwrYBamAQ2ZSFtYxH7Ox+EljAEwvt0YLm+b1kZ
         ThLdF9PfKM5fD4GSmmYZYMMq4v0FnxynUTfoCKAsPyf9VGPp7/80gS1QbxP1N+RqHz17
         EgYgRGvWScordPbkM2P49/aAvz5dlyp364QP1ZRjWhCLI9KFGp1lQP+qF2d8zLyEEsQC
         V9a7vrwqR+xdI6o+q4xiCTD9JO37G2kwPyrRyTXcdSGy9UxWnLloSPx1cmWuArgkMy4q
         WHjFDiY7O6T6awhL1FADZXN2g/laq/JIyaEy20IzBoZVsNBBcjrjyKkJEC0ZoBYMW+BF
         8dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704976918; x=1705581718;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eq/qxyPHhfvMdVwlA3Pj3KHcFBI4thohRD8j53KNVCQ=;
        b=geM1CvY3I2J+1lU1ydVaGq5654I66OnqNDS1aN5353Kcs0haM002hqxvfI8sewVksd
         KsfNzYDwtw8ZDGIxSo9We3VWN7DHMlZh1m5ADpRk7ZfYikjIigSlzunGKS8YnJtcNKgG
         ZeoAHYnb6hTF7X8Z1Kh+/xAziZBS3zsAPZdCC//15r3Hy/MR0/SGFF3FMRMxaD+o04JJ
         wOojVZcw1skLqGkFYA0kTvH6eaTeoBFlHkD4q7nzQTcGVuT8j1BzEinvhng/XNiLCibF
         0UBZRbXWzbDlfwDH2Y64SSnqp9lEOhJlYqzR94zlj6NV0/hrdzwYOwVNy/le6MKH28Rd
         hKbA==
X-Gm-Message-State: AOJu0Yz49HcV0FqGv1xno8tD3kIfoKMehi0MpBX4jlfiMSCO6ThIbrvb
	RGSz6IFMJdP+hA/nPrAUhltYAr4Hkm8=
X-Google-Smtp-Source: AGHT+IFI4MP57x1Q4YsuL6JV48uc3kNjkGcyoHxrDYMbRwD/2GqwCSP/aSwMB3AFlpWgh16H1Zx6Hg==
X-Received: by 2002:a05:6871:4704:b0:204:1022:f751 with SMTP id py4-20020a056871470400b002041022f751mr1361221oab.111.1704976918060;
        Thu, 11 Jan 2024 04:41:58 -0800 (PST)
Received: from [172.17.0.2] ([20.172.29.181])
        by smtp.gmail.com with ESMTPSA id e3-20020a636903000000b005aa800c149bsm1104517pgc.39.2024.01.11.04.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 04:41:57 -0800 (PST)
Message-ID: <659fe215.630a0220.4bbd5.231a@mx.google.com>
Date: Thu, 11 Jan 2024 04:41:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6702118613203391888=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2] Bluetooth: btnxpuart: Enable Power Save feature on startup
In-Reply-To: <20240111101135.272065-1-neeraj.sanjaykale@nxp.com>
References: <20240111101135.272065-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6702118613203391888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=816155

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      29.45 seconds
CheckAllWarning               PASS      31.94 seconds
CheckSparse                   PASS      38.45 seconds
CheckSmatch                   PASS      102.87 seconds
BuildKernel32                 PASS      28.02 seconds
TestRunnerSetup               PASS      440.13 seconds
TestRunner_l2cap-tester       PASS      23.18 seconds
TestRunner_iso-tester         PASS      45.80 seconds
TestRunner_bnep-tester        PASS      6.97 seconds
TestRunner_mgmt-tester        PASS      165.97 seconds
TestRunner_rfcomm-tester      PASS      10.82 seconds
TestRunner_sco-tester         PASS      14.60 seconds
TestRunner_ioctl-tester       PASS      12.11 seconds
TestRunner_mesh-tester        PASS      11.16 seconds
TestRunner_smp-tester         PASS      9.94 seconds
TestRunner_userchan-tester    PASS      7.18 seconds
IncrementalBuild              PASS      26.61 seconds



---
Regards,
Linux Bluetooth


--===============6702118613203391888==--
