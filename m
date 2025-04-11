Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F87421B905
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744391157; cv=none; b=GsELIVQQNPB1cc/c9gwjvmbiTc7/0ZKj4SX9kC1CbVhEMe50EnQkXAg5h+NUeu3ysCbXx33Yl6ARnADxo9aM08x7H0U1LSBKx2VlfZNQLVxQKr5/ZI4jPnhOJz0Xg+E4L3WbJtXjXAweShlM9Tw93rmNpUWZnHjFPdA/x7AcBDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744391157; c=relaxed/simple;
	bh=GbHCf5lGnsiFl5DVvAp3YlHWE5sHV7Nrz+Ia03AmHNc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NT6k2XwSQAT6YIwteg6EMPEvPA7Lb/Rn5BY2SbACK2OUWLJ8BaTg75wuLxJuWT+iSE4MJwqD99T8caWGa6AN/UQjOCWxppdX4Ql1zTjOKSJW8d26JNNdJCd0XmvYXDuSLVikE8vP1usUJUvqBZ08fPSJpt+kw91D2Ka7Rx+yjPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDnm3Mcb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDnm3Mcb"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73bb647eb23so2116236b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 10:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744391155; x=1744995955; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K1z1eujIRjOh9+W2i1G7J28OnQDHSi0vgvMF0+Cg92o=;
        b=VDnm3McbHnFg75PF3ben+b0SBfd1bQgcQJxwoi5LkwDg5kB1SLJNlQHbpMEOooQSbF
         +xdjfsGfZB+FGCpBVMzZpYVa/UAVGauigixmb3JmavqLUN9LPe4sD/3ccg6oFGgiwudT
         U+av5pgwM1SM/dyVOhjGXPJG7xyYqLC74XmCQyMrWb3T1C8jIYpWL9tft1JQnpG5j8tL
         8+7u1MQ9y3sXE/8BQobYNYXmo7u1g/DbSrenlVM7n36qa+aJteFQex11WuVCrz16FS+Y
         J7ePfjRLOSHRufh9UDUeS/k8WcYNc9t2YO66FvN/Ck3tsHoILc5jJd3O/tM0a7R5lP0l
         i/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744391155; x=1744995955;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1z1eujIRjOh9+W2i1G7J28OnQDHSi0vgvMF0+Cg92o=;
        b=d6AQtCUXxfZEC6yg+VatFqO1AN11yIPpHiJxQew22sJur94UPUcOrV9ck32l+Iub+x
         LfIHA4DeUdlyPjmvt3y1HQGGuMsUTWnEvo/c581BC1pCO8tnjeHHtBUa4gLGKPfsRB7S
         WEA9/9HPEZzlVOmSPdVhrzbVSyXMB+w+XCq9wWFKvXMOpBAitsqAWASbt5KwNK5ux2/T
         012JuUT4joh+Rp8uPk/of8zw/kGHJUalEpXR6iaiLZ+j51FlfeFRz6vSNDI2MdXw8xKY
         JUFrir2eoA5b1q2ex/1EooNhJXBCnf3Vi1jlWYNVpAvQVsao5V/dUzmHPNZT6SzJsQrc
         1cOg==
X-Gm-Message-State: AOJu0YyXpo7pempZ9qbiI5TNh7Awp9z+VncxeVkE3EO/+bXcRFJZ/gPu
	FulmEcDTG8FEpOrlZ0BA/fSpj1gmzfPe82EWM6vogb/LlJAxyklADoIIAA==
X-Gm-Gg: ASbGncvLoUw4Pu+fgIo3hOHABT7l+ABxP6ZTUbvkLg25ZF7KP6zEVkZhTy/5UdK5W8Y
	U7AA0O3JE5Py7/02mGLm0OQP7MDJ/y2EzuxOutQ9/YOIdlqAQC01WNwP0xxsNCOnMwOgVy/5KxI
	MHUHpSVFFFISL6S/lxRFdXKYopgWUcdvBV54n+3I+jBaKW/o8W93HzjwFso/c03MWwOlySqK7Ya
	0pm1eD/2E4mArErmJSxZFyivEIHErDpH3wbAHJ2qoLHL3euFvHGpaLar0k2n+X0hsNLn1LYYoid
	BsOq4+l4iAJ1QRdrj44y4btE6BF5byFaam2IEPoDrcWmTg==
X-Google-Smtp-Source: AGHT+IELa65MyvXEJIZvaj2+RZLzNC7UtHTX4R/BoniNyDZ4XdOLBa/fxCFKnBvYJD4WMxiLui/eQA==
X-Received: by 2002:a05:6a00:1481:b0:736:ab1e:b1ab with SMTP id d2e1a72fcca58-73bd0e97a1emr4543618b3a.0.1744391155028;
        Fri, 11 Apr 2025 10:05:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.29.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21e1f66sm1804331b3a.84.2025.04.11.10.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:05:54 -0700 (PDT)
Message-ID: <67f94bf2.050a0220.4d853.242c@mx.google.com>
Date: Fri, 11 Apr 2025 10:05:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1477401161799395198=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Bluetooth: l2cap: Process valid commands in too long frame
In-Reply-To: <20250411162908.772132-1-frederic.danis@collabora.com>
References: <20250411162908.772132-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1477401161799395198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=952571

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.51 seconds
CheckAllWarning               PASS      27.83 seconds
CheckSparse                   PASS      30.60 seconds
BuildKernel32                 PASS      24.21 seconds
TestRunnerSetup               PASS      466.99 seconds
TestRunner_l2cap-tester       PASS      24.31 seconds
TestRunner_iso-tester         PASS      36.93 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        FAIL      122.24 seconds
TestRunner_rfcomm-tester      PASS      7.80 seconds
TestRunner_sco-tester         PASS      12.56 seconds
TestRunner_ioctl-tester       PASS      12.88 seconds
TestRunner_mesh-tester        PASS      7.87 seconds
TestRunner_smp-tester         PASS      10.04 seconds
TestRunner_userchan-tester    PASS      7.21 seconds
IncrementalBuild              PENDING   1.01 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.195 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.141 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1477401161799395198==--
