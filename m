Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260D1DE4D4
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738100090; cv=none; b=GZCgrdf4bprrHJixhnajgTm9BqlxzSrrL5dqpl01IFHQF4HkR90tG/dMukAw1eLOzXBEJpdojk7SGQescR3Jrz8jFtCGgAHERsjLWfiFi94mesSrTT7boja3p4Y+UWdSfI2h2noparz5CClUxeCVeIE3P80WZ5lj1SeR5pE4g/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738100090; c=relaxed/simple;
	bh=9thh9eLDHeyadYuWFeEZ+50Vuonfo/FHMPy7rbMXxqs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BGi0DKS5Zrl47Z7M7iXytpkWIzO+ngtEbOO9bXgEBhijv88+huvHc5Y4wl4JBYb+oeAo4l58+nHuglVZy5YKQt3H8a1DhOCbQsp9UQ+UJ7s+L7BwBbO/EzTZyRwTpDD2FEVIXsAAARVWZjuCBNqyFhVt/xXj6fu/jPd6CEBh0cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw0v8OWx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw0v8OWx"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216395e151bso1281505ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 13:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738100087; x=1738704887; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oU5tp7YQAP9YuGu17KDsKyXH9t4rLrb8TmbLYyEKAD4=;
        b=Hw0v8OWxiAEaCGN3lRqMerDwul5/ZzKVOpH/PK6coPoztcjxdeg8lBzGmT4s1LKjFA
         Cr/xTAYziWnYorQgat7sirYkGBA/Jcw1TLZC5viv2WOvhCp9p8kcEySlm6F6HQlluymP
         4eGVOHsf+mJMTToPzEgMu6Xwjhg9pMz1I+FKN757954emjNWqm+vxEviQHfN8vgJFfQQ
         5sV69uFdkcooPl2kiEgyYhkpgNs8EP2RgA1HnpscTYB59hxdJdoPUZW7KLrVzHAUA6lv
         UtoyutPmKklLJ9hYyC6iBt26hvs8Lj/FRGoCnQL6A6THiCpou5/8tQ2tGZa4hLIxjeQB
         5+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738100087; x=1738704887;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oU5tp7YQAP9YuGu17KDsKyXH9t4rLrb8TmbLYyEKAD4=;
        b=dNjsfUgKcLptKAJvAE+YTzZ1UTJeKFc4Wp63NrssSsGNhhUpJBPUjZzy5qqz9IstVi
         DLSu9s9emTmCSk8Gs0tZ1uOLrq/4HnBCt3d2XmOzrsqybgGWkb0uGHd5ZtEItnK6umGh
         tGDawYP0YO7CYV7JGbBqs98G9JVXwm5lPlA3BgJ8vJ/tb33Oa98EjcbJfFuoMja93TD6
         fRnBovmXq9cx3GuK8gIhPX4fe0muEWlqvXHdMTDZ7d5TLjI0rWg+Xp8Un2q+/H9O74Gt
         3FXJOLGGdfM2OVBQIccrdIMNxs5opOpMBB5DX7ujrG9YwzvJYQQASSIPHrEui2+b6DX/
         Itsg==
X-Gm-Message-State: AOJu0YyfmvbOzRfAjYJecL593apJllcUmun2KX0M8GY2WQJ0dmXiJ4lo
	brx72euXWjNxRemzEYdMYbHqFDef+41lYGDWdHwOZBBMtKPypLDOQu6rLw==
X-Gm-Gg: ASbGncudfSaNHUCMa/8bDKs/h69R/omDVa/C4y6mRTPO16rqcpjBHvdgc5HsUyJbOWc
	CIPlpiYLTm589ACrUuaOajAK1FqksFbaA5h1JNI3CBJzgMSwjWCbUX+E5rLjlq6EWdTZU+QhVXZ
	vtdaIw/zc3T1/VTzBJhwJ+GovS87FpYYHGdtc61CuzV0HL8sidwKddj+Lx0zw8qCL+hbYsQWTuE
	lDCRuc/mO4CPA4KtSlrU9lolXWtIz5fsPw2VDDY9PNJX2W0pG+gyBFUTzOd1LbFA1fqtH/lcSEm
	hwLFK0m5ZqFaQyPLqb8L6rc=
X-Google-Smtp-Source: AGHT+IH29HCKQRdGPyXQApYzVP1pth9CbU2bNW/jsaSFqdb2SW7ce4s8z9QKkf79v+Xs3aqDEdm9DQ==
X-Received: by 2002:a17:903:2348:b0:215:758c:52e8 with SMTP id d9443c01a7336-21dd7776711mr13285095ad.12.1738100087446;
        Tue, 28 Jan 2025 13:34:47 -0800 (PST)
Received: from [172.17.0.2] ([52.160.165.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424f344sm86358045ad.232.2025.01.28.13.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 13:34:46 -0800 (PST)
Message-ID: <67994d76.170a0220.11e0ae.330c@mx.google.com>
Date: Tue, 28 Jan 2025 13:34:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4997900037622196271=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pchelkin@ispras.ru
Subject: RE: Bluetooth: L2CAP: accept zero as a special value for MTU auto-selection
In-Reply-To: <20250128210814.74476-1-pchelkin@ispras.ru>
References: <20250128210814.74476-1-pchelkin@ispras.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4997900037622196271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928934

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      24.56 seconds
CheckAllWarning               PASS      27.01 seconds
CheckSparse                   PASS      30.93 seconds
BuildKernel32                 PASS      24.07 seconds
TestRunnerSetup               PASS      426.95 seconds
TestRunner_l2cap-tester       PASS      20.24 seconds
TestRunner_iso-tester         PASS      29.57 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      119.22 seconds
TestRunner_rfcomm-tester      PASS      7.49 seconds
TestRunner_sco-tester         PASS      9.37 seconds
TestRunner_ioctl-tester       PASS      8.12 seconds
TestRunner_mesh-tester        PASS      6.03 seconds
TestRunner_smp-tester         PASS      6.87 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PENDING   0.51 seconds

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
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.199 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.147 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.187 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.157 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4997900037622196271==--
