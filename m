Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E90368D7C
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757453; cv=none; b=a6g+HRpsbRFxPPSMukzSM5kG4tnS6HlD5mmYk3q4ZNFC9ShtTapB0NnuG46fwAvIL4OvGZOKwPWThClS/evty7cHNFQjdyFLlzM6PKnr92KDRsU9yPtVugDer3Jm7A0y48xTE8Sow1xvmNDkXBqghTFToaoOqbZk12j8fhp+BBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757453; c=relaxed/simple;
	bh=ytM/GT87CJkwm/pHVhYPtXl7r7mK4EBjg/KTtwW5PMA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AbtxtV3bu5ehEVJHnJT7RY1n99nuuQw6GejXyiho2ox6l7mKfbHoBhjQZR/VXZ5zblg+7ZpLiIhB4hYVi+5dqWmtGIcyXu9skHD9IvXlZW9fQ3vJFn4EOcjSgzYfoPRZCxa7xXYpxo/o5fy+XXubteWcBU7XSGuUE/9mIEe1pM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=stwa1Zgd; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stwa1Zgd"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8efb708b1a0so17655296d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 11:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782757452; x=1783362252; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kv0oYWKjcB+l9QqBP2KEZxk5KR72AVr/OCnIYSppEnw=;
        b=stwa1Zgd2R0G3letjJ+EYecx2/sxUwo1J41j961FYiLI5PxmdkAbUb0HYILPZzS+t3
         HeDSgCwlMSCaml2Q1rskpgB3OyeTtfJSG/gRLe5GrcqPcZfVpDNuwS5IM16GoZvUJ86l
         zsx8kuHNhirwi18YMPUkNWrvI6QegdcI9k/zDGGiOLzKI9joka2cJOO1+gsDB91ylh5A
         apojezcNGTb+u3Uk3lgVtvcc5guayGkc757X4sVvy7zZ24UG0mTUvUzVi5wjazb9y585
         DeR2jw74HSERZArajuUrtLcCEhoXDPmZxEoluD0oim3Y3wuGHiKy0MEFttKVvAoJoom8
         V4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757452; x=1783362252;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kv0oYWKjcB+l9QqBP2KEZxk5KR72AVr/OCnIYSppEnw=;
        b=HFyFE3DKvp3zOGdpO2XPlvzXzZaV638Rr84QTVTwUZSBp764SPGyXU3fG88OJpudo6
         8iwyGTsF5S3M+Ds2NCAXDacI45hwfKBqD7+72UGuBFLTa8DsXOyJQIzGQhpY+QxBz9HL
         +b7d7Tc71d0n5xArlaKKVIblwDvxRrlMYbVcKLmeyTDghBQdLCgbUfAc7FVK60IBm7cw
         jJsbTyqqd6yaCJcUOVB6rWRHouTrx/BjVZQyTNMWNiUJ+M7bDNeDM7syuvZDbvtFMQwP
         gfSujQTLXQf2jbU51dCNNP5D4HeLBizExcj2tteTqa3vVc2TNV2J8ZnewZ8Bx37J9UIC
         cNDw==
X-Gm-Message-State: AOJu0Ywnjex5tkyD/cS7d34t9jjrsr60E2ZwZeWi5yjnP0vIPLIia0N9
	nRPeNI9g+Ho3Dbv7dTSXaHb6iQx1t5ZyAp4JbHp+aeVtd4JOkFoGDZr0u2xzsA==
X-Gm-Gg: AfdE7ckcS5fgnfKEzUb+6veDkkWaGvHTc92XPEF3eq9WgQBhogodZPgKSkDrBpibIXT
	RRXGZhrDtiAPhis3kR4yVnDfhq9+rqUp9nwursMYtC8c3A6TL+wr1iAB0lcn+R44miQfBIeRIiG
	WPaAH39+aiCOae1MkV89A+n+nJziW4J3tOZyYHXHMGI8fSskbeYbvbkBM7wFgRBMjQIe/sPueY4
	yN1oYvXy6jUj9AeWk21I+oKUhSknubaOqmv18RnoT5i5YFmLM6YH/n5g2grlsDzl4VASwkdBBDh
	q/c1C6qtcewXtJuv8jLDtSlKuB7BmcdMwDcDyw3aILVUEBjmA7k1+uFCY8GvJIXgG19RMVV5XsS
	vq89TbV9uP24Agzsy63+NN3DDO7RyU2B7IY+4mSxlmszCT6ks6BVSZipa38d9PYevRJLbTVL6ZK
	l/gM9o2PkZBYc15acYjsvB
X-Received: by 2002:a05:6214:f2b:b0:8e9:f5b0:f621 with SMTP id 6a1803df08f44-8f1bd506babmr6308496d6.49.1782757451481;
        Mon, 29 Jun 2026 11:24:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.210.149.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a6f8c749sm4161056d6.34.2026.06.29.11.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:24:11 -0700 (PDT)
Message-ID: <6a42b84b.d0999061.203e34.d728@mx.google.com>
Date: Mon, 29 Jun 2026 11:24:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3432708353119823376=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Refactor FLR to use device_reprobe()
In-Reply-To: <20260629134657.89584-1-kiran.k@intel.com>
References: <20260629134657.89584-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3432708353119823376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1118318

---Test result---

Test Summary:
CheckPatch                    PASS      1.27 seconds
VerifyFixes                   PASS      0.20 seconds
VerifySignedoff               PASS      0.20 seconds
GitLint                       PASS      0.72 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      25.29 seconds
CheckAllWarning               PASS      28.44 seconds
CheckSparse                   PASS      27.39 seconds
BuildKernel32                 PASS      32.92 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      458.70 seconds
IncrementalBuild              PASS      24.94 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/369

---
Regards,
Linux Bluetooth


--===============3432708353119823376==--
