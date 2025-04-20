Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F6517E0
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Apr 2025 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745119010; cv=none; b=csSQ5SerbbmW1q3ZrmSqz+d8AHUOdM8AFWN7H0JvvVqvxFAcZwPd8uQL1X1GQiMX8AMJwmVhs82t8R8mg6j1ckPyOk2UYyIs+Hu1PqzSo+tKmAeApzBYetzt5aNSYH8DURp6tXjEGjIjCKW1xVQqBdYLEsCB/9o1TUoos4eJnd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745119010; c=relaxed/simple;
	bh=J+2l5MWnEoHpx2LJPEGokCZkykWGekD+rtWMyyKQvSA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H2R2AHf9fPFfzm6R+JoEcQCv0G5UZYV+XHCm0k0KRZHrCqymjB5XBOVKa6wFbBqRTYgjsi7+meRwazEKCNws6KB95Mgryuj7zbj8T95kRlIfGRQENETgzchm21nty1z5kZzTDX9P9ArykJ9RRz5eQ59SdjlLs26rE1/73cXdnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqKbLgTw; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqKbLgTw"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476a720e806so27143781cf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Apr 2025 20:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745119007; x=1745723807; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HEyccVCfb0tqhVyKLLabcPIxeU52wX5o5DUQ/+uglAA=;
        b=nqKbLgTw2h0Z9FDceVp44SNBFUSZAp+eNRAT2QNMLQ+kPzyB5AUeVzRrQcl8BQ9a1p
         4MEqPrRmcMw1AD4LZ0Bb0gu+8We8NYEnP0lbW0uhZ4Nl6rVw1j9UFXSZWV0y74jws8g3
         k+sp3wXaw+ReN8t32lupElQG/uPUc8F7IOaX+5/iJ37a8zf3lCvwbvkNZaiDbRTN+byz
         NwQN8uAtrDoGcuvfoFjeFsBg1Z9xrZ06p0qxqwggV9HghUxjniY76uUlHWuI3xmmpV3Q
         /R51XfZtNoX0X5TmgxC9bZ2rj1vUB0wOGm774veMrrKzVAypVQD/XcbQjeUN73k15mfd
         TFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745119007; x=1745723807;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEyccVCfb0tqhVyKLLabcPIxeU52wX5o5DUQ/+uglAA=;
        b=bkendJ3QHjTSzb3TsnOf46Rx2hHL83scVpReHxkYN/bHcxYx1bCCFzLScPbhJXB2Rt
         EfVdVBxeAL76Z3fA/vNEYpKGhU5BL2vQGu5x3Aq8fFI679q2UD0A6nT+6aruT/JwAe5z
         qDEBOKmT5gAcUQ49KR3WBOaGcKshi8CoHEpmLxBli0Xz6TJbc5rLYi4h1CWNFPS9g6qX
         vXx3NCSskJ0Dm+TzIjKsIC/PAZMlMECb93wwZQ0ys/cMTMtUXxQKWmGol7Tb91aRWrO4
         gEiWGQUNTqoozKI8au3q4yiw73wVY8mIw/DAJ/ijhnrtXs3dBrgiMOeY6jHAQ895S35U
         8N/w==
X-Gm-Message-State: AOJu0YywYJU7Spyvcr4HrMCJRDzOQBYRsPbVGHj0re3aCzRKanJSwuhY
	N5cVoTkO3tECfYL5zsmK1aEI/C3xzqag/6RvVZkTofZKI4AsUarsx2DGwQ==
X-Gm-Gg: ASbGncsuIJWqisaA4MoHK4ZwyMHvaCsrrWFvgfsBfNfhkJAhGj3NVopv12nruvh+rZO
	IurBMCDDEgZLqruyK9srntjw9Qug8oG7C9BbB98zMrOZcT+hGNtkIwC0UfaqWf/xgpjpldiO+NM
	0L6C9eW1yPHbUrT9M4oeA6LG1W3RR4NlWmU5xcGekntmmOzoasZOOneGOc/xGcG1xekAqfbjshU
	36+0g9dj+o3dJRWolPvk8rq+qXpKRZ20+BpIw1+46axMWcfqGkAuDDWkUsGOilqGXEhgLF4aAnR
	8qt3nKtwVKVHy8GdFaIAJVEFWRZthTVxYUxvxlgl2Cr9
X-Google-Smtp-Source: AGHT+IH8bRyD6NujYXGG4CJ/PnuApcVoOF2Q6jQEgxLXTEFio8hbANdORQD11fXef1jkFB0e4asBVQ==
X-Received: by 2002:ac8:59c4:0:b0:476:7e6b:d2a2 with SMTP id d75a77b69052e-47aec4b6a13mr129395691cf.35.1745119007315;
        Sat, 19 Apr 2025 20:16:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.79.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cfa3f1sm27268991cf.79.2025.04.19.20.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 20:16:46 -0700 (PDT)
Message-ID: <6804671e.c80a0220.30bc3e.9692@mx.google.com>
Date: Sat, 19 Apr 2025 20:16:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6972654437301781912=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Add additional to checks to clear TX/RX paths
In-Reply-To: <20250420015156.192605-1-kiran.k@intel.com>
References: <20250420015156.192605-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6972654437301781912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=955133

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.17 seconds
SubjectPrefix                 PASS      20.25 seconds
BuildKernel                   PASS      24.03 seconds
CheckAllWarning               PASS      26.61 seconds
CheckSparse                   PASS      38.60 seconds
BuildKernel32                 PASS      52.23 seconds
TestRunnerSetup               PASS      453.27 seconds
TestRunner_l2cap-tester       PENDING   58.88 seconds
TestRunner_iso-tester         PASS      54.56 seconds
TestRunner_bnep-tester        PASS      8.93 seconds
TestRunner_mgmt-tester        PASS      144.75 seconds
TestRunner_rfcomm-tester      PASS      25.02 seconds
TestRunner_sco-tester         PENDING   68.30 seconds
TestRunner_ioctl-tester       PASS      25.44 seconds
TestRunner_mesh-tester        PASS      24.48 seconds
TestRunner_smp-tester         PASS      14.96 seconds
TestRunner_userchan-tester    PASS      27.20 seconds
IncrementalBuild              PENDING   0.68 seconds

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
Test: TestRunner_l2cap-tester - PENDING
Desc: Run l2cap-tester with test-runner
Output:

##############################
Test: TestRunner_sco-tester - PENDING
Desc: Run sco-tester with test-runner
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6972654437301781912==--
