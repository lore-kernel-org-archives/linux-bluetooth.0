Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA496F06B
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214230; cv=none; b=H/bEVXa5SGcVH8xoL1EeMw2GlBuvn8FgCEPsvsxPrR6UavuQyzJQUI9hxw3fVY/d/TEX/K69QvNzT5tySOhCJ7s0IxL95OOl+cLbmzfIV9hVRLhtadJ/W9wCqvL2Qu2PaJlYECgyjjzMxmtauMNODq+Iw8cCnNRDPSaJy6iKJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214230; c=relaxed/simple;
	bh=xVLd2M4+vg6TKKTXM3mw9stH0fM7Mw/GGlxAywCWYfE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YY3YWY3ga59OYEnIq/Acd0L7fnKu5c9R6WgXJgyre4tK9Nz0AdfZo3P8U2dL9D1oEPsoOFYHe5qyN1aXZRSWZOrj8I9+zi5/UQZ7u5jJ9FzCNWyplfSP3UYxYg3q+YF5+Cy9jyzqVeDo8qe2NUHuQ1+Y7LtsCkD3jundshPldKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6t12MAc; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6t12MAc"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460d2571033so8414301cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 10:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732214228; x=1732819028; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t3MPqIRNyHkF/Azwe2MX8gBSgHi1RNkUxozZ9JVwbkg=;
        b=J6t12MAcamIxJhKmWSndUzWu4yNacSp/xYQKKFYLejlVg741gQcWucJO7gkMx+y8Ar
         5AjCZE/SMNeRu0voAeh+qA9VwZg0/yXZFhEhx5z3YmAAz/LxFc5JFPJSX0iEBa4nr8Kb
         VjlK2Rs2XRjSUHk53DZsHxctuxgQjAfsJ2dmwvbkwleYHBoicPGNhJPQuX/tzII8Bix0
         rs9+LorOoLecTUrIthtFqXiQQzYXL373zQs/q5xdZrNP3VPbqN8j8z6ri2oZ5xiGbQOF
         sZ5+LmYdUHjRDAfxjg5yyWarMtZBvTugLHMGMZ8TFm+KeEtiUdJf/nv6C72NXd5xaesV
         9ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732214228; x=1732819028;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3MPqIRNyHkF/Azwe2MX8gBSgHi1RNkUxozZ9JVwbkg=;
        b=KDlEovYu6aeW56R/b8VfWEFWwfEvF72HTyWf8forP4MV3WYcd7fwoDUAhKV0R8n7HV
         Vm0ntjSSex8hRmc0qFUGE8Kd5fPoEQneJam/w1eMzXG2EktRrJcbr2XKr3WQcPYPZQSX
         ixFOhncTfopkBax+S339dkR2HqxGBbXrOhfwkmmhoihDHrT9G8aEW5cgZNhVFt3GAWKR
         IlfaeIiRLPevED5tzpakrWgIhG1DYmAyfzB+efm5bu7famI1axg2oIi7+C+savnydBP0
         GtmA5ERFdOjNozXRPWQMsvb61s7s3V0UnAPTGPeK0K6xwZLoxFPYb1zZ4uUkIepighnA
         oQNw==
X-Gm-Message-State: AOJu0YyOGqAwTdcS/tXQg+ucskqgnwybwBEC2RJCNvci45DV8TtWQz1p
	+KvHwi1FNixNpzyQzrFEKT22oZkzv1t3fdioby4ft5hT5NIYV9n0l9JyBg==
X-Gm-Gg: ASbGnctX8TbLpiBN/TJmgqmknCfK+sjn9FFZ2kVcNl8GcX4i9JvvhbRcBX5eEkexN5L
	VSsgAgFz8lyXnkRnWxgbp9gN0xV2xcFVsgDd04RUeTDBdNfYwMmxuF0FTn2PU8KKuLOdWYuKPpE
	tSsoQ/unDMZIVQcOpIzdDmHl4FiIb3xmfaDyZKwpkP5AMN1k17HZLDO04CneitqwF2DnCNtCyoq
	V2Tmd8RJ/u4cSRBXTbMIrSExIrHbUA7/DNagx3jIYg5lp6vTOfKXzCrxAQ=
X-Google-Smtp-Source: AGHT+IFzFKNM1IjN3FHztwLQDSd8SG65hXAKJEG9L5jmZ39E2eAayRuzHAUrGre5Zz+J80dg4iomcg==
X-Received: by 2002:a05:622a:5919:b0:460:7c45:2218 with SMTP id d75a77b69052e-4653d580966mr319071cf.15.1732214227589;
        Thu, 21 Nov 2024 10:37:07 -0800 (PST)
Received: from [172.17.0.2] ([172.200.207.224])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c3f31d2sm1798351cf.36.2024.11.21.10.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:37:07 -0800 (PST)
Message-ID: <673f7dd3.c80a0220.3cb591.0d87@mx.google.com>
Date: Thu, 21 Nov 2024 10:37:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4887710268098880620=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, greyxor@protonmail.com
Subject: RE: Bluetooth: btusb: Add one more ID 0x0489:0xe10a for Qualcomm WCN785x
In-Reply-To: <20241121175851.137414-1-greyxor@protonmail.com>
References: <20241121175851.137414-1-greyxor@protonmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4887710268098880620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=911571

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.80 seconds
CheckAllWarning               PASS      30.40 seconds
CheckSparse                   PASS      30.40 seconds
BuildKernel32                 PASS      24.38 seconds
TestRunnerSetup               PASS      433.83 seconds
TestRunner_l2cap-tester       PASS      20.39 seconds
TestRunner_iso-tester         FAIL      30.20 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        PASS      121.41 seconds
TestRunner_rfcomm-tester      PASS      7.64 seconds
TestRunner_sco-tester         PASS      15.38 seconds
TestRunner_ioctl-tester       PASS      8.01 seconds
TestRunner_mesh-tester        PASS      6.87 seconds
TestRunner_smp-tester         PASS      7.04 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PENDING   0.60 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 119 (96.0%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.238 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4887710268098880620==--
