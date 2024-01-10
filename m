Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9087239ADE
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jan 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdnujzQ4"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bbf67d619cso3020137b6e.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 23:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704871941; x=1705476741; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iPy+m0Uht1/4zhaDVZb9cdkDz2r5mFhpmfMEiycumP0=;
        b=AdnujzQ4P+XmuMumo6sqvs3Jm99OZbTCueMHvpICOtiTOqRcTM8Bjd3DxWwEGdkciG
         J785uaN6AO8YrRVVOtVUmAj5z1XsqS5FOn6sosJrqv3BSZmVJr0jD7ahbtXuARF5ygfv
         VYitUOB4mLhYvYw45w/6h461Id0DKtoMCPwXZ0fgpO/Ce+bj8Xo4F8CgDkI8yS8dd7Nn
         6/M3DsZfiRxSwIJMEympdvPuP2Yhq22BYRZ76EEcoAQAnBHuzuhV5eFffAlDUoYyZbzm
         amrhCIXoD7EWv22U9yQ65KIdS3LdCVHoiJ+DX/82pDG4lfrRiBYkWJ9MP/vUr1nVssgE
         vLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704871941; x=1705476741;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPy+m0Uht1/4zhaDVZb9cdkDz2r5mFhpmfMEiycumP0=;
        b=Kcxl+t8YTQOITi4tRMyacsnrqly9y9cL0UQheHklO5sd/gDhdEfWro2XxsxrS35WSB
         9UfOjiD5f22YUbBw74PtOSCl/71U4d6rVJLt8IyELArufAMdy44xXFYRCeBK+xS8O5LZ
         UjPos6f+hZjKyRmXTH9Dwl4NIlQ7wjjIABaxBhB8PsFhz7HjP7BQOIvbqsvgNK2hi/aP
         Ns1XDj9BpVj25AJ06wHGLfJMI4fP+8PggHUh/pC9Q+Ax9rIf73enhOTL189wK1Y5rfsa
         JEtYPS9QJ7aRpJ342+LKYMfbm8n1RAHqQGdpI1MMFFscazP5xveEjVbeOv/xPr08HaxG
         Fa+w==
X-Gm-Message-State: AOJu0YwLuyJJV8ed6VNHfQgMwYSuZgmtdHwHfO/7mVJ/vMw+hpftAiAN
	jVLFtsXrnuuAMHyjN11MT/kJouvA5GY=
X-Google-Smtp-Source: AGHT+IHA1JmJ0ZO9YXc14tPy9mnLA6BIHcDaurCMVIybJekkDMXS29t0x2zicGCrXuTr28G3ZSFEpg==
X-Received: by 2002:a05:6808:ec6:b0:3bb:bc99:1788 with SMTP id q6-20020a0568080ec600b003bbbc991788mr534865oiv.46.1704871941422;
        Tue, 09 Jan 2024 23:32:21 -0800 (PST)
Received: from [172.17.0.2] ([74.249.14.240])
        by smtp.gmail.com with ESMTPSA id o17-20020a0cecd1000000b006811729a906sm1058520qvq.67.2024.01.09.23.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:32:21 -0800 (PST)
Message-ID: <659e4805.0c0a0220.4e1e2.4c60@mx.google.com>
Date: Tue, 09 Jan 2024 23:32:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2261606017717135833=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, clancy_shang@163.com
Subject: RE: Bluetooth: mgmt: Fix wrong param be used
In-Reply-To: <20240110070143.806843-1-clancy_shang@163.com>
References: <20240110070143.806843-1-clancy_shang@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2261606017717135833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=815632

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.49 seconds
CheckAllWarning               PASS      30.48 seconds
CheckSparse                   PASS      35.71 seconds
CheckSmatch                   PASS      98.45 seconds
BuildKernel32                 PASS      26.87 seconds
TestRunnerSetup               PASS      430.54 seconds
TestRunner_l2cap-tester       PASS      23.60 seconds
TestRunner_iso-tester         PASS      44.43 seconds
TestRunner_bnep-tester        PASS      6.92 seconds
TestRunner_mgmt-tester        PASS      160.97 seconds
TestRunner_rfcomm-tester      PASS      10.80 seconds
TestRunner_sco-tester         PASS      14.28 seconds
TestRunner_ioctl-tester       PASS      12.03 seconds
TestRunner_mesh-tester        PASS      8.74 seconds
TestRunner_smp-tester         PASS      9.66 seconds
TestRunner_userchan-tester    PASS      7.19 seconds
IncrementalBuild              PASS      25.89 seconds



---
Regards,
Linux Bluetooth


--===============2261606017717135833==--
