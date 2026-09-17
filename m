Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149143BE15F
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789630407; cv=none; b=Px+xkLAXHlacqaSVa7WKrjkJIfxOZ3r9EjKafzAxqvxqupzNI40Za5WlLw1RwLwL6yahS3s8eituNBMJ2go2HlWK9nHfdgHNN6aN4uGj9XYUgiBEvw+YHa1dx+18+v1AhO/VScRRko/EXneJFjxrYd1EyYRntlP5GG3+CQ5Lsk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789630407; c=relaxed/simple;
	bh=xHwVP8A7AGttUdH9u7l43tP/DoFs9zuaG0xiLlsovGo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pMHTgTNg0sTZ2fZqa2PPA6IbcZP3etsU32ct6SoNP7kVCsEp3tbqORLZweyYIy1qe5F1qUrzcQn45M5oUxbCw++jkBlWf9NrPVPLWB+Vbcl7FPb03dugGL9XFoJ7WBXbxHb5AAxYjbwphORQ7dBMstQ4+4Zf1I8PdaKSyF+TFpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfPq6EIr; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfPq6EIr"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c6b4783778so285181b6e.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 00:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789630405; x=1790235205; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BNMBG3VKZumql8LhqMLOt42wzMyd5b4mFc2Y05tjTS4=;
        b=WfPq6EIrMfJ8NuBB0A/e69Xxcww77h863w+DlXcawyJLhZT6GdrLOAxGmFuauEelEU
         6m70NYZKX3Hc0gRkcSMOKKE9ZrSNSygu2mjvFLiuV1UAoa5HH4AG970r7Mo+jrDyjvHK
         4nf5d9L3tfeEu7K0MMetsl0SEfUCHTXxlCXyknvuuDjqHLzLvez9WH5XQG09pkTkPaCl
         mRR2yQIhxjigN3iebutmROGOGjlgv4nKV3C3qt5VSkKSwpj5Tt4wGMb46VHU7u2hcwRc
         WtnMuKLrfQnbJsWrv6hJKIf43yCzQpECtaqCkfBJnLEOJtzDRkk9/9aC31RyrBlxsXb6
         REkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789630405; x=1790235205;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BNMBG3VKZumql8LhqMLOt42wzMyd5b4mFc2Y05tjTS4=;
        b=tb/sWVmOEbt8F4QHSjU6Kb/s713zvfgluIZsonpNYBEaMvozmUG1WB3I3hcE1y5yxX
         YfZ2BLYAS2HSdnSt72UAU2hp8fQU4x75+SEhOYFkthlwiYFGRu3Xcbxybd2A9O6t1Z8U
         kdybtWabmgK8xjGjVE8MX31DCkBKuUwqj9MW4+CbRZ4+o5zU4hZCsfTZKW6trW1xUDet
         3MS66IPjjPhXKqGU/d0QgyhCF8qfK9Ok54sjQ3jDLSjJJopVwtHX3NVHX6kUA2f5Xpp5
         D6Fm/VwgvSjeVDwnWD9e/9RWMxiw9iKL1Q+7pWLPeMKAJJmD5WjZCmoIdD9Bi21livXK
         CCYw==
X-Gm-Message-State: AFuF++mI9t0Hw7PbvgRfJgv2/kKiQlAvLu6WcI58SbQvar5FLHloivHg
	sha3ftwcsxxd9vy1R5WqdZE5v1oMSZ5CMcJdMXkxQR4GywXWE/pZeeK5UoMDLme8
X-Gm-Gg: AYBFou1Rzj4jwy9e95vADAZjudTeujuaWgjmA7f+P4UU8j9qs4IOVY1J5TfY7gqehdh
	IZFQHfg4O54ratTOFmBxsjr1n7XkH50Wz7nxTo3ktw1QPLeC0CKXxQ7CflcSTKqE9ZtG/d0nPZm
	8ouW784wFNe0LaFJjhpwKgxVVH7y7vFub7ThAAtjIoCEUg019ZkIG+0oL5BuJDFg2q4a5eWaLGA
	N2S29mPMRiXfVtI7jG88x2k5HqOFZSPMLPLUxYz6191fYlprDcH7ZOBhQj33PEyy9IofebY8R5T
	nKSpIzcXhls0J9BPJOtSEVV5XAmmI/k8A0L1VoP0Jcx3bVz4X8yYFtRWm02DAnVqdNf0+IisiA4
	KCOTMLNwlKPYvIpGMGNYTJ9xYlBW3pzcM6bvvq+B7RP/wxSakjKe3Iai4GEKJr7CHnAEZLYmHvr
	0iZ7hzTzMvztca7ye6x0JKt4ju+TX5XbiQAKmSOLZrUZaCeuAEcmRqCH2kvYzr3Id/XLQW2b2Js
	pokoA==
X-Received: by 2002:a05:6808:50a6:b0:4b2:67f1:11d7 with SMTP id 5614622812f47-4ca4c8d74b0mr9092808b6e.17.1789630405004;
        Thu, 17 Sep 2026 00:33:25 -0700 (PDT)
Received: from [172.17.0.2] ([52.162.137.98])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4cb6c80c793sm1901456b6e.3.2026.09.17.00.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 00:33:24 -0700 (PDT)
Message-ID: <6aab97c4.c41479e6.310df1.f986@mx.google.com>
Date: Thu, 17 Sep 2026 00:33:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6312961223121668956=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: [v1] Bluetooth: btintel: read ROM debug registers on FW download failure
In-Reply-To: <20260917040853.2719484-1-ravindra@intel.com>
References: <20260917040853.2719484-1-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6312961223121668956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1167062/

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      34.82 seconds
CheckAllWarning               PASS      31.19 seconds
CheckSparse                   PASS      34.75 seconds
BuildKernel32                 PASS      27.69 seconds
CheckKernelLLVM               PASS      31.12 seconds
TestRunnerSetup               PASS      723.08 seconds
IncrementalBuild              PASS      25.64 seconds



https://github.com/bluez/bluetooth-next/pull/784

---
Regards,
Linux Bluetooth


--===============6312961223121668956==--
