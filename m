Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6A33B27FA
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969564; cv=none; b=EwyyG950Q0OoCQoqU8vvUlibXEcgzpgnXU4VH3i22ELLRTfVM/Qw+XpLp/OViKmtzprjVXkVQ/ELldFMfQ18fAh7du+OxPY5OQ1BKGVe6su3s+NolULp67PoPXyiPE2SGnNmeZzRuDqKZAUzelS5NKabVvqMuBRWyLC2BFKfr90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969564; c=relaxed/simple;
	bh=Ak967clWCgIcWr93EPpYBRqlkI9OfzlqDPkZH2W8cAQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J/IjMh5UtnvpyN1VaQZJZ56wqgdFkX71DMKo2AQSPo3WgEvfsIv7eyv7McSwoFXhlsRb4yz/b6yvRjLwyWODgD6G1uXBe5pimF8qldLwDbdzWho9EWugiK/zAi4RjB3QHJMehN48uFSYcm/WQSu8KGbSrgYBdwUODsG23wd5GN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2dsxls9; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2dsxls9"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90e9e042ee1so61233586d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 08:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788969562; x=1789574362; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uhmpxqgPwanjPdTWCbZRL14xYhryC2Wu678ASNOx9k8=;
        b=n2dsxls9Y0OHjtslC1CODi5BRO2D82NLrfUxkxyvan22ZxZszKstyEEBOZaHARjzcN
         BukB94LOSmoY9hpNSrqQ9kHBw0qx85GNJvd1I3EbgAe0z7dMem5EJqfjoTt5nazlmLsy
         F9ga3e0jpFlc0L4sy15rSUwEMjw90PSvSEcnnd0mRB+fSWfcfA2UQZCbgXK7mDXL2NNu
         U1sVsYQ8d2pT789djxGJNHkVoBJ4g1/4vUJO5NnRVOySpZBV/BD0afsc7xKgC6bqPU6X
         qrorFUzY8s9MsHe1FSV8L9L79G54hZw5iHA2MBirZMOnhKKCWqGAxCg3jmjtN5fLICt7
         kxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788969562; x=1789574362;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uhmpxqgPwanjPdTWCbZRL14xYhryC2Wu678ASNOx9k8=;
        b=hyaKaVqPt/Ab6BAH+fimIJc0ZKK/u3dWrEHQX3msGP+KZPXyPdTBNNv5ZYAHrcTIpr
         y1MsvxzYBlEiAATfgUCLeZKsm6urPdLRlqlKirP+16s5wTFW7livSnnHM7+0XWY2Hcq2
         S+SbVi6y8s0vVyEI5wjR6g1LWxnNEfdUhtKbr74rpvQeLH3c9GH2yk8gUapujEB3YO3x
         j2MJOf3Pm/thu1y0OCekfJqhsd5GJVM3EJ6NGJTx/v36Yuur+/m/BWtU97yQw+nKH5Vv
         vhujREVo9YBw3O2hjd9GOAW4zbOARltT8BSyKuKklAdIkgCRDZdFZK8h38Liz28i+o40
         S9gA==
X-Gm-Message-State: AFuF++k8/WkubxtxR4RgkawWB2pcejcOA0N83NFmJgB2n58VRxm04QER
	eCXcXNysth1+4PgG+dLPvg2uvpPPBOlpaDbOiJAt3LXu3vk/2JAEu/7MkBpwHw==
X-Gm-Gg: AYBFou0ChjkqfW3jyPCjPwd5nwVP/8VU3BGThbrYx6VnFZu4NcFVIeo/3Pt2IoeEQOs
	WDZR9rpz/Gfp31DLpDHGF9oiqbzsOaAfEcb8pp6qmb4iBBdB5qtwUL7Tnjy4tUQ14K6Sb22FiLr
	fuUY+mQmD+0eRZqNH0eCcVGJVAt8AJlvOmNi+o4DZbu6fSx1Oqhwbuig2LUEaoJ1yknar6adwzI
	jClt+VLNgiC0uYqPouDQdvAZeoEk3/zfzBFr+alf/UE53HcuDTB+rSnxlUMRh7oJoN3S3BWLf8d
	nvBcznPuypmwHUsiZ5HjSBTw2V0RzUV1V3f+LfArMCh3f1CFTwAByDy1e2MTd0/B5KkIxF70IBM
	XO3dXNCWFqxLHi9ZKn2PNCXvUEJuvoOh/JhKDpMZ5kIOjM84BgfzMFKoiHa99vFwgQbAP2+6u5t
	W86Ns13kEQUUiTgvAJBQ3E3ba72JwR5788NWskptckWnEGiLxkn1MvtkhZpjlcTZ3UZkDZHRb5X
	UQN
X-Received: by 2002:a05:6214:4187:b0:910:dc14:c709 with SMTP id 6a1803df08f44-910dc14dd93mr22595656d6.19.1788969561638;
        Wed, 09 Sep 2026 08:59:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.14.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91041fa4d65sm140729506d6.15.2026.09.09.08.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:59:21 -0700 (PDT)
Message-ID: <6aa18259.d84cfa41.212e81.69a5@mx.google.com>
Date: Wed, 09 Sep 2026 08:59:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0726288002288477203=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lsa.uz@pm.me
Subject: RE: Bluetooth: btintel_pcie: two PM fixes, assembled as one series
In-Reply-To: <20260909123416.71919-2-lsa.uz@pm.me>
References: <20260909123416.71919-2-lsa.uz@pm.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0726288002288477203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1161304/

---Test result---

Test Summary:
CheckPatch                    PASS      1.88 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.64 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      27.09 seconds
CheckAllWarning               PASS      30.31 seconds
CheckSparse                   PASS      28.86 seconds
BuildKernel32                 PASS      26.31 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      479.13 seconds
IncrementalBuild              PASS      27.58 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/728

---
Regards,
Linux Bluetooth


--===============0726288002288477203==--
