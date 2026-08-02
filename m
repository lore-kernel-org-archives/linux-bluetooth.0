Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376B5381AE5
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785678166; cv=none; b=AdkyqAY1sCuElK1P3xu8sIZPbyBsI9PGr9cZwWvM6pJf/ZcWJuWYATs8eo7q3vjYSpmVGdWIko31dhdRw9lYN81YfOdK6z7sb1qcOQrgotAfxYvONI/hkCBOQfzUqwfL4HRdCo4KiGr57XayzPXCgeRnSu1T2Zx91+LuOTgsJXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785678166; c=relaxed/simple;
	bh=PDlycUDkBEXK/ruXwbnTT7tPM+EsbkgJhkIa+zqEObE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ThEyt1fnXNHkiqVLGKd3Vr6gGFqPeuJKj7bbxh4mnhhL0LioQFqUrEm6migP21evR7YglF1V+dZ/d04KDlnRhZF55SfLrUngIPpjokUinNKE1Ig6MFJzh5uJq/WofJRh8XI3GGd8tKtSljlg7whpgeVN5GqgT4WrxYtL2/c9K54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEWN8ta1; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEWN8ta1"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6acc15016f1so1419389eaf.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2026 06:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785678163; x=1786282963; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VS/Wm1z1GqOutfobiNqucjKAp+u5MXAdq15qXWibl58=;
        b=QEWN8ta1xdgnEMkvSZ63/Ij8dER2Uum4o2zxy/cWjRiV44LeYYw/UE0IrFukZVb3a7
         pecl0qdb5Y94+YgIsmC+k7GIr1R7LZISUeEb07n5JOZyrKdEjAU7a0sYt1SnKQ7Qazbm
         EMTL5nv/EM/UNeSLFs4M/wmn/r4ELoVBubLrEMAIwm8wWyLMVDGvLE8Lrly0Lh0V3cOI
         fX0cYeZvTp5OmL5g25oTCGTWzto/eNlJBJPcdHgR/LhpUI6ZRMk2sTMvA7hc5OfPazb/
         BTPcSjbENFYxzEFrLivZI3+lJTFeGQbGK1uJVRiYqYF3vU5PD1FPKs1D2BSKdYNRW8nv
         Iyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785678163; x=1786282963;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VS/Wm1z1GqOutfobiNqucjKAp+u5MXAdq15qXWibl58=;
        b=ABIPRm+l6UR4EmS08UtI8Q962+MNcuyyn/i2IWEDCVySuL6EiYLX5okJUbwAsCihN3
         FPeH/zcgNr17ApTD/+LisyiJZFMb69P0aBHsulFaOrGmZBsso9u8aSOYhV9s7V3QIgVe
         fsD6Wzh2J0I4prDrgYg1TO/cLUDB9DNDdpRuh1ooidxatAmF1sfUefHDR0yYPS91JtkJ
         /1kIM7idFGv/7lTjyIVjvhJUXXs3Tcew15fWTx+LOnwEEu6vlMz+3AI98wMRDMh7vTph
         I4rpkSirnmCaq/TAxzCVwIf3kNmPLKveKkFFkjOS26t8IxQ9ZXPYiarlV9duBWzRb/Uf
         it1Q==
X-Gm-Message-State: AOJu0Yx5mG+0BNHIT0kx85vocqgtJ/zsspMc+/tWT4VLPEIorYmH7rTg
	HBieUDE76+AtpiEDT+FRlNn8wu2EDggvhvgaW2DktLZhdClRF1NKZP6XEAQ2L/48
X-Gm-Gg: AR+sD11PZN7WVVCXnDcjTyU1QUaTti/vOoRh/Uq05lpe8rz2JASsoHHTCwn/eUngoO2
	axqGepxgluNMrbfuoHN9U4oVIPjP083vdosY7papzrD4aKgrR927EUlWYEWfVVo9Dp71ToF5s32
	EpaKMv4znmZrL0lPuSlq6HKzN7Wo1MaGNCkRAeUft1VpuSC4vQwSY2DwkH6LVqpeNCoKKPX6sa1
	F2pVj+wV99L0a6lWbj8gz2fdeWX/gC/qXTUFQbRtAxEewjnnjIYkQtjw8yvp2WXzypAtIfUcl6b
	qc1oyUvn0pPOyFKIPXoOWVX8tRo4wTMsMU7uIeZxSu6k/Gz3q1pA2qhuWD2hL/YJtBcjP62nq5E
	HuhWiFJ043rcW2XLX1Wv09wbe1GhdWpuDKYE5U4GAzHzU/ZDoq0F+nO2a4RirGIG9XH1cJ2ANs3
	mQUJh4C7ep4t4nYzaEo7F9pVrgMSd3AHsFoCRjby76NFHSuX8q8V775gVkyY9lyyLFr1PC
X-Received: by 2002:a05:6820:168f:b0:6ac:9729:670d with SMTP id 006d021491bc7-6ae43422639mr8949085eaf.33.1785678162800;
        Sun, 02 Aug 2026 06:42:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.245.163])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae39db1c5bsm4679092eaf.5.2026.08.02.06.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 06:42:42 -0700 (PDT)
Message-ID: <6a6f4952.c813de82.b2021.1051@mx.google.com>
Date: Sun, 02 Aug 2026 06:42:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2915253532359386723=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen() vs. put_chan
In-Reply-To: <a5db0837d52496b7b2c23072f5da036b82f1433d.1785672691.git.pav@iki.fi>
References: <a5db0837d52496b7b2c23072f5da036b82f1433d.1785672691.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2915253532359386723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1138893

---Test result---

Test Summary:
CheckPatch                    PASS      9.03 seconds
VerifyFixes                   PASS      3.43 seconds
VerifySignedoff               PASS      1.99 seconds
GitLint                       PASS      0.78 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.55 seconds
CheckAllWarning               PASS      27.10 seconds
CheckSparse                   PASS      25.90 seconds
BuildKernel32                 PASS      23.93 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      451.75 seconds
TestRunner_l2cap-tester       PASS      63.97 seconds
IncrementalBuild              PASS      23.53 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/528

---
Regards,
Linux Bluetooth


--===============2915253532359386723==--
