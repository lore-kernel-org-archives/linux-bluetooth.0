Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736072E717B
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819336; cv=none; b=fQFUzn03FBvY5NQnjqEuExkwdCNHaZYqyWLDVvVTz0dT+AzpsfUYURtKLH0vjORsBmE8+wBXjR33NIck6jeBsTju0Iz3B6KHO0nVI+vYmYipmeZG2dE4TiP2sCr6/rT4PNRYYbhq5eZZdwWabVu0dQPwfqjW7L62nBkC8z+cP4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819336; c=relaxed/simple;
	bh=+cPjqY91r+kyTjgnc2uWprMw0SJj6lsREL3a0ENi68g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hGL7M6FZQLiTBLxAGvCu/8Sxjk0Zxf1g+GvPoD5bLeA/5o2aYE6TNBRWxPp4mh60KQ8gAW9bfBTj0e2ujmfWLqfemedoDaXPUuY536sPNk78Q8+cuwnJ9gJ3dUVx7TTNVSR2Nx1mstJAjS8JOjRzjYClVwKIyYg8iDb4qcO0SFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csf8ki1j; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csf8ki1j"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50faeb8317bso99576371cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779819334; x=1780424134; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9wsWqSAQ3iywn7O12aH0v0S6qHwQnQLkX1oXRUrqkTY=;
        b=csf8ki1jb/gWZiuVYNtVCiXNN5BNT9CQGjqSPJwGbO2hxxgblyiHUxQTLuJva/S2lL
         O6wsnlKgPHz06+4dKfHqpioXyggyF6g0Z5dejaqqiiEioseUvkpnXo/9bNG3s9VJmAkG
         OWB3y7mZUT+O5++LsNN9HWqdyp48FaUIFdZIe9M7VEjySiimo8IVmS7oat6SGtHbTJa2
         QdmnjDeMxuI0J21mct9Jc2psvQD9L51nBomPWoNCTXsu2/L+2hnIngDksMcFucMt+BVk
         dV0vUVEIY3ESnjgsPZTr+r+WyXyzih737xQf4eRxlIDDjDghmTQjo0/b9l/vOb3WnCBu
         ILTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779819334; x=1780424134;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wsWqSAQ3iywn7O12aH0v0S6qHwQnQLkX1oXRUrqkTY=;
        b=FDfn7mDCzAZsAppkCH3WikNQ6PiUGyuoCDUaMNs2UHMhgfw1zeMvTWkln4D30911lB
         aFbmJvSNN/eMLtaWuYnS8WF1+xDJEAaA/TLWicWvsc+ChPaWBDvPyR43L0Xf35i1W7mL
         4BKfLDsGPyfhjkSoNeXzW5JjSYyDRmwmcby/Q/z6Z9ld4718P/vCl1pFPtsh72M+E9tb
         b7jzIKVKE29ky+x3oGXtR5wju+DN9flfStjEpH017w54fmDV+muwpPuXxLzzNwXrPekp
         So+507FVlCddbR9AIIgYy6T5sMLMXAhBF5IRPN0nXErvkfk59E8tyYdg+KQqXbzxwLHU
         X85g==
X-Gm-Message-State: AOJu0YymdteAJfNIUMNxCOKWEwgxoLA1QR01zQ+CN+XnO1vICzCe8EDc
	izmzTZHjrI9h/Z1iSemvpIiXAjsmJb8jFbd2bvUVwK5bchJqNkLjSUdwu8tuow==
X-Gm-Gg: Acq92OHa24B44PHtckKrYOV8JvnR7ZDHbXadDR9LpXA7qXjtgawr1v5KhzvOhUmkHtG
	eaqYAhppFJvcqVVjHfVIEafw27a1Lu4sqx7faeMGJ2KFUKconepEg9s16Yv7WcusYB/sbQbevGB
	WyqC7VfEt+IK7wlRaELfdL/MsSi8rzjOxFHl9Bk3FKGqqlpwArLLD5p18FP2AGgZzgN6OXkXwfb
	EELJq+lfbIe44dR1hOkpDuKJLcSMeHKcmILgalGg1xAk52sav8J4IElpdoLT0NnLgvtDjKnTttL
	Dp/ls6clcwM1VeCYqV71TmsIOl9W5bBm5bKxEapklrqy2P3GyMb5JGesbJU1rVTPdcU6t75xHdr
	RCf+NB8pOm+HnSWXw2kpP64J5hZzS27LcrNS/CXf/4IFGRaTPW/tdem8hnNVkXqY8QBUwFgLAdH
	vUGFBvFzci7pq1MG+NRSQZhxrsxAtAOG/5dcwZdxXE
X-Received: by 2002:ac8:5ac1:0:b0:50d:a6e3:ae1 with SMTP id d75a77b69052e-516d4419bd0mr275568411cf.17.1779819334123;
        Tue, 26 May 2026 11:15:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.213.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706a0ebbdsm24885291cf.9.2026.05.26.11.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 11:15:33 -0700 (PDT)
Message-ID: <6a15e345.82e07fa6.16346f.376f@mx.google.com>
Date: Tue, 26 May 2026 11:15:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5524844543371332037=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Add support for HCI_LE_Set_Host_Feature [v2]
In-Reply-To: <20260526170341.3529825-1-luiz.dentz@gmail.com>
References: <20260526170341.3529825-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5524844543371332037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1101148

---Test result---

Test Summary:
CheckPatch                    PASS      0.99 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      25.82 seconds
CheckAllWarning               PASS      28.25 seconds
CheckSparse                   PASS      27.01 seconds
BuildKernel32                 PASS      24.90 seconds
TestRunnerSetup               PASS      530.10 seconds
TestRunner_l2cap-tester       PASS      61.24 seconds
TestRunner_iso-tester         PASS      79.43 seconds
TestRunner_bnep-tester        PASS      19.32 seconds
TestRunner_mgmt-tester        FAIL      211.47 seconds
TestRunner_rfcomm-tester      PASS      25.26 seconds
TestRunner_sco-tester         PASS      32.76 seconds
TestRunner_ioctl-tester       PASS      26.30 seconds
TestRunner_mesh-tester        FAIL      26.01 seconds
TestRunner_smp-tester         PASS      23.28 seconds
TestRunner_userchan-tester    PASS      20.37 seconds
TestRunner_6lowpan-tester     PASS      23.07 seconds
IncrementalBuild              PASS      24.29 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.281 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.204 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/246

---
Regards,
Linux Bluetooth


--===============5524844543371332037==--
