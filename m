Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02E4231830
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363297; cv=none; b=Ab+tVGT+NDFx80kUm/jJRcPw/oVX7hHlqQ1/HHPvdYpWOHzMSvKWDKNKEniORuLamLqzCVXq7Ve0it8SfYYG1a1V1jG/euE+34xNm+mOuy14vU9g3bNJbWspsJtWNa5lYTfwPeRqg+l2zq5NCBK3xwp8L9Cd2y2aBSHNSIa7zAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363297; c=relaxed/simple;
	bh=by0RVlGxuICdO1GAwnTwo+mhep0P5Z7f1W2Ls7VVCbk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NlhQbKLbkesu+JTrNhFv629gl/hsNs6Yb3vAyxlta/ypIj0gVQJlJHGGbk4d9W5W3K91or59t281Dj13nx+tE53V4Q3R9iawmntWA7c2JhOmQWWTnjFSPBwfzNOIgi6aqbxpI2RYcO2wzTWXI0cdSocDki1d3JWIpcH23uikOIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2V9glY5; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2V9glY5"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50917e02472so46670821cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774363295; x=1774968095; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AswzHCiutsiv0QRxm0+c+wu0OjgdAUZ/H0YLydA8H0s=;
        b=e2V9glY5ktupUNoOMd3I98+m8lJBEhlrVqsazH7znXI6AMJ2zpoXNZOY0xY4WSYOxy
         S8Y/dbk3J98YUVUsRjfkcTbDLiM184jNxJujIfYA1TAebC4kWSZh2OppCVzggrOxrXlp
         PuT0I4F52jkX8KhA1AxLFa9uDSjJRLSdmAfjwcfPX8sFhTYIdJEEuSvQvEtDk6UlPf7R
         PVSB1+5hS1SiL/SLB+pCQacd36yfPrtfY7fV/eWXQvYgOr/R3bg+yRNROQhJKNWKCLxs
         qQ6JZUOArHeKkww0kV+eaHq54YGEcLdk9ijcVu0QIX7V+UXX5Iu6/pdol+KyH1Vs7trm
         V08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774363295; x=1774968095;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AswzHCiutsiv0QRxm0+c+wu0OjgdAUZ/H0YLydA8H0s=;
        b=ThUcBBH6dcK7/OaPr9mgEjOGrvAoUjh23WMF75jwtuKCpoZXIZOKuW7KtwL8bYjL3v
         HhgDJSEhm3lTHKpmUVeGwkpAKQDz7fSj1axom7lf68uevzbbxSMr9WWI4RcO/D4jT5cd
         cygaGKvwOkyQH24PkgiB0lDWoCIV4fuNnmeZAvw6Sw2ujD4K+1fQF8Dyq4MCKE1BpAo9
         6UyJIMOUQaZWla70jh9sFW/CXoVTH8KhZb0iilBfFU7qaq6clFBkRXxPkQyZHNbgqgAS
         6slJ4lf03t1cVDT2Ed2kGFPTaNOE6Hed1pcEJ9QwyV3nNqUFaOuguds6hAY/XeN4CwtM
         y7SA==
X-Gm-Message-State: AOJu0YyBBHsnr+EJROsy9nhxtsr/FL/uS5FWV3uKT6K4ZlV0QrzmljEP
	NqOHblDVa/ahu9XxVbXWqnCcLz3PYy9QNYWy+fMW7ZHLkkl4BT7k+QF8bRReug==
X-Gm-Gg: ATEYQzwUpqjOeKmyah5CN6f8q+Ntxc6fS9idkkESAPtHrRUqX/noLI0Su2GmJqj++BV
	iIthuBzTImaaorWj5UgPkwuKXQgZlJmehOxFgGGZltP7O7Ffxb3BOnOaLqh0I2YhlyizmTLZqQg
	QmiE/hT16GCd6zdn2Ln6/YbBaUUnCEI3AcYEKcvya/cJm4ty/I02P0HYlDZjE9LXRiNPym8mUdR
	wz+iHjmiIUhKuWioieqTAzOv6JHj8FoeMiZQ37EFMR/HEe0n+XwvmAX57lRlN+H+M9V3nvEfWyx
	2p8eGzUA4y1dtj1NRVXNHpHAsi4hMJuRwNqhPBhSYx1yYfc967VJl/wT5TNY1Uhy0/7qSEpPoBi
	F48sWrPMyeexutnPIo/z7cjd1AnaDhosL9+OXB51c6qQM9/3iwu1+cBv6WBHBiD2omztcowqKoO
	uFFuw85qFAj/Pgk+5zWVbFKMGQXqhrO4f2GLJbz0qd
X-Received: by 2002:ac8:5e54:0:b0:50b:7d38:9453 with SMTP id d75a77b69052e-50b7d389755mr13035531cf.39.1774363295368;
        Tue, 24 Mar 2026 07:41:35 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.200.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36e9abe4sm105705901cf.26.2026.03.24.07.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 07:41:34 -0700 (PDT)
Message-ID: <69c2a29e.050a0220.1e393b.a432@mx.google.com>
Date: Tue, 24 Mar 2026 07:41:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3758397112718159452=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, moonafterrain@outlook.com
Subject: RE: Bluetooth: btintel_pcie: fix off-by-one in RX queue bounds check
In-Reply-To: <SYBPR01MB7881B5254647551279894DCDAF48A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881B5254647551279894DCDAF48A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3758397112718159452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1071681

---Test result---

Test Summary:
CheckPatch                    PENDING   0.59 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      27.00 seconds
CheckAllWarning               PASS      29.30 seconds
CheckSparse                   PASS      28.00 seconds
BuildKernel32                 PASS      26.06 seconds
TestRunnerSetup               PASS      578.23 seconds
TestRunner_l2cap-tester       PASS      28.23 seconds
TestRunner_iso-tester         FAIL      37.46 seconds
TestRunner_bnep-tester        PASS      6.51 seconds
TestRunner_mgmt-tester        FAIL      137.01 seconds
TestRunner_rfcomm-tester      PASS      9.83 seconds
TestRunner_sco-tester         FAIL      14.82 seconds
TestRunner_ioctl-tester       PASS      10.45 seconds
TestRunner_mesh-tester        FAIL      12.67 seconds
TestRunner_smp-tester         PASS      8.82 seconds
TestRunner_userchan-tester    PASS      6.89 seconds
IncrementalBuild              PENDING   0.51 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.112 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.204 seconds
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
Mesh - Send cancel - 1                               Timed out    2.724 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3758397112718159452==--
