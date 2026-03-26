Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9F01922F5
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514029; cv=none; b=fBATSlRrbfyZKx8fnOVc2GI76tjI52es+Xw00Gz0VBZEkhAtblBNu8E9QZqX+VqnG85kOMSgq46nq8wdqwMOCMlL/bakyp7U59QXvsMFkS6Pq3tvlN3sFQGonylJC1ajGv4uZ5jbEHcUZVOPpVUilaJZbcVRmOJUbHjVSVuCVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514029; c=relaxed/simple;
	bh=MZA1QwBJ8Fa0PT/KxB+a9qz4ZWmpjfsJtmbpM+hzqwQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OlgdYeKlvxPClvSo7v0J66oCUELzhPZXYRD5STVSpBhqSIkiIldyS9yM1E5EEGIq0uNxt6lCDgWb3wY6JVzxtWf9y/HxwJsXTG93MTlR6OdNG/L+ASNYEgPA4dUFamrVmiretGThBL4Ejw/LbkmFVUE2TIkYkMSvSeSoUMk0q/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9/rBdIU; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9/rBdIU"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-67bac077116so362611eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 01:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774514027; x=1775118827; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2AAAKF3Nd62ha1u5JFEzETGj/krRZwZLny7fOVAhVFA=;
        b=E9/rBdIUvQqaa8RETbB/x0d0L80BI4UwD6VW590eZdo7qTpxHDtCVSkUozbLO1LjuA
         Xik5uky5WGcbwxFaT7vSRMqhwPNc6uUbOqCvgqD8VoUKL9aeKqGiSlMO8+GsGBCD3OHP
         qxMi+DO0zfKG1zQfhxlL9BcNl96fTCBu8EWILnQHWPcQFghACzoKi3EDrJD8xmkehndJ
         SVQ5VYHrN2Yz5A8ULRfOobygPQuNy4nR1yC5fpl/TGotyJDvmJqjGDlG9tFZo3PDVDaO
         uXcCDScE+zQ27T4bLMJzBATOox4+G8G/2oTM/3Xu2wQIZhDZHavrSCjLdJ5L4KDynLju
         LNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774514027; x=1775118827;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AAAKF3Nd62ha1u5JFEzETGj/krRZwZLny7fOVAhVFA=;
        b=YXi7U0LwL6NJt042x/DWiqdSqOYGl/tav+obkDaeCX+4o3LsrbjhrpyAD8ImyRuE0k
         TJ+nFpIBgrp3QSOImdy9YczGb8F81urm7Df52gxFc9cB+HJJaXPB8n/iMl948plrKZsN
         EwS74zH8967qdf0nnHunDUE2EkoIfat/3R7r+jhGCvfIVlqS3gjlkAt/uLeNgTPLWQqo
         jt+lqReFU1521trJvg2TEBXpGB/PQyQ0kRNDj09cpsRN3hGh9iQp7FMiLQHbYq4WMoOh
         C8iWmPoP6o4G4LeA9f4kMpzyKN7stk7GskUpwlWpU6eMWfzB3R0kD8Epg5cznU3SWMZr
         VVwg==
X-Gm-Message-State: AOJu0YyF1pC+ntoS5uVz26d8HtBUjcg9PJVWvML7Pv+EEeLEGlXdaKHj
	A5nKVwvMDqdOzb2CsuNpErU6g2bqFYYcXMb/5OojFsju25VbgoQPEGblH4oQR/Vb
X-Gm-Gg: ATEYQzxACfhpx94QKIG03/hWCoYUfCqwWazYgPXzobQcQtbqu+lByF+AjqavZ2D+84j
	UuQ22PDseZlgu2BuXETV0l1FDuDTnvJyImhflWA+Fw7CAjyK9H64rmVf7N60jcQRzh7YINeoOZR
	QwOkKSKco8LT6DzW38TIHiJp6mMxhS0JbKZLRIY7npEc0wFBU6KJS/6keTPSMqtATordT72tXe4
	2blV4SugjqUncwer5FnJOeNVBrZkVzLKX6ZJG3+h3MSp8mRIm/Bu1SvprrGZyMAB2Qtcj+DFOrn
	N6MHxHME4NHpkE4OV6HY9fh1BdpMkFORLdv3heeTNGFDbScIBll5n0H7Llm5Loxr0elFp/q1LGO
	yZHE/7KbImlwPlLL8kKf6uczNCGPH3EfWPG6d7FHLXIjGZ669+OJ2qLch7d0Eial0R1NGYnz8jc
	qcsBZcz7KL+YHjQA5dn0pcbz4E4M9d
X-Received: by 2002:a05:6820:210b:b0:67d:e619:b721 with SMTP id 006d021491bc7-67dff461c87mr3465754eaf.30.1774514027305;
        Thu, 26 Mar 2026 01:33:47 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.19.203])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41cc7ad6b94sm1822972fac.9.2026.03.26.01.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 01:33:46 -0700 (PDT)
Message-ID: <69c4ef6a.050a0220.f9501.9e12@mx.google.com>
Date: Thu, 26 Mar 2026 01:33:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8544060064809247547=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, manivannan.sadhasivam@oss.qualcomm.com
Subject: RE: Add support for handling PCIe M.2 Key E connectors in devicetree
In-Reply-To: <20260326-pci-m2-e-v7-1-43324a7866e6@oss.qualcomm.com>
References: <20260326-pci-m2-e-v7-1-43324a7866e6@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8544060064809247547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1072784

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 FAIL      0.98 seconds
BuildKernel                   PASS      26.31 seconds
CheckAllWarning               PASS      28.89 seconds
CheckSparse                   PASS      28.28 seconds
BuildKernel32                 PASS      25.35 seconds
TestRunnerSetup               PASS      563.90 seconds
TestRunner_l2cap-tester       PASS      27.59 seconds
TestRunner_iso-tester         FAIL      46.27 seconds
TestRunner_bnep-tester        PASS      6.46 seconds
TestRunner_mgmt-tester        FAIL      113.62 seconds
TestRunner_rfcomm-tester      PASS      9.59 seconds
TestRunner_sco-tester         FAIL      14.48 seconds
TestRunner_ioctl-tester       PASS      10.31 seconds
TestRunner_mesh-tester        FAIL      11.69 seconds
TestRunner_smp-tester         PASS      8.68 seconds
TestRunner_userchan-tester    PASS      6.76 seconds
IncrementalBuild              PENDING   1.00 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.900 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8544060064809247547==--
