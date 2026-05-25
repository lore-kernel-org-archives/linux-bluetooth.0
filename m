Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB5334C39
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734148; cv=none; b=kTpZJv9bkQc/saTbexfrtp0g8VNcFHjTKICgo632P8QtlyiSmp95Avku2FoLEq2m1yKaRqs4Jr3wlQdiWm5fcomNJW9N6dCcgOs/1SEMaw8Z+cf3pyIAiZyVSLK+f8trmhrR4+ovpVV1fFV6w8qFafFQqg97cxzLbLoHtaWqYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734148; c=relaxed/simple;
	bh=Jf+FQooAApeyZA3j7HjnSQlSqu52WwUKksvgd9QIrnE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SAyDAym1lRDL2tkpMoBvEI1ZQdYWEM4UajRxL8T5PcU3PS2UGmAbSZz0szm2q/vNxPcazbMCXfx0HcQea++MVRdsX4yuPL7E9uMTHtJyK77Is26CNKs9AWqN5ZPQeLPN3bpiPmE2S1cfBfQPJ4Id84dqG9dBtrtX70DEBgW78E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XM9cNRuf; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM9cNRuf"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-516cbe16bcfso27632671cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 11:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779734146; x=1780338946; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v/qOwv2TQf1qPS6jNrirCUNOQ+3o586Cd0ilhYgxqPI=;
        b=XM9cNRufAOSAJpyy5R4skx4P8DL2hVlK95UQRANalNYGSwN0W7XRGM9UdH0WjV3WCy
         s0CEBwz18ssb84Y/NJoF2WYFJQODMUUE4ea+6ecq4qqt2+BWE5dDtGf1UhIjo+MsHG6c
         /4jL20k0iT9q3b1kjiQy3SykSOk4ybiiO7oa5KxxFP7GS8vcLCb6xWzFFoIooiVfckO5
         +SpNrJ5uhVKsZzOQDJawG6JEu5Ub239Mf3NgMiKul3yhVc0Z5S6OjWUmj9PIP5QS6AF4
         OaWzAWE6sr9UffRg8z+mXJ3yZ5AT6/r1PZ+oFjd9R9Zs3dsZnDkwQnh/ES44cfgI23D9
         Zx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779734146; x=1780338946;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/qOwv2TQf1qPS6jNrirCUNOQ+3o586Cd0ilhYgxqPI=;
        b=CN7QyT9BesTPSQLzBoXhl1PKVDz6xUePZQugSrVbRNBFGlK9eKcL7MxJS5wlTZzFbS
         ITLepj8D/EzgvRszJIrnm4fH+BYVyOopsHpfIJlQJSED5IFavUQxGeMg37irGl2pmW2o
         CIefudXTAlQaehENATnd/ec4R3lRHVSkJyEVXXIH8lMk2Ag/h0d/ajlFjj+012DfFoVN
         oHegSbYidWL2ENi9k6Dog7XR1EGzs3VsXkR0LcOw5Ad7mmmDEHGYjCdXUgmmphmpY2uv
         ajI9dkgWyXHqR2HLtOctjnl6WmMSSczk0kN9RVWMLVywhgSZYP1+VXURuYKgorndFVEC
         61Kg==
X-Gm-Message-State: AOJu0Yy6tVarLVDsWR/m4DRjfr4NDYHH4TqMYfA7cSYolbD1km+rLRZ9
	fIVW6V3AZyum91hl9qhrkSZIi3itkSWFsav8YopYDBKwZmbBRx+jSnWwsJSKJA==
X-Gm-Gg: Acq92OGy3UutMvQwWcpNAK1S4UuSV0RRcXFIPyC3ieynWG64516kw16+SejquG786gt
	jjSMLUA13pcJUR5y225SoVrJKc+BbMv8edR6dSRD9aO5ZVdAAy+sFQepjd5gQSxaVCwVcXODsNY
	Tg2yJaBGTp0LDyMXumCUz0B7Rl5ALdWD02Cw0HPDveXSIIRvbT2NI6NqRZ15RRvIIU0/NF0T7cQ
	BekE3LA2IONEI9+vHajGwL1Msvi5556dFMrFxPKuRbR19VgeYax7HfHtL1pjAIcRZH8kv0yP3q5
	Vu/ZrOobz06WAG5rcWFy+DTUHrg54uS/v1+RdowMMHVZinccjVn9MZ5MoDGrddNRqwMdozVdaGW
	LRbfGuOOD0KBJ9ByfKuARv39s7aQHmh2ZxY4aqSURmT7rHIrypW0i7SzGT1gSvnT+NpSFfQnQ7/
	HWMst1VA32tK04B4M3r0LxwshQTqg7huk=
X-Received: by 2002:a05:622a:4207:b0:516:d15c:7d10 with SMTP id d75a77b69052e-516d4293932mr245492181cf.6.1779734145499;
        Mon, 25 May 2026 11:35:45 -0700 (PDT)
Received: from [172.17.0.2] ([52.186.174.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cba4easm98926221cf.24.2026.05.25.11.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 11:35:45 -0700 (PDT)
Message-ID: <6a149681.078af235.2b1150.5600@mx.google.com>
Date: Mon, 25 May 2026 11:35:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4509437453429184944=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, doruk@0sec.ai
Subject: RE: Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync
In-Reply-To: <20260525162438.96881-1-doruk@0sec.ai>
References: <20260525162438.96881-1-doruk@0sec.ai>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4509437453429184944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1100544

---Test result---

Test Summary:
CheckPatch                    FAIL      0.76 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.79 seconds
CheckAllWarning               PASS      28.12 seconds
CheckSparse                   PASS      27.01 seconds
BuildKernel32                 PASS      25.40 seconds
TestRunnerSetup               PASS      532.35 seconds
TestRunner_l2cap-tester       PASS      61.90 seconds
TestRunner_iso-tester         PASS      88.07 seconds
TestRunner_bnep-tester        PASS      19.91 seconds
TestRunner_mgmt-tester        FAIL      214.11 seconds
TestRunner_rfcomm-tester      PASS      25.41 seconds
TestRunner_sco-tester         PASS      32.40 seconds
TestRunner_ioctl-tester       PASS      26.22 seconds
TestRunner_mesh-tester        FAIL      26.05 seconds
TestRunner_smp-tester         PASS      23.65 seconds
TestRunner_userchan-tester    PASS      20.11 seconds
TestRunner_6lowpan-tester     PASS      23.00 seconds
IncrementalBuild              PASS      24.77 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync
ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 035c25007c9e ("Bluetooth: hci_sync: Fix UAF in le_read_features_complete")'
#121: 
This is the same class of bug as the one fixed by commit 035c25007c9e
("Bluetooth: hci_sync: Fix UAF on le_read_features_complete") which

WARNING: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: c09b80be6ffc ("Bluetooth: hci_conn: Fix not waiting for HCI_EVT_LE_CIS_ESTABLISHED")'
#128: 
Fixes: c09b80be6ffc ("Bluetooth: hci_conn: Consolidate code for LE Create CIS")

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#130: 
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

total: 1 errors, 2 warnings, 0 checks, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14593508.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.253 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.018 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds


https://github.com/bluez/bluetooth-next/pull/239

---
Regards,
Linux Bluetooth


--===============4509437453429184944==--
