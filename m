Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFC3156653
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 Nov 2024 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732383000; cv=none; b=JjRiSJt6SNwIEvLbE6bFhWw8BWkooMCuEaWBcDnzp4MXO3INstaqIGSEldgQWxhnJQtr6PCK4pwf97mkAThtQ0PZmgNEzkWB9aCMuZRZ2TksTp0C6e8Ces4rX3zT5XJAjqzNurPnSZrD5Lv0Kjlp0QX+/l8qncHT0vzJ+dAJQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732383000; c=relaxed/simple;
	bh=/tl6b+FSZzW8gqKHHJVkM0k1OVcpUJKJlxkuOl1MDtE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=He0Xsw1/B41PkqQiIlnKMDlFgM/e8nxcb99H1OgstJickGLElETtaj9jjw7h9v4vzMj8Rja28YwlailtNEm9ZxIuwyYthU0znBTF2WA8Bi1W9Dc6FBBiWbOg63iWT03vUt3Kr2DJtGx5+n8BDxGu0SJJ5FYEQR/mDgcV40ulsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5diky45; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5diky45"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4667931f14bso4780031cf.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 23 Nov 2024 09:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732382997; x=1732987797; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AZc6rzYw2rOZVuViZkvHih55yc0dK1pf+UaCkHIugIM=;
        b=h5diky454uz3d/3BTTijya5bkFbTTe+MsNF9JxgN7r3uMToX4iHJRydRe50c6Yr5/A
         CjSqyh/9tPRSi6K/JbfPtcXRIB3M6ekFq7BsTehqaG5I07u8vBf2l9eBEIqWphungrCQ
         L3TZ+A11C2OTfoHMw7fLx+s5nckM9cITooNF7oDl/w5huoEuCWeMuQdeccvxkreDyAcz
         wz11t5OdjLNxgAvwfXY69iTBSI94jc5KFMD/OpTrU9Q1jm8HkHKy7HsmqL2ece72u/eJ
         apwC6z+qDGIlWI6FeDIHTZaD6NoNon/n1x3GkHgDphLZgUMvqU7dQ7PYC6Gzkd9Pk7bp
         48zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732382997; x=1732987797;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZc6rzYw2rOZVuViZkvHih55yc0dK1pf+UaCkHIugIM=;
        b=ltrbgeBptq+0Sy0RFRpNedZouUZgt0Nih7tBdYEsjqv662vX7QoSQvngJ4mulMtYDr
         TSJa39U3PAKZXjnJKlHn3Ik6nIF+ujTSBfm9uuqP8e9t2y7ATkDKONgqAMHyqpUh0PW9
         iameWjKE4UAPZPSiD3EafiJhN5ZP70ZeSslyxNxgMj04fg8Nhi5kq9vfKhfyvh/FRPBs
         oH+VH1zXUSeGnK+5eplif95vDRjIPbu3dNMe4u/1uOlF1Xdgh/pvVFVwtg1jdGqmKdQY
         RROilIpQ9Fd3kMP1L5KZ8UEAKQ6YPimdVSPgZ02rn68e58K8zwQRNehL0x2MG8qsDmRd
         2b8w==
X-Gm-Message-State: AOJu0YzzdOGPxRMqNbZDWMzb9Nv5TACtp3r2oKbWxaDmeePRehLbLLd9
	ObuqCYQdQ+1cPuacKz8kRi1WsVj5uXYWgxcBgn6UTHzJhI3tx66PmOJPzA==
X-Gm-Gg: ASbGncvlCeeTo6uddof2So2Ry4qhEtALfkuFhpWQWn63wAFB85NdrGFVN8o/ZNSId0G
	gn5qd3OqqtdZ9IFyrRZPHsdT3p1fLRw9dr8Ey6nY6mh3TOjy0ASpZkutOUN9H2lONwiDtFPJKe2
	50IEn84t1igqb7PKSN32YEVnNld6/7JMAXx4j+eEvewcJlabJVgI19g4xS0EuNAJuCywBILAe92
	uJ3dI4NpQV9Si6SgRbKYTMs70pU5IedWt/YzXz95W+Zxvaaqa7/UNsDFA==
X-Google-Smtp-Source: AGHT+IFge0mfjqa16BI0/vWzTfhZMFI7OCsuuc043I7qFLNlrVEPOky0wiVC/u9IV58X68taS8hvLg==
X-Received: by 2002:ac8:7d85:0:b0:461:141b:47a4 with SMTP id d75a77b69052e-4653d616f88mr105483271cf.36.1732382997111;
        Sat, 23 Nov 2024 09:29:57 -0800 (PST)
Received: from [172.17.0.2] ([172.183.77.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c48fbc1sm25984241cf.83.2024.11.23.09.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 09:29:56 -0800 (PST)
Message-ID: <67421114.c80a0220.3abc61.89b9@mx.google.com>
Date: Sat, 23 Nov 2024 09:29:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8928568647929287223=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, j.alan.jones@pm.me
Subject: RE: Bluetooth: btusb: Ignore Nintendo Wii module
In-Reply-To: <20241123164510.879109-1-j.alan.jones@pm.me>
References: <20241123164510.879109-1-j.alan.jones@pm.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8928568647929287223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=911980

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.54 seconds
CheckAllWarning               PASS      27.10 seconds
CheckSparse                   PASS      30.40 seconds
BuildKernel32                 PASS      24.53 seconds
TestRunnerSetup               PASS      436.30 seconds
TestRunner_l2cap-tester       PASS      20.55 seconds
TestRunner_iso-tester         FAIL      26.96 seconds
TestRunner_bnep-tester        PASS      4.93 seconds
TestRunner_mgmt-tester        FAIL      122.82 seconds
TestRunner_rfcomm-tester      PASS      7.56 seconds
TestRunner_sco-tester         PASS      13.39 seconds
TestRunner_ioctl-tester       PASS      8.05 seconds
TestRunner_mesh-tester        FAIL      6.21 seconds
TestRunner_smp-tester         PASS      6.97 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PENDING   0.57 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.198 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.114 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8928568647929287223==--
