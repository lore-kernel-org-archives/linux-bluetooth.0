Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742A045D188
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786704861; cv=none; b=YoFtkRAkqNZXoIeNmeSNhZ0R182eiBVzIsL3o8eYk8wt8NfG006jjevhiAwReY722o6SQ6TJrpk7C3SabvCMwUGCFKciLk8aJAvCAxtr+4SaWpIdHnlDhHobixTvWJ07adNfua5W0dz1kvWW7/epQzY827+NWI5ObXQRict37gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786704861; c=relaxed/simple;
	bh=HnH8T9Fr8NyDYDPxLKSWvQ+65tL6EOzX+h0wETKG8Zw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UyYxATGUInVaTXsLK5qjt3iJlr718go3SQkRRjY6HbFki2SK+fdJl1TLtsFgAt+ZMMKiC4OO53V0VnStes8UEJhWhUozHrlU/Txqon0VmmD6GULIxiUN9hZ86SNN3rqY5MqmsBL9Qh1y8qFqYRJsxJReHyp+Ud2ETjivr/z42JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwxH+m08; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwxH+m08"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8fcc43c48f7so8630956d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 03:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786704849; x=1787309649; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z9wVaFbSnynBNgSj4CHKLWF+ZGIc7tLVVGnyb12Jdnk=;
        b=ZwxH+m08uBBG51zj7REEXeJ2nBjkD0qPvn0k6XDHp/qKNc3CnXhauTQv+dzLA3Xx9x
         guWreAHBrYwdScYCL0fUa0QrKepjQFR16AjvZJ3npboyLBc6IfrzYYDgnljlJv30zVSn
         ns3BnJlenvay9aMJe1kyCden1dLkrzMYi5mm0n4gCW+CxfJ1EmkomS+4ZbTfozMXuL6b
         wfjZTLBY4xTNFtuXd+QJev/qHtKE8yz6sqJP3gXnzHzDbbafGA5RaywCKj3IxpWea5kX
         vF0dU6S+I5avc+RJzPcikFQ8QyfFueFbWYydGg6XRbJ7/+CDGrLrDdVFrrkCScH8BuI/
         ZEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786704849; x=1787309649;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z9wVaFbSnynBNgSj4CHKLWF+ZGIc7tLVVGnyb12Jdnk=;
        b=mWtBwPmBmirRLHG1/iThlWMiU3dLJhUtNh30WtupD6fdVVWLYCuY+geqRbe9iE+2eB
         E1EmFt20oI41dXumB7cS82Ad4KdUI2CIgszumAcp99z3DbJDqqZXzGcUFrgKLTeUi6Jk
         UlykG+wdkkHBADepnvM61Aidujzifs99RrHycv26WQmz6G7jo/Q5heBVsfcLw/KH/2z/
         vA1V3FM4d9lWjIhiCsSFIF02K9GxPUd5znIOvMDHUR4LQbmgZwtkGh3CY0tGXeLZCyw6
         iGEiYQ4A1FgKeL3S8nOrpPaRizmxK81dxAjoeK4aJg4ONNwg+dCxEJFTYBEWnOq9NcPN
         zbJg==
X-Gm-Message-State: AOJu0YwRzBxOyC8iC4MbPi9/y0wSEI4TCOcLaTtM6uWrYG8ckffXeyMX
	E6bRI2IbhxhdldhtyR+W8aZXFL0LvYchTuFlaHaeP+k7DfnUOdhkXBZF/oGfZQ==
X-Gm-Gg: AR+sD10E16uesfXPpK3jBVMGEkBZ13/v2WLNm5s56u6AtUcAOdYMby5PrzYe3Xq25Ex
	gGXe4xoBuv5YmmoRd6gvLvZmN8x7cVVxxfH0zHdym7CS4VH/cRi3YbU0a+3P2rgU78U0teraKxS
	zfj7Sgvz1CKO55nuzpC+qylVA9Oolv14Y7kmOmW7tZEELUvEVoUZ/pHSEWoOt7XY13dmnGhUC8k
	UG8wc2SPGpJWKkSpzqCKG/dVrMLTE+IJjMCxGeT/fcZVZsatxUEXtbDgvAr/unc+b0YwLcS8q5f
	rRX1UL+QLlFc7yHvux48/D5R8mcgkzm19mhR61EL0B7jCQlG8fmGXksVvb/cC+bnA1bz7z0jijG
	GCj8H5v10MWmwZQ0LNs9EFciNjpndB1PvGDGA4K+PxKhr3xqeamxIe34MKx/Ti7WV7V4DqP/ZyZ
	fezNzAODsJ1nEDvE0PGQ4A0AiLkDB2Jxlj4rqsDCjBZrW1D3KE4DNpZOvBYS3kgF9MaQo=
X-Received: by 2002:a05:6214:20ec:b0:90a:3c0e:a686 with SMTP id 6a1803df08f44-90a91d03becmr50243956d6.8.1786704849252;
        Fri, 14 Aug 2026 03:54:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.115.95.135])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a93548b24sm14786766d6.36.2026.08.14.03.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:54:08 -0700 (PDT)
Message-ID: <6a7ef3d0.057d2789.39f1ec.8969@mx.google.com>
Date: Fri, 14 Aug 2026 03:54:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1224523492448225524=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 13875017792@163.com
Subject: RE: Bluetooth: btintel_pcie: fix double free of IRQ in remove()
In-Reply-To: <20260814092838.527062-1-13875017792@163.com>
References: <20260814092838.527062-1-13875017792@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1224523492448225524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1145982

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.67 seconds
CheckAllWarning               PASS      29.85 seconds
CheckSparse                   PASS      28.36 seconds
BuildKernel32                 PASS      25.83 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      489.71 seconds
IncrementalBuild              PASS      24.33 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/582

---
Regards,
Linux Bluetooth


--===============1224523492448225524==--
