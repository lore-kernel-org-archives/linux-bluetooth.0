Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD92554F
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiSESW6I"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67f91d48863so6810626d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 08:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703264395; x=1703869195; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LuR357OTsm/nWyK+mU5Dtc4V3LqDWf/4e1emqn8uguo=;
        b=JiSESW6I94s6nwmCXwzh11h9d0AAIr5CM+lusThV2ILmYnDdYhK4hLZz1EpYVvqYJ5
         sjfrNO2ocn7sNabjXP/pQz4+T4aSjTRjbhy8MgEbAQNNjS2rfF/NOIQSlEQSH43AjJ7b
         W6SvYKl6VwdyjZKxssr05s2qSbqWRg2QO9QET+EqV8fG48rIzgvguw+1zBaXBjiRlrmq
         Xz0qoY6nujXaSUX/AZp7Ry+YzOzgx4FBhDgcYEnHCtykpWA6XVmvo4iICEjV3eu7jHaw
         mtc7Iwb2smh9QiAx/gn3z9rYqjze6OqweC34n0d2zvRprmEcm+U9RhWDQavRAKBEvBPN
         GaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703264395; x=1703869195;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LuR357OTsm/nWyK+mU5Dtc4V3LqDWf/4e1emqn8uguo=;
        b=Vq3rE4/XMiWEtFG6n/110LQSQupWFjEQtcQpGTl1f2SO+HvnJeRF5uHSW+C3WBtm1M
         RL7RhndaW4DjbccTqbWViId0dnSWxvPDuBM/3ge0ImldWkw+pbKJBoIk1bo1XoUk3z75
         Fslsp+fGQFu8Qb8Zg/5TXwcT14pfIZeMovUm3P2febQZD5soxpCq/+gU//B6x1A/bgvq
         6jFMX9/cnzdclW4RwU4KuB7xpd3nN+a56ymbR1Hh2SpJKEaNU9AHz+5G/yFkM5PG3Zpz
         4LJp7QvgMqcPd1fnM0JufS98rMOdbDcroEsnBjoOCGsPmbuwz6AEA6cf909kf5YqMBqJ
         llPQ==
X-Gm-Message-State: AOJu0Yz7g4fpH9S21bNBMvcY+zensOgn5sPFmVkIKNghq91OD+L2VxdD
	P+G3gK5eQR0H8uheTKcBStubKQs2feSBTg==
X-Google-Smtp-Source: AGHT+IEvgJJVUK6tJpepO+eVWmFZTlD3mF5jJov70fyGWFodoj5rPtdcOa4ysNZsnv/AFacrpQTlfw==
X-Received: by 2002:ad4:4d49:0:b0:67f:9bd6:85a1 with SMTP id m9-20020ad44d49000000b0067f9bd685a1mr872230qvm.16.1703264395109;
        Fri, 22 Dec 2023 08:59:55 -0800 (PST)
Received: from [172.17.0.2] ([20.102.46.212])
        by smtp.gmail.com with ESMTPSA id y14-20020ad445ae000000b0067f986ff8c3sm492290qvu.35.2023.12.22.08.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 08:59:55 -0800 (PST)
Message-ID: <6585c08b.d40a0220.ba713.31c5@mx.google.com>
Date: Fri, 22 Dec 2023 08:59:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6041773491984891818=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 2045gemini@gmail.com
Subject: RE: [v2] Bluetooth: Fix atomicity violation in {conn,adv}_{min,max}_interval_set
In-Reply-To: <20231222161317.6255-1-2045gemini@gmail.com>
References: <20231222161317.6255-1-2045gemini@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6041773491984891818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=812523

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.04 seconds
CheckAllWarning               PASS      31.02 seconds
CheckSparse                   PASS      36.78 seconds
CheckSmatch                   PASS      100.59 seconds
BuildKernel32                 PASS      27.03 seconds
TestRunnerSetup               PASS      434.26 seconds
TestRunner_l2cap-tester       PASS      23.61 seconds
TestRunner_iso-tester         PASS      47.73 seconds
TestRunner_bnep-tester        PASS      7.10 seconds
TestRunner_mgmt-tester        PASS      162.48 seconds
TestRunner_rfcomm-tester      PASS      11.08 seconds
TestRunner_sco-tester         PASS      14.66 seconds
TestRunner_ioctl-tester       PASS      14.26 seconds
TestRunner_mesh-tester        PASS      8.97 seconds
TestRunner_smp-tester         PASS      9.84 seconds
TestRunner_userchan-tester    PASS      7.31 seconds
IncrementalBuild              PASS      25.84 seconds



---
Regards,
Linux Bluetooth


--===============6041773491984891818==--
