Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B3C2E3719
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754424102; cv=none; b=sxO+psWTYB/8M0darcT8EhSiwpeB4noK3ZnT5wityDqqmX+3PLYIt728sb4oj7iYr/kzBsudaXIngYRh13nsgOrOoYlWFLamWeF0qSHPkHG4MaZcMQ7bxxYb3d3v9oacC4QhfMmWVcoYJIJJRJ2cSYuVOJ/sX9tFL6LDk8WG2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754424102; c=relaxed/simple;
	bh=/4cZKMDJc/27D3FOygnUJdcCykNC4jS/H29pXhcgXkw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QXw0a/QVazlxcIuEYG3FIaL89ZLl2LnGz2/plh3eyF9Of9r7KrcoT7emuPkDWFkCmNKFkYoDSp7330/3/zmTsZ1fVA6h05gzgVJ5j7V8TOnecc07nHUbu2M4Ul+7cHGUFAa9kT2Q9R5eGn3dXF9Q6GoOyPGs1TthAjS21fSfFCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSK7vKWP; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSK7vKWP"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-88192b5c38cso84088639f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Aug 2025 13:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754424100; x=1755028900; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dD3msLzpezPM4pac82LQd+QKpUQY7BcrTMzLXoudPWc=;
        b=cSK7vKWPIB33ICOYw7WYALcfds4UYjytSvIA6fGvahp/7k0vspSSIDcLxO+p+UDbtM
         rAHcUKlXmQWA+ly2eio5G56xG4rHrEbBtPZGMoXBm+TNY9/L9/po9nzhsFd6zaJ/rzHo
         iAoPWs+ubvbs8mTZJWw+0s3eqjAj/01jdl2oaoWcfbbkqM6V3LTv1NxUXdMGzLmrMpf5
         hIilcKKk4sRqMRq8uJfimIJDdzgX4iixyEXbG6QFWqnnbMI+ff+bSw3rWg9Xp6fRUrC3
         2f4pelcwP/CICfK+LRkR/t3j/XfnvSp3qZk1qC84h+c/cy+iuMxGPOtGIus3Xieo6TCq
         haBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754424100; x=1755028900;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dD3msLzpezPM4pac82LQd+QKpUQY7BcrTMzLXoudPWc=;
        b=B8x2TZLkmYLcfYAkdcOsH0udu+tHKioG9JVdSO8GJWK3Vb7r7zeEnX9w6j9oTqNjBZ
         cgr2ofrlSggYandu99OoW3kDpYvAYeRZD3reP3hJ1CZ+9jEcUEqZ1kXWAxBYsFjeF7m7
         kxwSRwmJ4KnUr1EXC/VGeWzcqzBzfXbkBBQWcQdL55G4rXmfwPy1xN/dKym5M0ays6Q9
         5KSHRK3PwMB/p7rBDKrQPrLLmOui1MOuaGVMrz0gdyQSqy4Y5Ywrt3zkYYU3Z7wtpQDW
         W0eZc5eDciHADHvtNZW8Hb450MikgV0SAw3SGrKDn2MlhDEoQv3G0XXf5njsCNu6lbLz
         LPUQ==
X-Gm-Message-State: AOJu0YwVJojI89Uw1K1A/Y84kAzufzOYBR/oy9LI4LPuuXfA4biJyBi+
	+Ao3fsqH8k24+2Qr4ql5QkzsfDQ8Nq1LQam8/SEAmvnbrC2PUsfzrRx4nDbHqQ==
X-Gm-Gg: ASbGnctRoLgioJf+v9iPLxRWJ/7bYpWrJ0Cy5yRgT/AuP9Rurx1TWsy47tm7qjam0U5
	zHK/qtXilkMewgJAyLEEgSNKEgMTKpcZaiFlLsijsT+MLfaWnV79MNl84re/cKsHw2eRY88Lqqp
	0cjDl+RAth02DTdW2PP7IjHidsGX2AVr2iKJJ2TAmP2Ztc205115sagUAFgA1QhjyBS0qnA/Mjq
	MO69kVajPremhCt1OBvnYsKiL9pNSyptJDrwv4d08rhz255zH3rx7ue0mMfHb1Ev2cq8PNpKnZ7
	pMwJETSncv9+R5pXgl66jHkZBc8oR+Syg0y8AjQqSfgC8dKlbTcgc4cRlLS1rnzXuZirYHDCpsj
	j5k04UGQjjPzFZWn3SZ+QzN3J8kjV3lwzmm3GnPh8
X-Google-Smtp-Source: AGHT+IEHtPhu+QuPQ6rJonKIYJA0DeAefh4O/eFKO0NfBtWZ8kiHiYsKg/ad6RsgJ82GkV8TJxYEFA==
X-Received: by 2002:a05:6602:3d3:b0:86c:e686:ca29 with SMTP id ca18e2360f4ac-8819f029ae6mr32573139f.2.1754424099597;
        Tue, 05 Aug 2025 13:01:39 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.124.180])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-881990bac9esm41849539f.18.2025.08.05.13.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 13:01:39 -0700 (PDT)
Message-ID: <68926323.5e0a0220.2b8609.1a5b@mx.google.com>
Date: Tue, 05 Aug 2025 13:01:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4632471459883196787=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, s.shtylyov@omp.ru
Subject: RE: Bluetooth: hci_conn: do return error from hci_enhanced_setup_sync()
In-Reply-To: <14e5f8f1-1f93-461d-9cc7-57e1f0b57911@omp.ru>
References: <14e5f8f1-1f93-461d-9cc7-57e1f0b57911@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4632471459883196787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=988539

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      24.24 seconds
CheckAllWarning               PASS      26.80 seconds
CheckSparse                   PASS      30.20 seconds
BuildKernel32                 PASS      24.01 seconds
TestRunnerSetup               PASS      476.35 seconds
TestRunner_l2cap-tester       PASS      24.81 seconds
TestRunner_iso-tester         PASS      35.96 seconds
TestRunner_bnep-tester        PASS      5.92 seconds
TestRunner_mgmt-tester        FAIL      127.08 seconds
TestRunner_rfcomm-tester      PASS      9.32 seconds
TestRunner_sco-tester         PASS      14.70 seconds
TestRunner_ioctl-tester       PASS      10.29 seconds
TestRunner_mesh-tester        FAIL      11.41 seconds
TestRunner_smp-tester         PASS      8.61 seconds
TestRunner_userchan-tester    PASS      6.16 seconds
IncrementalBuild              PENDING   0.78 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.185 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.161 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4632471459883196787==--
