Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5C51A23B9
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326699; cv=none; b=uwefbgtqcNjarT/tr4UOGgO4GHglS+RZyJ+TbeoPpVjQKlSCBDt0Wzo56Ce9U1+pugf3dLn5ig8Rzhw6CXM+CQpe/trSZes4qnZPy7Df7pZ22MFhxLN9Mys8cZ8pF0HCvuUJCmWBfePecflp5tWBPbC6jXbN8qoveIFQ64Xw984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326699; c=relaxed/simple;
	bh=bjeFIaQKHxfd/KeOL5YcWANSc+FQjTTwyvOPZHooZgM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OVjB92Tp7//r0MsIbiqfbk2YaMiHqVK78fQ5A8cVybgYrOI+mGvJcJrsT7o8tYR+Wou/HSWz0EDJQhl3wFeMePe2XCh4f6l8RzT8TVihmcGmCxXF2/bodBKkOGoGA96egR9uzk3OPGmQ3HMrCqXOpNSwVdllwHV7mgi4Fjz6aKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zzt0xOFN; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzt0xOFN"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b991ddb06a9so2454892a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Nov 2025 23:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762326697; x=1762931497; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wUlU+ECSSeD5v5jh8xj2j34F4v3hmdSKGnp+bxlUm20=;
        b=Zzt0xOFNwQpCp5MA/TgQSwqUvkpv5Vsz2H6/Spo/6cGeZ0Eigo74v/9ETdWkoVHAzX
         k1++7UHHzVGliMew9SbH/AM3B3sQdUpZYs8BX1gwJsOm2eCXR6OScQ41ORvnan1xObaC
         Tkyo4t2ikd/5I5jVSkYjgGeXVK0D9SVB/9mpg64+L3tmAVzraeYK5zBkBBPl3Y+4QpeL
         9IYTlRzaJx99GQ31QbLe4uGAEcsmoucuMqVqXHNLCG2XEIwxgyjtml7ppBgeRJ8soy+9
         NwDrLoyFNngfkgguTJDaYarE4IGUNsWLSAg+OwZgS3Pb4J+WBDOblkt/XWhZO3TRHB/8
         jQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762326697; x=1762931497;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUlU+ECSSeD5v5jh8xj2j34F4v3hmdSKGnp+bxlUm20=;
        b=FhhzAoSR3H2+k1ayBkaFI2BWE90OMic1tO4oZz2Q4cEDsrdOmsW2r4ShyOcKQgzvOX
         9fGnRy2OyZIuJYZ2sRUV1yhNKXzsw9WU62xduk/6hegd20ns3djNMt+hcDMykV4xkAgK
         sbQbUm3sIj3/qVsgVeu/XI7TpaiKk6m5H/8vlguegQRb4sBPAyeKDKYCCy2tJ/QMAIM1
         MPTAZzEAifAVf+2rLPdPdhh69FFpnJnUxUP6EGfVvSvMlraHQaGb7gNyiWtiwzmp0tDB
         N409bVi037KgrygtAjzPjNz6MwSP8DTYFcOqqZXKt8T4HI+m7HvaLcLiUF801ZByl3mV
         TKqg==
X-Gm-Message-State: AOJu0Yw8rKN5Pkh3Cv3lIiyQlTJdeOV3b7I28gNqZZSxNlZl4irkIedt
	OCJo/ljQCvEgWgkcrcA8E26lRIxyIk3Rta16P5Wja2dQxWps3UR5dMnHbh4Vgg==
X-Gm-Gg: ASbGncsce9CYD0eg1yqWTFW0hn0yF58hLAx5udwPCtq70JKFknVeXonAdggcL9p23wT
	PDVdc7PKS6zxplwQCErrjWK7aObNcPQwXEy3OiweI33YVfxkrV2RYy1N0gtBA2uCYxOYd57aAT9
	WUCmYNmHgAiyyShNctAYhwC4HwwuRlGfPVdJpQeYUHWEPwAe1BlTfRGoM4js7i6D6ItX8rIKVBF
	MeBlV+DKW5ecXsb64/6lX1LGBIhjHdOPCfcExMpE4F2FFPMTaCFjTzbofSLstA2/Io6T9XC1vt3
	5u+F39n/pxRlTJo+oMssl61W02k4f0jXoGyCZJCmB0xTcO+vO6DP4vhbYkeGSxR1gas4VIlJoh7
	g0DfgQqk2ECeXm4ShRdSB6GemzFPpIJAzEpxxXikXQTLY1s0mikb6TquuUtN3h3/2XofeCK0uNa
	wAO3upzqY=
X-Google-Smtp-Source: AGHT+IEcjkrb6MbVhGE2HtgQIIobke9tI25JooX3OGwVX2Ivu+mFFpXCfkSUfV5YiJOKGqWSK2SdSA==
X-Received: by 2002:a05:6300:210a:b0:342:6c97:3693 with SMTP id adf61e73a8af0-34f868ec5ffmr2476654637.47.1762326697001;
        Tue, 04 Nov 2025 23:11:37 -0800 (PST)
Received: from [172.17.0.2] ([52.159.243.179])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f83d2065sm4428108a12.25.2025.11.04.23.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:11:36 -0800 (PST)
Message-ID: <690af8a8.630a0220.f7583.3228@mx.google.com>
Date: Tue, 04 Nov 2025 23:11:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1188750694912661891=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: Bluetooth: btrtl: Avoid loading the config file on security chips
In-Reply-To: <20251105063736.456618-1-max.chou@realtek.com>
References: <20251105063736.456618-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1188750694912661891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1019729

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.12 seconds
CheckAllWarning               PASS      28.34 seconds
CheckSparse                   PASS      31.18 seconds
BuildKernel32                 PASS      25.60 seconds
TestRunnerSetup               PASS      504.78 seconds
TestRunner_l2cap-tester       PASS      24.09 seconds
TestRunner_iso-tester         PASS      84.29 seconds
TestRunner_bnep-tester        PASS      6.10 seconds
TestRunner_mgmt-tester        FAIL      110.78 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      12.69 seconds
TestRunner_ioctl-tester       PASS      11.40 seconds
TestRunner_mesh-tester        FAIL      11.53 seconds
TestRunner_smp-tester         PASS      8.42 seconds
TestRunner_userchan-tester    PASS      6.81 seconds
IncrementalBuild              PENDING   0.80 seconds

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
Read Exp Feature - Success                           Failed       0.107 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.159 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.894 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1188750694912661891==--
