Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D81F2B8D
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 01:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779326675; cv=none; b=uWDwWb27MgDufodVbx7Cx76Edo1bdswQmPG03Zj0S6qKECAyQqkdCzwEeZWG0ouQDYzwkOmNj9yZ+b4AxE4XNDoe3lr1FQx0d0yufEN7r70kJ6KeU8VzMWTBKjqbYSTuaFrfH9LrJk5okFY1Z1Gp+0VxXYLEA/phfrYYAmHa/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779326675; c=relaxed/simple;
	bh=TdAy1zQzFUKsxLPMJ+A91mq85aZHBiDmMr9m1DL/Qe8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=F6TTA3Fd4hzA39k+Ix+XaE14WAOFDyodgUeCX3+PopMSQWiJgdm6spRmw6BavbD8Ox/HqxUOzzY7fmlmJbidZ8JCCOJEghrkGYUeSYXQvznoxmFtUIj2m1UZNZOS/rRb8oi8ycNjmcE7v6yDGMH4qy8BYb0JdkKKbeI826OJz4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s244yRcs; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s244yRcs"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-911449d9d03so658092185a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 18:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779326673; x=1779931473; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CoNWf5RtCjd464UHCMo8aW1ATZbwAfpTva2xggkr7DE=;
        b=s244yRcs9j21B2nl4IfpoL8TrEtC5n/07nA7khutdjXVdM4C4f5fwlJgUy6gu/ExvF
         nuUCnQ86/XWccdLv9rq/NnyS18Q9bout1GhKMdx2zRMuk9j5v0B88V4qlFmc2TFx3/2H
         EIb9mvNPtWZ9tixhtfZ4gEkSL61YfLQ0pqHeQKB12I9uqFUCfnT9oIBvkmPVI/UV9oZ8
         9/HuV4HDHm6WgGyj8zjMo0/e8aqQsnkCJ0t8uqW5EtZRFiB7DSdfIHW2n7cs6ENhnRNG
         JJ4wU5syz10UsdM7ZIBfMpt8fwtR8BMXx/fl/gFgHI3/4BwtZwTS7QIoxU/9heYxRPlW
         rYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779326673; x=1779931473;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoNWf5RtCjd464UHCMo8aW1ATZbwAfpTva2xggkr7DE=;
        b=LV9pkxy/OpngwhELzm2FJzIosc/Nt2ISovQkHJj2ioFniCTJ/vtaVx9yzprBN1ePTS
         wQ+hJudE+WTpDR2w9cMJlC55ognmIOmkhmInxZiY7S5EJbLdaq5dhL8p5+16PuY1KAro
         /heKZelj++tN/NR8ANa4LA0FU0aiA+/n4wjzmXiu64qOdOHC/BdWK1/MIVDL0mMHM81a
         tQ28TWg1g28JeS1AK5//vN2pmVxj8aDGHsQllJ9mHKvtk1gb/jST6lqF4ZRjxeoK9LdA
         IsdXA7YvrNG7MM10+D0FPzXq+4HiAwsWu3aoSBsv0vv0gY+1s9YS6J/aSyD/CfZKQ3NS
         0ltw==
X-Gm-Message-State: AOJu0Ywtia2ZWJn6M0zCpvLLHWMswXnzJEiNMpl4UAMQpn4/GBMFhADK
	vPJTfgCczgl2+cGgX4/lXy5PXioeiHXjU7/cCY9V9aNkjtwqENbsckP1pMC+mg==
X-Gm-Gg: Acq92OFFCcdmGoraQl9kqMaGQGM/CMBEC/gRXg4JeKc2qPr8u2y88ZZJuI6Dxd6p0V9
	NxRQwNWTPGAoKOnJxUlWwvFDSeAK+EUu0uNqxPv3vknk7MRjDTKCn8JNePH2S/fTO6ZPbSvn/6B
	OSg6V/TPQAgiuGn/jBZqSQFYpVpwCIMzK8i+wALUiVF/zZ2fo56/Wn7J8IFbmbS90eIu9xkjFLE
	s3kjqXkyKo2I3+LjGLgUGcjzH1wawwNTvrtoZOq7OoceQLAvmEmYvDtHqbpMcI5AlOsxma/5hX7
	l6fdIeLxBMI0L9TPRQ5FKEulsZXDkQoN5m/CdN+b853O7iLpmbNDvkKBJu2y0U/Vokjfy6Jh4uq
	BY25UjcrX8MJmlcDIlAP8NCNs/zNV0jl4Qn+SvXfn2QzMksWMIcFbAIj6/G8k4XTC3BYjgzupjt
	ibu+uNRoLvpzVS892b9Qh5ztrzX9uXm42OtUqx53G6
X-Received: by 2002:a05:620a:4506:b0:90d:501c:50 with SMTP id af79cd13be357-914a2a62ce9mr104549985a.26.1779326673567;
        Wed, 20 May 2026 18:24:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.23.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bd823f66sm2260764885a.46.2026.05.20.18.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 18:24:33 -0700 (PDT)
Message-ID: <6a0e5ed1.6f516b66.306230.91cc@mx.google.com>
Date: Wed, 20 May 2026 18:24:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1619115656289273689=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, meatuni001@gmail.com
Subject: RE: [v3] Bluetooth: HIDP: fix missing length checks in hidp_input_report()
In-Reply-To: <20260520225643.35683-1-meatuni001@gmail.com>
References: <20260520225643.35683-1-meatuni001@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1619115656289273689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098338

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.49 seconds
CheckAllWarning               PASS      28.49 seconds
CheckSparse                   PASS      26.31 seconds
BuildKernel32                 PASS      24.53 seconds
TestRunnerSetup               PASS      525.22 seconds
TestRunner_l2cap-tester       PASS      378.59 seconds
TestRunner_iso-tester         PASS      597.04 seconds
TestRunner_bnep-tester        PASS      19.00 seconds
TestRunner_mgmt-tester        PASS      2023.48 seconds
TestRunner_rfcomm-tester      PASS      63.40 seconds
TestRunner_sco-tester         PASS      141.63 seconds
TestRunner_ioctl-tester       PASS      133.58 seconds
TestRunner_mesh-tester        PASS      60.44 seconds
TestRunner_smp-tester         PASS      17.83 seconds
TestRunner_userchan-tester    PASS      19.21 seconds
TestRunner_6lowpan-tester     PASS      50.92 seconds
IncrementalBuild              PASS      24.01 seconds



https://github.com/bluez/bluetooth-next/pull/224

---
Regards,
Linux Bluetooth


--===============1619115656289273689==--
