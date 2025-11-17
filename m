Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0423426E143
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763373945; cv=none; b=D4Q8QuO0Yt7FWizr22HLWfNNR11SyuvhfXh3ieje88w6SYllfsqmvs9HHmzQ797puGXIwsPWnjooRc4hyONz35zuegIADI2fecfDESUpCdN46uNREzE5WpxISyEv5uNKqarGd+Skh6hEMhmPAKZ+hFPr364zlsb41eyOFD3mxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763373945; c=relaxed/simple;
	bh=3tGCnaCFZSQuSJH0ousT8W1EYk1Evqg6h4b5X6rOHtI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tG2hSvioMNmTPNmMvztHiFqQ4FJbQ7vG4wmuATwhQHz7PQvfXQm63nEphw5O+wliiQZyj0inf7My/L6yv+5GJJWuBDl6igBjxtULEORsKHPIxHKFx1vi+NcF8SY7/zJCnNuQTy8DnajCBjPOhs7JYOrfDJ5FVemcDzYIZPo5BVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqIzZBJm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqIzZBJm"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so3803277b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 02:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763373943; x=1763978743; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FvAATWYZClN+yLmzd5nq3oXrBeTp1mniTdss6d0RCKE=;
        b=YqIzZBJmDLtCOjl+c2FfV87bGg2c9sGhcG0MX4SgxHPaAORnvqyqT27uwSQuePiFqz
         ytu9sM0feovUhfNWiwDFo6/9SmBAbskyE4am//9fowhTQDgTJarzFR8Wi0UDqzXI0ueu
         0k3Rq6W/rba5kzXdHJgMQZED4CiY7lfe+c/C2nHhqiBh7cxSk2H+gvWHoR6LNZgyIlST
         gZCJ12FgUNFjAL5zNG023MOUipXqzxNg002AtBjHlfvpUs4HwBLO/DQyR0Z31CNTXhTo
         nP8Py6iE5iOLS2qlIDKynjB7JjlaSATdhsJQEOGt7hyFZRNtr0PI4Srp/vTHmBe4x3l0
         Q89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763373943; x=1763978743;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvAATWYZClN+yLmzd5nq3oXrBeTp1mniTdss6d0RCKE=;
        b=hZH8ojgj2H/APWJIrlng1jkwj/1cC97rDdzyVwts+X5FUioQt8GAkLyZyIJI6hXnzJ
         u7hPlpCuMcfgb40jWKFT2oansL7EuDpmRIb+ZShDSnOOM2aRExo8jlSrnVfw0VVlbitw
         8/NAZmbgluQYG+KtgK3O30UJCMu0Rnda+YiaGoV9M4ro0MMDOyM+kLNpLH34T0OgFVbN
         NSsSlTFcmfmOiJ2T1+Pp3GseO6jce7IsIm5rUEx0+woNljYfTvU68gQZYUPlOixIZnIj
         i8gcLMj+0vVRECIFmECsArNxMijGbZvV2yknz/D8my+tPwjAzRbUU7dTP6KT/NIjhvMl
         mYHg==
X-Gm-Message-State: AOJu0YzXiGNl6+DX8lTvjOP0ElqPaUXktyQGwZq8u5EikuRJYQrm64jh
	y5jJdWvU1dlGJyMg7DAC5dbACyA+y/ix53pK4Y3EBU8XqU4BNFKZIB6RNmxUOEgy
X-Gm-Gg: ASbGncuCMVGLK3ld4U63gher1r7jz3SrkYOsNmNwnVOM/iEoEUitYxws9SoIpcpqjz8
	x77JDDj6dkv7kHrREGwNYLCv1iBvndViT8xM2ZNkzieNv2CT07gpiEZjwa8N6+hHIdyKjaBstuM
	tbHTYNnrjtktXUKiXTyMYlTgOBg1kU9w2M4jXtBzkNMmoqrx9OMoCSiEiIKnI1SbNRLZ0p4EZIo
	z1p7mHoOrKJrSe/UWYCWjdt57CXGANOpoynLeCRKSXVJmf7PFRbz905JGtBjUQUpwl/focQ///M
	V4xA78clgqC8e5sDIepet4TTTtFleArzDgWr3HdatcnoCn+jqTYoLFOMrl4AOi3N1ECSUyPm6IA
	3NObpLUudfOZa+e8vvVQ+KABf6q6me/5xSIGb5yZLuE5d8+NRuHzI5dRv3/WZ32wI3TJXbTU4Tz
	9TkZPpuMpw3g9og3JYse3+urqjOVSY
X-Google-Smtp-Source: AGHT+IFUoujdQSFjhu2/Xr7gnE8pEMAlfE6QJgkmKUAS1y/4wfJa85R3iDGjm+SqFZbawwJsiEpGtg==
X-Received: by 2002:a05:7022:388e:b0:119:e56b:9596 with SMTP id a92af1059eb24-11b411fc012mr5297701c88.27.1763373942929;
        Mon, 17 Nov 2025 02:05:42 -0800 (PST)
Received: from [172.17.0.2] ([57.151.136.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885f9sm40941883c88.4.2025.11.17.02.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 02:05:42 -0800 (PST)
Message-ID: <691af376.050a0220.1d699c.3e59@mx.google.com>
Date: Mon, 17 Nov 2025 02:05:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5858554980557840701=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Bluetooth: L2CAP: Accept incomplete SDU
In-Reply-To: <20251117092408.336966-1-frederic.danis@collabora.com>
References: <20251117092408.336966-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5858554980557840701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1024166

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.80 seconds
CheckAllWarning               PASS      27.20 seconds
CheckSparse                   PASS      30.97 seconds
BuildKernel32                 PASS      25.10 seconds
TestRunnerSetup               PASS      502.50 seconds
TestRunner_l2cap-tester       PASS      24.12 seconds
TestRunner_iso-tester         PASS      91.19 seconds
TestRunner_bnep-tester        PASS      6.07 seconds
TestRunner_mgmt-tester        FAIL      113.26 seconds
TestRunner_rfcomm-tester      PASS      9.21 seconds
TestRunner_sco-tester         PASS      14.29 seconds
TestRunner_ioctl-tester       PASS      9.84 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      8.27 seconds
TestRunner_userchan-tester    PASS      6.31 seconds
IncrementalBuild              PENDING   0.77 seconds

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
Total: 492, Passed: 486 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.094 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.179 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.050 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5858554980557840701==--
