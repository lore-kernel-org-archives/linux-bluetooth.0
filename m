Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0523371043
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 03:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282640; cv=none; b=PqyVHIqmB644eNmJV2DqxWdIbNnIw5jaBZks4m0pJlN1+6BbKe/rNTOW5rV3mpAcxZUER1VL8UnVOkmMcnoBmxXS4kic1G+kOyQZccwCSOOKLzK8T1a0287BBSwQushl7NVUY7B3Hz2p6mIzIztd1V8zlkdP6Uy5eeW7ZNx1IUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282640; c=relaxed/simple;
	bh=HiY6KIUE2i7MbS++YMQJoFiEDCQstZiQQS1t3gzW4Gc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JcKmsLy805yN0k/SA8HpqK3rL2ZdNu5e8m9IrLCMf2VoOi2HsygVF01RbRu6J2ict7ZsBp03xPuiQQQM+elcCJKDQWte6S/M2IQPJO0o/B4ilPUz/NePLb9O0+7t7B4EmnYEFeEY7rQdEjfvC51O5oHuOmBNna6YMpHnk1lRrsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nK3Ywjbx; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK3Ywjbx"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2cce930cso5112861cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 20:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787282633; x=1787887433; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rEfiw9vINZJdi40OxRL60d3pu8sC0BIrBrpffAipxxE=;
        b=nK3YwjbxFXpRGqsRzv10qDHN6KasOL9HVsJAKFF99BeKc79GJCgiMLrFM946FGGBIe
         nEWfGLcW3Myi93GYHsgBcjTRd/PChG0ZHm1tGMKP9d5uOlX1c1woi7VlIFAu0S28Lw+D
         j8XmcrM2/Hld2aDjbjqcflKbjkKV9Yy8gNx9RltZjmfaHk9WLorG054Oaqvz/SYd/5z2
         imD/U51Nb9Kj1X4oPQY4kU80KU2/pm4SCLvZOgSzkRMdN9DHoutRq1o0SzQUUZbBYxD/
         6Fs7pVMZz4c8U3BR7+UZzaEKpwCYSDsnL66UNXN4q7XAaoLfnzbrAcZEKEWd88grdlDb
         HkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787282633; x=1787887433;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rEfiw9vINZJdi40OxRL60d3pu8sC0BIrBrpffAipxxE=;
        b=CmVyuNxyeq7yc6Kp3BEuSZVeZyxTrmr+a5dXi17c5C69sY2xrKp8nIc15BkUMueAC4
         tKabS/osm1/5rJgRzyyrWS3FlkRgN/Vb2lPatc5v1e0Y9dfdZzDak24Nfid9omSjl/RY
         q6VRbPHW4IxGQ5Nw5i82YeHVMxyPpMu43l42FMEhMsTVTbyGKIZj5QqFlB8LnE6fxO1Y
         BFRJHHyyApd/e76hBpue/7u1T+qjMV13DUpekpU12N7q7H0V9n5ehrNpkMhA/Xetn0y+
         6yLSH9/+bbbOKYq0Eav1BwLT9AHtI5cciMD+3imSi2vjiYxchH+mjj2HMzDYmWNQyPVr
         o71w==
X-Gm-Message-State: AOJu0YyLjaxwTS1b57Ni5jR1cz6yIfMj24xG19+SMvi7ABb7dsjwSfbL
	G+EICQlhC3Cx/p4ZTKCOYuzZYJkADt5qqgY4upPUegvWGzii2+gVDEhiomeSyA==
X-Gm-Gg: AR+sD13fUPQibvh0NSsEcggQ9LCV6KJrDqCjkLmD+Qn2aCvqCrnlBb8mkKQW8Bx7ilC
	LeRBHw7LGeGQw4ruuCfKIyRlozdqnbMJUR5X6cVWhadWsgqF8PgBXYq2uLAG/LFsZWWqqp/yvMC
	QU7RSJ5QUWh/jZdWKLc/LK04FNjNu1ERasvcVh9ciEg2nk+YIDshrx9hxnMx6PfjZvziiVgDlqp
	iZn43SDXSxJpy9B7Bco6ZpnWVWHltonzWnlak36e2LLylj8bAg4k7gVe//bUU2J7vrrpI5gc7S9
	00VTNSTNCLhEHPo2XP1Z5iXG0RAs6m/iUVOemFCIIknpnfFtUZlYo/O368G2EwvSwyxNO9J/mdH
	AitA1OsjmF2q+v6FFFA03ORcJ6MHxe5ozgYvp+zCvJYp/SZNxF0S+2O9jpav1LTgIF64ZNKtqIp
	22lXdugnbnhOFnVtLpaucRU/wOwblMS5Tbtu4wE3z4cSsE7W6NyMNLidgDuVISUXNBcRQU
X-Received: by 2002:a05:622a:4d44:b0:51c:1291:911c with SMTP id d75a77b69052e-52df56980d8mr31415361cf.14.1787282633582;
        Thu, 20 Aug 2026 20:23:53 -0700 (PDT)
Received: from [172.17.0.2] ([52.186.174.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd87771dbsm42017551cf.29.2026.08.20.20.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 20:23:53 -0700 (PDT)
Message-ID: <6a87c4c9.a56822fe.14a561.412a@mx.google.com>
Date: Thu, 20 Aug 2026 20:23:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2157970988531678102=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 13875017792@163.com
Subject: RE: Bluetooth: hci_uart: Fix false success return in hci_uart_setup()
In-Reply-To: <20260821024555.1647597-1-13875017792@163.com>
References: <20260821024555.1647597-1-13875017792@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2157970988531678102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149414

---Test result---

Test Summary:
CheckPatch                    PASS      0.98 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.62 seconds
CheckAllWarning               PASS      30.38 seconds
CheckSparse                   PASS      29.00 seconds
BuildKernel32                 PASS      26.64 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      504.28 seconds
IncrementalBuild              PASS      25.94 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/626

---
Regards,
Linux Bluetooth


--===============2157970988531678102==--
