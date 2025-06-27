Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B7F2EAD00
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043977; cv=none; b=in3lcizzPZ/TN0gxrZIlplsq07590S3HMAtvhYESYwEj55FErcsKEt2dN0ffHPKo5jZ+MWEFRuN640D7WCltPSbSddiF5lPrJCjAFmIUIAMmOOZeYseZM+hLUeovYZ2kohgpGumjl2kbO++mX6DLhznkCbZ2GOMdzum5o1vds2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043977; c=relaxed/simple;
	bh=63A/M0HRB7x15t0dvHR4aDURKf9CbB7LrYHeSykfPgo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ifw1ppnO2ZI7CxdGJ9ahPvi/hLL3KoaWgxCjWWu0AcBM4PIJ8n0sCzm+HKaP4DvGoQ/EOMQ0rcTSy05SpCxCAQgo+2WyAjSC/rfC13p7GPA68sgTinPrrJdzqjJhNpyrNtklzpLKZpUCTgFdWrZs8CBX6b8HhjVQOqaY0V8C4Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+k5GFVF; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+k5GFVF"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso25584576d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751043975; x=1751648775; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JHFtQo8oaTzcayYG+6OXtDlxOTozpVmSj7eUg6zOPkg=;
        b=f+k5GFVFK49lYycVC4WyFDL/ZeRtHoQW49qwOWCKmJWvI7+FaHy8aXlf3wbTjVvS2u
         WQghAWCXUm0Zexh+CNP6eYzHfnx93JSYqdEhj8q49WR1w2zAdn3GOSRwpnu3F20VvHgl
         TlA8I8ymQCFGBUOpms2o3vYiuF4aWPRSMVJIjwdr+wAwfE+Fi5Q0fqBk45zbL4uGO1BF
         wTTcL26X5+d+nOmPhOK74jzKkNjATyEPy0m1sjUa+PBt/QVJoG1QGEKqOAsAx3uTLZz4
         Kr7tEuZT1voiY6aRzt0ZQ9aPn58W5oxzk3cr02yV2quz4dxKiRZ2tfqHO/X7CESDO6JM
         5H+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751043975; x=1751648775;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHFtQo8oaTzcayYG+6OXtDlxOTozpVmSj7eUg6zOPkg=;
        b=aqTPyR7q0yZyfCSRqt5IM/QDFPnkidnTYGd9YTt9xKVvOOY/uORC4s/ByZpa61Uguu
         FNjfqqBaX59KBgldPXhI+znTHpakj8gxYgACxxfZ+YS5Myjw8hZZjDcRx54xsZoI6H9t
         2wPPCzUKJSR5BO4JIuIVmDkKw6Qp6+yitIdAJaIpOjk5XTYkiDBd5qz8MJbsgtZvpc6s
         7Ib5w1jbGvWuy63SIWLNBjT6uzOFYV+UTvmfCqCsXYohuf52SizQk09ZyZKv1OfJ6GsF
         bNr1/iFyLH50aC6hsdvJ8kSSD59O6UUDwOvX1wpqJIvxdilQaJXu+vtIg+7cOZRu3JFy
         NawA==
X-Gm-Message-State: AOJu0YzvbQca8b9oEYSVtJT323KRYfTCy8S/bzwH+J9T1x57qjdjz8lz
	QVOWXzHLpdH+S4ht8aCLmpOfRr32PeQ+wAxhucD7P7uEN+sdhtM4hNyyIQMO1Q==
X-Gm-Gg: ASbGnctcVe+R8XyQAKvFQ3VaVgTaVSuAHIS+oakgoQgacLh2HeySQYVeuqBJEslTBkW
	ocCfbKCwLGWmC+456L7Ah19+ILQ6xj0tNx0Hw9NteFTzjMn48Xt7/rBqJj6WahRdrfFQhRUbazZ
	CYDV2Jf9LgV5RtUv3s2pWAcbkKmeacn7eRo1z9iFxRYe6yIx4pam5RU2DCgDSqlwDNoYJPyinVv
	K7KEEfBunaWFOYuv5jP2Vg/y0YeMQby6YEuhwe1p0Pf1HOlwCmaiAKuemmxvkp/rure5ijhtQux
	FS7JhtNnG2IOP3yyBuP8bm6RhO3/1ygUkCwHuejY+aK51j67D/kw9lSIDAcMR3AoUjmG1Q==
X-Google-Smtp-Source: AGHT+IFZ076UVSv6U/GKrpowTPC759QFLZwkN/LtCUmufSczVYOwDzlOnju0dusWmQAyhrO1ebD/NA==
X-Received: by 2002:a05:6214:21ea:b0:6fd:5cf4:cbb0 with SMTP id 6a1803df08f44-70012de5f96mr73851166d6.25.1751043974616;
        Fri, 27 Jun 2025 10:06:14 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.175.14])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771abd15sm24161116d6.29.2025.06.27.10.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:06:13 -0700 (PDT)
Message-ID: <685ecf85.d40a0220.207b8.8d13@mx.google.com>
Date: Fri, 27 Jun 2025 10:06:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5850105461496113558=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix not disabling advertising instance
In-Reply-To: <20250627163133.430614-1-luiz.dentz@gmail.com>
References: <20250627163133.430614-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5850105461496113558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=976739

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.88 seconds
CheckAllWarning               PASS      27.37 seconds
CheckSparse                   PASS      30.87 seconds
BuildKernel32                 PASS      24.84 seconds
TestRunnerSetup               PASS      486.23 seconds
TestRunner_l2cap-tester       PASS      26.24 seconds
TestRunner_iso-tester         PASS      37.76 seconds
TestRunner_bnep-tester        PASS      6.15 seconds
TestRunner_mgmt-tester        FAIL      139.43 seconds
TestRunner_rfcomm-tester      PASS      9.59 seconds
TestRunner_sco-tester         PASS      15.05 seconds
TestRunner_ioctl-tester       PASS      10.46 seconds
TestRunner_mesh-tester        FAIL      11.30 seconds
TestRunner_smp-tester         PASS      8.70 seconds
TestRunner_userchan-tester    PASS      6.36 seconds
IncrementalBuild              PENDING   0.38 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.249 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.179 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.865 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5850105461496113558==--
