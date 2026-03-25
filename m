Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5C221FB1
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469027; cv=none; b=KA+7hvOsEtplo35kdthllE5bzd645OINrRtMWOHSZJh6lP6CRWbUcVz2qiAAJgtu+6qHtyML4/jMzSq4jLEQBXyO3Nq1CxQMVVXsSN1ueifQbiwkwcC+WCGX5pHUn4d43z/PkIX9PkgYNBzzQPNL+1uewbrrlVqEa06iNqeeY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469027; c=relaxed/simple;
	bh=0MwkOAhB6YnqF918GWz00CPJYvrTpb5o0Yx1hsp6qsM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h6ixIok+ehrgvcWZS4q3THVfmdGQUPGXUiWhAbiVlruDOz9qKBaFQZxlOf6qJb7fCYAAxdcuVCNL1CDD1JKNRGZZs8eIfjZQ20pOVDem8LqPD6O68UE5cM1eF6N2jmD1ulLu7xiSO77UlZPIK+UX7a2IDsxnw7kYQWjF6FM/aVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWwWkX+J; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWwWkX+J"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c0bb213b16so465302eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 13:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774469025; x=1775073825; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tKwcBcPuzYgwoYI/uZ3zHUUQ1ME+ahdKM70zSlZaoL4=;
        b=bWwWkX+JfIcdC2S+ZOJmvkZcsw2wOl9Cw/xosq+PEkL0Cu6rQQOQgdaQfA+zrdJgVm
         QOjcfVRwNxjVmqm7eAi/biRuDTsP7hW/vYF4cpzQnZSVebbITSdU1HFAvfjg8l68K9Vu
         PcsI/R8KIdYQvxyXl2Y0T5linVpsXtKy6cQ4HM2XjReSzUBNZPFtARlXFDJRKFJgHYZd
         aJriGCEd7VqeK1magiKX+GKWmkc0B88QPE8ZykuU4LNzkL5Zeb7acv41quKt9z2qN99O
         2Wk5Ihjt+WTF36nzyJ7cH8VtkcRSNLkAL2C+v+G4YCbZOzL6kl7wKtSxKcYCGrGynh8Q
         WyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469025; x=1775073825;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKwcBcPuzYgwoYI/uZ3zHUUQ1ME+ahdKM70zSlZaoL4=;
        b=TtdyYUrqcSOGxCUW4ewweheu6pTiDKMlA3XSUV6di1iklnDhlwCh+TIeiqeunJ4soz
         S6lDNQIENa0cyZFzLae/C7vUi8Ke5/FSLywBzT8ASUAV7EQGKS/n2q3K6Gvu9YBxk3tv
         DmCg36jLwb6THA4BAGgmWVAY3/X6ksSEaKG4vx5oS1ZdP5FwhKRsfq0i8EA7i1SA6eJ7
         vfegEY3wI8XyxKTbYC9Pigwy86Ntohk4Csk8nm4F8SiDKWYbmkjeXvjWVN8tOKDFiVVi
         8lijScl5TiJLiA6uX5+LfuE6talT2/Sq6mxfVbdmtnqVwgAlGGj2Hp36P8GmRaPiBXfV
         Nw1A==
X-Gm-Message-State: AOJu0Yx7v7WBEkJNmLIOYyB3NH9DabxN7EsvoaVvfj2aNtvwrSpQQ4to
	2j1I2RcCtOhBQt52DplDK9G3z8qQCoBneV+CqoR5pG2x7KanHrZtkS6IR3WjaA==
X-Gm-Gg: ATEYQzzXsBMKL/rEiGcsqEC8aaBdjxjzoiDvRg+0GfbxM9VtX6JYW2E0K+HzRyY05cj
	zVI0nnvBpv12QHjX9TCDh6yrIfSuhOFzqTz+L7cLFnUqz8aG8nwVqVhwi0uJqmVFuywC9RcOecP
	iv/mXMJYiBN4CDWfDqQASt8cZRrf4WeD+zrki310w7xtgcmvb7H5dXsSdySSYjBe6RbAbEXNS6w
	Vf0PGBAMKLL9c6IktqOHieHS/0taJCaXgmp+CBx16vE4NGq/nkKY5f+XGR1ujsdhEnJceziYPp7
	PNleurQp/HICMqglwThAI7BqCCXe7y9FoiHAckn2shllBULwYU+Tk98xYqubQP/37nQR/KB/TX1
	iu2LZ8FQgsC+w8Xd5ZqMbZTz8gwdjhqaGi0Yn2h/ymHuo5q1VchJKF7N5M51b7Fiehh4OL+Lnk0
	l7FgdXgktnZG5Gjfnh9mvPXepJctsyn28=
X-Received: by 2002:a05:7300:cd46:b0:2c1:4a7b:9aea with SMTP id 5a478bee46e88-2c15d3c9644mr2913056eec.25.1774469024964;
        Wed, 25 Mar 2026 13:03:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.109.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec2690bsm791289eec.5.2026.03.25.13.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:03:44 -0700 (PDT)
Message-ID: <69c43fa0.050a0220.6b21e.014f@mx.google.com>
Date: Wed, 25 Mar 2026 13:03:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8996040859523763109=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2,1/4] Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
In-Reply-To: <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774465559.git.pav@iki.fi>
References: <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774465559.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8996040859523763109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1072503

---Test result---

Test Summary:
CheckPatch                    PENDING   0.57 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      24.22 seconds
CheckAllWarning               PASS      26.37 seconds
CheckSparse                   PASS      25.37 seconds
BuildKernel32                 PASS      23.27 seconds
TestRunnerSetup               PASS      518.53 seconds
TestRunner_l2cap-tester       FAIL      27.77 seconds
TestRunner_iso-tester         FAIL      36.49 seconds
TestRunner_bnep-tester        PASS      6.21 seconds
TestRunner_mgmt-tester        FAIL      110.66 seconds
TestRunner_rfcomm-tester      PASS      9.24 seconds
TestRunner_sco-tester         FAIL      14.16 seconds
TestRunner_ioctl-tester       PASS      9.99 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.41 seconds
TestRunner_userchan-tester    PASS      6.59 seconds
IncrementalBuild              PENDING   0.79 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.117 seconds
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
Read Exp Feature - Success                           Failed       0.114 seconds
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
Mesh - Send cancel - 1                               Timed out    1.926 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8996040859523763109==--
