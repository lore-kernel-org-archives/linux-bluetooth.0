Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398D92C21D0
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774793409; cv=none; b=knwzoBkgWWj7Re/PRfsfbLbWblDnRnzQX43Zi57c79bT2nGbGpkzkVK/I9JLHcC2dnsafpl5KAHfwAQW0E0h34fWVjpW9Fnzh+TBlzFTuiuZFgGiLmeFXsr9AnsCmjPdLkILyu0MRLujJpfK7c8IvZJpr6dw1GqguFrkLPQ6hCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774793409; c=relaxed/simple;
	bh=LJZqDg/W0W5AVVyvC45Bwsw7/34cGnqIBmr00V3ta5M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ERkUx9el+OF73pdXMSRME9agDEQ7SnZc6OCjmaf6q9H9XLmjzhufFU+fMpX9C6K+V2EMQMfrVLlLYsnT5HE26YG75FLGBuyeKH2MJJ0fgtEfFqqxT5Vz4ljgi5Z+GnmCryuQQnfv3xVP1kRw8zR3HhYiI+D8dufYimKkixo3bww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRFYY4Fz; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRFYY4Fz"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-509006c070eso28751761cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774793407; x=1775398207; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q7wHTmahME+ey0dMgrH37iVi6qE4m/EHYHeKrm//XGo=;
        b=hRFYY4Fzk6fnJUz4rV/UAelUFxid94GNCsANmfx6zgYj/9XuMpMsAeMaZ++0IUDnmF
         HWg6mxu+/MZ7rnql4VV2MRKsPn9X89LjJANmIAqXzvcwpeZ2ohs8MxIkyu7gvxEPrUE4
         xIrI+2r9OMXNpGwW5tYmQbUi2Bz0G2Xmh4X7MUKX+cOu5Qk8gEQp8yXFnr3k/uxHbcg/
         OmINpCwZUHli0dWAuywUShBYBE0qPVTbMqm79E3+ByV0lSX1Il2UwLO6IBujPeaeNznE
         jIIbadBqhXqtl38xOU1OB+uOWaolDh0eOcXQrjCnXvS4yazSfEmXWVoecpkpKYe3F10q
         6Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774793407; x=1775398207;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7wHTmahME+ey0dMgrH37iVi6qE4m/EHYHeKrm//XGo=;
        b=E11A2hCxWZMcvmaebVVamTO9/cmQ0Vhgwj5UziNZ0YIs5kooHED+jaTYIWQ8rr50Og
         5oT8aG3JkGUMhYeilS+aCUgkRnrP0p2l7Fvl++pKNGF+Ps9edRV2lEsMFINJLAaXgzI6
         x61QKgKcvOWicVZ0zWM1rBLI5Z68k4PcblXSZ5MpPNxv1ZnOXH7BETFcCnM+qk+RcMPj
         TeKKR+S8lPCyKgPU2Kt2y20rfngutU2F9V0BAdGYAjJ3OiRev72e9holVm6XpKaNNkyQ
         jnx7EOQu5+8vXYoSCjJGFBThZeNgqrBmfiUmN0QuAdUQA9+ArnvgE9g7Un/vTiHIOaiQ
         dK/A==
X-Gm-Message-State: AOJu0Yw6F4NxOAFl8xqSjMn9WgOhN6MGHNsezizVQHwG9OUMcOyxY9wW
	p2zQ8QoTs16BkMIqeg8xXUO8IjekQs35cb5MYcU29WNKX9zJZh49ysobxo0oVQ==
X-Gm-Gg: ATEYQzwJG4IP/WlfGM3Xr4+k3P231puHXhgkrg23FdruzcCLAfLNUXEbS+QQwiz+s2v
	u2k+KE14NQ+UOVtzU3VuPKrKWja8ZuRbqEooRUm93kRtxLsCvvfaKm3vgOqNIApmKOOp+ybRiTP
	04GxRjk4Y++You28I76mntV5Ejq24GnfQkIyy8QA+fBZrzA1EnTHqtNzADdfaclZ7w2rIBEu5HJ
	INmjxkc6neputKbivBtR8El/Qa607ameptv7C7pC97m+xikBVuq8maETj42f9zGVBVTve+kZB1K
	Yrt+KYZ95E49qYzVBcIoy8Jl/q0UJMyC9RLKSDh3zo5A575wGtlExhHAmd/eXEgd2BhKPJ+n0bM
	8QtE96SfXsUOuncgmGd/ekjysqCfiBFCcqOX1yBYa2ow9IGD4QIEGbYWH207ZgV//U3vyGIZQRj
	TCbvE8iWSO5uazeseTbi4ocLquLklUPg==
X-Received: by 2002:a05:622a:1ba5:b0:50b:465f:708d with SMTP id d75a77b69052e-50ba391ad15mr128723521cf.45.1774793406901;
        Sun, 29 Mar 2026 07:10:06 -0700 (PDT)
Received: from [172.17.0.2] ([40.116.92.116])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb399502asm45303681cf.11.2026.03.29.07.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 07:10:06 -0700 (PDT)
Message-ID: <69c932be.c80a0220.b28d4.5b33@mx.google.com>
Date: Sun, 29 Mar 2026 07:10:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7100876138040611428=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v3] Bluetooth: hci_conn: fix potential UAF in set_cig_params_sync
In-Reply-To: <5d61842fafed29f489f472bc6cb324e41f568083.1774787573.git.pav@iki.fi>
References: <5d61842fafed29f489f472bc6cb324e41f568083.1774787573.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7100876138040611428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074197

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.40 seconds
CheckAllWarning               PASS      26.91 seconds
CheckSparse                   PASS      25.60 seconds
BuildKernel32                 PASS      23.81 seconds
TestRunnerSetup               PASS      522.92 seconds
TestRunner_l2cap-tester       PASS      27.66 seconds
TestRunner_iso-tester         PASS      33.42 seconds
TestRunner_bnep-tester        PASS      6.32 seconds
TestRunner_mgmt-tester        FAIL      109.10 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         FAIL      14.08 seconds
TestRunner_ioctl-tester       PASS      12.19 seconds
TestRunner_mesh-tester        FAIL      11.40 seconds
TestRunner_smp-tester         PASS      8.46 seconds
TestRunner_userchan-tester    PASS      6.59 seconds
IncrementalBuild              PENDING   0.67 seconds

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
Total: 494, Passed: 485 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Adv. connectable & connected (central) - Success     Failed       0.124 seconds
Adv. non-connectable & connected (central) - Success Failed       0.116 seconds
Ext Adv. connectable & connected (central)           Failed       0.172 seconds
Ext Adv. non-connectable & connected (central)       Failed       0.175 seconds
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.817 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7100876138040611428==--
