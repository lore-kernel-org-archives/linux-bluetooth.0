Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942E3A9624
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634487; cv=none; b=O7P1r6Dny+xYYYqj891/FLvoQqtOuoNKgMIRkyY7Phnv4Oz8F/vOccZI/Y9BIUt2TL6qUK9o6dvNRwak+B3+fqzzXN283mHJrYj2pd4NDwpSgRhqQLcY8Q08whD7VOnBSdA+1AenB5V0RyDCpx1kSvZnbN+9O2tHRWHjzaRIgVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634487; c=relaxed/simple;
	bh=s9Lx+dUyx934C+Ju9mt8XLQ8it4GIFcQArkSQGixH/8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZyhJrZTLtUHQxmJuMkT6WiRGL+N2QNkKTEBCKIkdBUSWlY8lh+/fu7A63b5e6aVQq0/rTaMY7JA5QSJ/ZorPfZtVp6YP7eF850AAAn8/xfhmocuEgjB1tEmfLc/T4e1zkX/NqWcbwgyEJEQjcNZvwSiACpjBjRh+KkVVSh/LNQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXc844CA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXc844CA"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ced3386430so74581945ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 04:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784634485; x=1785239285; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wsAERBIho11GzvTUxOTzwRAiZ3fsmdo463AhxdyDiH8=;
        b=hXc844CAwVgCNQwlZ/uVDqeaeBBQvd7933CdMkAZeuVtiUbx/anjzRZy7UWkISOf1z
         3Co6UWJhXyMOif1B8RheFEtrXFvd9yXNYlPnj74kWmThymOwOnnLtOeygTc2rx7TlL0U
         FxZzGxGvQbWRfQBbDGH2Ix5XclzgzH66QukzcdaW/iQQZhLwYzuZoCUhkAOtuaQcHgpp
         qOOULbvnNNCYYoFGslkVZLWvxj5JALwBXWlgrQJU6sEAd+sf+90WJi4jHoasbmEnZE/5
         AWkWkrkYhhTb6/5ACpWe2kvy4+2fP1Snz266O8Ixph9cLh1Wo9kGZCVfqsDGTXyK2Uv0
         i2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784634485; x=1785239285;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wsAERBIho11GzvTUxOTzwRAiZ3fsmdo463AhxdyDiH8=;
        b=I4H+U6TSJmY1U04yyHd1r9joB5+hSOyzY0BLTqkirME+NqaXDTS38Kfe0mtjBILbmh
         1tqBQ7mX+ml6aMkHdC92cEpClyfXyBxRT94N9equMqp/H3cq2aBt7/icOG7j2rpXB50R
         wQTJXGj7KSYp5g2QtJDPFbOugRLF9iXrmEQBA6MeTxQTMAP6O0booGeGPr2e2OBmEX6o
         hxTzEyxZJkLSSNFY+0RVmJDi+PkwkvpeZz79CDkqoa012Te6DrgReD9+AnBoyvQNw42i
         ++T5A/945wdqMsMEFCanUEMbn2AKJHHPT1ugX4P/m3G9Ufqy/FiKnXWiXDlKu8wr8zbc
         aoYQ==
X-Gm-Message-State: AOJu0YwL5e68X3PK0J9/U2qTW1zqRwHO8F7dJWrKJwo45L1g4ZU3+aYO
	L/SA/oIeNfKwIRzuhgwDwVo29meCWZvmDjYfX21tAGdxeBSh+w2NabVMduRrjQ==
X-Gm-Gg: AR+sD11TF4OlAVD9D9LP9tb148xAeaaw1MjPXDngiBiO5Ozn/tzbrpXtB5Nfy+lBvAA
	Tm91/5N5WFHsXWGth2fiuybvMWtinFPyXw9CP90jV8GslqsYGrpKrwdo2vINJFTxtjfwkoYZNV+
	xKiX9pE7EwIH0TOz1F9wTAhcdIl4Y0v5hm8ijfgvFjCxaJ1J65u9X10txE1DqjZdIbdrAlYtjdg
	EBmZohXZtA4AnOKgLVEv/7f1WQW1ceZ2K7BC35lkGeZ7wNHjTeD1X6obwpQLHRcAI2R7YE5wamR
	CYEzcdfZPnAQmc0S1BiNRxueFYU6hQNWDMyn0qA/xtYlGIpb3AWGz8k0AfPp2bzf9lkFK+/Fo3Z
	tC+aqfJDYGbsL854fjaCr56jmws/QKXy0AMbYegXCQOKWTTVlx9MOwBxDBpfh7aGm9tAHAVHxp6
	llwiE0B1BQySA=
X-Received: by 2002:a17:902:d984:b0:2ca:11af:5ee9 with SMTP id d9443c01a7336-2cf3494b34dmr199814565ad.25.1784634484628;
        Tue, 21 Jul 2026 04:48:04 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.214.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344bbe50sm75483325ad.27.2026.07.21.04.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 04:48:04 -0700 (PDT)
Message-ID: <6a5f5c74.47d170c1.ad7bd.5397@mx.google.com>
Date: Tue, 21 Jul 2026 04:48:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3370292637708062435=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v3] Bluetooth: ISO: fix UAF on socket close before shutdown completes
In-Reply-To: <fbd9dd573bb1ce5f38370128dd35447e2ddfed9c.1784625576.git.pav@iki.fi>
References: <fbd9dd573bb1ce5f38370128dd35447e2ddfed9c.1784625576.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3370292637708062435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1131484

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.03 seconds
CheckAllWarning               PASS      29.52 seconds
CheckSparse                   PASS      28.50 seconds
BuildKernel32                 PASS      26.53 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PENDING   566.96 seconds
TestRunner_iso-tester         PENDING   144.76 seconds
IncrementalBuild              PENDING   61.72 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: ISO: fix UAF on socket close before shutdown completes

42: B2 Line has trailing whitespace: "    "
49: B2 Line has trailing whitespace: "    "
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunnerSetup - PENDING
Desc: Setup kernel and bluez for test-runner
Output:

##############################
Test: TestRunner_iso-tester - PENDING
Desc: Run iso-tester with test-runner
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluetooth-next/pull/469

---
Regards,
Linux Bluetooth


--===============3370292637708062435==--
