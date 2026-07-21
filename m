Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE8D1A3166
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 04:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784607238; cv=none; b=dNY9R5LqzJoPOIoeQnTwtxnHn+jOzq45nONirLkd+X8YqZREjj1QlCRv6XecQBC+gmQtjQO36Vv5R9UHK7GBCkvjD+HD7yJe1oWk1EUPA0BUymZ7LB+3ArZfqJ3NAOBX3tm/rg0dAQoZNJ/mJL5HazWpblo9gwtALg7nPCTUzH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784607238; c=relaxed/simple;
	bh=3lTt7XI21PfoSJaD9AFFZNYxq6VxvSBqgB0p8yLnnEU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VeDwSWbke8AptbUgfBCwGWLw/s0Xt12JCduEYV5Kr9kHF7TjuQYNMbkk0hyhPzSGLzs/kVtP3/XP7mrA4cmGVp7SRaATHcEGbiGrjaIPGYMppzhpxBOxqE/7KC8UsMa9YqZkZpah5Mr74gqbT4F3Zz/sdVF3sCBfyzvu1iYRhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBI38uS2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBI38uS2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cace91f112so111024155ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 21:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784607235; x=1785212035; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=adV2x45/jyRZrNRYwJJwRkQTonNlE1pYWdfZWHyIzT8=;
        b=cBI38uS23YcBwDY/hiz87dTfDdo0rscce32Ripc5Y7JVXW++oRkA6j6FyF79k1ZfWO
         6CZHHTf0/R0cGwF4wh/68q1IJs/syCHX+P1S1oQO7nHJhwxI9ApWBwGCUHsCmGAFnTco
         rcGBfK6Wr5scHP8MfL8bUZYXTBuK6K5la2riRCn0NgcElgEXLDY3MLarBoXDLnqF2YpM
         IuvDIEc7h5Y0ItAQKuiZrPA00XIv9ZLzOPsQGYUYPLMaGaA/Ygf2l8l9tdpu630Ohm/n
         4HS/Z3VhMysCpBhIkydUEn40PaCQ7MYXbFXcXbuxhNqruXNMqjPunytjHpCMUUY/P6O9
         JGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784607235; x=1785212035;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=adV2x45/jyRZrNRYwJJwRkQTonNlE1pYWdfZWHyIzT8=;
        b=eLfcE/h0JPFDnRC/6ier8C/Z/1y2mL2MZ6iF5tcw5tWc23O2yKsCGVHJJqckTQv+9l
         uT869KMeoh8Yo5impE0g6JpV6+TbIc7MvWdVJtsu5xEPowX+kUAPh+4pE6vPCfVrVqDP
         vjx9l3+hXbWjSO2Hxko874WTWdM+EBmfwXb0dcYuRfQDznIwAylZ6JxwEV0ck9O8mRN8
         dhdrlbl2Egc07GodkQgBcar9nmwa7dzzhJpXzxa7BK9cGT0a+SvOe2oFFbCB/SbyBtXU
         Mx9iLkFt3ymJ6u+68/i9Xrt0MR3BkTFrNuV6i5a93tLwb0MfZeul7oLny4s5JdXdCPxd
         P5mQ==
X-Gm-Message-State: AOJu0Yx87ueqPc9TpywkEZ5CPi1PrGPxQjF7UGtEoK/o5VHRAbzaelYU
	SjGuktH/TFo1Bt45OSqTtkJGLPDQnR38nwdd+fyxDna7du2gnRnTTW///+vkUg==
X-Gm-Gg: AfdE7ckfjoLlS+zbvN8KgjuT94hTMZ9Sdw0h2U46v61zNs5KyU3wKtyFqycDD9fGLe2
	WAd/hs38Le97gFR9EqIJ0wceAZrdApN1T1HQtwIMabyMnp1rhI6Bh3W77Xi3TuLdQtPDW2jQAw8
	Ss9rht5Seu0hNbWvkrIYuxfk95kbH4wJb1H/9QOzSn9gjmqOlglAgq8V5Gg86hcVVYt4ZoLwBtr
	RTQp0EigoYJ2dIwS76Oj6oGP8xcKbCEtiEBx/1Ao6mcbfBbDv/rQwJzhxsOx09RKQx2DkXOMyJK
	V5rYN1S4EDxkQy3uvLgGGCTKFmIHoWbSd33M5EJNnPXjvR604xjnINOq03ZA9OCkegLSwIJwKt9
	zZDbbk+lv5lwaqzK59mEOKBn/2E8wog1WD9hlNc2KML6upGBaliF/SPvk5LCOXjn9MPylpc303k
	XaGtUnX/W3lUY=
X-Received: by 2002:a05:6a20:cc0b:b0:3a3:a9c4:3d60 with SMTP id adf61e73a8af0-3c3ad7ac045mr18150135637.27.1784607234785;
        Mon, 20 Jul 2026 21:13:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.200.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bb8a4sm45460298eec.14.2026.07.20.21.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 21:13:54 -0700 (PDT)
Message-ID: <6a5ef202.0c05e68e.3c2f5d.7b6f@mx.google.com>
Date: Mon, 20 Jul 2026 21:13:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2212748897764251000=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sherry.sun@oss.nxp.com
Subject: RE: [V7] Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq
In-Reply-To: <20260721030458.1160824-1-sherry.sun@oss.nxp.com>
References: <20260721030458.1160824-1-sherry.sun@oss.nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2212748897764251000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1131272

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
VerifyFixes                   PASS      2.25 seconds
VerifySignedoff               PASS      1.70 seconds
GitLint                       PASS      2.26 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      28.61 seconds
CheckAllWarning               PASS      30.39 seconds
CheckSparse                   PASS      29.95 seconds
BuildKernel32                 PASS      26.25 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      502.94 seconds
IncrementalBuild              PASS      25.15 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/467

---
Regards,
Linux Bluetooth


--===============2212748897764251000==--
