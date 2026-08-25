Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170031A2C04
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680709; cv=none; b=kTS04CEeq62q2KS4bARnpVbVUAqNJ4Nv2W/fFz2of1QL3yNRhw0I7Z99ru6EdKHEQsSI4Jbidz9yKERc6Kfmg2rEwCtr9YNYewf+Lgy1lFGOgqiJ8q6UnIez1FkGm1+ad027De/Qqkd8ZgTvjuN83vv71H3rwYdWgcXFZGbpzFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680709; c=relaxed/simple;
	bh=jncsxUB4Ajnru+p8Zciq0mSoCv6QSr4cK094p5rut2M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=f56oGyUyErz6zKF8/jtETwFJjIoQg87QM3x5w9etRDXG8lZnin8loJbPdvLNhEEAoxmA8Ln7Cbq/rTNkt/20EGr8fTekhsNZMpfsK1GhP5QVGPzKVjAd2WfbCmT7qBRBSYifnbD9oMN946sbjcHfKMuxm1McVMNRyDW4ULZ39P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSSXw8Sn; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSSXw8Sn"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so157285a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787680707; x=1788285507; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GvZuYf1QdAs7HXm81yUcPXHglBjCLl5f6lAd/u02KfE=;
        b=iSSXw8SnamWeEAy07ahOGSwvdcny+TMjRmGuuc/Kt5jK8dDW0UfWpQ+5DWTDvDUsx4
         nPWol+ryTK6UPjhRFYJCGr8dKBjvnV90ji1IxiB9fPuaqGiGWwNGjTlXkUii4VcBGiqm
         pr8meUUF5oHCL1+UDUHtu7K6VCiMxzyHlvuO0ndFiDOHjH8CfGYy+a/dGUJP+BqRd76k
         NMpyWNA980zAMmpaq85pn4QTo+luvrt4l3OTolnzvg/zZ4oU/4mAxEsNWlHT7F3Tyh3J
         Q8msHhEp8HbGRnb7hLs0xJ+yVAjwBDPjT0CJCDTf4ZBi9/aTmbYLNXMiHhpZeb/swX/x
         /row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787680707; x=1788285507;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GvZuYf1QdAs7HXm81yUcPXHglBjCLl5f6lAd/u02KfE=;
        b=eIXNSLUOyVpRajm3uAId6QRc622rDwIpXdEtvc1nu5yIUDjcmPYlKBfPEWizMio6H2
         yx5TzvpMKVr74yPv4jZpqma2c6J1kJctxM+zuA+nkYpgg45eY6vKlquWTK5carW7BqGR
         lju6Ek4HfIMbmuXKPjj1xzvtkc3JLnsZDA6AsCCMtgz0Di0m8BYli+TM/V1wnm+fdHYc
         nfY8RGPrI79r+snXPW3EMZnut8XMN6ZX7TZra9IC0N7NB60B+XELOHO1HmuQJ2m9j2/P
         sZKXDAWns3H4vuhciYEWrtenz/yN1FnLqXFO/bRJGM84kCENfiZbIo+gq5VJdqor8Tv/
         oI9A==
X-Gm-Message-State: AFuF++mLru5fcyoMwGXUV3uPP9h6U7yPeu4xcxJip9zWGFOQJ1xuSvdy
	MGjfbE2NkMnkLImWw24WRXT+X+5TybuvaCcUMU106i8TYarlqL3s/88VwW9cgg==
X-Gm-Gg: AR+sD113hfP1PH09JuAZVjkVGKl/OQVTTdHMvNfy2F1yyJZoP9cl+wxxjEJS0xOvUR4
	yCgEcrchEIzLFA8Vik6rPrNbO83rL+ot+z+irGRoOydgJ0id7VlMfjtNjhVZWN1F4LWNAuMKpGB
	Uu3O4o+BU2JFJu5J2fDZAyWyfGJrL/oYKt3rqhqW3nkVeOQr+xfE/dsg3MhklPtDXjEqhqsO/nL
	XUqpj6/SRshRKhRqFvMzT6WgA+2BSoz9AEO3+mAQXrW4h4AqX0yznCOyo1koTqvw9W2/Vypv9mT
	BDfcQ7GjMX+Wl41UaRv0qcgU5oOgZ5P8ePqIGHsgj2h6HQ+XOYeE1FrQgJ9OQToXMpQwpD4jaKu
	rVNa6bp1yXUD8rTTndmsxmSUA3HjgNmRuojsXXuM/ZoCp7wO8dj+2x6U7YaiQ58EbOv4246nZj7
	sFPnCIIoXv1NIS2KK3i0WE1XjX7XQsc45oe1bH6pT0ZvtCIz2dWJ/tIBDSxzckNFjLwqEcKg==
X-Received: by 2002:a17:90a:d2c6:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-3966d3dafb9mr1824184a91.11.1787680707328;
        Tue, 25 Aug 2026 10:58:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.173.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eefd98sm1853982c88.3.2026.08.25.10.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:58:26 -0700 (PDT)
Message-ID: <6a8dd7c2.0318b02e.61962.e3db@mx.google.com>
Date: Tue, 25 Aug 2026 10:58:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6592860716863004914=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Clear automask on spurious interrupts
In-Reply-To: <20260825172300.150440-1-kiran.k@intel.com>
References: <20260825172300.150440-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6592860716863004914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1151649

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.48 seconds
CheckAllWarning               PASS      29.75 seconds
CheckSparse                   PASS      28.62 seconds
BuildKernel32                 PASS      26.17 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      498.41 seconds
IncrementalBuild              PASS      25.39 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/654

---
Regards,
Linux Bluetooth


--===============6592860716863004914==--
