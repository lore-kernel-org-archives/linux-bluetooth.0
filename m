Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F4337688
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422171; cv=none; b=S4Le8n/lDElgilxhvZfJmERRMOrLtwRTWiRZHCUG7W5ZypYkZYebsLHyOukVQ0y26CzBf+qAqQ0BI209lSAyMcmr6u9wQrcVuzJLgk879j8GAo+dE0L4gYg6dfc4nVJFnX9mPLJSqy5ewhH06JsAZP1bm5WC875XpHeDskF0NW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422171; c=relaxed/simple;
	bh=OJ4Aepg9SgMwOEIENABlKtdsyntsNSOtVzgdA9lGAk0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tzsmbDdHxFM+QJGmLNvFdhPYG2BYmwCMeYursjL0zqg1E3+AxkYGcztq/OqgDvKTSG1M7q21A6alVi6wMX/fehNzYw13R8+ZH86FizkcJwki7aCSXbIfAB4J2aYxRpmU6KIGePudBZ9IHxwwcgG2u0eNbw4xy8K1hYIorFkhsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izvNfjsi; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izvNfjsi"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-40c8ed6a07aso14239865ab.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Sep 2025 05:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757422169; x=1758026969; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ci3ozvLMWZK/Kqb1N9cybaz4yIjUt+o9GXE/teREMag=;
        b=izvNfjsiBDOfNtt78db/Fh1/541l4HAIhhDjYO4/hUUdZV4LkC1tqd7C2P050BjU4r
         E5w1upfpj0k6m/sCvB4rkfaE/OQlyJz5DkQntcSuwaL0lsA/1nQPQPPLoPwvhPum2S+O
         11NvOIoeFP25h7Dz7iyKPUZl8BiTd2epCxPGmYgI5u+7EIlo+3lPufjprAx0GwpGAApr
         y1KkO42ZbgAFRmDKanWgS6gRuYSn+rJJqXkb2zHN470uUv23XHa/oLCCeHXrAWztJdZW
         twp39ltVLeRLE80Vee6swqTZMpoIjaXMllatkf0PKHVmDzNIIgS9qZ9f660CNHroS8tK
         haqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757422169; x=1758026969;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ci3ozvLMWZK/Kqb1N9cybaz4yIjUt+o9GXE/teREMag=;
        b=bhs+CgBIsuveu3/WjUJtO5yejoQtCx9FOhgngBLqiF/LuBsTOj/p2I+si55Tvofb4f
         HMGIEvnqarK+4vxnUZ0A2Tok6VS/eU4amXUwSAQgSq1FJsH5QzKI4xAsH6jXn1zsZ4qP
         Z00KpXQ0oi4s4FMMTZbqsi7gh7qgLQPGKH9gDFDFHS8mN/pv6hWpEtU10xWkZutNZaz/
         YrXx4WRYA+3IfHv9rZMSmEkvlc1z5w46cztipL9WzSacD7nnmsJNufOD56LDU4Ndzb0b
         4nA1jY4c4vZinEXhL+VPbaS0Yf+iiWoWli0cZYbjwkXWZTZMFrDgKa3gas5RwA3Zpd0X
         DSXA==
X-Gm-Message-State: AOJu0YybbYWOHB06jZ7s8GdS/T2pL1xsW+sgSIqbbDgbRqApV1IP6AVk
	Mp2PLfoyUGwp3YNB4EH05sZHg4pXfbA7wIFNVeomyw7LzEF7EmZgvmYi2+/WGg==
X-Gm-Gg: ASbGnctGi5QfWVt44wL7GhEj657yeUzom5HFI644G11+JpJYkL2GgHIi5zGnNbCC25h
	N9FxO3kDqNiTfTX7MOEqejalow8FrFht98UXHSvu0ao63e7dGiHApaKr8TR88fikqPVFqY8RF6g
	i6d3Oy4VW4gXITXJtREQfPC2GBEspeMFRL37vOtsKlxWj0OtKzNO/jT3oZ/FhFqgQo5UDgU9S9o
	iotWSmN3qajbvuVyTNoDoQ3FwEdrEZs8FaD4QEE3VCyYN2GHJHzw/mMqaoWQDsLG6fmb6g0Uenu
	NaVgOkOaDAfpkhmx9/O8V1OwFM2VS0Ru6+pG18EyLCuI0YV8MO7bC1xHrMUH1PQjnhJDmUxIWEc
	lHlSCUOb2UVpUziJ1pUvi1ZrOq2OfUFtRLUkga5WR
X-Google-Smtp-Source: AGHT+IF1LcSQeI8iu3s27kBPE0NfKnwevQrzNwkL0Q9a8qhN/Md9gp8FGxuhBzR5vUg0uLq0+YX7xw==
X-Received: by 2002:a05:6e02:219b:b0:414:3168:b9fe with SMTP id e9e14a558f8ab-4143168bcdamr12182305ab.29.1757422168691;
        Tue, 09 Sep 2025 05:49:28 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.251.164])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f3e136cc71sm120466075ab.46.2025.09.09.05.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:49:28 -0700 (PDT)
Message-ID: <68c02258.050a0220.16f0ef.73ee@mx.google.com>
Date: Tue, 09 Sep 2025 05:49:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0054726878153058257=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, gustavoars@kernel.org
Subject: RE: [v2,next] Bluetooth: Avoid a couple dozen -Wflex-array-member-not-at-end warnings
In-Reply-To: <aMAZ7wIeT1sDZ4_V@kspp>
References: <aMAZ7wIeT1sDZ4_V@kspp>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0054726878153058257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1000473

---Test result---

Test Summary:
CheckPatch                    PENDING   0.50 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.72 seconds
CheckAllWarning               PASS      27.53 seconds
CheckSparse                   PASS      30.82 seconds
BuildKernel32                 PASS      24.53 seconds
TestRunnerSetup               PASS      486.66 seconds
TestRunner_l2cap-tester       PASS      25.33 seconds
TestRunner_iso-tester         PASS      39.31 seconds
TestRunner_bnep-tester        PASS      5.99 seconds
TestRunner_mgmt-tester        FAIL      127.39 seconds
TestRunner_rfcomm-tester      PASS      9.29 seconds
TestRunner_sco-tester         PASS      14.82 seconds
TestRunner_ioctl-tester       PASS      10.08 seconds
TestRunner_mesh-tester        FAIL      11.54 seconds
TestRunner_smp-tester         PASS      8.63 seconds
TestRunner_userchan-tester    PASS      6.27 seconds
IncrementalBuild              PENDING   0.56 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.991 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0054726878153058257==--
