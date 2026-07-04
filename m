Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE51E7C18
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jul 2026 00:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783125450; cv=none; b=AlliL11ia91T4hD77KdBayz8bRvyaScSxQ8llDta1qW6xpO9iyP9OUpK6ObKUnAumhIULsvHqOLOdsMWk9TIW2f9G0qTD8YDTnKEtN+z/kKvWT+sSFTnfXRPjllz/La1frMd/27wn4rY5MPGBD+Ed2LNApgArndDQ8OIriV2uEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783125450; c=relaxed/simple;
	bh=/wqkkA26rv/l4rPBnjDtOqArmdcJAMOT1XNB4gIjHDI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jMk5evRa2iADlXobjaU1k9eRhprv+zmcLOnBaoqqdI/GPThUJeV5Mh3wLJRoVLOXbT7YpCITdKjF/cmBjh2SFNGFIMCsl95j3myjnwcsGCeB/c/I6IE30FN1GjqIuCBpbUOWOC7uEamPavbF4gAhvf+IXOPsA4ltfSFE1DDBVKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhluPfRT; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhluPfRT"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8eff5ce3b95so7626446d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 17:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783125447; x=1783730247; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YKjBVCpoVw5E6U/eBfkRdi87NWjcb1yU1WWT6P+u81E=;
        b=VhluPfRT5NIYc8KdD1E+1/R0rU+hHiYN1yANzouqS8fYzyNbfy+ObPt7uDOyl/0tmk
         NrtS7nr/UiwDeuXBCi4TR1rKB4pFRNe/NyDTXeIy3W5KjEWAaIUSAx4XawhKhSqNG9Q2
         AGu6xwcY/T906INtyJ4syCi8wYI3GgrvQAoquSYyzixgALDFopa/p47ywFWLgdCDS2Ep
         EUkXPx7pIwev7x2JKhL84tBE/WvXGF63cdcH3cc5IU/IhJkX4+pGCoQDDI91aDSKDxeY
         A+K71MILTteFozEcQn16nRmsF/Fi3IYvpVYHNtdcSVUrsD0GxAw/aP7qOJq1rXBTNqja
         V+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783125447; x=1783730247;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YKjBVCpoVw5E6U/eBfkRdi87NWjcb1yU1WWT6P+u81E=;
        b=LwpRw8WTYJEXBCv1EqMCnuIfjRuR10TIEyN554DTIgnGxh+VR7dmmRgMQomZRhMt45
         sAYZnaCbo/0PBaTvW1pHV0zM6fxcBbg42j7Y4ngx4Q6sb0oUd3plplww14EZDWbmZmgw
         8GNmQ82xDWE0Uw7JStcl/Ti9Q/9modUmoS4ntm/Oj/U45QgWY95KNBimOQcyQgozjQaL
         6HSUEKwC/LTFkTb/r/wfKqVF07Y1oxmdflfvCJl3rorZZa6/NrLwS/59uFym75ocmsnO
         Zk8oFSGtshXBxnyPDry2ctN/IWJZIQm8MMiqZtGJM3qEHASUQk2UeU8O/dbhQvP+tWke
         YNrA==
X-Gm-Message-State: AOJu0Yy+OiJDhmxT74rkVI4ypMYqmhypxB4l8NWh6sadyNZuPaxQn4qh
	GqK0iTGgwffiKqRoQZy/WRxIj8Dij1fTh/wEGMWw4bbMw59q1KFZ2RZmdVkLng==
X-Gm-Gg: AfdE7cnaDWztkm+xcxbDRpOhRbgD0oPqtQV5NX5WnW89u/tbafEtw9Kf7g0xBDAkx2j
	RZKEwD1HAP29hV7iuf9QeyajArQvuhwyhzB9WCeBwKLdS22fLTwbh55AIJOkCgXrxlDyVhuHGXO
	RRbDO+xpX69KxSY/5VFbOlavkLCQUC1m4zmccqUY8ww7PBcs/mvNBoM4lBxyNTRQmAW1mQdm+id
	UbQ+UBXLeKQ9R/lVJLGXmgYLFE3qWsaAyOQvIe5ZRzILf6qjHq8jFOaAYnmN9P/NRJYCq+6limD
	m79ahr6JUOaRgUPOLJPY5D0SXgbkFxA/dyQTgiwjiHK2GPgcx9qqnfbytmGAlBHgcaz43QiEGZy
	tlpiqu1nZ+GAl6enq9nWondOAGba4pETigvBdlC2sWKhJsWvu9oNyIOkTAYhKQjZHGCGDk+TxAD
	gD64S4hqbJ6avZLrpLBbc=
X-Received: by 2002:a05:6214:4018:b0:8f0:7c1c:75f7 with SMTP id 6a1803df08f44-8f74a9f4b42mr24793546d6.24.1783125447208;
        Fri, 03 Jul 2026 17:37:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.127.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de87e3sm68151066d6.35.2026.07.03.17.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 17:37:26 -0700 (PDT)
Message-ID: <6a4855c6.33897c89.13d8ff.b540@mx.google.com>
Date: Fri, 03 Jul 2026 17:37:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4601293997213078224=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xmei5@asu.edu
Subject: RE: Bluetooth: hci_sync: take hci_dev_lock in hci_clear_adv_instance_sync
In-Reply-To: <20260703234350.225221-1-xmei5@asu.edu>
References: <20260703234350.225221-1-xmei5@asu.edu>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4601293997213078224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1121363

---Test result---

Test Summary:
CheckPatch                    FAIL      0.72 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.14 seconds
CheckAllWarning               PASS      29.13 seconds
CheckSparse                   PASS      27.88 seconds
BuildKernel32                 PASS      25.90 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      492.72 seconds
TestRunner_l2cap-tester       FAIL      58.77 seconds
TestRunner_iso-tester         PASS      88.28 seconds
TestRunner_bnep-tester        PASS      18.79 seconds
TestRunner_mgmt-tester        FAIL      210.08 seconds
TestRunner_rfcomm-tester      PASS      25.03 seconds
TestRunner_sco-tester         PASS      34.71 seconds
TestRunner_ioctl-tester       PASS      25.82 seconds
TestRunner_mesh-tester        FAIL      25.88 seconds
TestRunner_smp-tester         PASS      23.31 seconds
TestRunner_userchan-tester    PASS      19.42 seconds
TestRunner_6lowpan-tester     PASS      22.11 seconds
IncrementalBuild              PASS      25.85 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_sync: take hci_dev_lock in hci_clear_adv_instance_sync
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#129: 
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8

total: 0 errors, 1 warnings, 0 checks, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14663493.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 94 (97.9%), Failed: 2, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 1M                     Failed       0.264 seconds
L2CAP BR/EDR Server - Set PHY 2M                     Failed       0.265 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.238 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.669 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/395

---
Regards,
Linux Bluetooth


--===============4601293997213078224==--
