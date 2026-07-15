Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1CF3B3888
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784135414; cv=none; b=Va33OpIve9e2/x/p4pk7AC6jzLS0yc0dm2/SFcDljgPxVIPpl08nIQz/1/d0zDsMx4tgVveNvavHtWsUswV+ePnD6t9bS5RfdrYYtXYEwvCUXd5tg3CKkQJWP7O3bRePq0LQgu9rFZrIEaE7LWLDLcfzOvyutUd7TGAZ6TfQBdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784135414; c=relaxed/simple;
	bh=rpTtdjIL9VFdLOKMXTzEE4FSFSqUpRJ6IsUltpbOjWI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K6qU4kn5BepW+cFdFgi1sS9A9M9IOp9W/lkBlg/0xm7yCey7jA3O9U461TRb8MEkbnCehgSi2eevZTjGjhZnjCY3SCpPKq7zwYP6Sw7dW76MDl7HGKRMCYQL/GuCeU2sphLDAEfmNlJvLZAS3bV6f5vBz3DF8i9xQDYYTMIwB+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBQbbB1C; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBQbbB1C"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8efcfdb2b43so51622786d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784135410; x=1784740210; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z8Va7sAwng6DaO3zNOJEkyPgXqyfOcrAKQXm3I/nM9w=;
        b=lBQbbB1CQag30JMaX/R/5yCCwyosZqkehmFl6Ybu0TRJhp722f+Ful7+BIxXrwaOt2
         EIb9V03ATr3IDGaMMpAC0O/ICr3zwfoGF+RB95vqS85NYtobs0Rg2Oj+nINu0SZq2dsl
         fB+8EhKuqtDEbFzBqVJ8sZR9M/mDCBnt4XXGnmxGbZywPx3s7Nw813cWf+HXjFIOyOEC
         YFCIDm3uE882ay1wthNaXSD3US4PLE+89mLpoHGYLfACzfA5kEpvJbvsmaR1fD9v27au
         mHLAAYLcE7uHiSQk6nti62wMNFqLhy3KtdEwBkUqP0hu5Lx2qleiqSUeZlY02mlciIE/
         WodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784135410; x=1784740210;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z8Va7sAwng6DaO3zNOJEkyPgXqyfOcrAKQXm3I/nM9w=;
        b=f/vtxB5p1cdrkBUCDKKnyK5Yn4gnDOSyV6+c/kLPd/oNInhQqI19GyBJkwpqkwZgsB
         3VbpEQsALWxpOmF3o4vRetqh9+f8b0yOO1z2SRbnSVu70izrTjAR1FBzS95xbAIRVpLt
         GpXp/qPC813RsRT64aeUxMKmKr48pA2x8fXkGwRxQLQD24oAwpDMq2atRnD73eTJZsLW
         MDVmB/v4HR/lvglWq0pKVw7iixRPZ/+3g3ujVj83bK2kEgjGFUhENHb+0KfWG5ruDWc2
         fe40M8n4VYzKqhLW+nTY6vW2u38tTWpDhrM0LH/tJLKz9Nj9f84eWkfyWdi4ftvArgee
         6kiw==
X-Gm-Message-State: AOJu0YyJded5c1Jdk56V0IxyiQ0uLUE5vI3Yu57Y5nO3NQIm6wM+ph4K
	0zU7sM3XF9JoL83NvDFz83MetfFt05hgPsZEldPC2/aQRrWzRLfyqPwkvHFX2g==
X-Gm-Gg: AfdE7ck44h4n+1Ow7cpLWZIX683SlZEQC3GYh0Wd3UuahRD/6/ciI5trpdzYDiQMD4t
	PccMBa1EA+hoIDBgU3ZBKgnCUkA/6OX/TrsVGhfVuNaJlSQDGiWzvP55s4PIKV2cHh8o/a1D9kL
	oH18KEfmiMjOVp5QUBajSS71W2dlcgdkYrUDMMAKYEFG3LJyhOKAf31h7bcN52M8Uoa0EClzhIw
	wzu5HyPrTCZ685nseh2s7KkMk1VLSSc4invOvYV6QRlpea0X2j+0FsAc0l9dCPNzK0nifPG2G6L
	KAOCGe6XXEEqAYtGoSwExRWpW5bHIDevW+M0X5+vb93Q+TuRARaU47yQdIxxo+86jIHVcJ3zs2i
	0LKEXi2z7C+MVdx9jmIRQcvttOk/G0QywJqeHK9NgztsJHGdfJ+yP5wuhRJJfSSkbS7IeTMIZQQ
	aRYbC9zvg7Pm3XC24V
X-Received: by 2002:ad4:5765:0:b0:8f1:579e:a418 with SMTP id 6a1803df08f44-90758e16c5dmr41286276d6.43.1784135409977;
        Wed, 15 Jul 2026 10:10:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.10.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-900a7f8f5d6sm185408746d6.15.2026.07.15.10.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 10:10:09 -0700 (PDT)
Message-ID: <6a57bef1.fceff8a7.20b165.698d@mx.google.com>
Date: Wed, 15 Jul 2026 10:10:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1624609438858540774=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: serialize reset_type with RECOVERY_IN_PROGRESS
In-Reply-To: <20260715161754.213393-1-kiran.k@intel.com>
References: <20260715161754.213393-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1624609438858540774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1128276

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.98 seconds
CheckAllWarning               PASS      31.07 seconds
CheckSparse                   PASS      29.46 seconds
BuildKernel32                 PASS      26.94 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      501.99 seconds
IncrementalBuild              PASS      25.47 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/446

---
Regards,
Linux Bluetooth


--===============1624609438858540774==--
