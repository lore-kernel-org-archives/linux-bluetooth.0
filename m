Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DE72D3729
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546981; cv=none; b=OOyDP5UBVLHB1WithMt/9sUc+27yb77XzSuuYMSGkXUDy8WIm65temecefOK0ys2Hb6yRuVZ+OKQTbLQaNjw68YSMU26Bb8ZifF4PkvPRRRafeGyF0VhQrBvny8pz1cRnuapzwBT7pTFK9hLsI8rUgAjGA8eYOaaua9ct9qVC5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546981; c=relaxed/simple;
	bh=MLGlOzyrzb5OUHlnliPjSbET204wt9RLdpU5ebJbv28=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ByaxZL46YXVgCm6ECzZM/X/EcfRiZLp9a4Olfyf1rpfniZksTSX38f0FF9v2n+HjsF1RrE4x36LWRPV+yeDtu8lyzax9oOrOHJf3y06SFxpuyx41FpHEJeu/ol0X76P3n2oiPwaBpAx00VnKHIGhh4Mndk0HMzInVteUxQm5VOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFNX/7H3; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFNX/7H3"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a97a67aa97so11392641cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jul 2025 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751546978; x=1752151778; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4BakEz+jBnDuSp+zGpdm8KgDDEUClbG1iZLNSHxykzE=;
        b=PFNX/7H3zwFykiAmWk+Mtz4OBVxdfthPD14QxyQZ3eGMwKVD+OAQ6QCHGLrBv2/azN
         Ot1mlq1cCyeUh3mhNnm3o4c6aDMH9RaWoKkxgGDKE7cLjPLI5lOzAPYOmfhXTKshnXTc
         JSry8YJetiU9OCw4mwvNQTp/PlRWm1JtcUeEQijLuImmvKfa4ZWmhtfkQ785w6ZVL29h
         WeOQAsR2j+zW4t0SbKWsOsialw/mZhNEkEJhxvQGkNnalMx8GDRo4VMNTmomCXHoimDU
         CbWN52fHAaVR3FJuG/vL03TpIKek8yWjJonMpFVfXVUVXvmGKHKYRVtzOWKEsbLMySap
         wKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751546978; x=1752151778;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BakEz+jBnDuSp+zGpdm8KgDDEUClbG1iZLNSHxykzE=;
        b=qcX9crwBc7WKUDabB9aX62Ggzg3anj63hGpg4sIhu7nEYa6eZhJCVYIKmQshAvo1ap
         OQJVWA44uHnfZQf6uWJTGTHnkVz0RnN+pKwnROCOtkfHVutNo8hHJypnxkOmkufyRbvc
         kJb4VeJvAg/awKs6CY1tVWdxFATn7TL0Rz34dM7wPxUVHQBx6QybZOBpCGGBBxRC2N2s
         KgJlOjhdohn83rsIw0gHJGG6DMAoOhmTlDSML+k7S5cawdJTqyOxk9QQffw+54H2oXLD
         ZGpM7v0ecCjSqsq2qrJV7UwKC6deq9TXn6iqRptwwkM6k61wEgjEL88fHkZjMmzquTr6
         /Z+Q==
X-Gm-Message-State: AOJu0YzvO4hwP2ttK6ideT3o4+U5OIRi9FurbqyWNIfjQkGaFifFRzXs
	Q+7bjJ5vINTs8zyFlmo07/+75mxnjD2glCkMYYaG2UP473YZbtMJWO4pOHEpeQ==
X-Gm-Gg: ASbGnct+L4iHZPRsheYIOxnPx1QLiOwqm/mzH1/sZIRCYMn2fQrfARHElByF6PW5cKG
	X9CMNzzBq3pi4ZdP9+c6krLG70a6ro4wkj4Dco06gKIslffZzL0HogtSoonbkS/VEDGEZSORXjq
	mL9PSUJORuwxz91SPu71Zx5ZV9+lqL4hAPosBO3USOZa6vvzQdMHRBSL+HpIhYYcLxKCOLy3rda
	qhBrTjpPUsQQJJBoovqIGGvjO3knU0aPFd5gT/02nwzAErvp0euOTTuJxtZkCYDf5oRU6ZbH0SV
	DuVVu8ATC1caxbzGFt2LwlREELppKdIKZ7lnVMAeH36dXb8SyDZnjAfZwsYnXFhoIzbI
X-Google-Smtp-Source: AGHT+IEgVrpyw25SQIRjbINOwlO8o4mv24fRLzzndMYQfClmc3KVNmyIwsZG4kgihkTB9RoIyEXNiw==
X-Received: by 2002:a05:622a:1311:b0:494:b914:d140 with SMTP id d75a77b69052e-4a9769f19f5mr124563501cf.43.1751546978231;
        Thu, 03 Jul 2025 05:49:38 -0700 (PDT)
Received: from [172.17.0.2] ([172.191.23.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a97c7ef5c4sm22949291cf.53.2025.07.03.05.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:49:37 -0700 (PDT)
Message-ID: <68667c61.c80a0220.22cfde.8ed5@mx.google.com>
Date: Thu, 03 Jul 2025 05:49:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5863383235810887632=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v2] Bluetooth: btusb: Add 3 IDs for Realtek RTL8852BT/RTL8852BE-VT
In-Reply-To: <20250703120749.2519605-1-hildawu@realtek.com>
References: <20250703120749.2519605-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5863383235810887632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=978607

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      23.83 seconds
CheckAllWarning               PASS      26.55 seconds
CheckSparse                   PASS      29.66 seconds
BuildKernel32                 PASS      23.76 seconds
TestRunnerSetup               PASS      464.70 seconds
TestRunner_l2cap-tester       PASS      24.99 seconds
TestRunner_iso-tester         PASS      44.12 seconds
TestRunner_bnep-tester        PASS      5.91 seconds
TestRunner_mgmt-tester        PASS      133.81 seconds
TestRunner_rfcomm-tester      PASS      9.25 seconds
TestRunner_sco-tester         PASS      14.71 seconds
TestRunner_ioctl-tester       PASS      10.03 seconds
TestRunner_mesh-tester        FAIL      11.41 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.15 seconds
IncrementalBuild              PENDING   0.58 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.132 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5863383235810887632==--
