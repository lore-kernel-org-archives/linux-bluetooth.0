Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DA4408006
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509718; cv=none; b=cmatIFMzyDPl9pUfIp7fN2PHVAxh2mqRhAUP39+mvQtNaXIbFHav6evwEVVYEjINlFSNOP2rh0C2G6klISSUfTNkF4Rf97zSFR6zTnrFxxiCL0K19luw24EEMP/xseI4GIM6Oz/xxIkjWD2fg/d5385yKw29lNaiHc6cue8YrqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509718; c=relaxed/simple;
	bh=RcMDqWmJlnZ6//8/nybv9I3q6tPO5UoOWGIH2He+h0U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dTHqGARIZiuU+MQGvEZcCoxyMP7qj7wB/7jCRuOi0VkRiXOHzDi00/AjS933HRY+LxJRlGEPBupbHwJ/TXX6SOCaQ662Mt7d1xGvq2u3tIDh6vRp13kswq16lQ35IY8fPKAavBdI9reLScZwgn0T+HtxVH7W0rAQQdui7LE05qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDsHhxyn; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDsHhxyn"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8efb708b1a0so4461306d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 04:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783509716; x=1784114516; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NQgK5cmIvpwy1NK15xIok6+TYuM4V1OQD76k1NNPlbg=;
        b=HDsHhxyniGvK8zE4Wbrx7b6Vy6N/bC9a3tQLIVLeq+nYRCTm4GLU5Mp6wpryfmOlvT
         nNG62Jm5hDwYdUd24URBCBuTXCK7YI6Te1B0V1B9Hj0HA4cvxDdq2iDb+woZ07SLQepO
         UpNmT6T7IRH7h+eahIOH5FHidn8tZc0GS84EKjy0J5qC6hIx4kfRCvNz4tUriTNFPvjD
         WV8XBTBEPNCJWQUYvnCF3gX8bZfERvjmyIDmhB8wG1SXLrm5g+Fg39TbYjsfGdkQN1jt
         iHPTrNvV6o8+iAeMDy+x3eFhdt+dEevRVcGIYlf7i7pPgcSj7HYBXje5jOa2fcMRkXTU
         tB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783509716; x=1784114516;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQgK5cmIvpwy1NK15xIok6+TYuM4V1OQD76k1NNPlbg=;
        b=cZT8IJei9J/43jJuL/lXUdNpJ6Ai+KDsJyZOEEwV0bf9rbR7hIHMoKZdUPRq8uNBDO
         ryrfZp6wiiAH9RNAT8BrywGzgdvuNrZAGhdRgDHFVNtV4dbrtatT1SyVnU5tTFMLsOad
         7z6Nxdnm/zJGENapseS+G6daD4MLSyYa6JgGs8za58o6w9p2kt25q1f4zJCgprTGSNQ1
         0yxqbmYn4E8XtLkbxKfNGQtyOSvqGMveKiHlmJaY2MHNPxTouK1bqy8ERpdjVbcYH7Vj
         PXJ3364DdbCWoZOcdE7d64KbSuNpAwzTLxiu60fKGa4JEpy+aZlar7ov9TKDg2wjOZtf
         v8/A==
X-Gm-Message-State: AOJu0Ywqm9bxnv3I6IQiJWz6jYfDCElF5subq/mZqn/egwLjmZ3qDX3d
	1JyJFwuwwR/03wS0tdMLtt26KLqQRehKsnSn9x2yC5K7NauBDTgEnNYWq3paZQ==
X-Gm-Gg: AfdE7cn2w0KV0kHg5xG1bbSvu7VUuxT+ADW6jJ63rZNUe+8qos+NlWvor6Lw3oQQfWb
	mCFgGKSqYkXVL5/zzSH/KEExD94ZpCFK+9wFcm2viuja6Of8OvGkqV0cB3uEpFvjmpcxAxgEk/E
	5ECuuOuRdCaLVxBZg4Y84JUBldiVT4bnzLRfoysCbZ9hJvpz0sgN2fUnbznwoow5vQnMfxmXITB
	qWoibDQIj3MyoAwekf1DU6hGBQj5YNjT9S5jZSOC3buEYeVtSJdytnpamoJb5SFxhBwQz90Fab2
	PG+e3xhH6Z3sSDZlF1sRxAGez4i/K9LYUD+6yPXW7g34BUaWAJgVdnw3hvnPRzjcwaFr7HcaW7k
	oxuKs1cSWQjT0BAXR483uYJ2yK/ypMvhqNdtZforczl5wnkT4nIcHm7ha2225PMi5jslOroIQNt
	L3de2kX/TZ7PQHwyBrPM5w
X-Received: by 2002:a05:620a:618e:b0:92b:67e6:8ab5 with SMTP id af79cd13be357-92ecf672bc9mr141307485a.63.1783509715559;
        Wed, 08 Jul 2026 04:21:55 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.237.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b804c1sm1382810985a.5.2026.07.08.04.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:21:55 -0700 (PDT)
Message-ID: <6a4e32d3.9814f051.3029ef.a476@mx.google.com>
Date: Wed, 08 Jul 2026 04:21:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2319069364626027255=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiuzhuo.shang@oss.qualcomm.com
Subject: RE: [v3] Bluetooth: MGMT: Fix discovery state race against cmd_sync worker
In-Reply-To: <20260708093822.3495633-1-xiuzhuo.shang@oss.qualcomm.com>
References: <20260708093822.3495633-1-xiuzhuo.shang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2319069364626027255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1123700

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      25.73 seconds
CheckAllWarning               PASS      28.80 seconds
CheckSparse                   PASS      27.56 seconds
BuildKernel32                 PASS      25.48 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      464.04 seconds
TestRunner_mgmt-tester        FAIL      206.88 seconds
TestRunner_mesh-tester        FAIL      25.01 seconds
IncrementalBuild              PASS      28.33 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.238 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.832 seconds
Mesh - Send cancel - 2                               Timed out    1.976 seconds


https://github.com/bluez/bluetooth-next/pull/410

---
Regards,
Linux Bluetooth


--===============2319069364626027255==--
