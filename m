Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D62139C9
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774011934; cv=none; b=YkrqFtOXEQhzwbimr6OVkMfxA5Rpi5VDtQVaBPqo6aUx114SlzhhxJtVZoDznCBBr7VTCPc0TTfHvVsK0stXpFBOkCnXNZ/0BbroPdhXyF/zXPYB7kAm38K5sPCLRq0TCjRO1WymA7dJGN96vk+FBYrvA8Iqac+sbqBWcGNhFew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774011934; c=relaxed/simple;
	bh=oWN0DeEHwjKY53MVphG9HxAq/qtdgmCIUK7bFOOvdPw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ev68O33XRRt8gMWtK6RVx3qTSGoQoiXQxtxYGUpdcz9nxxGFnCWF4bYylq820O1euKNp7H1vexDJnMcOu3iAe9ht1tSBOmUZeknhz6vxIcjiyCd/0nqKMnFy/RoaK3aZ8MpGxr/SNpdQ4xXHXa0/CDY6FlTl4FvUS1zzHREcydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCxQzs3j; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCxQzs3j"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-46702742c99so1178256b6e.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774011932; x=1774616732; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k59PnuE69D6I7bGuf78sHrtV+zC7RHx+bySInqIJh9A=;
        b=TCxQzs3j9/0lkeZQKQ+h5DawXOOXIWR2AYnBRnmqZlkn93W3tUFw/LnzNfKfucto4A
         SNKRAxgbFi4KnQUmRdeblvKIK7cr4Tg1K0gIyBFLrBthyoJvvmLZEqj+GyRbHrPsOXJJ
         WFWj5hsyaYm6Ok4UMqakkzpJseq93XLiiN5+1qEOIMXyYGKmkQwJBWhOLOukwFvC47kD
         ppY+RWgEPlrITW/OoWAsnQvZVf7CaONPKcSsGb0iPYvm0ldXp0oHBd17yZQlOYU+qXPX
         ydVux2cUIO68CnERR/YogJhkAe1NjE1swg57876oYqNFHhXGg/N4DZUKrwgSo98SoQAr
         iLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774011932; x=1774616732;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k59PnuE69D6I7bGuf78sHrtV+zC7RHx+bySInqIJh9A=;
        b=SiXknQXzyzw18wlpqP229+K3Fk73JhWyPXAhsxf9rib2nazIp7jnvzFtQO3gjeiHjy
         KqfCONrUEi5hRgpKT9wJVizl94Q3nrukdi5WYHvt/kKCAPwhzrPenr6N/8WcE9cdP/52
         lBgJsl4e8fQQ5sP3JvQKobhB11KfvACJRilpvosl+eIj1ufeFTcVrIQG6vmpTnd3Aq9n
         xXRdhtbN67Wdh0Y/x3dT1To6PQQ/9sXxe7fbFeQ99bHjlfv4oFSCNIs9e2YPgZFBfDPg
         jeselMxZ4gfsrpzU4OvyzApbCofm3gvaUbfCplu+MA2dsp3or94zGlHO8V7SBC4pQEhf
         vriA==
X-Gm-Message-State: AOJu0YyCeFqK3NoQIqLHEz6lvZx1a0+WNbV9GCaF1gh9M0zkFqkdDfnT
	m4H5YZU0c6QwPW2D/jNC7i1jw+dyrM5sPUoLBTiBaZSzE4Oo6GTEnAObNVNfuo/Z
X-Gm-Gg: ATEYQzxA5Ajhj7CXBoS+25m5CZFzMFd2bPkYOV9R7ezSyoqKbKQa+2v/QUtYlFvw3rH
	LaXsvHk+G3n732KZSVpYSWGXN9DRopSkYJk93nz5TgygCZ0WpUo9Ex9JXCyR+I+laPTBVaBCDGU
	GKwNHNO/uh+aBnHOkNUTds4Pm3fdRDkB9vhrIwX2VsWTijRNTWOd01+0cruRxdqBN2IsAKNeZSI
	2Y8MhZNthpH/uoy7TO/bOK97OWuXlnMtjbfsje/jnpIv5MmFaxBef2zWsWWbMuBVze2wvmwwkYC
	wfMJ+4JTJpBAqi4nJjPkI0cXbjy4i8xiTa74TGFoABY/sF1zLGQrJrEu3si5HbNHVwH/kaNQlOU
	rif8ssqjBcH1HyKS0RQdl3C/DaceIIBzZImQWpU4Oxi9m+C0a++Zyva9BIMdNwALkovYxaR2ty8
	6gK1Q4DqedlBWu6D+ZeKhXFGELPaxf
X-Received: by 2002:a05:6808:1396:b0:450:d471:dce5 with SMTP id 5614622812f47-467e5d24081mr1655597b6e.6.1774011932261;
        Fri, 20 Mar 2026 06:05:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.87.116])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36cb2e29sm22334971cf.1.2026.03.20.06.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 06:05:31 -0700 (PDT)
Message-ID: <69bd461b.c80a0220.301447.ea66@mx.google.com>
Date: Fri, 20 Mar 2026 06:05:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3802544907313238616=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jonathan.rissanen@axis.com
Subject: RE: Bluetooth: hci_h4: Fix race during initialization
In-Reply-To: <20260320-hci-init-fix-v1-1-e1960a41baf2@axis.com>
References: <20260320-hci-init-fix-v1-1-e1960a41baf2@axis.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3802544907313238616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069873

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.60 seconds
CheckAllWarning               PASS      29.28 seconds
CheckSparse                   PASS      27.58 seconds
BuildKernel32                 PASS      25.94 seconds
TestRunnerSetup               PASS      569.53 seconds
TestRunner_l2cap-tester       PASS      28.30 seconds
TestRunner_iso-tester         FAIL      36.61 seconds
TestRunner_bnep-tester        PASS      6.29 seconds
TestRunner_mgmt-tester        FAIL      115.04 seconds
TestRunner_rfcomm-tester      PASS      9.29 seconds
TestRunner_sco-tester         FAIL      14.40 seconds
TestRunner_ioctl-tester       PASS      10.10 seconds
TestRunner_mesh-tester        FAIL      12.55 seconds
TestRunner_smp-tester         PASS      8.65 seconds
TestRunner_userchan-tester    PASS      8.98 seconds
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
Read Exp Feature - Success                           Failed       0.108 seconds
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
Mesh - Send cancel - 1                               Timed out    2.740 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3802544907313238616==--
