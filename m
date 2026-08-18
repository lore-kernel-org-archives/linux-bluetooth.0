Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855E352C3C
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049424; cv=none; b=JOnuJnmQjTOoiqjmnx2GHDtnghiLmtqR3Oos/8WbDYLynUwms/zdMPOYZIl0+njArlbpyGquIku3M09D65XEyrtv1IQSpTwnEUl5undnLH6xLkiDZvlGItjY54jIElhMnCHEJEeD57HcXmr/Dv+8XJtrRefxGTDn9scSZlPGriE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049424; c=relaxed/simple;
	bh=3KasoFhtjpggFokhU5AklkXi0vJzE8KIaFk81mwF54U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VbS9Aanr8IagQ+9bSCkb60E/7l6n8N6aCIrWcjfUQk5Rgly22blk/AxgpE2oe9s1jfJqrTKQnNp12EZZzQID3YdznivgFnszbLOpKaPO7llB4hhAkhiIievEZs7ay4ioBYk38G6a11hwuZj7UlV3pBwhYEHm79bYzJRYkyIAMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X51Z6dPn; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X51Z6dPn"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-930f618435cso258549985a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 03:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787049422; x=1787654222; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bl8kEFEfE/+g37Ux9zbwhW30qD2aF82VrIWPT3MNU24=;
        b=X51Z6dPnWrjv/PyW5nvf5Z7hXkRMIw3EDq0BehFDGNQ8QE5surWmYxQNN75MNhL72v
         SY+/0ylePusHOXrWWIN5uSys6kvXGIzv+Pg5GY3fm5+AhIOSWLe4HC4nEj3b3fADXhK3
         qbJalddjiywIpkXvCt79SIcn4p6qImlOHuER4AmXil1Cqs3wK+OcSmSafR4SH4MeS4my
         9cWsUKwPJ81aT5ZkjnV+luQ4+v1w98gRVYZ1uEEfmtVmRziv/BF+WK9lH8mN/zk2s9ms
         st3HFNBx0z7UANcGDCoeUXIVGYUroF27KiwQGmyaDM3JKei6sseZHNk/yTry86k0PU1u
         nG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049422; x=1787654222;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bl8kEFEfE/+g37Ux9zbwhW30qD2aF82VrIWPT3MNU24=;
        b=qImdcXex1uZZtByI1u+DQ0Dhsk1VbTO+yEnEHdQiYs49yuJUHV3P+q5F4Gh2OE5+jp
         kpAlqZokbGiHFK24qXkJ8ih6gFXpFxsrxcu4fE3E0W8T6RtsaS5dL5PoPyCKPQMvfZ2/
         dnTUA6iCO1JcGZq5FsZraX3BzmgB8DXjIFoyXs/dhVnhjeb/kBOwdHnUbgMxkaWyIgni
         EgrPvedkcl5/3bB5HMWu8OtoxVm2Tk9QFKbl/Qi46KMvTf/BrDPRBoMevqhsUAEAaFMJ
         B3oppzeVSQDK3D2lxE2Me8Lflp4Sa3VBKwZXWsCrsXlE4cDNuOvn+6tO9k9CiMt6evg8
         T9eA==
X-Gm-Message-State: AOJu0YyKJ+y1bUZoekbGVK/4RN4ed124AAcEe42zxx8Yz7SEKYXCbyEn
	Ffxhd49PY2hPj0jXgxN5MC3zda3YO4uvvhsbPge/B+AFtrirR7ZaiRMdgGX5Yw==
X-Gm-Gg: AR+sD13ilgF8I+LK1iSNja3hRf3/IwTkByw3T1Nc0/gZ/bFPItW8XXD49bJbcRRqE+w
	WX/IKKoHVlDP6gyieWwU2Vjy8m+fMLIDHv96DU21KDo2pgrRIMeobYafvVrnuVgy9Iod8nojVgy
	IlJ4+Wdl6gCuZwxam2lSJ4dZH3WkFih1jWqjc6LujE4eIxKX1ON95OvYKzcYlMZG2wLeEcauLjj
	G/5qs6F9XGV5fG8cn1DueL85SG9oh46Pp/kH2b+UhN8pP2L671lWA2GEFJ/RAAnQ3sY2AiGwOru
	4hV0H1xKs5fS+Co9SxiuRQhVOzFUT1QnmnKaK9Af09nbYfxuRNg5E6q8p31VI69Yt68H/JgEbF5
	0GcRwP2JyjiDh/zOs3ofsjVtTEeKfSyInzpT5axHsHyiCqn0PQJxemuUZ2aSuouO9s+T0RjWj3J
	ElL/43ZIibQqdpJw85rqgVZKQRYEqJIX7Sf9Xi11YH8WCJ94WXvfZoJar0nB2wbMqLkfI=
X-Received: by 2002:a05:620a:a188:20b0:936:9fd4:e2bf with SMTP id af79cd13be357-936d230fc18mr2450766085a.37.1787049422279;
        Tue, 18 Aug 2026 03:37:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9370342513bsm256223685a.40.2026.08.18.03.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:37:01 -0700 (PDT)
Message-ID: <6a8435cd.0ea1c686.251490.1a49@mx.google.com>
Date: Tue, 18 Aug 2026 03:37:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3860049605218792014=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ljs@kernel.org
Subject: RE: Bluetooth: hci_bcm4377: Ignore reserved PHY in ext adv reports on BCM4378
In-Reply-To: <20260818-fix-bcm4378-ext-adv-v1-1-81a143eac194@kernel.org>
References: <20260818-fix-bcm4378-ext-adv-v1-1-81a143eac194@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3860049605218792014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147701

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.42 seconds
VerifySignedoff               PASS      0.18 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.73 seconds
CheckAllWarning               PASS      28.79 seconds
CheckSparse                   PASS      27.87 seconds
BuildKernel32                 PASS      25.54 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      462.35 seconds
IncrementalBuild              PASS      25.06 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/607

---
Regards,
Linux Bluetooth


--===============3860049605218792014==--
