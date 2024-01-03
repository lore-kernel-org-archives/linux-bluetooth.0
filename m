Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422317980
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 04:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmRlh75c"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-680a13af19bso26888106d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jan 2024 20:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704256492; x=1704861292; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AFjYhDBDE4bS084dbjx/7MOSc//2g6/WT5rFdDskZW4=;
        b=bmRlh75c9b+uXI+QQseFSpd0+pb0ruNycxvPPHmdQtZcH6j5HrJ0pEMyrMqdnFWPlW
         rJ9NASznta2SJZrhxV89SpBq6whGupi846fN6/jzUgySSdlKKn+pSuOPuTaV/VhWymUw
         k4LhUQR/2m6oebnS52vAiBe6MRBeSlULXxlmQ1gbcwhID8dAHtdrCb+OjtdYWdYqi66S
         QJppd6iCa/YLMNpTdiIiD7FGHAR5V3vetH2j6NuW3AMitPjJc9ijn0oxD4uGSSSEH5Kb
         gpsmmdNc78TPYf/i1pE5tLKv1HtZaW9O1t1o9Vc/t7xJX7V7sUs0BRR0N3iyBI62kuiR
         TkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704256492; x=1704861292;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFjYhDBDE4bS084dbjx/7MOSc//2g6/WT5rFdDskZW4=;
        b=urcgGr7iwRA7s2MS4PeXj7Mpl0aMCFUphjWKNmbRurjOL3k5BkvfhoGiyCUt5wtKgt
         c8q7/q+WYvKWwlAkwRE+joc7tH66qMqIQMEXELlbo3T6RtCC+LWV8OloKzECNqxJ5BVp
         vQe/qjqJSXNiIh2n/g1XQQMKCPR0EJL8J/pxZM2x/L81eJMH2apQbBVHlmnuFZGvnTzF
         oahKPdZchKoUSiLpFAS+NdxZR46mMe0kE/DnoNzBatLXGaZOYSq+9vGzASIW29F24I9n
         BzJy2Y4+9ykzFEXPxvrIDqpbtjCrSf0VdhRi+Ckr+7cwx7WcS8OCxbdupwfsz8Knm9pe
         H4Gw==
X-Gm-Message-State: AOJu0YwJAYfhEGlsMQ2XgMZpifBj+ARoSOGRP6jli7ehnGSv9DSPT+ha
	Bqpz3mVrG9P91iBc8Jose7CEQc2EcgA=
X-Google-Smtp-Source: AGHT+IHaQ6RoDzMYp9Kon+lSEMHu8cpPWbO1gZ2WyNldsJutYXaf5wkNMzuuZO92oxOJZUuP6RyVCw==
X-Received: by 2002:a0c:e891:0:b0:680:3f5e:f52f with SMTP id b17-20020a0ce891000000b006803f5ef52fmr13275174qvo.90.1704256492467;
        Tue, 02 Jan 2024 20:34:52 -0800 (PST)
Received: from [172.17.0.2] ([172.183.51.116])
        by smtp.gmail.com with ESMTPSA id o8-20020a0cecc8000000b0067f37d9196esm10662312qvq.93.2024.01.02.20.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 20:34:52 -0800 (PST)
Message-ID: <6594e3ec.0c0a0220.ef174.019f@mx.google.com>
Date: Tue, 02 Jan 2024 20:34:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6552092932103047207=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 20373622@buaa.edu.cn
Subject: RE: [V2] Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security
In-Reply-To: <20240103040611.3279681-1-20373622@buaa.edu.cn>
References: <20240103040611.3279681-1-20373622@buaa.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6552092932103047207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=813996

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      28.36 seconds
CheckAllWarning               PASS      30.79 seconds
CheckSparse                   PASS      36.29 seconds
CheckSmatch                   PASS      99.59 seconds
BuildKernel32                 PASS      27.30 seconds
TestRunnerSetup               PASS      435.31 seconds
TestRunner_l2cap-tester       PASS      22.95 seconds
TestRunner_iso-tester         PASS      47.20 seconds
TestRunner_bnep-tester        PASS      6.82 seconds
TestRunner_mgmt-tester        FAIL      167.67 seconds
TestRunner_rfcomm-tester      PASS      10.89 seconds
TestRunner_sco-tester         PASS      14.55 seconds
TestRunner_ioctl-tester       PASS      12.12 seconds
TestRunner_mesh-tester        PASS      9.14 seconds
TestRunner_smp-tester         PASS      9.79 seconds
TestRunner_userchan-tester    PASS      7.19 seconds
IncrementalBuild              PASS      26.29 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 495 (99.6%), Failed: 1, Not Run: 1

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.295 seconds


---
Regards,
Linux Bluetooth


--===============6552092932103047207==--
