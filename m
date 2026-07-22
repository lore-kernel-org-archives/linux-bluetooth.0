Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DA143CE53
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740003; cv=none; b=W4SrJdjFACvBIOCbj85lr7bUm7g7ThgrGFAmR83wqcwdSNeROdgVQSXmOC4GH9PqzhvEWaNRel/R41m7TO+7+eLht8t/aW14XiZ9u+LRyb5wH2G3mXg0/yZ82wOlPj1HLgkwmIB/y1A26MqtmpQwjBr6M2rnIvEyy+hk/83PBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740003; c=relaxed/simple;
	bh=4SeJS5W/t3vrc7q0GaNhy2K2aHCVqfyIKr2YYY5Yc78=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EKZVOAOEYZN5RYk6sDhXCO0EV5xCMcgiGAQ53sCI6+z91E/TeHUXNUaDudjD97PYnGyofAKHN+4wPtN2O+g9wKbj3ms21ZQfMNuZSsPOlx1P3wpZSyXZ627S/WX2HmY5bwm45Z+otMyJFZaHgF+BX1MofGVuChokqbhVfh+DdoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/eAd7vV; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/eAd7vV"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso125213496d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784740001; x=1785344801; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tPdqJ7MQxsJdnoqY00NNbEOUyhEmxur2IN7a5tbArHA=;
        b=F/eAd7vVnD0av98u8zw7VOAbWm4C0BmSIdXSCqGB8TMo8Z/sWNHX+/IGa7UwyRuOdo
         jAaKO0TMS1tywzua7jNm/ctgqk+O29KneSkwR9b+n6F/Dq/9egrOgR6IDGhnc9UaPEio
         bCe/UJtZefseZy7TTvJvmAesnPrDua7fMhHSbXYum4PBX0ZcBxbNwcQL+IFoPu2m/54e
         h013ruNTv2AcOYbaX1Xeuuxb9Iwt+FrPkZx/YhEeFTFu4fplvxsZXKREjnj5GSUx+TLM
         0wUJI0qFE7OmCRW3AQeHQN7Vf+2X1NecrwrKEq/inQv8T0yjxS5VveJp+OgYRIx3Siwh
         1DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784740001; x=1785344801;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tPdqJ7MQxsJdnoqY00NNbEOUyhEmxur2IN7a5tbArHA=;
        b=jm2Rfv2he3LmAyUx0CxVDLYM/HNYH42v3ou8IHtSrmD0gVFug++jbw7iHEZCoUrgh1
         BKvBMwwbiAXeA4dnjCMYTN3w75eWuu3047LmDmnSf5RSUow5SeWZTqs6OLrXy3iGoaeV
         uwAbZt1F1tQIFKTt6XvabesyGlDNNyWLJKI2Bm/vVHoJBX8uF/kLoLe/tap+e8YCjclM
         Z1mQXAN+5idLXrOsCdncuaSx9buIgYDlXSxoNkr5z8r80G6NiVXUVToQ+taTsiWAdrMh
         rABZFYtcU/n3L/D+YFjLy8DT1JCF8mmoxet5tjge5jeIcDEcNyVnSJWAGP1gMuwW5ZqW
         yx1A==
X-Gm-Message-State: AOJu0YzUBGVXUEql86lsc7bEAXbX/facJmOILTWhC/PHOZA4aK0ujtrM
	XL6KLSKNetJo0oPQSCc4L3HRFyxHZxGM0OaPgvWS3MJODAcxEG0DDEaXNC7SQQ==
X-Gm-Gg: AR+sD108M+a2uD6mqJr4zBQHWpz8gHfbzPcGDRqS6UUdfIeS0JCOEkZzq0W3SwUT7at
	OV2Cj5GPU0Arsc31Cdn/Xb3uc6Qm+IppVkSSBoRhILVNwKUXHqMkrdKJIuntv/Pyo4ZajhdE+G9
	9I640dMsxwOdJndMUG8fhXR1/2K3BeSJ1O3UBOsUxWvJnoc46wzg/coTqk8wbAykGBGlg3nsZij
	m32anNM97x0Xq/OYPRaj0wltkXnYYTjrX6DwrH2SDJXfDg0lOZc5jz+KUb55K7iB3iwANgB9OsK
	Y6QbGqDb0bJ+3seEde3nvZc4gOjx4lVag5fFS+DeWfMRXOHg5tZgsMhCRU3gHJSyfnc51OPemUf
	4t8ch0yCzJJiX5niGIHzbhPk+EI/q3DdS4AxfhvoO8CthinTIfis/+BYVCLR/fahYdx02+2InvZ
	WjnCYsFdBd
X-Received: by 2002:a05:6214:4d0a:b0:907:893f:6d8c with SMTP id 6a1803df08f44-907893f6f0fmr207657816d6.55.1784740000860;
        Wed, 22 Jul 2026 10:06:40 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.123.10])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8b92c0sm25449566d6.6.2026.07.22.10.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 10:06:40 -0700 (PDT)
Message-ID: <6a60f8a0.ff298dd7.1b8d7a.d0ec@mx.google.com>
Date: Wed, 22 Jul 2026 10:06:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0943486815548163984=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3] Bluetooth: btintel: Add Bluetooth SAR revision 2 support
In-Reply-To: <20260722155943.296245-1-kiran.k@intel.com>
References: <20260722155943.296245-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0943486815548163984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1132562

---Test result---

Test Summary:
CheckPatch                    PASS      1.12 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      9.44 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      24.99 seconds
CheckAllWarning               PASS      27.63 seconds
CheckSparse                   PASS      26.49 seconds
BuildKernel32                 PASS      24.38 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      464.61 seconds
IncrementalBuild              PASS      24.67 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/477

---
Regards,
Linux Bluetooth


--===============0943486815548163984==--
