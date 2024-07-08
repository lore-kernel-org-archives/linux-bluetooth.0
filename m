Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512BA29
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720471008; cv=none; b=VvZJSsWSlqMm2A5g8U+5c3ZmkTbanr751s7Di/YSK2H+CZYrgW4wi9V4TMinlKP6Hhjnk+pSf6rEptdHMiuhSyV21PAIA/WhwDcMAPgr1/ggMlVuurb59cYPQz/jGrZY13HCZ02K8L6cRS2tyUWD+SW0O+qdsbkSedLEtLupQ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720471008; c=relaxed/simple;
	bh=HPKAxNvNyfs+nTTLMeoJCpNefp4/pmeVgc2Wz8aMYOY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XmIpfIZXkY2K57PHUo8Gd7uaM6DUDW+81UDmOUY70eZ5vY2neCl0DvpK/eYzUfvcvrw1QkVvgz27tdvxSF2OicMwWBlq4VHYjhMd03p+XtrHYAyg7F4ME9p9QQ1oPIkNali8mnX7eLBQ877GDWgJ67Fhg0/M6Z/IhIgEg0TsSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWomrhWR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWomrhWR"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-75c3afd7a50so2171535a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720471007; x=1721075807; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kZal2n/zHXGYfYd1NyzPHGvbTj5fY9pjNw4JMhJEDxc=;
        b=VWomrhWRqDCQXUKXExuTVAoZs6bmmuuLiuPbtb80/p0XvU6j+asTsWD+tXzGmRc165
         Xm+ezhMnuZNi6HnsWnBUoDhilcZFgmtGmPTQkJLpk4b9RU4A5NXLvvHhF+0w7QYxf/L/
         844b3IVPD//DjjROlftpq+qsUcQ61frl138UfL7xbFdBPyH2E+dUfYep3tPlhbG7iGas
         M0BZ/4/klf72XBT7EAYiOCW76YN1MptYb60XP/scnp5DZHLQwLdOPUK4qpairRPuDmaD
         VwlKNrLP4DQBHKgdkuY0Hwsa/jpMnDRtRbblnPYJy+0lWAlemCOKzJoqR53lbrQONkcb
         Sm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720471007; x=1721075807;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZal2n/zHXGYfYd1NyzPHGvbTj5fY9pjNw4JMhJEDxc=;
        b=ll1lE10ndP3Ysbwr9bg+O9xNfdv6q1AEUH0kchjTejgjCYe7mnmRPwmpedYY6Ro/15
         M7u+Ej3jz5wooExwIeoUEDF5FXJGs6pfD1S7WyeBujK8UekUJlOo8vE+KyyFd8RnBZIo
         cvxzcrdO1KtndgWKJn4A9hnkwBIWmrj2Ue3JAHiuUNu/m3A5t/Ocmjj8rwiYpMFYbNIq
         Ik4y5E4Yx52NhjClU+R0q/DRisze0CiEQQYTBaYTYRGQGuskQP2bIWAOGQ/pYCEdkVPB
         JcdIXMeG5+9RNy7afswX8uBuvbaIj9qd2vhXgpHoqwcdobVjMJ5l+VmaWKFAnu8JK636
         fPAA==
X-Gm-Message-State: AOJu0Yxd6EtPVYJqtUKxk0cGK+TTTme4qEXX4BrFnOR42rxwREHE/hEp
	i4FgNlqn8ySCa42m0O3cyoZlR/p+Pd4nCr1386myIkKsd/GiyTIA7QtvOw==
X-Google-Smtp-Source: AGHT+IGsIEcMA5gZHw5mDjji3B9EjrJw2DFadsd8SF0LLr2tdYBbdyohrMaNvYbFAh3tvteB4rVw1A==
X-Received: by 2002:a05:6a20:1583:b0:1c0:f648:855f with SMTP id adf61e73a8af0-1c29821d98amr521546637.18.1720471006493;
        Mon, 08 Jul 2024 13:36:46 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.38.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac3111sm2697785ad.212.2024.07.08.13.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 13:36:46 -0700 (PDT)
Message-ID: <668c4dde.170a0220.e4ee8.215b@mx.google.com>
Date: Mon, 08 Jul 2024 13:36:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1847200881664896222=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: btusb: Don't fail external suspend requests
In-Reply-To: <20240708191727.2775854-1-luiz.dentz@gmail.com>
References: <20240708191727.2775854-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1847200881664896222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=869402

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      30.03 seconds
CheckAllWarning               PASS      32.32 seconds
CheckSparse                   PASS      38.31 seconds
CheckSmatch                   PASS      103.02 seconds
BuildKernel32                 PASS      28.87 seconds
TestRunnerSetup               PASS      527.00 seconds
TestRunner_l2cap-tester       PASS      22.10 seconds
TestRunner_iso-tester         PASS      35.16 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        FAIL      113.18 seconds
TestRunner_rfcomm-tester      PASS      7.43 seconds
TestRunner_sco-tester         PASS      15.08 seconds
TestRunner_ioctl-tester       PASS      7.99 seconds
TestRunner_mesh-tester        PASS      6.00 seconds
TestRunner_smp-tester         PASS      6.97 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PASS      28.56 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 6 (RL is full)               Failed       0.197 seconds


---
Regards,
Linux Bluetooth


--===============1847200881664896222==--
