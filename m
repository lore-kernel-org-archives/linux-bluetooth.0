Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B5B3491C4
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774730687; cv=none; b=mQwYYsbwfpB2XJSi9qWpRRMz7XKV3Jo2yRVa5WqJnxFUc5VlkOCwbrE8lRslcsRR+Fzpg1UgdofyWmkEdoFoAIQBGn7OFJmlDfjLvU+R+o4gJ3XHXAcm5uRxJ/dbzxLaXn+SDrMNbQcXtGgC1pg2x8AmzkbyPD4Maa+3pXyDWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774730687; c=relaxed/simple;
	bh=p4ZcyMd0hZPdyDbNwf4U1gdUJLT7P1at71hHJddjztc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rXdCdgIW57ghLIls5LulyAMg+W295N4QmB860Wgb6OqvWt7pFkq9FiyeCHCu+GI60yX/ubu0nJ4UDWCYMzJrK0o55bd1meNn9q0aeU7R+wusD5ABPBvfq0rgXtwmOvz/1328WXvqFyejlmLI8pN/bv5H5Kx9Cj997/zdcV6ETRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAbroS2c; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAbroS2c"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899d6b7b073so41698176d6.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774730684; x=1775335484; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GmSpGmfMjTNz4I471M9iFD9JC+NxFr+xy0dJLmZrNYE=;
        b=WAbroS2cm0Y7KzhOf+qtwcAnkZt1VuZg5As+HkeIwB9bQe5FxdYQdrcg29jy5U/Z59
         K7g/x4iYbTaOfwmrKR3dSLZuOx3DSxsMgKmSNJ0iJfoUyCK4oGmCmXd4d3Edj6wyaBwd
         LwfAe0f3+Jhwu8KxQIZJv+yK0Xs7+4GLKCUxQcMyxfqhYcDLzGgZjpa61MRxvA8tllwp
         1zjvViT/CfLjsXfCui6DoNP07bZzkjAx1lJQ++2WPBwRQ0Vfp3hxX1FrnBVlnquZG9tC
         /D35zqwjGwJQUgU/sXUtLTO9hLWmU9T+46i68sTwJcMdD5fkAYQf4Cys1wQ1g0jF8qj9
         teVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774730684; x=1775335484;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmSpGmfMjTNz4I471M9iFD9JC+NxFr+xy0dJLmZrNYE=;
        b=RaHkNsBG+Gng/HrFrOn1Rc+apC9JnNboskWnLmgq5lRsHeA4VjEsoyrf9/jobkPtV7
         vHYO2/9mnwQwtSqEjsjP/hWyBGVFphP9RPqRJd6qkLssReRPVcpGQglaxcyeH2Qgo/lr
         1VB/zh8GsQ4tD3LI1DCTdKdkikWkEm/AB17RPMuTL5M0O0yzs8q5zW38u474w0vygSKt
         Nz6YlIE2lA/O3H0AsnOmbpIpqB2u4YBZZz/lyQT7udLPxZOpOt1jOWET3nYPjDJhF3lr
         lLOzkQnMpeynHNSO6K7/9j+6XAUl/TlHM2fpvQXJfOTKvkXiLb8KAbDESYZEu7pWDHtq
         itog==
X-Gm-Message-State: AOJu0YyNngOP+mAyo39gtQ4o0GEFeKuL3UEZaNTaD3ybNuhzdwm1PV4+
	nSAbn5OBKbuPUS25mA93r3U1zJ65hX+w8GGh4RNLfIFfagSKarp0EgHh/FiJuQ==
X-Gm-Gg: ATEYQzyXn+LupPpS6iqE4y8J4Bmt4uxH5+wkrq22Oq7cIhDOpbtxdYIx/CvtY7FSwXl
	kfLS1+wHelYuSOckHoae1IA46PDRND9TYT3yLSjbAe272PBsO5qbdb0Tik1ufNxfBluBhaDeIOn
	t9nraSVGwZFDmDrDaK+OWGIPgZLc6NCVVWa6xTtvPEhcspyGi3sPdPrrbBnjPzeoi1OGzZqccyP
	k8M6phk/P4eKRbZT5X3WZF7bsw+Ij+9HEtI7t/PaJpo9D4Q44MxhImAMy5Oq/CB6Qlz19LUwuE7
	LZcCyy7Yb3K+F40ZyQ27XQ9JiT5ev4bCchM9hkDogsyGrsxyhItySgmPDAlNx7OvRmvMaSYNan6
	a7tsoEZnPTgc4ObMuHr3y5AW7T200zz2PyWbJRrmaG0enmYsFq9uy9INURx5AiaZSyqFPr2YD3b
	dGEwNRGgZXGdVVvTzSkHrMVzf2TrHjS9tzJgrZVW5s
X-Received: by 2002:a05:6214:6005:b0:89c:5c57:98c with SMTP id 6a1803df08f44-89ce8d3b820mr101895986d6.18.1774730684482;
        Sat, 28 Mar 2026 13:44:44 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.53.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ed0521d64sm23501826d6.49.2026.03.28.13.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:44:44 -0700 (PDT)
Message-ID: <69c83dbc.0c0a0220.16f3a0.cd9b@mx.google.com>
Date: Sat, 28 Mar 2026 13:44:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7345722169824134518=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiaoguai0992@gmail.com
Subject: RE: Bluetooth: ISO: validate ISO_END fragments
In-Reply-To: <20260328200938.140528-1-xiaoguai0992@gmail.com>
References: <20260328200938.140528-1-xiaoguai0992@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7345722169824134518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074052

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.03 seconds
CheckAllWarning               PASS      28.36 seconds
CheckSparse                   PASS      27.30 seconds
BuildKernel32                 PASS      26.91 seconds
TestRunnerSetup               PASS      567.23 seconds
TestRunner_l2cap-tester       PASS      27.98 seconds
TestRunner_iso-tester         PASS      35.49 seconds
TestRunner_bnep-tester        PASS      6.46 seconds
TestRunner_mgmt-tester        FAIL      114.56 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.27 seconds
TestRunner_ioctl-tester       PASS      10.11 seconds
TestRunner_mesh-tester        FAIL      11.42 seconds
TestRunner_smp-tester         PASS      8.63 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
IncrementalBuild              PENDING   0.53 seconds

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
Adv. connectable & connected (central) - Success     Failed       0.131 seconds
Adv. non-connectable & connected (central) - Success Failed       0.129 seconds
Ext Adv. connectable & connected (central)           Failed       0.180 seconds
Ext Adv. non-connectable & connected (central)       Failed       0.184 seconds
Read Exp Feature - Success                           Failed       0.115 seconds
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
Mesh - Send cancel - 1                               Timed out    1.875 seconds
Mesh - Send cancel - 2                               Timed out    2.001 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7345722169824134518==--
