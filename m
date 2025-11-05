Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197B32E13D
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355148; cv=none; b=MVvDOlum8Axtt5NyVAq3CuwXE/hQshrQCQ7VHzCCn6kS4U2tJwIYLdO+hKCS2vyrie8dTdJa3UrTMe7N49fcnoUnB1JzbVFknTpdV1xRAZk0h0/ElEJE2I1A6H2hnXsW8Gp6SF/IK5DipSzQJqdfqJVor/kdboF503txsGQhHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355148; c=relaxed/simple;
	bh=F+Bl2oRhDblv/+gSsWbVlckR0tI4ESdhNtBDtruZWto=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VBPWrcE/I5XQ6qIvaTAdQ6ZO9sIbxCyAMtvwvpgfbPPmPzpEwrEAjmEDfVXgpk2P1HUb0IRZfv11+h5o/2Ku/Cre3VP00BiUFkL6MtVd77RuQWS7b1x7Wka8gXC0a/fdbYmWJ4jDCPDw9Y/ziEX+dl5lKCw/0y96LqGKjk2OLuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOPjEKTk; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOPjEKTk"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-94863b3620cso150513239f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 07:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762355145; x=1762959945; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3qFY8j1uEgh8/JjrlOhN3tnf2WGGqhflJJ+KVvLtg5k=;
        b=QOPjEKTkpUKSFha/t0jHojekJ+FkI+vraOf7zz6wU2aoRnvQ+6AGEx3E7u3eUYUNCd
         ozROy9Drtl5UwtYwIVLErfdVnjU44cugGB4wjvA8+OdZwVcdfL8o2iRBetz6e77zmRK2
         kn0yHC3f+67I8S1or89ClSqen8MvVPDStXszC2g/OPQhDg3tDUwzT9Q6ETKIQnXIRGhL
         xFmMqssrc8UWP3amdryXQ5r3lWfmmkWHzcqYCyzqpdOWpHq4XW24AMNFkDnLoqLS5A1r
         Lt9JebfBlLuPiBiA2TPahZYe2xKuqLmwgfmVRlveIN4W0qT48e3Gq8pi7r4u7RdV6GPf
         CndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355145; x=1762959945;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qFY8j1uEgh8/JjrlOhN3tnf2WGGqhflJJ+KVvLtg5k=;
        b=YVWb/EyAz8nSYF/ksSy9zyc/q9kLi170STU4psT7249VWP6qv8K4aKzU8P58aH+/P4
         +iQIbtFniqpsMzUIFYIhkTtxCmA4cknarMuYUw7aesusl1a32oYD1gaBjZq6+hlcDKW6
         J8jzDO1TaisabXsQE0ENmbai6ynTMumynYcdeG5ORvg6uJoIqn0a1IsGwx+T0V6XA+A3
         LLW3oq1LbHBRBdqTHi2Lnndkc6qeCcyqdV/esSUTP7Lv2qsDMV/NBdiBShLQ3kDfPYxL
         bW4IFZewd/VD5m94OMwpqE/BadkOyASS/+43FWOJLGLvCsbIw9VyeE3XmVzk4XBIMG3O
         O7dQ==
X-Gm-Message-State: AOJu0Yxbwqp7Tre76S98Y3JMJGC3syK9UD5kcLQXIGhmqA5MVqnBSs+i
	00u4/pdQ88ITMyWNbhtFSnMEuvoDR2oW5TmRxRVJkGxcS2ebwejyYjteQlmglg==
X-Gm-Gg: ASbGncs26nCIkBykA8LZ/3Z5tiY/NvXAkodjEZa4meI0f4cPHzJTR5Tl/n7kbje+3aB
	hB2bgV9SrXWOL/g/r9SfyOTkMTqWY1kR4sxUei1tEHz6nijOANrWur8Dj9KpisF+2CW6dlTskC5
	nrvvJ4uBcQ4M4j6WMR+UGj80sCq0XXD/FKk9FAWK2PUjzXPdwnLFQYmAVqtoMR2jis0AkftD5al
	CJf/cVPT4cf1XSEBEm8crsrjaniw1WoTGwYalJjQtcRKzN52jR3bM6+X7l9T05II2Ss3rKRRpVh
	L9wR/sqm4FLmujS1Y1TrhGe9djgkpnjLa24rPem5OC2jOgGhTCXJ1I1zw9exmGCvuXy+bqKJYd9
	f7I+GDuFy5yA0aiU1lS2AGJMqwI4riOUKTh9CmytcQ60RCXltcgctNaEXKM14VoQXJDXWT6BkhM
	qFYUq+2Fe/JsBviYczDA==
X-Google-Smtp-Source: AGHT+IG83gqkC3U8RsSQ1cmC8yf/ZgyuY78ctjGZUoTGE4eyDY60GW+8W10pTCmox8qWZGlQlumdtw==
X-Received: by 2002:a05:6602:341b:b0:945:b0fa:a77 with SMTP id ca18e2360f4ac-94869e66408mr629458239f.13.1762355145137;
        Wed, 05 Nov 2025 07:05:45 -0800 (PST)
Received: from [172.17.0.2] ([64.236.133.194])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7225ae9dasm2400028173.25.2025.11.05.07.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:05:44 -0800 (PST)
Message-ID: <690b67c8.050a0220.397b0e.4859@mx.google.com>
Date: Wed, 05 Nov 2025 07:05:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8135107079888795964=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ssrane_b23@ee.vjti.ac.in
Subject: RE: Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user
In-Reply-To: <20251105142251.101852-1-ssranevjti@gmail.com>
References: <20251105142251.101852-1-ssranevjti@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8135107079888795964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1019901

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.82 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.77 seconds
CheckAllWarning               PASS      27.34 seconds
CheckSparse                   PASS      31.19 seconds
BuildKernel32                 PASS      24.56 seconds
TestRunnerSetup               PASS      494.73 seconds
TestRunner_l2cap-tester       PASS      23.48 seconds
TestRunner_iso-tester         PASS      88.10 seconds
TestRunner_bnep-tester        PASS      6.13 seconds
TestRunner_mgmt-tester        FAIL      111.51 seconds
TestRunner_rfcomm-tester      PASS      9.20 seconds
TestRunner_sco-tester         PASS      14.31 seconds
TestRunner_ioctl-tester       PASS      9.89 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      8.34 seconds
TestRunner_userchan-tester    PASS      6.46 seconds
IncrementalBuild              PENDING   0.70 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.097 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.173 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.171 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.009 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8135107079888795964==--
