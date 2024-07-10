Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DA18FA17
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720605581; cv=none; b=Y7l9VjkvGDkSfzNbqxsV53s8I4l/9lQ0kyVb/aEoK6TgFzOhnEEN7wbjGAwvYYUuD9bfA1toubOnZ7P8aVtUi4v+O1FLTtZ/U5Zi+r3shTUG90D3HJxTDTXFV2fcRH/54ZI97b6zKVxLLypqJR+2z2t844ZrcNh4pVpfmnIpTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720605581; c=relaxed/simple;
	bh=OltiGHSm2UXmid2G9GvWahoUzpNAaUwIepfB3EyLobs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CA0Zj3GRTj5dRt7rPIdweJrUPFWChNHfLLXb58iCgmXUhy2139WYi4y0eiRGNEEWufQCp+tXN/ndkYliKN6w8ZUrnxr5TFe47KycQ1Yel5p9BCEwhhA2h03KzrokSE98/17yo4qEwmVbLGduvVL4ob9x79W+61+gPljefDpj/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdwXfcYI; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdwXfcYI"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79ef8e0c294so44295485a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 02:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720605578; x=1721210378; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iGCLdbCrXjFw8Z6m+iao3AogsgHMhDbu/7Ixq1IsP6w=;
        b=fdwXfcYIp/poJwR2EwMlKntSheuajWyFIGbTrLUlgmm8du2MvLpRALpxci0apUYni6
         uoDsEQcxEKrIMQxCxN7b+Y94fXYHeIh/MfbUMMsGIO+EPBsEMH16jz1ehjjLvupMDPNu
         uAc5uFmuHQVHTJNUCBNl6/OgRLsOrx2dKcnWuFQF/Oynf3ddtE8/liwIy1c2hew+Q+mk
         Wg6/1x5rkgHmkwTZ1mR/egF9J5+erzJLmVaxl0atxrhSkQTejOaI2iG0PXkQlYkBW4Xy
         km3aCEHfS+SJRs6rBxijUXtOWtUH1NeTv6b8+D9JGA9VIBfcimOuxYnNDBGKdR+gqz2U
         UJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720605578; x=1721210378;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGCLdbCrXjFw8Z6m+iao3AogsgHMhDbu/7Ixq1IsP6w=;
        b=k0jjIlcLZbiGPoiwxPlFmTNFKrOfT6Kz12U+cs5vkqrEbNkOvD1+yp5QidZ4fGr5zE
         XBg2bjPZJifSIEBMcNcaeBCWqnXupCd3JksGMf6eFpZBKOEIvcaDgtbdXnC6FXbLRaiz
         sqw+6nhPC/C9EeNNAcBVAMMfy/yX/iZwhpkr0RESh69J0K+7qwbbKhMIHYO1OSEbV5+O
         iR1ipY6bbMd3qwU/6wR+rTt+ZRfJG78CemFhvm9bbbOUQJ60Xk221Y7Vjd7YD9csr/9l
         MfZVW3WZ47z6+SCz/EUMigUU9/62sNtwxxhdCOWvza5ts2GjqH/0Uu2rLo7Vm/YC+L4Q
         rWgw==
X-Gm-Message-State: AOJu0YzJ1lLRh2bKdAB7EVp61h+RdaMbMjrvoVP77mG7XYv5rDRyxNNh
	0HpdrHd7N5cwnDiawSGRr4jHFHjsnf8QVX2JD49NYi4bY5h1lrv16/dfgNia
X-Google-Smtp-Source: AGHT+IHePlThae2pE8PcquE4QhkCBFjCp8tuUxbbwNvIFveFYmaHmLjfTRVO16W6hhtemIyzkp39HQ==
X-Received: by 2002:a05:622a:5289:b0:447:ecd9:9f77 with SMTP id d75a77b69052e-447fc377e1amr80529291cf.5.1720605578569;
        Wed, 10 Jul 2024 02:59:38 -0700 (PDT)
Received: from [172.17.0.2] ([172.206.110.210])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b3c54esm18931821cf.28.2024.07.10.02.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 02:59:38 -0700 (PDT)
Message-ID: <668e5b8a.c80a0220.25e13.7e1d@mx.google.com>
Date: Wed, 10 Jul 2024 02:59:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4712188553112796600=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v2] Bluetooth: btmtk: Fix btmtk.c undefined reference build error
In-Reply-To: <20240710092614.7297-1-chris.lu@mediatek.com>
References: <20240710092614.7297-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4712188553112796600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=870048

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       FAIL      0.93 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      30.25 seconds
CheckAllWarning               PASS      31.85 seconds
CheckSparse                   PASS      38.25 seconds
CheckSmatch                   PASS      101.62 seconds
BuildKernel32                 PASS      29.06 seconds
TestRunnerSetup               PASS      523.73 seconds
TestRunner_l2cap-tester       PASS      20.08 seconds
TestRunner_iso-tester         PASS      127.94 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        PASS      115.40 seconds
TestRunner_rfcomm-tester      PASS      7.49 seconds
TestRunner_sco-tester         PASS      15.15 seconds
TestRunner_ioctl-tester       PASS      7.85 seconds
TestRunner_mesh-tester        PASS      5.94 seconds
TestRunner_smp-tester         PASS      6.96 seconds
TestRunner_userchan-tester    PASS      5.07 seconds
IncrementalBuild              PASS      28.05 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btmtk: Fix btmtk.c undefined reference build error

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
17: B1 Line exceeds max length (82>80): "Closes: https://lore.kernel.org/oe-kbuild-all/202407091928.AH0aGZnx-lkp@intel.com/"


---
Regards,
Linux Bluetooth


--===============4712188553112796600==--
