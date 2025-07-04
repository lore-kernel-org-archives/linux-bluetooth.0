Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603A2D239F
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jul 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751643295; cv=none; b=htbOz7j5pnBPNXe4fU6u1wQ9iHHT4D606C1tyBzpI76x+MPUD1PQLd8j6RSgV1Fmj/f+oPrDVwiUd2hDGocz6ma3rMKw8ZbQTkZJQYmX+gKkVgVEciMWL2BwK+0tX+ICrNq2OQPXyeItTIPtcX2JAC9f7eof1gm6a+4W8kxgyqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751643295; c=relaxed/simple;
	bh=dKLgQ0QAxq3YtzHaNf8h3lUPHi2vD8PRoU9CU7F06eY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TC8Rh7GWNUBCMd4gBWUntzQfGV/ZNjAvPzk24skSRWPz65BRuhol8CVWOCTXd9Cc/tADsbQEyQzhHbaeWZz/fEmTRk4mwF8uKSO71yZk2p/YeFQmwX1HJNY2jw1hb3MJzLgueLfzsJoA3iejq2W73N80rPP32Z5JeQlIR7L44Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hv1Mnet5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv1Mnet5"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a58c2430edso12890151cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jul 2025 08:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751643292; x=1752248092; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4K/YDXTm2hRoGmrGaJksRA/6SRc3AS8FwDqtz6nPShU=;
        b=hv1Mnet5xswtMpVcV2m2voeEzpNRJpePJyCLUSTU9hMjXTy60mz8b6VcXuQi6Rbn4o
         N5nGZ3U7Kot9Q+xaYm/SNCJmoZNXV7UDwMhYVieEOnuFEeZgB9gqComG6V5aC7bTAOzk
         chiWHrM8W9m4RJOVFQCcLqe+HInXP+aDxdTOisCPT948GvF0yfoLFbFVfQMd7I4rsNkH
         bGNcAnm1w1jwRD9ApEoXXfbdM+spYyY6wf2TxgbgnfcZJXrokfnyyTSn1qPbCyKUGaMG
         62Al34PKlG4G+Ho6Ulk8TnXvjvodsIFcdp+CdxpSnv/gIyjO8eiaF1g5Y3D1e2x/enQH
         1GhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751643292; x=1752248092;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4K/YDXTm2hRoGmrGaJksRA/6SRc3AS8FwDqtz6nPShU=;
        b=PgZarhzddIHBFsokkwcZjvIcdsDm9slAHyqWeTPd1P019jU2HUUML6sP9VzmQQXhat
         a7E6CVlT0lJnvdVyHmBkAA1OxkY1a5XmGRh0UramCuOjNJ6UEM6IfvOXfUWYlq9xy2+k
         sARzvGma7btBGIo2gWP1pHcYEFNsoruJ5xpHoJqOaulmv9lddcq6uMbLfJQX3Yg+pXSM
         IwFdDMfpfbfWBVjM6lS/IlY1lRpQUEAixxdZ/fCEmZ/wcoIbrkh/dSBTG3hNJYhxu1Cr
         PJpIupogFg+t1U+Iw+sbXzeZzJJyAKFag4zxNgnFBJXXvQ3KWWoXxKBt+Je4InTdVjlE
         qBqA==
X-Gm-Message-State: AOJu0YyZdjrm4sxT+1E+sTrJMkfmQiVLPawNBC01xcbv5VUnkAAo7iFk
	OxtkreXWgmVng1qt7fx+0BBAL4ItCKgJrjbuiF91tpwbz/bb52LyAwQOSD0GcQ==
X-Gm-Gg: ASbGncvrSq5dJRXsPRveuULVfdEq/MW+p/34IOKuDhuXPK9cACpohTs7r3/bC97JCGW
	5AEGiqUL+esYnHyhuCtBAvkgLkQNBWzTzSxySaR46qzes/TcB/tjnGUwQc5GW7oe3v3fpqwOsWR
	ebhKb1afLjJcw+FTsSu9ZqZ+dR2qslLM2tDL23N4ZWJb0ITlKF4w4KuvFNqmuRfcVB0UcUbxQNi
	Eiv3DH3rhTp8KunR+XiE9cTGNun84J7GeB6CYhMmsY/P7cC4N3ZBXwQHdOHFtwrVTSpGf8MaAWq
	+7nEilZmeh2zPtijKqKmA4iD51LMA7aOFsgGaK1KVXMKTd3YQl2UZlz3zpY6pFJnIgc=
X-Google-Smtp-Source: AGHT+IHbn3Z0KCtDTE0uGhSNZOnVQbLmHvxtZWY1HYbch2gHYe6q+r8599GRobmaycyEahM6Vdoc0w==
X-Received: by 2002:a05:622a:418f:b0:4a9:8299:4e00 with SMTP id d75a77b69052e-4a994cf0d4bmr57079181cf.0.1751643292271;
        Fri, 04 Jul 2025 08:34:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.177.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a7a6c6sm16091711cf.43.2025.07.04.08.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 08:34:51 -0700 (PDT)
Message-ID: <6867f49b.c80a0220.7b098.5402@mx.google.com>
Date: Fri, 04 Jul 2025 08:34:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7686227248603285337=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: MAINTAINERS: add a sub-entry for the Qualcomm bluetooth driver
In-Reply-To: <20250704144724.63449-1-brgl@bgdev.pl>
References: <20250704144724.63449-1-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7686227248603285337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979169

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 FAIL      0.32 seconds
BuildKernel                   PASS      24.24 seconds
CheckAllWarning               PASS      26.52 seconds
CheckSparse                   PASS      29.75 seconds
BuildKernel32                 PASS      24.05 seconds
TestRunnerSetup               PASS      469.68 seconds
TestRunner_l2cap-tester       PASS      25.03 seconds
TestRunner_iso-tester         PASS      35.93 seconds
TestRunner_bnep-tester        PASS      8.37 seconds
TestRunner_mgmt-tester        FAIL      132.95 seconds
TestRunner_rfcomm-tester      PASS      9.25 seconds
TestRunner_sco-tester         PASS      14.66 seconds
TestRunner_ioctl-tester       PASS      10.05 seconds
TestRunner_mesh-tester        FAIL      11.39 seconds
TestRunner_smp-tester         PASS      8.63 seconds
TestRunner_userchan-tester    PASS      6.19 seconds
IncrementalBuild              PENDING   0.92 seconds

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
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.198 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.142 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7686227248603285337==--
