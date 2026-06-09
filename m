Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A428367B83
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997451; cv=none; b=Fn/WtctGGuhGsViPbN1pKkGVsaAqWKdzqwoDc2+o77RJTOvC92etjBs8tEnlbV613hKAVvCaHddPpXKb2x67fUGIpCxJW5l8BSwfHcip4bojKKeLPxTXaoO4LmcNfTRA1J4LQm/43/GawVBLSgttEnr7puNve6+PSI0v8+KW4lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997451; c=relaxed/simple;
	bh=QGj5KaDb8t5dQBxezjRkXEsqjrZGv4pqrumUk29zgqk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aPt9ZcvGVe/AdQcBC8pKcd06BOkV6vx7jXsFdUYVJOgPEHYRDDkVRWlKanAJ+ua6ANf/Y3yEGR+bhqr94OE1cuttW4XIX4UgTKDdQf5ChH01+1tftM5+5LkjszNilcbcV8td3UvZd+M0vjsddhEjWw3AFJ40gj7SutHzcZQPUrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWyPswrv; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWyPswrv"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9158c621ebbso636149285a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780997449; x=1781602249; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FDXHuFV4ybCXX9kmL5LLBuCmWFzkTQOtiEqmBcLo35g=;
        b=LWyPswrvocH5cYwVlN9uAPeVsl+DE+sOTaJrNw9VwoXml/O9hBTjafL5LCprPU4Irg
         hBYK6DZ2eKlaTJuaWOZ2Jcr/zTktYRuZ5BOOKTnaIWeBro4YKJLulVoR8/X38ge1KelP
         fCxec/as8YU0ZNQCZnrRILwuBkVZ3n/ayvh79Gvp1zh2XJ7AXWtp3ov6qCeMgslibQNx
         CT4vWLAjU65/ij/AzDMjQDJEjfWvmIF5NnR97EEBcCVEgwX9WzuMfubwg2lLEDDE7+52
         1gHYx3V4Q7hDeUJqnAt+WL3DAvPHHsg5WsXHML0p+qqu3Cd41BjhBAnJCa4TZNkJ4m9F
         q4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780997449; x=1781602249;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDXHuFV4ybCXX9kmL5LLBuCmWFzkTQOtiEqmBcLo35g=;
        b=SlHjuj4tpTshGt+Dtf/67FgRo3XfckyOPgwEO+MBgzs/8iFB8ouOBarJwN0PWE4bJj
         aYnhp0fRdXwY24uzOgEKUHAHxAQ9gDOjJoFFWIBeQp2GlFbJ6dzO+WhxuhwzH1wQQSNz
         qko0rJclk9Dl74Yg9ZUQNoGLlwrt9ZPqt66IOb3Agb/q/VdxoQfAqB2SgBM3mmxUnEwQ
         QJONnSFyEgGnykIeKjNen5HrE7LvmVERonEAsXZK0BfRYXKEoqIJFlKs+pxEPKPXGaR7
         kQ7xQcnoQIKDj/g/0TpJ/8miqhi+UHyND7zTuG2V2DXRrs12b7N9OZvcuLRbw1szYHPP
         yhlw==
X-Gm-Message-State: AOJu0YzSFCW7lYCXl+bAVncege6MHk9a3YpQoVLsMM2fyh4j2QnRQ4Ap
	3C3+jfvAaBx78pRAreakKl0PYrR2p8K1is4t7TsizZ5Fi2/4pWYn3g7WKouhSQ==
X-Gm-Gg: Acq92OG7TP7QLEx9mRAu54iEEyRVOzZlfjdx8VNTZGjNF2KcFTQ5fROCJhSnFE5LdtX
	l1iQkuCf7ojcTjOiqGNcZpaqmWJUxC6hLmCaenhY33Z1EwjDgJORvyRZ7ex2AZToEFZB7ItRvCU
	mkpUdbLKpLHOPVOCRma7xq1U3IRGe/nNuM6XiH4Yfsc2yb/FoE4+uSHvWInWD5jwJHntV8yv2Xd
	Rp4espcXChSnIsc/pMv38Vpz9LgvOQxWy1CLeSx9MZcFV/nA3EMGSxYiOJ5j5gM1EjnWTxWVonD
	MR2ZIDMTxc6GECQ+nRWWaOobxC0C7Hm9OrOZaMznFRfPu0YAYtjxvIAhAVEu+NM69gcV75sFJHP
	cNMpmBEeUYGhPaWWpa/ex7KkI60hSmce09LCCB5NfOgD+VwYtPSGQ3xadghocRmOyeBSyMZa7D0
	JNCfbS18byQ2OcKMUBTRQOmINtixRvYvI/EZ+ZNtsr
X-Received: by 2002:a05:620a:269e:b0:915:ab83:6963 with SMTP id af79cd13be357-915ab8396c4mr2928714685a.15.1780997448975;
        Tue, 09 Jun 2026 02:30:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.198.199])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a237330sm2132326985a.16.2026.06.09.02.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:30:47 -0700 (PDT)
Message-ID: <6a27dd47.77e39773.24a495.6164@mx.google.com>
Date: Tue, 09 Jun 2026 02:30:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2990051391661115959=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhaoyz24@mails.tsinghua.edu.cn
Subject: RE: 6lowpan: fix NHC entry use-after-free on error path
In-Reply-To: <20260609080054.4541-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20260609080054.4541-1-zhaoyz24@mails.tsinghua.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2990051391661115959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108371

---Test result---

Test Summary:
CheckPatch                    FAIL      0.75 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 FAIL      0.13 seconds
BuildKernel                   PASS      28.31 seconds
CheckAllWarning               PASS      31.95 seconds
CheckSparse                   PASS      29.63 seconds
BuildKernel32                 PASS      27.13 seconds
TestRunnerSetup               PASS      596.34 seconds
TestRunner_l2cap-tester       PASS      65.08 seconds
TestRunner_iso-tester         PASS      86.94 seconds
TestRunner_bnep-tester        PASS      20.27 seconds
TestRunner_mgmt-tester        FAIL      224.52 seconds
TestRunner_rfcomm-tester      PASS      26.68 seconds
TestRunner_sco-tester         PASS      34.10 seconds
TestRunner_ioctl-tester       PASS      27.51 seconds
TestRunner_mesh-tester        FAIL      26.96 seconds
TestRunner_smp-tester         PASS      24.40 seconds
TestRunner_userchan-tester    PASS      21.02 seconds
TestRunner_6lowpan-tester     PASS      23.79 seconds
IncrementalBuild              PASS      26.60 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
6lowpan: fix NHC entry use-after-free on error path
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#120: 
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#121: 
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#122: 
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#123: 
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#124: 
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#125: 
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1

total: 0 errors, 6 warnings, 0 checks, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14618776.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.265 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.252 seconds
Mesh - Send cancel - 2                               Timed out    1.985 seconds


https://github.com/bluez/bluetooth-next/pull/298

---
Regards,
Linux Bluetooth


--===============2990051391661115959==--
