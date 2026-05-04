Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1F029CB24
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879796; cv=none; b=ZGF3RIvb40F51vPLPlsnxFmWRA8DRP+vkAE/f8VO8StJYEuMt71YmGJTNulUKQvCj7bO+VtsXEtiDkUXzgW3cQLQA1d6q3GnSnUb7Zd3KMJ3OWef82URya+xGJqx6V0qIa6DxLRDEQSvUYGdHBuMTlhB4O5kfQZLecFP73vVk00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879796; c=relaxed/simple;
	bh=7Xqu/wUm1QfOXctEIzRh75K+quHMqxzwGFGhOHhW46E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pLzsb4ZPp3bxuhFcrdmO1qhnPSnSp2z4vY5smmwvXKnITjLCZzuYWX6G1u4kujAHGNVC2b9d65Hg5mCZrSgbG3UJ93/GVhwxWyfx7OB+++H/eZ9kaSKOYVSiAPZWyZWCHa9cPrUS+O/GYkNOLbxcw7m7MpRJhGPVdAlmqjB0w6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsPYDwXI; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsPYDwXI"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so3862401a34.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 00:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777879794; x=1778484594; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QAjsO2yesbuznQNwUB+axaoDbi82kmw01D+TRlyNDjk=;
        b=WsPYDwXIsU1B5m5WPeyVPHGo7ps7Io2HsBfedTfdkr5A9DvXyJE/bmjpUBLy+graj0
         gRNR8a0JkAzpQ8fvtBhBM23tIpDRWjquej9srFYd6CEdmPH4/uuRvHvdwmgH64NL/xpq
         9Yune0vXKCPWwEiGkqIrvwTj1mq0a7ZXMpfz+hJmOE0WIykIbSE1XKXcQq9i47OvmCE9
         +d7O9HELDtPlMZ4dY77PmT+fZNUP6ZqUx880Cr2JIf3dLEZVpaTVFjfrrJDQOy+AQwfD
         Kkvidor7uLL+d+yf3CC6+U5mQE+iwH/nAyMIHQvPMsfhO5JOqz25zbKxg74JUTKNGaAL
         +3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777879794; x=1778484594;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAjsO2yesbuznQNwUB+axaoDbi82kmw01D+TRlyNDjk=;
        b=lXP+kDfg/QsKc+0//K0CF6H/NZ79/pV4as1hlDr5ucExboowzkaoiLHeo3hu4RxU2a
         MbzZhslcw6I1g4wcXfc5uK8zd1MhShOCpA8cWoNItDiTOBDx6jAUzCa3rFA/ig6y1ycx
         aksKRbwEcBcRYOLl/2paJB55KaPVwh+cQn9Jytl2N6+qWFKA7wS5nftK5H2TNi5mEXwy
         ioAnhMPM4NoUsuxL+VQuXm/5Psb+BlgpAOFG9NeHU8l4VxuMLX3KqdCS1on+N0qY7a7q
         eislJnNmsdTJf3jop7vyLMXufEEOS+y6qDXbwbkcpHXPDtJFBkhPPoGnrhtp+drsJegW
         vrvA==
X-Gm-Message-State: AOJu0YxtG6z+7J/SqzIFOindim380+UGq4lQNT2TLV6fowerDgo9aLbP
	BfdNgQgmahHZ6WN03Qv/qa5fMHtx1Z6lwEqF8jXevMfPlfrCpesFnvGACKHN9g==
X-Gm-Gg: AeBDieuPCweWxMJpVCPPQAdHh6sPluPGRnoAZkfKL3976IcJdm2PGOdrAi3tNM4hSeX
	vb02e7cZxT3gS1WQNS0UJx51AXuLfRhJaZZ2FFEUfuRDDoLWStsnbq8sStX4iE8oANNQYYfa/KX
	Jng8TTSWhBrdfQ7ulEIkFE3kp++U/IEw8epQiJPCjkiAhEnlyJm4eeYZ3FEdbgCEhUBOsXR2OuZ
	pWKrn2xAofEzpgxtXaFcLL/R3bnoONnAd/pol9qkMaJmb+B+ohIc99XA8eSNFaf3HVpk0PEbEVW
	VhMW6hUvrwPjPAJZXgez/PEckwg0RbKDyBD3oWZ9B+pvoHa2bgx2pXKz8u8+VP9st5h/PVcm590
	gvTplR0jjq0R5dISgmbq+/zH4RxmKbwnZRl0HG9Gu5P5MzVA4eZJGZHdyIie3am/+SLXMisVjvp
	h5irbgMr4V+ukA03SxKiIUaXIiOOlFwqACEE1ntqttiR4wSqQ87wA=
X-Received: by 2002:a05:6820:3104:b0:681:b070:3dc6 with SMTP id 006d021491bc7-696979cf6c3mr4356528eaf.10.1777879794085;
        Mon, 04 May 2026 00:29:54 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.83.33])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454cbbbd7sm9347310fac.10.2026.05.04.00.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 00:29:53 -0700 (PDT)
Message-ID: <69f84af1.050a0220.2ef67e.53fe@mx.google.com>
Date: Mon, 04 May 2026 00:29:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0698462937048448091=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, conorkotwasinski2024@u.northwestern.edu
Subject: RE: [v2] sysfs: return -ENOENT from move/rename when kobj->sd is NULL
In-Reply-To: <20260504050736.17672-1-conorkotwasinski2024@u.northwestern.edu>
References: <20260504050736.17672-1-conorkotwasinski2024@u.northwestern.edu>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0698462937048448091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1089086

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 FAIL      0.10 seconds
BuildKernel                   PASS      26.76 seconds
CheckAllWarning               PASS      28.73 seconds
CheckSparse                   PASS      27.73 seconds
BuildKernel32                 PASS      25.43 seconds
TestRunnerSetup               PASS      525.64 seconds
TestRunner_l2cap-tester       FAIL      6.55 seconds
TestRunner_iso-tester         PASS      295.63 seconds
TestRunner_bnep-tester        FAIL      6.40 seconds
TestRunner_mgmt-tester        FAIL      8.76 seconds
TestRunner_rfcomm-tester      PASS      28.75 seconds
TestRunner_sco-tester         PASS      68.04 seconds
TestRunner_ioctl-tester       FAIL      37.27 seconds
TestRunner_mesh-tester        PASS      26.90 seconds
TestRunner_smp-tester         PASS      6.41 seconds
TestRunner_userchan-tester    FAIL      6.57 seconds
TestRunner_6lowpan-tester     PASS      22.78 seconds
IncrementalBuild              PASS      24.00 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
Total: 28, Passed: 0 (0.0%), Failed: 11, Not Run: 17

Failed Test Cases
Device List                                          Timed out  -30.851 seconds
Device Info                                          Timed out   -6.202 seconds
Reset Stat                                           Timed out   -6.205 seconds
Set Link Mode - ACCEPT                               Timed out   -6.208 seconds
Set Pkt Type - DM                                    Timed out  -14.396 seconds
Set Pkt Type - DH                                    Timed out  -14.399 seconds
Set Pkt Type - HV                                    Timed out  -14.403 seconds
Set Pkt Type - 2-DH                                  Timed out  -14.406 seconds
Set Pkt Type - 2-DH                                  Timed out  -14.409 seconds
Set Pkt Type - ALL                                   Timed out  -14.412 seconds
Set ACL MTU - 1                                      Timed out  -14.414 seconds
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:
No test result found


https://github.com/bluez/bluetooth-next/pull/142

---
Regards,
Linux Bluetooth


--===============0698462937048448091==--
