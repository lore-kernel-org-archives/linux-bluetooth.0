Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B6B3D9050
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919920; cv=none; b=S/XNkzzcLj7OhpD+T25OYa32wazk9Vg3sKmegL/a+dcyC9DoSo3LSuQlQeQUD6+KgWLOPLhy+gp1xnob8rc2LU/KsAkns6lV6W1YvSaxVTyiqVt0T6vAPS3vYRh+BYXz9DF5jmUWWB2fX3nlDPXECzw0DePe+7owA4NiiLW2wTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919920; c=relaxed/simple;
	bh=H2nZDfP1I7iCNihk+5q9h+KiL+u8JI0CC4yVF+n/S80=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZDoAwR2Xr3Ha6WLxa2Mf288uiomkzyMBADqUKNpX3pdLAkD0OsY5qwPh3zYp7gjR1rXd7k9G/FLnszr5BYILCVjDlX7+ONDsSe9JMOlAAUs2birXw0g4UOEHFtANmmlNy5EMn8F76kfrvI/Mjve9T2daBzqfLm3eUN22AeEqsT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V67BZGYG; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V67BZGYG"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e50a650a0so73857085a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 05:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787919906; x=1788524706; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NbrWvjk9xMPd3sJwqtOVPDkZxnfi2QsWWsVqKyWHUxU=;
        b=V67BZGYGT3BrQkDpKOT3SsJIWpFdAdohKJu2d1Diz2MxyTtc+w9kTp0IQQBw33lBwu
         HnmLgcQogwcHBJo657PjaHGJcNKVD3XIGmKbegIpvbADULtST/mXHXkeOUYtEtbb7Iq6
         thqEohuLu6LjWNQM8lweq7F4nn3YtYCsXY2y3Oxtgphe0TsNHQk9okMv/uGKz1fJpkS2
         f9Kuea8RB/g74uLmlxlfjlIwa1OgR1nUnoP1DE6vn1hqUd0WxC8DeerlWuReGfQngnfk
         /O21ahdPoe+IrcosWA3wQppHlkBtVTlk17lo1r2Q44TLR7VR5p3bnaH9bmez7mS6T9cV
         jLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787919906; x=1788524706;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NbrWvjk9xMPd3sJwqtOVPDkZxnfi2QsWWsVqKyWHUxU=;
        b=QtAIAAtcMemyRbgJ9g4dtpNbp0+wHYkJdXU8SvI0aEKklSlOPalqQjE+dvWr9tl1nZ
         cbHw9+drJ4S/8AMNWf8Zo7o7jEQOyrYDHhOnclZC37pdDYESPHK9zYjF+k+9uk9/MGmh
         89aE9pASn+4tok/4lX96HeY/rbZxcA8Uo0Fy9UqZzHm5TLcbTYQPbG24ynJOjwFfm8fx
         dvmNd8tsllH4D6NBMvT9/ZFY5uAbkL6zV4WCgN6z50JHq/1DpSRVozQEp24ZcnP1zUmE
         /SOHu90tclHl0fHFG3unllMRCtr+is5O/vFGh2BpRcBPHyRKzco2nW1QAqZr5I+hJd8M
         0tTA==
X-Gm-Message-State: AFuF++nNfKz5+ykmnZMreEMldtzsLVY+T5QfIzLElPkn0uN6rraqamMK
	YKmlV5iH3jCl6gMFLyxeJvz1CFGoVNgjzIk/GyciylcMSmzqxwtIcrEev8FtdA==
X-Gm-Gg: AR+sD10tcJLeaX3qcMUPq+rTTiIrR2vJ60eW8dEqOTdwzGCw2tpoiToZkWHxaPGXyN0
	9Uy9sW3KCTp3tuBUvPi+Q9UACdlKKw+B+LqZNkrc8rKGpPISRASK7frIA0h3C+y0LjtHJWc/onB
	ZnIbd4OJLnr79uDnHanp6cqmvr2VTNXSMXUlJStfHwSjVUTg31DHimAd5VPozH3PDzkjbgTXZEO
	3TuXY5JrSbU5EgZ4/871D+8cWEfZMp62dBcBxjyEAHHgA8IUZwG93EbiRNcOFXpwtHWRFQ9NjHl
	rdMaEiVK38LJSUXnQ2ky52WRwNidnZ/IUsd40BJ+zA8a4U0VmKaeEAw8+8uRIN1ZtnU5PQEFT//
	lN9U0OvfHjmjJEzO1D9k0TtiuPQmlbRk9ijtT0lK2lRbUnRGg3TkM7Q7LksvTJATpZ8GP85GPju
	A0paCsDV1hw8ce9gUTSCl5K5w8r/aBUHabRzw/lVoq/YLMFMJGzVuSX8NVBD17y4oQMh8=
X-Received: by 2002:a05:620a:1d01:b0:92e:8405:7ad2 with SMTP id af79cd13be357-9391392a8bcmr708322585a.41.1787919905985;
        Fri, 28 Aug 2026 05:25:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.102.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939173a6af4sm130819185a.22.2026.08.28.05.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 05:25:05 -0700 (PDT)
Message-ID: <6a917e21.5a609c75.e0bb7.a85d@mx.google.com>
Date: Fri, 28 Aug 2026 05:25:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8663391667020843723=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hnkz.64@gmail.com
Subject: RE: Bluetooth: hci_core: Fix IRK lookup lifetime races
In-Reply-To: <20260828022549.1721170-1-hnkz.64@gmail.com>
References: <20260828022549.1721170-1-hnkz.64@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8663391667020843723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1152930

---Test result---

Test Summary:
CheckPatch                    FAIL      2.75 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      26.64 seconds
CheckAllWarning               PASS      28.85 seconds
CheckSparse                   PASS      27.42 seconds
BuildKernel32                 PASS      25.61 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      469.38 seconds
TestRunner_l2cap-tester       PASS      63.36 seconds
TestRunner_iso-tester         PASS      105.85 seconds
TestRunner_bnep-tester        PASS      19.07 seconds
TestRunner_mgmt-tester        FAIL      221.13 seconds
TestRunner_rfcomm-tester      PASS      25.50 seconds
TestRunner_sco-tester         PASS      32.26 seconds
TestRunner_ioctl-tester       PASS      26.77 seconds
TestRunner_mesh-tester        FAIL      26.28 seconds
TestRunner_smp-tester         PASS      23.78 seconds
TestRunner_userchan-tester    PASS      20.16 seconds
TestRunner_6lowpan-tester     PASS      23.29 seconds
IncrementalBuild              PASS      24.69 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_core: Fix IRK lookup lifetime races
WARNING: Assisted-by expects 'AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]' format
#129: 
Assisted-by: LLM

total: 0 errors, 1 warnings, 0 checks, 661 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14772457.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.252 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.232 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/658

---
Regards,
Linux Bluetooth


--===============8663391667020843723==--
