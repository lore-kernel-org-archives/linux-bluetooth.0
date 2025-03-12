Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB68A1487D1
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770138; cv=none; b=vE8zdPU7jcGJnCQJZM0keiSR9YpCFB2Vw/SZz/MiKSL/OBLY/Ik8TLBPeuuMoD+LhYAdSxW1MOHXl+qXyjzslEu7rKgGfrAE9O8iI3Ra12fIETqel+/25PRGreLL3UJA47gc7GKKvJljxEEgYqUeByGdrUsNP0J9AjcQu9h4bgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770138; c=relaxed/simple;
	bh=RUUgHwlCRn8WvM0wLSCkUcEtmWzzqJv8zYVms9efgnY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GyxC7C3wLJpUGfUzKBMGulG1tXBafYc6qi6P0H2XoeRw7PmpN3hN0JksIkQcMlL1ed2N16dqcw4Cula209WywEqZDY/GLxZHIUnhY5QZ0xmsb+rpSlvq4NCwNOQxfUfiMcj9O4oj3/dTaBLBXrqtCexhEvPe+v2ZtaJnqNE0/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ23Eogr; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ23Eogr"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47690a4ec97so26975611cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 02:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741770135; x=1742374935; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VXZDBb24ALPum1jtNJvgbM9LzG0IJ2gTurr479SvBqI=;
        b=dZ23EogrxqsptVcpSaQ677CUDa/LVu7DMlG8dy8KxSLQrl3Hj/aq9gXpQTCIoqevkK
         6jJzZ6SFgVCZdnxVaE6LpRsN/Etp4fLCPFGwo2aYi+9WjOvwGU+c4srWLhzIAGkahYIH
         QR12I/W8/7U30mUNpu7ucGSgNxG69eEnuozE5Im6sXNvydEgqBgumYIR75Un28Y+vZGC
         zgF6RCmRf+ZzYk7C8Q8hfNdBGyWJilfkxDGw8wDgomVAv07AlJJEjHi28ADepnVNc27V
         X07EhibdT+wTcIUReeaAYX783jmI77Q4XnXy2vjfRSUFT9OsZGdZvenFviIwMkYcAyBH
         Mz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741770135; x=1742374935;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXZDBb24ALPum1jtNJvgbM9LzG0IJ2gTurr479SvBqI=;
        b=AdlhgvLh5vT5IfMP9r8sDlXPDJM3OITfEIGXnDfAyOV4v8cgF3H2R7WgkNADLkMF4b
         1vg+Z8+Ug5TfMry7O8kSzyFpDhn3NxqO7h8hwYmMObxoZunwH/+ODCTcNGm+WqcB+pha
         DY54ff/hs3OiWxhot0b+mfj/8xMKaFkgAkaZojQUdCkxNB0wbKpF+mzKExA3UWcnX4N5
         Vc2jxOl+Jj3eQZ/gyZJ8GX8ErT0j0bODmhxThIAA8vq4pfr8G6oR3WIQrEZQTKJx/rOl
         BWHqv9xwHqe3aQ+ygqQwY2HxlDabNgO76RpOTzCEoawpDsV3pZbfof/F4GFhlLF4UVEm
         kV3A==
X-Gm-Message-State: AOJu0Ywt26av5uIllgTfK5Ub+vV/IEAWFkmaRwTjtt0zh8fDGIW5djPL
	202DuUzJtYp9o4fVtb8qd1VekfJwWoWwIYkDTarnl5OWZ2WfIfU7kET3UQ==
X-Gm-Gg: ASbGncvd/IXVz9XP84siNe+FJGFjyw/NhSorusLTUgVfT1CTFrEs3nIEtBS9lfqP+3F
	3kw1xqenxc7zdWrnGAksA872lYljCXjsU6MgAcubIOw9s9fMLRUtOfIjWJ0smnnglx3OSXKeABc
	ovGy8hf+y9+3Q1OFlyrQQWNzA4bMmoJhnswIKw2OTUewjGc/0G3xxOBxZzGZJHgIk8l1oJfFyUo
	ODnmtTE3WYQ5mZ53QQNdL6F5yyAps/8KZJu11RzMk+u91ffrHyePurh+JgcfEwJ8Uol9CF0q35x
	QkjFfgTkm34i4LRq6fI/t3IY4iJvkpHNTcqjndQ1rw1GpJ3gXw==
X-Google-Smtp-Source: AGHT+IFg6usk6LuexBZBe86qZxP34PWNbb1twrrMSVU3jWm1NWdPWrACXFs7O14gKB8WojvQ5VRp9w==
X-Received: by 2002:a05:6214:d09:b0:6e8:f166:b1a0 with SMTP id 6a1803df08f44-6ea3a69bab2mr99722706d6.36.1741770135261;
        Wed, 12 Mar 2025 02:02:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.193.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707c55bsm82251686d6.8.2025.03.12.02.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 02:02:14 -0700 (PDT)
Message-ID: <67d14d96.0c0a0220.397259.bf37@mx.google.com>
Date: Wed, 12 Mar 2025 02:02:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1039874409754630432=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sy2239101@buaa.edu.cn
Subject: RE: Bluetooth: HCI: Fix value of HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE
In-Reply-To: <20250312083847.7364-1-sy2239101@buaa.edu.cn>
References: <20250312083847.7364-1-sy2239101@buaa.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1039874409754630432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=943013

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      24.61 seconds
CheckAllWarning               PASS      27.21 seconds
CheckSparse                   PASS      30.56 seconds
BuildKernel32                 PASS      24.01 seconds
TestRunnerSetup               PASS      430.35 seconds
TestRunner_l2cap-tester       PASS      20.79 seconds
TestRunner_iso-tester         PASS      28.31 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        PASS      122.13 seconds
TestRunner_rfcomm-tester      PASS      7.84 seconds
TestRunner_sco-tester         PASS      16.20 seconds
TestRunner_ioctl-tester       PASS      8.37 seconds
TestRunner_mesh-tester        PASS      6.09 seconds
TestRunner_smp-tester         PASS      7.21 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PENDING   1.00 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1039874409754630432==--
