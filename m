Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DAB42A8C
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug 2025 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756586059; cv=none; b=JV/RTMH8Q/ZWdKRJCj1zz72GDbW84FgnqNIYoG2KletTUudCswyqmaC21Qyez2BYaaAglIqjlHs3qaiP7g+Of2GgmCS9ABr2EXIkx+z0fTcGXSyfeDn3r8Fe01Muk0nhrqyOQz9FJpK9wVifVThzZnTE2MAT4QQqrYk5bb97UU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756586059; c=relaxed/simple;
	bh=/f7VFud4Xb6+/Y0xuHG8XVTKLiAp6ONOpNHc7VcbaIQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MIO/9hnqg9XKSwbwLY8uZsMD0emL2M+NmjP+6OeF0Gdy6muvxNsll41cY3iLf+p4XgTaWXAaIzQkkQIQTVrAPh0P9ZElrpCCcecX315jcAc0t3DpdOmlK1flzqAdARorTiiJrlfaAmOm2dVCEerB8zN4UgYk6MrKGsEN0qWTGt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hstUxRgm; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hstUxRgm"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3f2da50ad46so10054915ab.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug 2025 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756586057; x=1757190857; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WKqdFJ5n9J4xL+o1a/gNw+mM6AqqhDFja5n1PoEd0yE=;
        b=hstUxRgmCNk3enpeql6nRwE0kFwYqMCrXaqwQ9VOeMK16+qmUeptUnTiOgDGZ6+EKl
         niYfTpbBnMcI9id6hut+UHEb2taXtraG6JF52v2yj9U3d4Bm9NHNj8UBRbvAOXeGZyPx
         iBUKGATV3ZgpSSptLYsHNqquJJtIdsAjbpp2vDzUpa30rugQbAk/BaSbcujZmOMz+Q8T
         C83WCJe/25/PSqziK/aiaY5eaiFRq+2FApVI2IwI/+IFm8r6dujuWtAw9r5tXgBy/u/R
         kb6u8FS5+8c5vCNirVcnoo5e6Tbn+6zOzNN55eCthGBAeeMX8223o381XiRJHQaOOCc+
         yumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756586057; x=1757190857;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKqdFJ5n9J4xL+o1a/gNw+mM6AqqhDFja5n1PoEd0yE=;
        b=PZYdRokLsswVB++D9G9QGPaM53fQRWLaB234euCKS5HfHy0O3VBEUYByqhQJo4YdIa
         TTfsBLfZ0YTg3funPIlWVaTEtMX9cki6Jv2NiI3EJhfJc8qfgXLYjhMj5ILnpn5/HjI5
         JtTe6vCTB/lg+kC4LKRyitgw/F8H59zxmCiGSwSmCDysneZzxgc833LC3ymIR3g9Vn/F
         dWnCFNxjft+9nU4cAS9MUDqY5YexOyq+bPcy89+2LtFqdfvbBEQaSI8OSUGRl1Aqcgab
         JXlurD/dkinGNf8rX5nXvTH/NrwoBT0THAXXvXDLNiAuBu7qKtt/oSrrPG//MBRXHl2Q
         Ryxw==
X-Gm-Message-State: AOJu0Yy5H6fAVhSXpJk2YRhXA7GyqSzY2gzHsEGN1xRadcxuhEvCqlJE
	TYaGzfkC29UE82bCJIjr1Dy7LsFwoOA9TWJ/T8qwwMlu613FgxCM/AIohHvfjg==
X-Gm-Gg: ASbGnct4EUBsKPhb6kvtLQprqm9LmbyqwLZvh3uuAah/c//oD5rBpl9RMpkW5VQzlBl
	dphFOqW+hFnO/qzClNbCmg0o7PGb/NFsIibG++P3TtQB94fDLN9DeRi9mFnHbynhuU8DpJfoo2C
	YKXiRV6ulNQOzlGrkc+bzV8/TJ9yUnkJhFcHyjydTHkPwjqr6PMxCcW2euwmoB3eqAgdx+qOyqs
	A0CDk/KIX/mZyYY/eIu5uQ5l/pYVgPC4wjyHeze919547JfY79Jpi0fZZI1JipXyrhJUj17Unp/
	izwMP9N1P4/lqaMKGB8XkBXCIghPmJSRHVuXVXdSRYtIoyb3ee14BOOLuuOzsf7CCxFZlBXKNKt
	Yv8BrCFsLrOKC5DezKmII9z4ch8lRjWSWDjS/q2Jv
X-Google-Smtp-Source: AGHT+IEMuiTw7pzE5cjX7Wm9GzsQyu+A9nko6RcOIDJipZni0ueM7v15pSeMNt5eJdm0WKjItaHHwQ==
X-Received: by 2002:a05:6e02:218e:b0:3f0:aa7:9f6d with SMTP id e9e14a558f8ab-3f4000978a7mr83819125ab.3.1756586056808;
        Sat, 30 Aug 2025 13:34:16 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.140.163])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f377edasm894498173.63.2025.08.30.13.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 13:34:16 -0700 (PDT)
Message-ID: <68b36048.050a0220.202b94.1b47@mx.google.com>
Date: Sat, 30 Aug 2025 13:34:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0463039298170662940=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ipravdin.official@gmail.com
Subject: RE: [bluetooth-next] Bluetooth: bcsp: receive data only if registered
In-Reply-To: <20250830200339.36429-2-ipravdin.official@gmail.com>
References: <20250830200339.36429-2-ipravdin.official@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0463039298170662940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=997255

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.21 seconds
CheckAllWarning               PASS      26.76 seconds
CheckSparse                   PASS      30.25 seconds
BuildKernel32                 PASS      24.30 seconds
TestRunnerSetup               PASS      482.67 seconds
TestRunner_l2cap-tester       PASS      24.95 seconds
TestRunner_iso-tester         PASS      42.91 seconds
TestRunner_bnep-tester        PASS      6.05 seconds
TestRunner_mgmt-tester        FAIL      129.17 seconds
TestRunner_rfcomm-tester      PASS      9.33 seconds
TestRunner_sco-tester         PASS      14.72 seconds
TestRunner_ioctl-tester       PASS      10.11 seconds
TestRunner_mesh-tester        FAIL      11.38 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.64 seconds
IncrementalBuild              PENDING   0.44 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.031 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0463039298170662940==--
