Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5B1946C
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VstNja0S"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce2aada130so1888648a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jan 2024 05:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704287474; x=1704892274; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HAMwXQQFYnEr9SkhncY+JerlScbQqrTL7lcJKJiH7iM=;
        b=VstNja0SIGZmplnKuV4ISNS0D0mrmpjEEAzf036wXffKLK2hMY0IWpa0lDV5AFkVTf
         N4gT81Dpw6yZAj2nwggK8SIeMTGwCrbLs3fXCXhFiLfFdIKXE2jZA3KaVXhXcuKJJcAz
         arXYfWT0r2j3caXplic/bXiUGgYPFIJ3wjDwQ5ZmqkNvk10al3Xo8KyPWv5CqCiilAlo
         rHifLLx6x87fc/zAIeEn7ahWb8RMxaoiBGnFavK++ikMkdwwV0s3QyoQBLTUoMMYTYvx
         BrD97W1o0opLD7XCQEZc4dwmt341PloZMCOh5sekHHxjynbt6H0jtrbztx11uAj09eiw
         ExoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704287474; x=1704892274;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAMwXQQFYnEr9SkhncY+JerlScbQqrTL7lcJKJiH7iM=;
        b=fJGqiVt+OjGZwifhEqrCGHqqdAyVOOQJ81uPSLpi1LhNU6noqS6iERqEiQmSmLv/y5
         ShsLNBH1nGDJnPzyQCRYy2U2aVUhTdJ2tGOaL9esrShyzrG3mJ/hYHhP1kD0CygrIXY9
         N1Ob7x7sqospz7HgMfvr7GT6QV4rz//L8Mh5xHlVgkcziJG9J0e0Qh47PobGWDG8UB5j
         f+s9mkrnMvyTZLQk/ivzUMx3OH1e8tpKTSWkT+vF+bTjrmHdBgTsKM6cEQWzktCkpaVg
         0XdBS6k5VjXWbDgDHLNDmJmjVS4xigfm7LojnrG6uXKJX0A1NefAeCrlWhgnOWOUmKVV
         OUUg==
X-Gm-Message-State: AOJu0YxpR1TafMluLD16McCbBOgaGhUXueAg+NFOkFgtxw+f2532oBNp
	zxD+53DoNRaoe1zNXGDOKcLHugut814=
X-Google-Smtp-Source: AGHT+IGvWXMOLdUF7a0hnE6xjeSiJRzGAD/LPBmFw00vgPhq+jmBdLnOs4Z858PBxA1q/+3zVPsd4g==
X-Received: by 2002:a05:6a20:3509:b0:18f:bd0a:5fcc with SMTP id d9-20020a056a20350900b0018fbd0a5fccmr7257932pze.101.1704287474311;
        Wed, 03 Jan 2024 05:11:14 -0800 (PST)
Received: from [172.17.0.2] ([52.159.142.195])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78649000000b006da3b35bef3sm9106991pfo.54.2024.01.03.05.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:11:14 -0800 (PST)
Message-ID: <65955cf2.a70a0220.f67f1.266c@mx.google.com>
Date: Wed, 03 Jan 2024 05:11:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8506119747286393256=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, clancy_shang@163.com
Subject: RE: Bluetooth: hci_sync: fix hogp device suspend bug
In-Reply-To: <20240103101201.1812679-1-clancy_shang@163.com>
References: <20240103101201.1812679-1-clancy_shang@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8506119747286393256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814095

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      28.56 seconds
CheckAllWarning               PASS      31.37 seconds
CheckSparse                   PASS      36.98 seconds
CheckSmatch                   PASS      100.39 seconds
BuildKernel32                 PASS      27.91 seconds
TestRunnerSetup               PASS      449.38 seconds
TestRunner_l2cap-tester       PASS      23.23 seconds
TestRunner_iso-tester         PASS      45.94 seconds
TestRunner_bnep-tester        PASS      7.05 seconds
TestRunner_mgmt-tester        PASS      165.04 seconds
TestRunner_rfcomm-tester      PASS      11.40 seconds
TestRunner_sco-tester         PASS      15.00 seconds
TestRunner_ioctl-tester       PASS      12.09 seconds
TestRunner_mesh-tester        PASS      8.86 seconds
TestRunner_smp-tester         PASS      9.72 seconds
TestRunner_userchan-tester    PASS      7.27 seconds
IncrementalBuild              PASS      26.70 seconds



---
Regards,
Linux Bluetooth


--===============8506119747286393256==--
