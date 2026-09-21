Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69794E325A
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012049; cv=none; b=MX6db8NO2R9YXpsFbG17Vp4avybO75DSZZsO4JNuk993Wjnn00mcsNsd/JACwPeQbX1kLuMqmQ8qwUseJgaAXox3Opv2j/ZznuD/EGZQQgjEICoQf/ME9QiFHLx3aX3pGSAWR6vjU6C1NzfDHqoiDEXqu0zSV8QYlw081bbm6rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012049; c=relaxed/simple;
	bh=l39ykzqgmdtl23vc6QCiyTNg0RMQNfk4+u3hzVDB3Bw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iWGs9k7rJ3K+FFbtpwcf73eTGjNvYjtt7xuSkIpDHOwn62AXnLdlHaNbs8jEwwXhm8Joy8XpGCoAI/jx6uuSgR918jM3hq5hL7gZy0EToLO57jzUsef/p92/EdOnX4nPifMDQXNj889s0/PjxdgsJwXN137UaNlGr0T9qoqsdqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXJvjOyO; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXJvjOyO"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91058dd77a2so35544456d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790012046; x=1790616846; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HQ5XgmH/UeNlsJGdg0c3JL9GMS7G5U1ANdlnuxyYquY=;
        b=EXJvjOyOUXkjgYYvmzy40vszjc071QUP2tIY0FWclxcGxEET9ce6ZxZEFQ4QNvjOhW
         wpq5TvHJ6NrtHJev+1WvXl24HsATq7jXdjCHZg4Ut3SUezG6RF64di3V/unRy4xvIkZ6
         /1vyYK2XmaeYru9bcnLbml0BsneoZVe5SguhGHGpZb9q6gSCtqvv867ikyfBaumWngNt
         5Bmr+k61igiCAjzDlxUUx0/aPuuakyT1I/qBaN5gw9opmxJllWq0L8QdlYgrCMEiue93
         hnk3Sb0p6lNFZh5h2fAL8/LpY+9EUBRpB4Q9mYAvZhrfCXGnZSi740TlrNq0y8S/BVwl
         txEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012046; x=1790616846;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HQ5XgmH/UeNlsJGdg0c3JL9GMS7G5U1ANdlnuxyYquY=;
        b=RV8BCq1GiABwkuD1HUOmj6rS8VljQDYgkUzDt069iSy0nzJm0gu/lK0PISByJfqwjb
         4TbUuyJwBH71E7ldw840NslFreCkPqK4Ww9LrxOHnVo6dkaveRVp5sKyNJY52nGEwynK
         I8aMueVYPsB0FxVN8zvNN7cif6FOEO7IwgF0TVEjGlR7QVEWN6yHdF3MoCWJ4NYsuC6R
         hc7L5NqcigMQQiDvEie21UyBo481a9087GJ7oE+wuhXiDB/1QZ5gzJOUszZDUuYQYrFe
         dVAwlVYJw5O7hTCPu1+5ppQmaeAsTvpyAjf1fk2IqovEGdsBfCgn5jI3aCaYYxxjTDGc
         +CKg==
X-Gm-Message-State: AFuF++k/Q/31oOmucnV4bxAx0g69jngG9z8zW/ZTCYsNl+EGcA7WgRjU
	rxLYKKSap7wSilUdEvv+V3w9XJ4dLXlrYfJIh/+ast9aMnghGJT67zF2FgcNAw==
X-Gm-Gg: AYBFou2RfogyUPDzJ97ZIkgVcyLyJ4qMyf+LBdv5fmJ5fB345nI6zaA43EslMgZ7TFT
	xzis67fe8WrZfRVEkOzDoLmJtnwLcek3nYsObD7ooyyPwqtEfVUxvCv4amEiHYA3KDKP4MQrOvt
	ebOO07ju5+B9LFf++Gl27nrnWYeRd8+0+kUsqLIJwwPV7d7yy+dYyRigEgHLB9cv9xDSf8HosyZ
	zTcIO52vTmcpM5k9uMCzWkAoB6u13KR7NB1inQbhXSHhcnsWkvG4m+ihia3+dSTuviVxt/Q8bU3
	SGM6So6PlhL9t5uTBIGBdlmmQCgoYjxCXYWprJM5wqcQTlv2yOWGjo9j5tLxOw6Yjmwan6RrKpe
	qd+Yz0f6RUx6tcz3ipxTJbrncvzq+SWMkR3L0AOUogacOC+GXXy5zCKSzXTW9OBX9uPNlTsxfdB
	ZnqIZtb+DRKAwdM2i2gcN1y4vn7pDVVOmtq6TsHpjVcEVgRYHTAH5t9Br+i1vhe6LTQqr/NSZVh
	EZQHa+r
X-Received: by 2002:a05:6214:2026:b0:912:4608:b953 with SMTP id 6a1803df08f44-913fc94b325mr15697466d6.25.1790012046398;
        Mon, 21 Sep 2026 10:34:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.119.41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260a8d2cdsm72485826d6.35.2026.09.21.10.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 10:34:05 -0700 (PDT)
Message-ID: <6ab16a8d.9eb508be.1ae927.d794@mx.google.com>
Date: Mon, 21 Sep 2026 10:34:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2741266626878348964=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: 6LoWPAN lifecycle fixes
In-Reply-To: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-1@gmail.com>
References: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-1@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2741266626878348964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1170521/

---Test result---

Test Summary:
CheckPatch                    PASS      5.37 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      1.79 seconds
SubjectPrefix                 FAIL      0.66 seconds
BuildKernel                   PASS      29.34 seconds
CheckAllWarning               PASS      33.40 seconds
CheckSparse                   PASS      36.26 seconds
BuildKernel32                 PASS      29.12 seconds
CheckKernelLLVM               PASS      35.03 seconds
TestRunnerSetup               PASS      797.01 seconds
TestRunner_l2cap-tester       PASS      16.57 seconds
TestRunner_iso-tester         PASS      28.97 seconds
TestRunner_bnep-tester        PASS      3.11 seconds
TestRunner_mgmt-tester        PASS      62.84 seconds
TestRunner_rfcomm-tester      PASS      4.47 seconds
TestRunner_sco-tester         PASS      7.63 seconds
TestRunner_ioctl-tester       PASS      4.65 seconds
TestRunner_mesh-tester        FAIL      7.84 seconds
TestRunner_smp-tester         PASS      4.38 seconds
TestRunner_userchan-tester    PASS      3.21 seconds
TestRunner_6lowpan-tester     PASS      4.43 seconds
IncrementalBuild              PASS      75.68 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[4/5] Bluetooth: 6lowpan: handle channel setup failure and callback lifetime

29: B1 Line exceeds max length (81>80): "    [  101.222759] BUG: unable to handle page fault for address: ffffffffc040199f"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.419 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds


https://github.com/bluez/bluetooth-next/pull/808

---
Regards,
Linux Bluetooth


--===============2741266626878348964==--
