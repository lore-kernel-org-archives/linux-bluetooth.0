Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED0E12D758
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Dec 2024 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740430; cv=none; b=Eq0c0p0KmYHAUEgLF+N1Eg4TDAITJr3NtctNW5lIvgx7v0oXDxos4GFCG48qrbp8nVpXWT8kI0wmdg5JnPE2uJ/AZF+SUhh0Ugu5zJNtKEXOc0z9O1VDtGKIR/6XUIPRvD1ErIaotUdM2YVLFMiT2ijPfLgTS0yPf3p9/EKIPCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740430; c=relaxed/simple;
	bh=FJ5C2EP0LTEk97Ee+DdhGyOylrdSYwR6zt+xDmq+Ewg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J+jVAMdqq+I9IpTR0iZPZUOcqRyLE77kQ6sM4gTVyGw9+QcY5updYbVf5JW78Qw2CY1HPmXzLOBUVRfaDDgEqoP+KM4teOlRxQAax+RqDtSb0qtdOgMhpU1NeqNRdQazoBjoF0B5w6Mjk6MKAMBXZqjRsAKcPwqBUn8lfCx9uoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isG1zZt7; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isG1zZt7"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6c3b1ee59so136673585a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2024 02:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733740428; x=1734345228; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XiQdYWBEjhYuNtUa/6PlPDACJbIhPOATVE0B2+IrzDY=;
        b=isG1zZt7U9WhyAKufZOQkbxahXqacWRXWIY6j/TsuDPb9TPnapj92LB9SpHIXnHnvi
         Ea1bpw3Dh6SSqhayFGBTFXobEWUihVUXX1GPKkdN+gZjRLxcUgY5duebg233fsFEQInR
         LQfu+tAghMaLJvuO1w7Q4wKfu25IuUSB1Aus0ESOTlLu/nIGz61Mt0fYYDbigsuGY+5t
         Epsp/xcOi9JzKBvtzueSLHhtP9KUkAYvKIdpUWNspr5buaIMU4MWiZVEuvPQ4tPYkr6v
         MXqgFBXkxhl3JT/7bdB4DFF61BTBK5QoDnGkFOt6agz/7OHmf1UwPuctvvK4WW4Z0xYJ
         DJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733740428; x=1734345228;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XiQdYWBEjhYuNtUa/6PlPDACJbIhPOATVE0B2+IrzDY=;
        b=rrew6zC4wDuuGGCPk1EiP2qk8L5smztgVzEW+OAZuoQbSVlGy3UL0I68S7rY6iUxBP
         TaFubGOL2bFCsMfY09AONJu/EGfkug+xWtIB7J60iPtpVynQtpF95cMm6YFEBV1N+g75
         tb3EpCG5tKYcJGyxVAf39rl5pJwWyyRA6m1MqCLpQvVRF2VqeTCL+eJJFk1Me6YCKnyb
         /Dd0U1VDsZ0lXUDiIOGaDWXq51i4/FQKMw/QEkTtpgfD80cNSFHil6gO5MMtM0lOmLuh
         yF7cRfVZCJQ19RDZHs+bX+keuqaVea/bnrKtwWQy+4AYdyehKulJuo+hdSlXD+mScPsO
         ZJMg==
X-Gm-Message-State: AOJu0YxxPYQRRNlZAY977KxegA0Ux1GtpSUwPTtvy3Zbn7u7vqKUX+Zn
	vVWH0pHuaQJ7N1i+M2VstkMbo7Q0atIHjq5fn5gZtC9dX9NanxVaaOxIeA==
X-Gm-Gg: ASbGncu55DWGwX3EqHxQMA1MF8U5/Pxi8WsTedT0v501s9dY0ax0z13IaiC9Kbf8Ydf
	5GeSmrlxcv6iMJwBecb5YaQIrB7nMnAcNC+vOzyAbiNOKceQpY/gPgnUCoI33DfI2/45/SEQahi
	nftPyrutWrcVXWU59pSvZadkfX7Z6FT08lisqS5yVeWxh8PVpEpRtDDdX5oAdCNa6pXvwGU/p7S
	XebKHKXGasyJIkW6sfwqbS16K4i/CiLJQlN+ZaGryue2XZ2anDQEiyb
X-Google-Smtp-Source: AGHT+IH0hGg5hSCwUkzcBkEmnIRSzza1s/kjgoc3nIngdxUpMW1cYXItzJSWOnsY48h475LUuFdVlg==
X-Received: by 2002:a05:620a:244a:b0:7b6:6add:4a3c with SMTP id af79cd13be357-7b6bcad519bmr2314803885a.21.1733740428020;
        Mon, 09 Dec 2024 02:33:48 -0800 (PST)
Received: from [172.17.0.2] ([40.79.247.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da695e1asm47453016d6.29.2024.12.09.02.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:33:47 -0800 (PST)
Message-ID: <6756c78b.0c0a0220.3d8136.eaa7@mx.google.com>
Date: Mon, 09 Dec 2024 02:33:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0035033979235629484=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: iso: Fix circular lock warnings
In-Reply-To: <20241209094218.4939-2-iulia.tanasescu@nxp.com>
References: <20241209094218.4939-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0035033979235629484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=915843

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      25.78 seconds
CheckAllWarning               PASS      27.60 seconds
CheckSparse                   PASS      31.26 seconds
BuildKernel32                 PASS      25.38 seconds
TestRunnerSetup               PASS      439.26 seconds
TestRunner_l2cap-tester       PASS      20.54 seconds
TestRunner_iso-tester         PASS      27.79 seconds
TestRunner_bnep-tester        PASS      4.91 seconds
TestRunner_mgmt-tester        PASS      120.37 seconds
TestRunner_rfcomm-tester      PASS      7.56 seconds
TestRunner_sco-tester         PASS      9.29 seconds
TestRunner_ioctl-tester       PASS      8.06 seconds
TestRunner_mesh-tester        PASS      6.95 seconds
TestRunner_smp-tester         PASS      7.01 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PENDING   0.90 seconds

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


--===============0035033979235629484==--
