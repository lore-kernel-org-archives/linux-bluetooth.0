Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE22489888
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Aug 2026 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785601355; cv=none; b=l4rs4mZ/vzM/PiXwBNdotY3cfibT/M5+afHraL78BXInurvFSsZVEA36oTmAfGauoBmt930Bhd68W5g7kfyMZtDfXPERwg8STtrYILc1xvnkVT6+OpUSLEJqXivzamZtRob7KONBB8cuvGijEZM63ODTdCitQ+yeMs++6qLEybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785601355; c=relaxed/simple;
	bh=pLNvdoEQdkT5kgkZiprEY4DhmZidfsPqP5drYaV9+qc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hr1AzOTALX3vVPdmB7lpaksunqj3IEbNW/QB9ZaSU9ao6J7/uaeubJCqELSuBgFgqmqk5AFOp2FtDQoE/HBAaSajEFteh8uh1NUxvyJoffIlayayy91GduwY5JgzJs2iK/RUSc7onioTk/xeurbvUBOj9FmnMktK2h/F1hBOEco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=og0v5SJ1; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="og0v5SJ1"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8f18d92172aso21278206d6.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 09:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785601353; x=1786206153; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SqplX5dttV8KWYrVvOheDRYl0Unwj00eTvzjHHqB1ko=;
        b=og0v5SJ10rLRH8m86UoHT0Kb4C21xjEaofXvjs7xdpdZmYzaiJ9DnEzqrcttlvDS9r
         cW9iH3daE3UxVnCYidnf9sKXDNYMOCOQTKvfHUtNz9moeaE/+U4x0/Jy3KY1AcPU1rJ6
         sBWoNPys2ZEb7+DCkVfnU0FMTUQMLR3lWmyW+TkpzLhHmgx80Gn6GnITUIHzni3sKGtn
         SXappZPM1HrO8APzW6lmTsbTPy3wMOlb6Hm0g6fGfarTV5N5O0iIPtYDcnAjKJl9TLUF
         ozqKaKVDif6p8dfOyV7Xn/aS3Un8cZgcJsAZe0QMoSE1XDmpgepi2J9OiacN56Y2ajeT
         heIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785601353; x=1786206153;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqplX5dttV8KWYrVvOheDRYl0Unwj00eTvzjHHqB1ko=;
        b=aEgePer9G0l6jEUIO1KM9km5/dxCyryTkmd31gM2JrE95QUa+DS3DolE0Jix4eTZJs
         2J5RyxGkg936SSb3KMuhiu9FMoHEQPdbSZhK6y7ZZAelx207V0hgj7iFDfuZCGLMq2go
         VOjgHEOlO0W9NKcljkrxVcbarksOdsG90UQdjPwkSQ0yeDMRvX0RuBrX3l1mbiW8GD+G
         jRAVtqXIxhwN1X9lLA3/xnhnqSp8RzMj3m2AmC/1YKkghdHRl6Z9Czf3/OAcCmrovXDz
         EBOmYq37fbAZQzmThtzBTTBrmyJoeSFbfCWysuMrIoyN5iHyeUE1M7DxRz7mLgTfEiME
         OwaQ==
X-Gm-Message-State: AOJu0Yy1nJYyTlVJEELt/YPgWCjCV841zsd6kD630fMFTC+OgWQIvIgT
	4e/ZnJcgcsOenQNJvDq/1o79+TbZAUGOTeJ/eUM2ajFtyfrvjXgFhAp1A0NwmNqw
X-Gm-Gg: AR+sD10u+ah9HYmbQMDyGBTpueVlhys4awrrRMoWaE3dWqP30JB36lpY/yoTvOooFPe
	3MPjPMQ7t9OOVlXbHXDcwsS2EQS6vBbZKwTxdR+kQKv1tOckZdotDOe6Udx8FhedlUuXgvb0eHo
	d9yyzpVmhjBJ7fb4N5OBLXXMDbai3Gg/wBeMlVo9tqYsF83V21kI7WzDQ62zDFjGHLgDFMotDGU
	dHCvqskmcYGxOKhFN3ilQ6iOTvGDoHAHUzdsRJjYB9Ik8YifN8wcbtfWUwwnyWxzgLKF3hxj4SS
	TyTL00up+6RsyCnOqah/+n5oxKkYm/iWCMRdl1orlXdqVcQ2FHt+IRoEDS31wgwrE1cIboXlsOP
	uo+niMO5L1tF6ebAcLztHyKRkN6MvRcdDmOCTmAb5l0tZpDGJ8kHI9PnsfeOhR9dVCe0Dg/fOgS
	sad0PabLmWTlOn+IXsQTq6rw+xOPS2MAlBhWIvg+ke4SOdDVtelnQpCZKsKpATRYgPIIykbr84n
	ZiQ4g==
X-Received: by 2002:a05:6214:2f90:b0:907:8eab:3062 with SMTP id 6a1803df08f44-9084963fab7mr92559076d6.21.1785601352758;
        Sat, 01 Aug 2026 09:22:32 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.227.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9084360708csm36142826d6.45.2026.08.01.09.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 09:22:32 -0700 (PDT)
Message-ID: <6a6e1d48.201aaea8.186ef7.f60a@mx.google.com>
Date: Sat, 01 Aug 2026 09:22:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7996711813531055510=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: [v2] Bluetooth: hci_sync: wait for directed advertising completion
In-Reply-To: <20260801145430.3560911-1-nicoyip.dev@gmail.com>
References: <20260801145430.3560911-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7996711813531055510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1138651

---Test result---

Test Summary:
CheckPatch                    PASS      1.39 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.24 seconds
CheckAllWarning               PASS      27.78 seconds
CheckSparse                   PASS      26.69 seconds
BuildKernel32                 PASS      24.64 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      460.07 seconds
TestRunner_l2cap-tester       PASS      63.09 seconds
TestRunner_iso-tester         PASS      87.69 seconds
TestRunner_bnep-tester        PASS      19.18 seconds
TestRunner_mgmt-tester        FAIL      222.69 seconds
TestRunner_rfcomm-tester      PASS      25.38 seconds
TestRunner_sco-tester         PASS      31.56 seconds
TestRunner_ioctl-tester       PASS      26.66 seconds
TestRunner_mesh-tester        FAIL      26.01 seconds
TestRunner_smp-tester         PASS      23.50 seconds
TestRunner_userchan-tester    PASS      20.52 seconds
TestRunner_6lowpan-tester     PASS      25.08 seconds
IncrementalBuild              PASS      24.16 seconds

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
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.255 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.528 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/524

---
Regards,
Linux Bluetooth


--===============7996711813531055510==--
