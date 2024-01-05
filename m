Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DA7538B
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jan 2024 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhUbVkO2"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78117e97becso64969085a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jan 2024 19:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704425594; x=1705030394; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ecIgcRMGkAulpY8RwNMdpmwwRXe+BRZhfIk2fu447dc=;
        b=UhUbVkO2ziGWmgPQ7nz2Qfh5kIguTYoNtqTy5tW3WQn12Tbk/+nubT1docJhu/uEkJ
         Zqzi77gyKq5PnEFXNWEqm2VCp65Ky2PvEPtqJ/kfimvTDL4JC4v5H/h2w0mWq1Ocd+d1
         o3hzuMOqRRzefsqjQb4KLVcNqmKJxtQ1vF1Gt5Kbg7vZU7yLUXaorKBk23Qv9O4GAN/1
         Hr3CmAr2qN/kwhYM7A+7yFLsUeqDbM4BmzTbYahNMXQ+D18+867fu0h4/rhTLbdEFQar
         92DiuEAAyZXlOQHZlq8zlokCBn8dcgOgYuQPJMQB1fIfCl+3J3FqPeQDvbun9Bwp7cGg
         pI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704425594; x=1705030394;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecIgcRMGkAulpY8RwNMdpmwwRXe+BRZhfIk2fu447dc=;
        b=WU5oI62BW5ME5PUlnuumfZMmAjHeAS/XZBpNrSrND+h/3q6CPo485PBawoNNs6jJ/Z
         XLDARaOT3wVUyZlb/PUr/6wBGuu2fr1olzzxwNpfCqdOJpYcjIZylx5AuJuvoCgwlDX4
         pd9osLK+5jDVoBHBQeC8KnWVGxcF5ygJhtZfqniyr0nvXS+gMog1EBLgEWW1kwBeH/oN
         5uVUq0gG+Kl32MvS53tDs+3h0bJb/QBy2mMOt1OLka7czkW6LM8hvSytsQyrjhD30zmK
         /L/BcJHXTso1xPMvB1CQhqAVFvbSgzgXglWu9QYS2sLv64+ogD+q9SVu7bgrLPT4dsnk
         PDHA==
X-Gm-Message-State: AOJu0YwQRjJW0lTCSGgXp+2hHAtPtAmyPJ7qlJq+CxotwyiwemQgCynm
	OXSR8mG760ELWmg2+19FVJqKvnfst34=
X-Google-Smtp-Source: AGHT+IHFUe4N4U2VCuethx26mc4QW47ZtgDw8GGjysiPET7bwhbIANtpCeBcQ8xuF2PwyQ2uYbGRBw==
X-Received: by 2002:a05:620a:244e:b0:781:ea60:b466 with SMTP id h14-20020a05620a244e00b00781ea60b466mr1688357qkn.119.1704425593793;
        Thu, 04 Jan 2024 19:33:13 -0800 (PST)
Received: from [172.17.0.2] ([20.109.36.213])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a112700b0076ce061f44dsm282353qkk.25.2024.01.04.19.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 19:33:13 -0800 (PST)
Message-ID: <65977879.050a0220.ac5c1.100e@mx.google.com>
Date: Thu, 04 Jan 2024 19:33:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1175106077460969771=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, clancy_shang@163.com
Subject: RE: Bluetooth: hci_sync: Fix BLE devices were unable to disable the wakeup function
In-Reply-To: <20240105025625.125895-1-clancy_shang@163.com>
References: <20240105025625.125895-1-clancy_shang@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1175106077460969771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814541

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.78 seconds
CheckAllWarning               PASS      30.53 seconds
CheckSparse                   PASS      38.59 seconds
CheckSmatch                   PASS      100.43 seconds
BuildKernel32                 PASS      26.97 seconds
TestRunnerSetup               PASS      434.01 seconds
TestRunner_l2cap-tester       PASS      23.08 seconds
TestRunner_iso-tester         PASS      49.83 seconds
TestRunner_bnep-tester        PASS      6.82 seconds
TestRunner_mgmt-tester        PASS      162.98 seconds
TestRunner_rfcomm-tester      PASS      10.76 seconds
TestRunner_sco-tester         PASS      14.54 seconds
TestRunner_ioctl-tester       PASS      11.95 seconds
TestRunner_mesh-tester        PASS      8.73 seconds
TestRunner_smp-tester         PASS      9.76 seconds
TestRunner_userchan-tester    PASS      7.24 seconds
IncrementalBuild              PASS      26.13 seconds



---
Regards,
Linux Bluetooth


--===============1175106077460969771==--
