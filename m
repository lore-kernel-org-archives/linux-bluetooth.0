Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD6C28F935
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774008788; cv=none; b=O4KOYKRsVOGrsAD12fsN2I0MTm6NwdXGloxvhrwVBkmT9/rEDIl4q401JANVYzROcFDFsXB4MhbJ//aeCHYcT9QkDjmHSvUBmKXdHwqAVD+pmQDFfy1Qd30prLCzgLYY7aQcWvvnw9LYdQs18ImVH3lzNiNA6aGPIpKbJ433IiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774008788; c=relaxed/simple;
	bh=GG49QXGzBAWf2YVz0BH/GMacbSYud/MYNrEnX9gi5sI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BykE13iJ5UWdSAc6PFckddJKJHqo80T2Hp2DaAIMYIDtaRhx8U0V8PJdD1h4kduQ1UxWUabUeX71xgi4N1uZ6WU+KgvBb4v+A8ZkfULyvN8UYEzqUhjr5vaEBLsSwiqiaAc7mcgF5IYRADhROWmxyl1lPL+Awq+BBoO69ACzX2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRnrRvUd; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRnrRvUd"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so485523eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 05:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774008786; x=1774613586; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Preq38qXAC80ia9QyMAZZG4gbBx0Ab78zbNe8yPBA6g=;
        b=WRnrRvUdI3UrmG5UJQ+Qj6fFqq4o5dBAAMVluWlzRgKiqmUJqgJM6ihDYHaIC/9sEE
         5vEL9o1TldKWwezJ1qtxq8g/bTSWE6EDiDeaw3RtQbGwschR8fUA2FyE26ujefaQW6uZ
         2X0xfGz11B0dQs37tDgA/O9hJsuUe3HPBYv0t1hmuyz+lc1VEmRbjdsjBJCcLlqhaLa8
         zY8uhGDS2djZpWykUbINQ7UWXUy4L8sq8cQQkCVPCIecAnG5Hn4CfpfbFsXUoCXlefaf
         oXSRID+fnnpTXEFL+OcKzJ+ptnUBHk+6TYN1BMk7agjSe24jqkreWpLW7MYFJBsITOPx
         qgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774008786; x=1774613586;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Preq38qXAC80ia9QyMAZZG4gbBx0Ab78zbNe8yPBA6g=;
        b=Fv7nwbFiTdFj8+eNjJv0HIv8Thp2FqallMJjvajg2xFw1TrMiECqQJYYhWn+b8YgYY
         ygohxwf7U03tU539nQq13Eyc5mEswn3q1weZXrbH7nyy6aqrc/23yE3ixzlflAenCwZb
         2peSdFSpa/Nxd68Z41vBjIohvKYh6pMlTWzSGX4GOfJrfI2pzOS5aBxzurbxc780HBo4
         pvVPgi9fh+2ReeJvPS9y4T3K68i4cAXlt3bZCmcACIjSXccHwDsSkNk6Qbw2lwpxJpDV
         QHwfc+ijtbw5Msnk4CC8ei+03gA1VGvCu1B5WZy2vbl86ERJqXETEBzhm8wZu4sLkTyL
         2vbg==
X-Gm-Message-State: AOJu0Ywnq5mRdf2X97WuSczg3hr8+PaxTUzL7H+B5MvEPy1TxBh92GSZ
	wi1/rzuOaAjMPIR3mos5HBuAtloMtJIqlv7KZ40TsoxddrqfKIxT+mxrv+0IPw==
X-Gm-Gg: ATEYQzzGamhnDVw7O6IeYRQnx7y+NGB/RKmE7GBx9Ne+fqNFN3O5hx1Do4cN7I6jvoW
	cgfdGXYTXH1LYZVhg45d8Wl0eJmZsJopFUfq9Mqew1Ayi9Z7LZPD/8VTTuwz0AR+17MCUnZCtZL
	KlYes1rF6tF0wSzf0ukHqWDonhv+KQ9RZ8JKK0lcLvA4WFBOtJ/POL2hCpyY8KEbTnGcdLCfyye
	vYCvYrYOVLR7kxHmzl+aqvo6N0AHrhhvNXN3LW/54ONRltghN3weEd/kbO3BPTxUUfDPxbQeq9U
	AMgYbUnqZ9P2M1wBUQW9GReIdHMFaZx8VhcQ4yViM2TNprzPXAYZybvLvf/PE3GV66QDhjUr0Ca
	g4tgV4xO6TY1qd0cNL0lv7WTxhJHCd6CK1f4TFJDdQkgh73e+2SZtPKf9dUIaKV9/q0/nOcbpEs
	4UkqEVwQes0To88RlTIQYsvRCigDXdFQ==
X-Received: by 2002:a05:693c:300b:b0:2be:1f56:ed21 with SMTP id 5a478bee46e88-2c109563b70mr1191482eec.7.1774008786198;
        Fri, 20 Mar 2026 05:13:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.107.209])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b3253d0sm2864368eec.29.2026.03.20.05.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 05:13:05 -0700 (PDT)
Message-ID: <69bd39d1.050a0220.2fc010.39e0@mx.google.com>
Date: Fri, 20 Mar 2026 05:13:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0803608494599050079=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix use-after-free in l2cap_chan_timeout
In-Reply-To: <ab0yX61gGSlEaMEF@v4bel>
References: <ab0yX61gGSlEaMEF@v4bel>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0803608494599050079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069866

---Test result---

Test Summary:
CheckPatch                    PENDING   0.51 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.16 seconds
CheckAllWarning               PASS      26.95 seconds
CheckSparse                   PASS      25.53 seconds
BuildKernel32                 PASS      24.06 seconds
TestRunnerSetup               PASS      529.75 seconds
TestRunner_l2cap-tester       PASS      27.60 seconds
TestRunner_iso-tester         FAIL      31.87 seconds
TestRunner_bnep-tester        PASS      6.41 seconds
TestRunner_mgmt-tester        FAIL      113.73 seconds
TestRunner_rfcomm-tester      PASS      9.41 seconds
TestRunner_sco-tester         FAIL      17.75 seconds
TestRunner_ioctl-tester       PASS      10.17 seconds
TestRunner_mesh-tester        FAIL      12.43 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.67 seconds
IncrementalBuild              PENDING   0.80 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
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
Mesh - Send cancel - 1                               Timed out    2.699 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0803608494599050079==--
