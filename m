Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knqHOvWG"
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC7BBD
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 06:32:23 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cff3a03dfaso9150965ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 06:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701354743; x=1701959543; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2UmrXwnx2fJCMB6rg7wBe1+7vpCWYQXbX46v4Qdy/cs=;
        b=knqHOvWGFsIwcj+Lcc92Jx5QfGxMOa1vIXsWpYPsVcgA/ZTOEl/VLj2SxQjlmuXh9v
         Dldtfx1sWKl7JvwLyp5VFgzudetTSu0fMR9MZFRpYz8+9r3JtZWljbOXDCmhqt/nzPXf
         xDx5kyCCYznDuk62jMj/zPuQwzUzvr3Nf+s0JhvRCaOAPOwCFU/uTXAu/FSy7Se6qxre
         AC6zVD6eNxeWsJdKHaFM2Sbzj+u1B1sO6UYFNt6oc0HQ5kt20vRFhHh7x/rDW4F+6KmK
         0vZKLSsiLZO4E2GvXRBLFDIKKAPF9N5oCoEauloM4NtkxTtp7GUXV5ADtTB3e+jQkX+m
         +ZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701354743; x=1701959543;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UmrXwnx2fJCMB6rg7wBe1+7vpCWYQXbX46v4Qdy/cs=;
        b=J0yZEtFfjDm5Q8bo9TsgY/D0Nb40gSV10GWvlQy2nH1ptFie6YhtV63WV5jtHgz2pU
         K/9vQbFyF333n8CgOhx+ljW1eeDraOBH1PrKLPrIu2YTW5lgvd/3ZY2V/62z3+eoZTHz
         NLh5vVYjHizwbrXWTm4ff+NAieuHehK5IlRzRwywee/FTlQeyN3rJ9BIE351IfdO3Ygm
         UEy6QSm6LgFckAbC7TnU103oeAMaGP4sMlSm37cxOIU+5O7zzQZgTJgpYMzxLWQnN35+
         VHf3QiEcUSSLFguSrW7FKrszpu4dtJ3w6np1/wg0vCRw3NnzD6ZirF0epr1bqAgIPNZo
         Xf4w==
X-Gm-Message-State: AOJu0Yz7rwD7qQ4cIDsKmk1SKna/HvoNcTmV1GR6cQwI++/N+iemXA/z
	U1xwkf5d7cgC+RR8DIfNCiCWKzkWAGI=
X-Google-Smtp-Source: AGHT+IETLPAksEPOvum9Lx/PY8maFeOxvwPslnSFaJH1R5iwdgeamKp+cIRhfmal1W7AvIjDfrkoyQ==
X-Received: by 2002:a17:903:5c3:b0:1d0:492f:b96a with SMTP id kf3-20020a17090305c300b001d0492fb96amr207225plb.48.1701354743144;
        Thu, 30 Nov 2023 06:32:23 -0800 (PST)
Received: from [172.17.0.2] ([20.172.24.211])
        by smtp.gmail.com with ESMTPSA id a5-20020a1709027d8500b001cf89e69a70sm1433059plm.307.2023.11.30.06.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:32:22 -0800 (PST)
Message-ID: <65689cf6.170a0220.aa94a.3c6b@mx.google.com>
Date: Thu, 30 Nov 2023 06:32:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3226712027518673401=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [RESEND,v2] Bluetooth: Fix bogus check for re-auth no supported with non-ssp
In-Reply-To: <20231130135808.286908-1-hadess@hadess.net>
References: <20231130135808.286908-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3226712027518673401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=805623

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.59 seconds
CheckAllWarning               PASS      29.98 seconds
CheckSparse                   WARNING   35.35 seconds
CheckSmatch                   WARNING   98.09 seconds
BuildKernel32                 PASS      28.17 seconds
TestRunnerSetup               PASS      418.28 seconds
TestRunner_l2cap-tester       PASS      22.81 seconds
TestRunner_iso-tester         PASS      46.71 seconds
TestRunner_bnep-tester        PASS      6.94 seconds
TestRunner_mgmt-tester        FAIL      167.28 seconds
TestRunner_rfcomm-tester      PASS      11.32 seconds
TestRunner_sco-tester         PASS      14.67 seconds
TestRunner_ioctl-tester       PASS      12.43 seconds
TestRunner_mesh-tester        PASS      8.86 seconds
TestRunner_smp-tester         PASS      9.83 seconds
TestRunner_userchan-tester    PASS      7.40 seconds
IncrementalBuild              PASS      25.62 seconds

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
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.296 seconds


---
Regards,
Linux Bluetooth


--===============3226712027518673401==--
