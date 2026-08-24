Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B060437419B
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787539240; cv=none; b=OAPo9VJ5x5OI3fci7Gh4+gDY7k2btv0X6WGwFVAOfRkWEaphlHC423uUtffNjjCXN4kdL/Rjh7BMPLtwwCFsNTNLX6//+wqhegUnIl0/AT5WGrnAY1DDE5Hx6h/Cep24ZyCetTHy77sxfeSdlbzdyA5Wfb7ijvNJ40uExlNlUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787539240; c=relaxed/simple;
	bh=mskG7dMTR1E4yvjlJqDGEcu/ezSy4OoCLR3KQPC+O3M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ncsOrxT2F0DS+Nz/aBFyem5/H9XDnxvITq93qKpUPL1lQNkQLMnfmmLJTARzQFnLUMi90uQrXY3TVOKoG0YBvKW81Jgwr/AMBB6tiwLt5wEds6xDzv678o3PFpUlXkXSMT40E0IyN4e16FjqRg7stX98tNo6/kWsulKjymS6528=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/hlBpyE; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/hlBpyE"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so2261525a34.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 19:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787539233; x=1788144033; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SX7avr3oYleNvWMnCWflnwhNmvqQhONEGMfYYP/KvW0=;
        b=b/hlBpyEkapOSFaiboVDGY1AeCeW0gfZzNbX5eR3+4Yg/57KV40C1JjgOzOHbnXEsn
         qOaAo+EuucUO34Fpi+bZHOKmGqquRblxL7Fti/wVKcHA/oqRAFEuno8VfU7livTwM21z
         iqz2vafmvtaqxZgyHg4N781VG1cK7EcO1jP8qvnMoeaoBx8uD6BLodjbyBq3BsPV6ZTz
         TDOvv1h2Gm/mc40sMZ3fwAokpaQV4d8Yb8RBkE+D6EjzKAp/rgPMWkw66lRx0nM0KE7r
         RhFjjr+OWPR0Ppm8433+u4HW/kAtuo+5FARc2J2maZqQn7yA3Y0VqtKiX4azDVURA2Re
         Uw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787539233; x=1788144033;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SX7avr3oYleNvWMnCWflnwhNmvqQhONEGMfYYP/KvW0=;
        b=sygxJrn2OW8iM4nvRT9j/XLnu9hyL8tjwD20Hv6DUjGr8HYwbY8fsaREY17ckejWcB
         ZbbPNVDa/pPWv8SXB2H+D3/vx6KHpUjbqCiFn/ol1kkySajhofiLDGOUPRJzkNW3CoZe
         WaX4U/VQsD+gKj6CMKZ3XN9DfPJOfpgXNYxOO+6S6PC5E7YTDI6Z3UgUfDEkuK7ycMKi
         ibqexkhfJjR0rYl+HmxIwOvYjTfwCvC2IMAjbJGDOkXAB17DiYa+QabMD1/5dfsiqM4B
         w99mL/QlClBhfxXj7hZapEaqa/5Qn8HEekfmK7ozFePdRsnb13AgCAGT4/L1JwhRKwRc
         jo6w==
X-Gm-Message-State: AFuF++nuoMclKHlarIjn59FULPyaQYZB2Ix3zDYeAT1y6RKqazn3GFNq
	K04GYdFAmj3oDxEDUZFOas2iMESh/1G+Q+apqZT9kRpAaqXw1TRitdS6n3kVeA==
X-Gm-Gg: AR+sD12rVPFeJ8pk+HU8K5YCozdgv0ASGwvOk7u0Xqz2XFuo1oVWgbh6Qri9Czy2zOD
	U8R+W/UJAhuAhq9TFyHBcFmYnfRknAzjkGYLalhyaQc9cov389w5wTmSYqvwVoLRoHbqCb5ZoOW
	ROZQOopC9sZUTUQp/OAV0c2vh2f+G5RTk42Z5FFJDcf154wrs4ks8wT/fPJRQOt70UaiHS/wuNt
	FthKW6NqNPw4xBs5U4lVXXoBbMV10oyY2juYHNl2JjrB9z0V/H1ze0EHjo8WPcmPxzo6rKElrKv
	3g8TU/82Ca4d24QttuL3SeNp4N9WzcgJ8vpEXQnHDZ+EubeNlYzhqIsjiz7bectlvlCmnHydY57
	VqYHM6Gak3Me6ZzktCTu9ytUF4+XL/fuwYeZB6o0LGBX0SDwl9wR+FEJMw4x9ucWErkKbQVkz6k
	KVrvYRGxTtuB5Z6Vgaa9cYPx25ZQQWRGCpi5HdZvYDPDGhDKlFXx7W0SyVi+AsB0+hV963
X-Received: by 2002:a05:6830:838d:b0:7e9:c76c:abe3 with SMTP id 46e09a7af769-7f461319e65mr25414557a34.6.1787539232868;
        Sun, 23 Aug 2026 19:40:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.237.132])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fc4f367sm2930836a34.17.2026.08.23.19.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 19:40:32 -0700 (PDT)
Message-ID: <6a8baf20.6e22276e.255d06.d0d7@mx.google.com>
Date: Sun, 23 Aug 2026 19:40:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4942113441903703145=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, liujiajia@kylinos.cn
Subject: RE: [v4,1/2] Bluetooth: btusb: mediatek: Fix leaked runtime PM reference in reset
In-Reply-To: <59a4c09e1cb02ad8c375a08e5af164d64a3d7061.1787477831.git.liujia6264@gmail.com>
References: <59a4c09e1cb02ad8c375a08e5af164d64a3d7061.1787477831.git.liujia6264@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4942113441903703145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1150542

---Test result---

Test Summary:
CheckPatch                    PASS      1.01 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      17.72 seconds
CheckAllWarning               PASS      19.43 seconds
CheckSparse                   PASS      18.31 seconds
BuildKernel32                 PASS      17.08 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      310.98 seconds
IncrementalBuild              PASS      17.92 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/639

---
Regards,
Linux Bluetooth


--===============4942113441903703145==--
