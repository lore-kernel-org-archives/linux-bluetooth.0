Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71769443A81
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784112662; cv=none; b=s4YXt5NMFwJx473ZSMY+XODQM0qSYGREt9eYD+nrIwrEMVBVVC/rYUT9ULVXVzVcYLLR2P0h427DnnV3xtd/eVycwfuP7gT1Ig0flq024k+GjBwS8gwcYwzeeTlO2pqFuxEPthY4LrNStmtm5IxLowXdFULTcZWrn3x1JCXbKZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784112662; c=relaxed/simple;
	bh=5aodyq3mLoZ2eXAqYdCo4bhv70z4waRjj+cW8v39AG8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QhQ158pfILMm4ldpJ8+zRUQinsLqKfgAiw9cR2UD7yhi5IdZbqQTlB7fBPLDKd0a7bzBZirD6ZuWSvL2dU5DK23MYiSzU+Kl+duzgewdT4O99UiKmDsyQqUP5RAQpgEQzblgKJtY6FegeGaBfUo7WT2N73cOO4h9kuJSi+fMd9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXXoFaPg; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXXoFaPg"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-902fc790cd5so54737076d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 03:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784112659; x=1784717459; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CoPNy+hnPJYG/4FrhXHfXQMIvVY5rXvfOhBZzyRIy74=;
        b=KXXoFaPgbtbYavG5QeBrFr5ZVUZxcAEFpxeDNK8893Cu32ULRZFP0KoIEYZwwwDGJh
         0t419cMJrLtbzqjGIoM2EIFoDmXOXy9RgMgOTUpeOYCUGPmlznhgpCzs+EQi56c9xqub
         Q+KgsOfJNc/kGPTc868OtG2bufPg80KXEoikRm1CZd7xlhb9dN8gDiCVWjj9HP3WZFE5
         Dgnz1fgpXE0G6v1SWNH4scDmrhs78rdy2nOjanaLOci98FpeIkYxX5uqCt4k5p3I4oaf
         9IJ2Hk+Xzx+egHYUazdp8djugZY3aQESx2qKHa/9pZ01CPAeX7945laIwjUpcax2y9iT
         GFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784112659; x=1784717459;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CoPNy+hnPJYG/4FrhXHfXQMIvVY5rXvfOhBZzyRIy74=;
        b=SwwepVX35Z7Fm/r7lr8Nz5u96RqWXBYg+CYtHxGyGmXWYyNaBakJrl+z43wr2b5CoR
         BIK0cBms8fSP1fvK9TtIjJdi6MdUD9DDRCS9oKbuABQuY765FtSCKtqqiZUl7Ad2Y0Yh
         pyJm1bN2+inpBgwhnzYLj9ouQN/YUENkoGaeUCLpmfNnNQkAAGxJEW8nyqnjn04taG6G
         aaGOgsKf0ro8dFL9hrxWn2JqLcx7WUpabSmYfSvcnKNXrbC73rvTUiQCX1v7GSUbtNTK
         iIdOC87C3+IZbC+FDP0m0J6tAoW/i35KusxNRdrLSMlFeheAWvkYTLHWGaTYwkj9KIp9
         gavQ==
X-Gm-Message-State: AOJu0YzW6cVvqj+GFBxTCEyXOdHuD7FNTx5Qs7cOmKxkRAevgrOfiQnx
	LvwoeT0qPSDhmwayhRA6OssPpEe1YJ6cpcr0HGw1ZMZqVv8/01IC5u6lCq36Sg==
X-Gm-Gg: AfdE7cmSFRuVcnuuVh4iBF9m19g7A4uYzVNOUTUDYybZ4jrK5F6+/M4MmgjhEFAZIrD
	jDl1+FonSpK+xekvfQ1NekhnIhgqAlPKz6yeTCr9mSZIYCSOaGffmgf1e35gqxQJrIH8h8iFu9c
	t7iDl6LRXIlMw4cTK7yS7DGSNIfK49xJwzZbNkls3X7MQXZwX7vENAPAKbIEh/XOgU41++nBn99
	JYSB7Oy6iOiK4o1Ag6rrTZLhR14J5i2JJXvxZbhZHgg7IXEI/lzJBG6IuwL79GhkOrl0+wXG1nV
	PEvJ/nX/8EGIRmSfYWgVMCWAUTy0zEpDm+7R0hF8x8275kOMQ1paIhvio5BiekMLd3tkUK+gsAr
	sSJdOZpFr8d8v0npDYB+eQb9J2HmtBcWNRXpySoTfMU9QB37hDAx+dg0E/jmVihoQxUN2O/3TPf
	fDg7EkdAQrLSOwKDNeVMUhNe9TYls80Q==
X-Received: by 2002:a05:6214:c4c:b0:8ff:496e:1071 with SMTP id 6a1803df08f44-90747c2eeb4mr87666546d6.1.1784112658607;
        Wed, 15 Jul 2026 03:50:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87c8d4csm207084056d6.44.2026.07.15.03.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 03:50:58 -0700 (PDT)
Message-ID: <6a576612.45cbbc81.84df2.f94e@mx.google.com>
Date: Wed, 15 Jul 2026 03:50:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0348771843949533908=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: RE: Bluetooth: btrtl: validate config entry bounds
In-Reply-To: <20260715083604.28393-1-pengpeng@iscas.ac.cn>
References: <20260715083604.28393-1-pengpeng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0348771843949533908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1128000

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.16 seconds
CheckAllWarning               PASS      29.66 seconds
CheckSparse                   PASS      28.21 seconds
BuildKernel32                 PASS      26.32 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      464.27 seconds
IncrementalBuild              PASS      24.43 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/442

---
Regards,
Linux Bluetooth


--===============0348771843949533908==--
