Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871F73859D4
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281061; cv=none; b=oUb1FwTipaGpE6j1EySY4hCejhTD53IuQNnMGWsEz3IBjkzk8mgM3xG1pWDFXUIU3aQd9j6QalhqxPjpn8AOb2q0om0pQYKk6O89YgtW92XQb4DANUhqTWNsK5DCWSKOsgMv4bh6jHFtfIOzOd/utrCNynJJjmeV9G8KsaWzkVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281061; c=relaxed/simple;
	bh=zVFJgDhpwENBajAaH7yQeYZ85GE1jT9HZDz27EjFR9g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bZ3Z+OczuwZx2SrnSQ57rPPFMVKDRxnJUKSCcCZnzsyC2DPNUSiiyuRA8zB8iHlQ6U7eoePD+GdeZqDteO/vNnCuY5lnLbPSW8LtpItPU1Wspim1pcDim5rzLdkHtaK+P/I2Q9W6AS46HSVa1Zw3osF2KeXo0vLGSWeqFXWPvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwrCfEjU; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwrCfEjU"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-91563382bcfso127909685a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 09:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781281059; x=1781885859; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gSZKNv1qMk7ynPHboOjYbZAzkmccAnm3jviDzj6ol1E=;
        b=AwrCfEjUxrnkGlXZrB86ekAlya0wFGNGWPKby2A1oUaebxMzk3ePLhRZYa3nqFjK+T
         2FCUXEEZKdN9oaUrWArlV+X5RBMpykKvoQByHqEKP2SLo10r6RV3d/47LeBKesB119wo
         2CA6Z7IsyI8GyP1KivYQQUlng01073+BrVyCQWYXR8viFBpjvgpz6oSkM0iUHmd1UgEe
         wWexBO6nQsCNhjFVlaVeMcfdB4uKIQe087O9/u3FKA2Xjw+ek6CSKpDKCq/cDIcY/TDR
         4koiqjwLYyZ9eC/feEvT1k4BOVkG8SwEJvfP48Xln7+UXxYFJzpsOANNtXRqHXaxi2bI
         ai9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781281059; x=1781885859;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSZKNv1qMk7ynPHboOjYbZAzkmccAnm3jviDzj6ol1E=;
        b=pPaXHnKHFiiejOACmlblLNbpWwyTuhqwJDbz5xxLSQc6UVv7Bh+uBI9tUkz8F19N1J
         QVdwuB/xqzVLoND3QOSMsIhYMPWsoPVV/lZdlusb09vb1yxuXJPwXtqwaStvdPoXq+wg
         qevJyphwpO/ReFFfCtI4wKr1O0+nGWja6jILZw09MvMfvPPVJpvWO/wvvEwlGNAATMP1
         zlTUhnX8N4OuIMSRWxQzenrglOv1IUnOilN5uiKzzQXpnPQ2uknJXRwaxHCqWwQj6V/H
         O2LRAPHJTxIH5avZPjrWQG7rcIaW2Vpl8OGR2pGKD+T024RE95/kh6dhp91PnKsikegZ
         izmg==
X-Gm-Message-State: AOJu0YzRALSasTBdNdwa5g5q6LnvAsR43oy+Yj5wZYHRsGKOy2quF228
	BefWKiayn0J5bJ6UO4oRmgznhSGr1iubNZfz9L0SVnb//92yvHs6/3ngUvGBUw==
X-Gm-Gg: Acq92OHK7p2HQ5HHcpxRb5Cir9NiYkwM6C6/6yd1A9i2JOSTfOsZPFzTYEzA91k6uZR
	cugiEvONZtCUbvdKUUKRbjGNk0mZ/hT2YxBUy8JRff86vcBIqyb2diiuPnzvG8IvsTAtyms4mIe
	Jp06KYLvWI+yLfhV3HhU5mxF8/LK7fQDeGVX47GB1WhVvCO8+E8XjnShvPJOgmv+kyBu9C1ejuF
	P7pjTp6Q8ZL0Y1NJ7ExJYmmIOIGkm58YFYS+3pylSSIgkXi4fVfI82ZptxsiwTU3FSE/4Tesk9v
	JdIdjpmV02Ny3gk7W0B0cz/FUH0tKnhGuJ6XxULms+zIyzY+PAeXOFV3fZqoQPii3vRBGKX5a3j
	eSsRhvt4hzBO22gAzSk6NMqzbtTCcsW8AEUgnTshys0/IFOgFgmmRVUJsU130FbDWfE3UUrI8l5
	fFYRCVgEfEUCzF5KvU3AUMNE5qKgUq
X-Received: by 2002:a05:620a:25d1:b0:915:aa63:f362 with SMTP id af79cd13be357-9161bf5c9bcmr485462085a.56.1781281059332;
        Fri, 12 Jun 2026 09:17:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.42.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f1b400sm250400485a.15.2026.06.12.09.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:17:38 -0700 (PDT)
Message-ID: <6a2c3122.a342f677.387e91.4350@mx.google.com>
Date: Fri, 12 Jun 2026 09:17:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6515139256786348238=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
In-Reply-To: <20260612143449.3045055-2-oss@fourdim.xyz>
References: <20260612143449.3045055-2-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6515139256786348238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1110715

---Test result---

Test Summary:
CheckPatch                    PASS      1.69 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.75 seconds
CheckAllWarning               PASS      30.27 seconds
CheckSparse                   PASS      28.78 seconds
BuildKernel32                 PASS      26.04 seconds
TestRunnerSetup               PASS      593.41 seconds
TestRunner_l2cap-tester       PASS      59.89 seconds
TestRunner_smp-tester         PASS      23.36 seconds
TestRunner_6lowpan-tester     FAIL      45.88 seconds
IncrementalBuild              PASS      25.58 seconds

Details
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
Total: 8, Passed: 3 (37.5%), Failed: 5, Not Run: 0

Failed Test Cases
Client Connect - Disconnect                          Timed out    4.974 seconds
Client Recv Dgram - Success                          Timed out    4.990 seconds
Client Recv Raw - Success                            Timed out    5.000 seconds
Client Recv IPHC Dgram - Success                     Timed out    4.991 seconds
Client Recv IPHC Raw - Success                       Timed out    4.997 seconds


https://github.com/bluez/bluetooth-next/pull/309

---
Regards,
Linux Bluetooth


--===============6515139256786348238==--
