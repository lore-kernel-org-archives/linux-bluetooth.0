Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D5318631
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO69ktbn"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d98f6e8de1so3242213b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jan 2024 01:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704274418; x=1704879218; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iNhDsCLx3NnLNHyjHIvlccgHh0Ow1W6eRqcAVzYeyaM=;
        b=YO69ktbncVfCQCk0eZ2u55aRP84iDFtPAFWWe9f5fo8g4UCZSIoiYdbWOfK0kPgbDk
         gQYJqqpYXpxFPLhdYiGWwK65bVOkDDk6u34v9j9PMNP+umgp1zhKCODBTPqrFdKlDWRg
         hgWCMzVELaGY5CXSs/tCt30rcuYwiGII/PNJB9l0KjSbXcgKdPOE/4fk2Y7DbZdP+sgA
         q3owG8iSV5/SRKeUrwtJNeIrJSnmosoLooae5YMHS/dpxUnoNQQ/GgNWRwwvxKiAheYk
         StOBwJBAPnmPBIpWoS7IkeJk58poWFEzV8/7sNVEe8jloa0UetDXHZ40kQ/MNIPB6f4Z
         tyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704274418; x=1704879218;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNhDsCLx3NnLNHyjHIvlccgHh0Ow1W6eRqcAVzYeyaM=;
        b=HULfDDtZNaj7/AMn67/R1fxWw3XrZ6Too6CcbXsi7ADuOdGZSCkMY/kFpuuwHTH1yI
         VVlYy9mweP5c+Fg+JrRWMU4Kvr178QRkVeEi1Ab1LmttxkNZMSg+JfT6L2dFcN9kWnOM
         9xcBLbKSSFIwR+U0a8rgFSWFVEBfwIiJmXC62mm6XyYk+/Yq7C9sTJ/2+tVaQikHAFBu
         t8sUA7j1J7DaeYhC95jjVn3AqI9jfie1uGPD/Oj22u4uJwUZc+5Eo/yAP/HaXbMcg1zv
         Pc3m+3yCQypynNmlBIOq2MaWmFTKkQPOuh5cj2g01vpCVn5xVAcEofE5mB6b9KqvwcSR
         gm3A==
X-Gm-Message-State: AOJu0Yz4NrDvW6t0Fpm4JC75kJmu1jvG9zSeaNXBph/UFSvJRsiF3ELY
	Ed/HycaIKE/DzOvzgsJBZtOIs+QQXyk=
X-Google-Smtp-Source: AGHT+IEUlO6AfjQ3huvGvX1kmSnZzXJ2Cskocf+uyHYJkmZdzFa8B3Q4QIaieplnre9IC35bqGQghg==
X-Received: by 2002:a05:6a20:e10f:b0:197:6a98:169b with SMTP id kr15-20020a056a20e10f00b001976a98169bmr692507pzb.32.1704274417992;
        Wed, 03 Jan 2024 01:33:37 -0800 (PST)
Received: from [172.17.0.2] ([52.159.137.233])
        by smtp.gmail.com with ESMTPSA id ck4-20020a17090afe0400b0028ce12f8cdasm1147774pjb.10.2024.01.03.01.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 01:33:37 -0800 (PST)
Message-ID: <659529f1.170a0220.90b51.294d@mx.google.com>
Date: Wed, 03 Jan 2024 01:33:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0471621532136957887=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 20373622@buaa.edu.cn
Subject: RE: [V3] Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security
In-Reply-To: <20240103091043.3379363-1-20373622@buaa.edu.cn>
References: <20240103091043.3379363-1-20373622@buaa.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0471621532136957887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814026

---Test result---

Test Summary:
CheckPatch                    PASS      1.48 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.35 seconds
CheckAllWarning               PASS      30.21 seconds
CheckSparse                   PASS      35.87 seconds
CheckSmatch                   PASS      98.79 seconds
BuildKernel32                 PASS      26.56 seconds
TestRunnerSetup               PASS      428.00 seconds
TestRunner_l2cap-tester       PASS      22.86 seconds
TestRunner_iso-tester         PASS      44.57 seconds
TestRunner_bnep-tester        PASS      6.83 seconds
TestRunner_mgmt-tester        PASS      161.35 seconds
TestRunner_rfcomm-tester      PASS      10.88 seconds
TestRunner_sco-tester         PASS      14.36 seconds
TestRunner_ioctl-tester       PASS      11.83 seconds
TestRunner_mesh-tester        PASS      8.58 seconds
TestRunner_smp-tester         PASS      9.62 seconds
TestRunner_userchan-tester    PASS      7.58 seconds
IncrementalBuild              PASS      25.43 seconds



---
Regards,
Linux Bluetooth


--===============0471621532136957887==--
