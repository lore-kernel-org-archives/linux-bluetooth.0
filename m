Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5ED1A3179
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763391925; cv=none; b=UIDQVfsITIhvg2MqtltXc2I9BuMj51yxToN+pKqhBUjdOKnXTdtHOt7He6JB/x7RAxG95IuGBQuCW8Kvqr+qpuMZynq0RDiK/CP5rMCIJJYQC+f3A39gVr97BZuTNDWGJynbvPJDYm3RvIn1E1odR3aHBmraSiI4KkN6kuFC4q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763391925; c=relaxed/simple;
	bh=vJXpBju4e+max0wMkN5E+myu9BX1swGrz1IKHkvG6os=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mkinEyCuppVRmg46Iz5GLPfwMZ76YhYO6qS7Cg3JJn54CODKddGCjEEuPZc2LVuIQPieSufasLoobgfkz1rCkM1bzuT52kLs9LCUlWEibSeSyQt0qM5AxkHCtwDS//9IwS3XaxZSVpVIwOaz0oA7I9gAowYEGZi4YO+oSXLZxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7yhDKt1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7yhDKt1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2958db8ae4fso40574885ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 07:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763391923; x=1763996723; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jDBYgTbDzfdXaMeRQpM5oY4zdBaEM86aFRUKtdHu6us=;
        b=V7yhDKt1GIpMCQ9q+k4wWqzLfJU/lwEf6FQ/Bqs+voXH+Dil5PCuvo4GzwU/qXPksX
         dKHsaCmJarD6u6YIhoSCJ4utj5d5UeGoAFk3gW1Tb1uVDVLqjelmdlJe3uKu24GpmUuK
         AESofgTiT0s/xtORMfiPPdq/VucdlfJxu+0jQ5wuC9b/VFv4KV5a+Zhqkod4Nx+/kL/B
         I0GCsqdTiHt+ehGlkxtDROj+RDsymBRsMz8cktlNtD+z4mu4QiMQEdGWdg5GkLACPdle
         cTP051nbpkq/IMGBTCiNA6IN2IROOUaASf4nypJ13OZc2HkIld+b7mKsaij6n0qnSFgT
         u1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763391923; x=1763996723;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDBYgTbDzfdXaMeRQpM5oY4zdBaEM86aFRUKtdHu6us=;
        b=ks+l9SPywF9Rf6a216G3R91NXwQ9VFFZRL74e5QwH9NxcSxhRaf42Bnsqi/fxd+fGu
         Orxh+sEHgvPZwT3chsVEmiR+YP0szWyXKFbznCf/L3iBpNgt6MrHbCyh/pTvTkOZYv9I
         MxXmPVozHjJ+F+D/1km+t//hqfznEd2Muy+Um5Ly18nGeAOVnrD4MU4f7zrh3cB+RA1l
         Yn5ObqKKH6NXZNi4FjoTYCtjaKAHo4Fk079zpJ1adCv9NlnYci3bQpt/9JWjEh9sw5tO
         tiEcGdCWo1MSCr/Jx6CLri0XQKJu1dvl+X1/b11lb3XeYcs/eVMXlzEyC/15m4u50yDv
         wquQ==
X-Gm-Message-State: AOJu0YzcZPILoPSvQAD43LWY6eEk8rTtdjEcYpYbLiuwnEx2AD6XIKJx
	aZxuV4h8n9O6vhuxgkVPhG65G4El3zqt1w53K7p/Ymvn+XY46+50EehZaXB7otCf
X-Gm-Gg: ASbGnctoxMmMh0bw5hBhufrx/B2Y0NL6loccFUdDGYOLiHn7hF9/R/vJcJKpBHuzbHn
	RBDMxy9GP+ay08ty9NREMVTaGxYnBhH/nOFx7tVDjL7dqawd0sBiRwI/QSej5uZYQ4tXsZVwcwZ
	17tpIEprYNhEeEI+Gxm+9ZgiNTl8P8stBnlddqN16psVIKqpOEQGsC5IdDiQVd4Cbsm+BOKXP4L
	PinxzKr7L2AJOh34vfpzrBmiUr5K1alYanJUhJWeSK3o+NVwRpIsQoNTvacdYgG/yIr8sME+ZKO
	VQmMwn1YTRmCR3u8sngjjuGgNM6qZ8yo9H2DscTF8f8a/z5pNr4kJ5Q5mwBdoGJlld8Og4pPUGd
	xK+RstbsC5UlIMFSLLekkMY0DfEclkODVG7h8cdp8AYhz+SjyZxDKOy2B+zm7S3JnFoBwNniobV
	Hcvuz9kA==
X-Google-Smtp-Source: AGHT+IFuzrxNkRdkCtuz1c2/yuaOvCBEPleO9btCPn5MEAhVJu0TBt7oa0fYJWlxat1Lh02z6rbcTw==
X-Received: by 2002:a17:902:d54c:b0:295:5132:1a99 with SMTP id d9443c01a7336-2986a752875mr145432935ad.44.1763391922874;
        Mon, 17 Nov 2025 07:05:22 -0800 (PST)
Received: from [172.17.0.2] ([52.190.183.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc3760d9887sm12416870a12.28.2025.11.17.07.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 07:05:22 -0800 (PST)
Message-ID: <691b39b2.630a0220.2246a2.a057@mx.google.com>
Date: Mon, 17 Nov 2025 07:05:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1118767177809967551=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: HCI: Add support for LL Extended Feature Set
In-Reply-To: <20251117142521.3804561-1-luiz.dentz@gmail.com>
References: <20251117142521.3804561-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1118767177809967551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1024320

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.00 seconds
CheckAllWarning               PASS      27.18 seconds
CheckSparse                   WARNING   30.66 seconds
BuildKernel32                 PASS      24.94 seconds
TestRunnerSetup               PASS      493.87 seconds
TestRunner_l2cap-tester       PASS      23.83 seconds
TestRunner_iso-tester         PASS      82.83 seconds
TestRunner_bnep-tester        PASS      6.14 seconds
TestRunner_mgmt-tester        FAIL      122.74 seconds
TestRunner_rfcomm-tester      PASS      9.07 seconds
TestRunner_sco-tester         PASS      14.20 seconds
TestRunner_ioctl-tester       PASS      9.92 seconds
TestRunner_mesh-tester        FAIL      11.66 seconds
TestRunner_smp-tester         PASS      8.30 seconds
TestRunner_userchan-tester    PASS      6.37 seconds
IncrementalBuild              PENDING   1.05 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.100 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.111 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1118767177809967551==--
