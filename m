Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16187376BE4
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774982090; cv=none; b=YpIg6/WFqx4wTir7HnhwNBSHXPPk4yMfwCzgBG6U5ZqTtGe7966JFKQLddgjff1/t4FdbxT9VBHePqFNI1ilMkoXXeI0TBN6TplcULicfaMuUU2M7zyRYt8zMdBNsHAJBcH/Oyi5nLL0APSLdsYFyy2eu3yW9ye0GIataCo2OQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774982090; c=relaxed/simple;
	bh=tYTsbM8gSBXh967M354ggusanv1jXdeCaOgrpC2/Ubs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D21ClRvYFgWAi+WKbDPfvmDPkcbnuV7Cwn0OaXGqyxd7m+l2sxjaEZZamvIZ+/puwA3bqk7PaCCuGMrE0o2lFhyhzxmv29tx1QAo/g93oVYkN0jOP1wIVrzDdMzeX6+4bZ/h3wbs40FRAlj6wKdjyk86HI3nRxeVWMeMuvhA2Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5TTZ3yQ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5TTZ3yQ"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d744d9acbeso2484138a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774982088; x=1775586888; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=brYcq9OETEyrATVhVWTeO9yDnoxRwM5n5KfjsWFYaZk=;
        b=l5TTZ3yQYLenazCyrc3fw1KmB9zpSq/KElGX/z7PUktvjBMFDPxcEDe1rCJJqqSsns
         Di1VY5JV3rdAyffmLuQ/JhPmWQ0u9/1PZIJnfm2vud1WEP+2+KbvKXafeJX2FEPG3gG+
         iqLVB/Tz91Rud8oKehr2kWRheVd2adHHDUIcslXDmI//4JueXdqf3bFf4n24VeuqIfD+
         lXk8UTm3Y1K52DO+FwiqJDu51Nd44fRMa6UJYuU6Y5bqnq555Yk7ytrXVMlaeXScZhuJ
         NVKtT0x/zwfxlVpD03SrJ2S3jYi7wghjvh4SvVtPw+RK8RAPyqblUqQj6//cvhumUPHK
         pzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774982088; x=1775586888;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brYcq9OETEyrATVhVWTeO9yDnoxRwM5n5KfjsWFYaZk=;
        b=YY+eMTCb96xUQ7DmYbNF8ReG7wZnWFCO9WXJrWe8xc4pbvcgTGWwW2Uf86N9cbiUPn
         dEK+KGNTwzTEqqsmhXLRfQmxXZakipc+u5LwD/m+rYcGJHv8kTI10awzLFkMJxZqpIXu
         /N3I2Ww67Lm6cQlCg8vKbKjWM5gcIRDz9IjvFGKkFSLb2bYSigIkw/VAmj7Ea5J++Ni+
         CDjofOZx5YbhaYwKuRxiCugHi4CF2DAw4YH6shnZi2+6Yy/pzdn4bYMxxIhsaLeCavya
         QGDmDSJEJwBYqn7fs1Ma0+n9n6ddGwh6R8JsNvaqywJopkd7/HVEnFIcYMsRR1cQqkJK
         B+bQ==
X-Gm-Message-State: AOJu0YwyiirJrMsHotmiQEx6k/cEv+iXW3T1aKlttQ/DR3+l+6ja8q28
	fdaR8FcOiZPqQ2Q3QLN+kDz02Nqim9LZ5ydooxnMwkP6O+p1WkoVs1WgS2nvwkGQ
X-Gm-Gg: ATEYQzwf3nUxNp9jmmnPZybrNOhOHGzEzwqFqwCAGZbF/bTEyrAZI0TJdrj3qM+YFxK
	0D3MoGIr+7u4faNBto2uzYLYptdLtbqFDxL28Fu50ABhs8gzRm6v0mbpyzdbzMwT0aqrtU1yNaW
	bFU84/fsmphTvYUzmjGc0lkYSVGEkoSMwuj1oMDy0rJQytwfacSuFp9do1YalGXgIGj1T9go1Jj
	Fu5/5F8pVdroRH313p8iOENzNbX5jKfrt6dTp53MU7OzRqqb8ThR4NeqpnkMLvLaBHWUSaz/SvI
	3UOHV4fJbXBdwVNaje+9C15r2SqWBNkrn9G6k3kEgHsjo1nNVLTamTzanbVfYs7lyKWk3HkVSaw
	x5d60nuhE5Rp5i7Vbdt6D4BlFHqGx9rGoM3PiOfTTOCopbK4sgN67znsmdE/x+J2++9E9FMVM97
	KVP4uUqouzs1vyp31rpVOr3evwLI94dA==
X-Received: by 2002:a05:6830:6d48:b0:7d7:fd7d:b035 with SMTP id 46e09a7af769-7db9946f8b8mr492922a34.32.1774982087779;
        Tue, 31 Mar 2026 11:34:47 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.94.35])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da3356d8c5sm3124097a34.14.2026.03.31.11.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 11:34:47 -0700 (PDT)
Message-ID: <69cc13c7.050a0220.f09fa.2229@mx.google.com>
Date: Tue, 31 Mar 2026 11:34:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8100353794453509640=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nercone@nercone.dev
Subject: RE: [v2] Bluetooth: btusb: MediaTek MT7922: Add VID 0489 & PID e11d
In-Reply-To: <20260331175301.6946-1-nercone@nercone.dev>
References: <20260331175301.6946-1-nercone@nercone.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8100353794453509640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1075353

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.35 seconds
CheckAllWarning               PASS      28.74 seconds
CheckSparse                   PASS      27.80 seconds
BuildKernel32                 PASS      25.30 seconds
TestRunnerSetup               PASS      567.92 seconds
TestRunner_l2cap-tester       FAIL      28.00 seconds
TestRunner_iso-tester         PASS      38.03 seconds
TestRunner_bnep-tester        PASS      7.56 seconds
TestRunner_mgmt-tester        FAIL      115.07 seconds
TestRunner_rfcomm-tester      PASS      9.37 seconds
TestRunner_sco-tester         FAIL      14.22 seconds
TestRunner_ioctl-tester       PASS      10.35 seconds
TestRunner_mesh-tester        FAIL      12.46 seconds
TestRunner_smp-tester         PASS      8.62 seconds
TestRunner_userchan-tester    PASS      6.65 seconds
IncrementalBuild              PENDING   0.82 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.112 seconds
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
Mesh - Send cancel - 1                               Timed out    2.693 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8100353794453509640==--
