Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522C4271829
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381493; cv=none; b=P8/ryBxrrOnsxD/B333xPQ6+BP0FUJFxFA0gOb6p1XdMoIkGlnxbgHZK1nYzDFQjzZ3g0fpOq1papV19xr/UGOmMc0fKzt56rUQ5VFXyAHzZSnhZJwsj/pQdkfW7waAmZepZ/rGth+zyBNGsZaAFrsvqqLC8Lh08yMAd5O4ezHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381493; c=relaxed/simple;
	bh=3fhAZtATVnFCRpzclNV/xCc1rp5IKro74UDV5MPUAzc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JM5VokR7spy4ioHwDFmfrnO8oBIa7iWP0Obz0bbfBx8L+MW3w05pSCLqALRj4qAjyjI4XBB8GVtLemfpzSLUmCNY0g7fOItSqFFzLw+lfe6dl96CGXjpablZEcSSgnCkcieVT6XNVKoLa8PM53huIvqZjX6plgdMLDc0sb6xYx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCiKph/n; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCiKph/n"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46c8474d8daso56444231cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 09:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739381491; x=1739986291; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BB2zgl9lz6B/ZJRyeC06Akd4yNZnrX/F9JacODQtUnA=;
        b=GCiKph/nFFhZ4Vs7Tb+7V0oHOresWuLCX9/gMSsH59swd7YYL62/iGSB+mcvk5+pD+
         8tvFrZRqbMwGT/2/D4qrg4gUW882YfG8+/Zcf2/HOXfmYcDXyBsJX4gJ/p+LA5a9rJIB
         23t7NKs42AI0fgnX1pk5TNfTAzYwJFDvtz4yu1HH5mN3+riuou1hA+YsBV1BeXMcX+DW
         ZNmdhXg7zkrU9zCeeHlpqVO5sXghU3OqTqtEo5JQqSM1IbVasP/H3lMPytYMgNyO2QAb
         z5uvwbfWFpjMtNeH+Ic7mcq03ZB2KO2P51KqCvC19L3zMTlVsNtffICQQh7+ZPmzRrfC
         Nyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381491; x=1739986291;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BB2zgl9lz6B/ZJRyeC06Akd4yNZnrX/F9JacODQtUnA=;
        b=hXMN8n3uFCoUkDjBy+stF05Hi6pNTrg5ynN/8xP2FyO1NhBn8UzqjxX7FO2Zyyr2AL
         G+0gv36E5zyo7gqL0DC9bPdpwLuatumkJTF3SpcTIgxEt9c49zsBCverSCymC5NDWjvt
         l21VwuuqNx6+MsNi17yMY1u1NpPouOpBjmTU2DaJRGmVsx8DztYm1sSZzjmHu9evwJ2V
         5se2Y1h07GvVlO9T6B/rOi7iDWdYnl16lWZShOgsJ5Cky1SNQnO7eaJdY8eAQzD6cpDi
         r5Oi9tqMoKdBfDpS3E+Z+5rfuv5McxG3/R0bTxHK2yqnw6qgZ8KVgucRu85jgby7b1mn
         AGcw==
X-Gm-Message-State: AOJu0Yyf9Q4Ri52FEfncmW+NOSrrUaIPqzpiNlW3MZD5xJU13C3f+sRv
	4u0u3m1g5E2hbXacrb42S8IIkitj36VAslR3ta7/FJ1lZnlx2NSf2g33QVqt
X-Gm-Gg: ASbGncsMxtaSd5SIeYjksA89MDLoxlwb2h45yjBFnfFtstPegQh4eH/Fds5XueHE6Qc
	EVmEmE6QGUZRvjWHN+tni9UC0Z+nDYAe2g8RbzDrRkQKcMN4+XZwnSlpa4uOCVgIGr4FeRFOiH4
	zEYQ9e8SjdvY6MNnAU5CASyUSzg8OYnX3IheuVEcN7HblH9dVz30n7zl1EPPd+15SUIro0oDbIp
	Lo+9GTjUWwHzjDPHBrarYYaCUA4I7J4etTVtkorZCoDioNbL/+laAmfsPNHa+a5eyOUVqTpzd9e
	CQNe3lsxZ1EHgOSWNLcPZw==
X-Google-Smtp-Source: AGHT+IFVboGJX0DWZbvuSyyrB1D9g1909iiKV8D8v+yqO5NaC3OjUFamrh2cw6FPZ+IHAVW2fzfxFw==
X-Received: by 2002:a05:622a:1193:b0:471:809d:de4b with SMTP id d75a77b69052e-471afde1cb2mr68184561cf.5.1739381490862;
        Wed, 12 Feb 2025 09:31:30 -0800 (PST)
Received: from [172.17.0.2] ([20.124.86.165])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47194f06979sm42279981cf.2.2025.02.12.09.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:31:30 -0800 (PST)
Message-ID: <67acdaf2.c80a0220.e4089.df23@mx.google.com>
Date: Wed, 12 Feb 2025 09:31:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2140571743121616532=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dan.carpenter@linaro.org
Subject: RE: [next] Bluetooth: L2CAP: Fix NULL dereference in l2cap_recv_acldata()
In-Reply-To: <f9975604-6a65-4bcc-b532-15fcaa6da0e5@stanley.mountain>
References: <f9975604-6a65-4bcc-b532-15fcaa6da0e5@stanley.mountain>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2140571743121616532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933263

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.53 seconds
CheckAllWarning               PASS      28.14 seconds
CheckSparse                   PASS      33.87 seconds
BuildKernel32                 PASS      25.79 seconds
TestRunnerSetup               PASS      437.43 seconds
TestRunner_l2cap-tester       PASS      20.46 seconds
TestRunner_iso-tester         PASS      31.68 seconds
TestRunner_bnep-tester        PASS      4.96 seconds
TestRunner_mgmt-tester        FAIL      123.37 seconds
TestRunner_rfcomm-tester      PASS      7.61 seconds
TestRunner_sco-tester         PASS      9.45 seconds
TestRunner_ioctl-tester       PASS      7.95 seconds
TestRunner_mesh-tester        PASS      6.08 seconds
TestRunner_smp-tester         PASS      7.07 seconds
TestRunner_userchan-tester    PASS      5.13 seconds
IncrementalBuild              PENDING   0.91 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.206 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.189 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2140571743121616532==--
