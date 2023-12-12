Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haq15D8E"
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151169C
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 19:04:29 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-425c3e14380so14737621cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 19:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702350268; x=1702955068; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EKQGkXHf+ndQDxWI812ZJg2K217vpS7Ef0rYvmyRtDE=;
        b=haq15D8EnKImAMd5pIwxLCaKSda2306/CL7bmrOKbAtaZ77T/yPVKKnjvidfCWRkRo
         pAZcUzueH86t34Q2GeZVAWTJpUj8RnQSlHTv6a3E3IKE1Zy5nf8rJm7HABnlH3vE6SJN
         vpoMSaCLd2AJiUyKuTw6TA9nIe06nNG4SfV30X1wfMeAz6F222D5fst4MpwdGl9eu3zV
         jW4zx3yHsewTJuBKIbXzjioSyQDjm85yLyottaQPYZ26OSiCxNGd4lMwzm4KiEtANtiO
         X/8GlshSIOlJDaeoLOgFkoBu3Wgv/TiSbtmKIUGcPURR3S17nrhcB5qXMH2+9Asnv4E8
         vWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702350268; x=1702955068;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKQGkXHf+ndQDxWI812ZJg2K217vpS7Ef0rYvmyRtDE=;
        b=RjJN9y7Xg9Bfz+tTa2XTLfHSPx6Z8Za2qzhxBvl1o7SA5qh49KndqqjGzJUhi6sxQw
         0kiLRv6KGXrh7rxRWGU0ATd83uoQELQhfHFHIXq0aEzl7XOrN6XoUMKHKALxds8x0RHc
         fuqHFN2CVADGfPhvy9MIGfEIbigy+R7/CSAj2BsLxR3tTs7AHP8eS1I+de4JTLL6UAA/
         9UV+fQFSKk1VLFiGuSPpVpiZaRBJ8tvui2f+OZ4CS/vL6Ab3sSU2CN38exjomG5LJR3g
         CPhJ8CPHPOGLyxhO+PbOxYKQkrIyjd81zp+UPxBcwo64LE+ISTvvzEaIxWpqBxy5YIwn
         CzUg==
X-Gm-Message-State: AOJu0YxfaiIsDBLXpLD/+S4Aq4+uxjcLNhL/Ym9EnYxyySCr5MzfmL9U
	RK5fbD1GlDUjH6wyRZGiBBvwMLwfhLc=
X-Google-Smtp-Source: AGHT+IFqzt4iSSdb7Ddgk8FaUcxtMInIGacRW9TVL4DpDG2ib4BK6ppInx5tn/H2Y0IMaVKiZO55jg==
X-Received: by 2002:a05:622a:251:b0:425:a549:c867 with SMTP id c17-20020a05622a025100b00425a549c867mr7449267qtx.35.1702350267996;
        Mon, 11 Dec 2023 19:04:27 -0800 (PST)
Received: from [172.17.0.2] ([20.55.15.34])
        by smtp.gmail.com with ESMTPSA id p18-20020ac84612000000b00423e77c96adsm3703543qtn.94.2023.12.11.19.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 19:04:27 -0800 (PST)
Message-ID: <6577cdbb.c80a0220.50903.064a@mx.google.com>
Date: Mon, 11 Dec 2023 19:04:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1658371752919162499=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, alex_lu@realsil.com.cn
Subject: RE: [v3] Bluetooth: Add more enc key size check
In-Reply-To: <ZXfFyoEhCj_S70qp@alexlu>
References: <ZXfFyoEhCj_S70qp@alexlu>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1658371752919162499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=809021

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.61 seconds
CheckAllWarning               PASS      30.37 seconds
CheckSparse                   WARNING   36.53 seconds
CheckSmatch                   WARNING   98.92 seconds
BuildKernel32                 PASS      27.25 seconds
TestRunnerSetup               PASS      421.86 seconds
TestRunner_l2cap-tester       PASS      22.96 seconds
TestRunner_iso-tester         PASS      46.60 seconds
TestRunner_bnep-tester        PASS      7.02 seconds
TestRunner_mgmt-tester        FAIL      167.54 seconds
TestRunner_rfcomm-tester      PASS      11.14 seconds
TestRunner_sco-tester         PASS      14.67 seconds
TestRunner_ioctl-tester       PASS      12.00 seconds
TestRunner_mesh-tester        PASS      8.92 seconds
TestRunner_smp-tester         PASS      9.93 seconds
TestRunner_userchan-tester    PASS      7.33 seconds
IncrementalBuild              PASS      26.08 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 496 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Pairing Acceptor - SMP over BR/EDR 1                 Timed out    1.996 seconds


---
Regards,
Linux Bluetooth


--===============1658371752919162499==--
