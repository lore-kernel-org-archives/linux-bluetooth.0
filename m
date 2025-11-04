Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD821ABD0
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257535; cv=none; b=A20y6E6s7m0bMHwkaf09AFZC7RslbmVxsjTwQyqqgx63c6veEbX0rYcNMIUlw8iJ2msTAI9xZY2Yg1dI6JYKGeEV1KExpBdo3VzY1tNdHrLfoPX8oFxzQKoHQxObft9lcHyRI+G0v+iGo7hL6Advry4V+YRArFE6TkWh9vPtjGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257535; c=relaxed/simple;
	bh=XnVwDAiCu9i6lA1ZEhkrOr2FylVkBo+US/11nFUiWbY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ILQ3jrzyUQIpas+jAeQYaw+H74HuBKjC4m73D8T2yx411CVia0SBHqi6M5GA1XSll8IWTfPcZ+rPsnYEF+b1m6yHH2hUHJuJsxRwmMYPRPW/vo+sSx5GBfHrkFjmICM2xSLajQ5wdbVUouA7OwDHSN43AmpllTSbaPjPvo0seiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGvVDgoQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGvVDgoQ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34101107cc8so2206866a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Nov 2025 03:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762257533; x=1762862333; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5TEkPVzHUfrh2Ou5DFA4lw51LqbFMQQyfFcib7tG+Qg=;
        b=NGvVDgoQQGPkwZICxs5XFPeC0jlZMAHIIOYLPwxQoDEl2qZbjEDy+1chhKKMgHAVUM
         wBdzKlbLUHUvRIO9Kr6mTy3j+fJrE9HcYeTgYjC4SmutuXoQuOA1pU0RRRY5pt/VS5AR
         8vH98Crt5ci2nW2RMPToRugQZSmEBmazIa+0t/jTjNbw4/xnc71VdfqQcQdsLPyeCJy1
         swQTLTjk+5JAt1aGCaL9QrrsdgE0AvHPYKCnIqe2esCxX3uJ9pm4c2VzjUxx9CuRYarw
         2S/qEHgYsraO/4FWzlyg9yVyOonZz68Ol6pvMqM+XSqyqBaxtQny+VRzcd7B3yoqwGtn
         OlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257533; x=1762862333;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TEkPVzHUfrh2Ou5DFA4lw51LqbFMQQyfFcib7tG+Qg=;
        b=pOgHk8KNNsyWpTzF1YDawXvgMeQVYvOCAzUu6qxJ0qgQ+xSN0s+s06Iy3pDH/kG1jP
         5ES64MWMlAZZjPgsB9hTvj9gfiw4GSiusZQCzNogB3zaJ25g5OLPhcz8/cYKqt/+o/Ev
         KsBW5E5tSHgr7pMssHBFXQZVsnerppRFAVjjgLoQgYUsmF8HbAqSOdR1Ef3gkv+VhRjp
         tBmuIUPy/ZP9yPCS762XE8DArM/F30umtah5yvLmTnwE3Le0hC7q+X7aqJivzrlTcoka
         eamk8Tqtx++ckfJGATKoOQnEBitwVIZ380fh0AQKyA3I8tj3cr3/u7qP2lA+SLkRVzV5
         puwg==
X-Gm-Message-State: AOJu0Yznj6s/tkYk0GzmTio3aeQRZK+66LEHD9wz13GUUgCQdKDSiBgY
	W31pkg+gqvWmntbrLJNUcoRen6DExDh5E2Sig2532cR6nTXG/Icgl1OnMrJa+Q==
X-Gm-Gg: ASbGncuB+S9MXcsglnXuVEavgrgEjbqduI7fLQHIuCAL0vfsGpKHSGfeufO5aRt5ov3
	mY/rDhDtoHskWgzrD1/FiJc80zylh/iViOunXgPqodF6ztg9BUCImtSPin4Un0yIXVFxnKpTnaX
	fA40zYx4lztkUUmWWsl+bX+lyX0UNnxp72Ka95ta6yB9K5Bk/u08yzw3I4lMMXQjzPVJEDsM43n
	lhLt66CW40wqJb+6ZJ88loCZu6YIekHTq144Fnk2ORg1M+Zig7oRoU9/MfYxTJ85I4LEUSCGBpw
	Zj8Oy5i5rtBXBKokndKfC8DxIO2HGj7vy//JcpQsgq4Nm/4LQaQdMFBiaxot6ahWUnfWhlR1Ii+
	XojT3sNNfFtkPeauPpBF8wIVSEcn8ZaHCE2bMAvdWB56mvIQkiCYhR5kIgEHcm8A/keHMF8BIhF
	gqO+KBQhs=
X-Google-Smtp-Source: AGHT+IGZO+eKy3T4oztqr7dxjLeGCb/0QTtX1se9/EFfXjJDQK2mzVDwwkFudMB7KoUjUfCajUIJNA==
X-Received: by 2002:a17:90b:1f8d:b0:32b:c9c0:2a11 with SMTP id 98e67ed59e1d1-34082fc4a4bmr18696079a91.4.1762257533355;
        Tue, 04 Nov 2025 03:58:53 -0800 (PST)
Received: from [172.17.0.2] ([20.171.125.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c69fcb3sm4375454a91.16.2025.11.04.03.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:58:52 -0800 (PST)
Message-ID: <6909ea7c.170a0220.275b43.4770@mx.google.com>
Date: Tue, 04 Nov 2025 03:58:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5881296871567392632=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: [v1] Bluetooth: hci_qca: Fix SSR unable to wake up bug
In-Reply-To: <20251104112601.2670019-1-quic_shuaz@quicinc.com>
References: <20251104112601.2670019-1-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5881296871567392632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1019390

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.82 seconds
CheckAllWarning               PASS      27.64 seconds
CheckSparse                   PASS      31.08 seconds
BuildKernel32                 PASS      24.67 seconds
TestRunnerSetup               PASS      499.21 seconds
TestRunner_l2cap-tester       PASS      24.16 seconds
TestRunner_iso-tester         PASS      76.17 seconds
TestRunner_bnep-tester        PASS      6.13 seconds
TestRunner_mgmt-tester        FAIL      111.20 seconds
TestRunner_rfcomm-tester      PASS      9.24 seconds
TestRunner_sco-tester         PASS      14.31 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        FAIL      13.26 seconds
TestRunner_smp-tester         PASS      8.36 seconds
TestRunner_userchan-tester    PASS      6.58 seconds
IncrementalBuild              PENDING   1.01 seconds

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
Read Exp Feature - Success                           Failed       0.099 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.059 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5881296871567392632==--
