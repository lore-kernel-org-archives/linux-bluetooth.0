Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE81380FFD
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481219; cv=none; b=KG8PPFZKxV37CHW8f0V12GnpnDqJ6FaxNr2dw4EvRcDWSjhCX+JIQBZaS0RzdwIkPJga3D9xN3/gc7076Nyd68CoXd6BdOHozmPvZqE6E4aTr44+uM/rfXo3ZTlurR1rNxBOOL8AG/x83ruOCG4lO7hgTXPMN2YSZxLJ0hAMQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481219; c=relaxed/simple;
	bh=U+9kZGDfRUWP+WRQvnn6KKQUFZh5nUhlt2zvTkhRdEQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BXGXN3NDe/fYiiXJ+dk2oeEBmn2QJh/N5cUGwvORG34SMBicIG/Y3f6oJZWWXl2OEHHyL45GAeXwOat9xpVc9KRm+UwK96ktuwa3Zu7COBnN3KoYPmUi+rpPYHgp3zusnuFMg/3AjGc0qXXzvAG5eMnrgJyz91WZ3mzOQIKVWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/Gxh2tp; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/Gxh2tp"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30c6874d295so629507eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481217; x=1783086017; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=APA6pceS9eSiRU2+JR0B49VQGJ85aWHVopN5+67rMg4=;
        b=a/Gxh2tpQHeOKGqnKdiD7TwIcPSriKo9HuSjNijzoTvL5L/4LKZy4Wsp7AulAfpkKo
         pmaBkFSvNwgZ7CTKdwxIE60EuEbxIYuuebVL4sAJHCXg3onjsvDcrcqA4PyiUjKQ2G7Z
         Pn2n5/dTFJZSSR3wzQtGK5icOHO/iQsl/EcLqOfQ0orzUa/lmIoE3XREZCNttGEyi4mg
         yfykuaOWZAtsTrg5+ZGLMkm2F+CUQR8tnvQKjpP6KV1MQ2cr3fO7aMJVcCChFXHyeF59
         kNBHUmcmuWPxrlhySHbfjsYZraZ4bGkN3/0DS/VqYg3QtYkkXvWG0BWtsfMW2GPf041z
         YYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481217; x=1783086017;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APA6pceS9eSiRU2+JR0B49VQGJ85aWHVopN5+67rMg4=;
        b=jpirydNqfOYTQo4OSKR6FlkZH0/olyLlJXqOtZNbs8jx6dUbPCc6ehxQNUaumtS1hL
         mSjnrFash80SOtFPPJ5V3IXVIRSjxiRa2+LbdytdSIPlnSsgpBsHDnGoAzYDMqoc3lb4
         5tZr6YiPlHoE2crUpTs+CEC7D8sDf/qEj6+AiN9eBnIxumrTOI4q6tmBWunOS6RnXR2V
         kuFa8bK6eShKDekUt6Yz1Ix+cYam06ssEY75iSUJdp+Q3iwnQg2QmJfswdippuVLhXay
         jRJiLrQntcKUhQ2tuu+ZWMMqzpYsw0ichwKHH/o5AP+5wKxeja0cV2AFSHNDmAkKymiY
         XPTA==
X-Gm-Message-State: AOJu0YzwcBHUY/Droo8gAlJKNn8Te8YSxGGMF9FqelIg/LGgN8iK6La/
	4Yr30eWl7IgmFDNl/n6nb28+7PXuE0gWJKT9hYF7aERbmgb4OhY68sIG2jmt1A==
X-Gm-Gg: AfdE7clvwli4Cfqs8PsZNbGzQg2/ygAEZNnD8TbdO4LLSwH8OCQ0nYZIPNE0bLg5/Xv
	eiiYvJT/uGw1PnG2W1w/sE41plMUBvivbvX0eGuiOc89ZlRLP9V5FmbZgj7KKWd4LSO+bKEOszh
	NO9GKrCsWIPfX3Al/9dd6tJkX2kPNRXnXGPLoLWExjhudS0aWIvtODMFeoUbP/Etg/dN0O2f1UM
	vuo3XxOTN4q+fZj6CGvO4X85EX0p/KmD99YBBdECNkZWQY/K98jLc15l1TZmVfO6tLJZBRXjPQI
	/6Xesnf1qu41/ENlZML+acqV2JTCBL51eu7rx1J/IatVhqpfI0lkjRFLg/RHgMaWTDYXX4COH2E
	+efATlV9xI9O/Tr1ymoJmojLgcsIjz6jznMWC0Dl65EB6W22Ra09Csj3hNppeJzTd9CdmALx8/X
	frRgJ60CsSWau9eLd7Vst3KQ2N2Oc=
X-Received: by 2002:a05:7300:23d2:b0:30c:a9c1:4a6b with SMTP id 5a478bee46e88-30ca9c14bb3mr324547eec.11.1782481217166;
        Fri, 26 Jun 2026 06:40:17 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.61.6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52c591sm24767841eec.7.2026.06.26.06.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:40:16 -0700 (PDT)
Message-ID: <6a3e8140.e9d484b9.1b3bdc.c1fb@mx.google.com>
Date: Fri, 26 Jun 2026 06:40:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8088885384488237531=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vulab@iscas.ac.cn
Subject: RE: fix: net/bluetooth: iso_conn_del: extra iso_conn_put on iso_sock_hold failure path
In-Reply-To: <20260626115312.33528-1-vulab@iscas.ac.cn>
References: <20260626115312.33528-1-vulab@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8088885384488237531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1117045

---Test result---

Test Summary:
CheckPatch                    PASS      1.25 seconds
VerifyFixes                   PASS      0.37 seconds
VerifySignedoff               PASS      0.26 seconds
GitLint                       FAIL      0.59 seconds
SubjectPrefix                 FAIL      0.13 seconds
BuildKernel                   PASS      27.90 seconds
CheckAllWarning               PASS      30.35 seconds
CheckSparse                   PASS      29.40 seconds
BuildKernel32                 PASS      26.94 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      502.60 seconds
TestRunner_iso-tester         PASS      82.03 seconds
IncrementalBuild              PASS      25.51 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
fix: net/bluetooth: iso_conn_del: extra iso_conn_put on iso_sock_hold failure path

1: T1 Title exceeds max length (82>80): "fix: net/bluetooth: iso_conn_del: extra iso_conn_put on iso_sock_hold failure path"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/357

---
Regards,
Linux Bluetooth


--===============8088885384488237531==--
