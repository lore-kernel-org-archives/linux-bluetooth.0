Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22114322F8
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800811; cv=none; b=dQeEyaM3xn15VsqHkWV34DpkdeUkB8prANKSIMih4cS3Rf070aq5W4B3GoSjg+VuqkxAzSHi4lqooyhWwadAiNsqaMGVDBt/6nbKUh0x6BGGdyPfqyP2af6GCVaJMEOfKTtSOFVbh24w0zLKMutWIDXbnsaprtRa/6/pd+Il9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800811; c=relaxed/simple;
	bh=f+k0h0F8g702U/+W3yW6aNoQqyXqYN3ZvNH4C9EPXUc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VWJn1llNYj4+G6nRDdjFjHDy/7HIBRtBjUffRP7LQRKsk9iXP6wS+qekfMPngdKECfk4W73+pvuIyj+PYKmPOCy2A93/nU0h7+RgCrhBFnJbPDSiRmjdw7XgpBPT/75c9osmuahsgeAwgBK9J/CzLwz1XUzz8x4o2z4mvrkggho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQjkYgic; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQjkYgic"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e6391b114so34899185a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 03:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784800809; x=1785405609; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LoW0MMrjxuu2QE9kK3XNu4kpP2cBEYL9OxCc7JHJzfI=;
        b=lQjkYgicNLgjsLno5t6Os5pMZg0Ly7afy3rzPM0Q/bn9XWFZM69lRoipRqsE37QvPF
         QRY1X+ybkOGApdU3xWH2GsABMWI8HKGGWHCRwcaA1Q62paEqGO6JOK5D2cdYXQnmitNd
         JQ2HldXSmEjREBbEiceWRDbBJJL1ICAXGkJzg2RBXfp7505Fzl2K36W0sXjTwaBZncOH
         9C6WjjKSthfzyofXlL9EUBIw37lOwo2rzL2yw0alLNcQmPLKyje/8objNS1nPJIQnxFY
         K7r8gzc2aYYLzkkx53tXxS39RSQrOArK7aakZ/C4pFRoSEqv1oLSuVhqD8Wx1uU4hEPZ
         7yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784800809; x=1785405609;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LoW0MMrjxuu2QE9kK3XNu4kpP2cBEYL9OxCc7JHJzfI=;
        b=X0aHlUnnPmPNZuUPVOp5F1oZiwxEoqak/Ogke51haG83wt80hGrEAhihWSo+qmuLHt
         tEpdw+hfd7sd350s3mV8UiEAarXnhebbd052WZRVAZGlYifAFkb7yyIx9DnlaBY2pNaN
         86ieXH+qoL8AXDjf1d2JkBhKCyFnXemU9aGqPfSSg/MxGTtTI6RQQjrG0zgwEFLhN22D
         6emgRJi/c7g91g83XeDHgvfyWGIjIjO+GC3LFXsq6rU23B6rsBx1jlVHhcX2sWe1EK1U
         0JNjov/NzCm/6c3xWpZOyk4OMh0DuWU/mDFAXsDSvyninUCZzPmv0MEM2bkM8biDGRPR
         R5Vg==
X-Gm-Message-State: AOJu0Yy+R7oZ2NEL5kg7Voj3RVHBjG0e8+Q1Z6ZNVdlGe+K5pp/hkMrl
	/mgH0tcKIuefCAoIA/9lPlCRE5QeDWGII0kIGhIeiWkdjTuQ4YHR1JZ3YkMr0g==
X-Gm-Gg: AR+sD11TCLkCqKSgNVjarqet3AjRUghFAQFzResfC/Zd+Ab8vZSeU2D7kS5neCZ9IOX
	NtWw6nVwCtHCdCeOF96/wLHvVs9zTtExQiDBhIddIS25UIJ0MVJaOubd3SE+1Wp5fI/IR+8scYP
	PmxD54Z9gHj8deojuoqbEXd/1xiv93DTrTE/RUuh1OYZWBbNFapmKLH7a4pw4RxFDMYMCcxFBes
	FDVjAidqWBotVeSnC1XbGSEIculcksHqluQQJWFzv03DugiIqIA8KJ5zdo/rSDRMR4Ax43kaUMH
	evuTNVNeNfWs8Q+7V4RPIknzS4GwT1ZEN44fPntK7LIkzxZ3FS8ktoZGEAQavFavJKURWoIUo3O
	1GJcWba2Rjwph2U2wXdWhof65yDwd0/iC5LFsWiuaZgRJ5C3K+ukcPvEAnMyD9nJtUKnMkTGV9e
	kqlVaG0v892zoNUd6Q9XkpTQ==
X-Received: by 2002:a05:620a:170c:b0:930:bd54:c073 with SMTP id af79cd13be357-93103805486mr215807285a.3.1784800808726;
        Thu, 23 Jul 2026 03:00:08 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.200.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a41a47sm376934685a.33.2026.07.23.03.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:00:08 -0700 (PDT)
Message-ID: <6a61e628.e317185c.9e1e.b995@mx.google.com>
Date: Thu, 23 Jul 2026 03:00:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6021043574551777111=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaojiale02@163.com
Subject: RE: Bluetooth: L2CAP: fix UAF in l2cap_le_connect_rsp
In-Reply-To: <20260723064845.2298792-1-yaojiale02@163.com>
References: <20260723064845.2298792-1-yaojiale02@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6021043574551777111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1132977

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.99 seconds
CheckAllWarning               PASS      27.75 seconds
CheckSparse                   PASS      26.60 seconds
BuildKernel32                 PASS      24.67 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      516.43 seconds
TestRunner_l2cap-tester       PASS      63.53 seconds
IncrementalBuild              PASS      25.06 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/480

---
Regards,
Linux Bluetooth


--===============6021043574551777111==--
