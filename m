Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F68179A3
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 00:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331477; cv=none; b=i5TJ05auNY5pkt07hoLU+HiGcx/QuMBcYfNs40w9eZYwCPCLXMwQRYU9g4X7Gu6ubQb+m/vv0JwEkwYOYagBVHHn2ly62IA1FaY0tu2Cc6s2CsmmzgMaQPtgAtpJFJKqbKh77PAj4PWYwC/YHHTm2Yn2ZvFMMrrb/HRcBdTyI7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331477; c=relaxed/simple;
	bh=CKFQqjafDBKs+RDXjaV4m7rkjDK6LSUA6O78yxNJmvI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NzFPwRBYKSN71miBEw3zEfYRhyaueH1P/Rqak4JDPVwwR3cl1hiGLriV3Cc+PhJ+9saj8IMpMj2ADASx4J8mUIU0Nt3m6kHmc+7vXoSbQpjIK0E9DrisWUx6lgam6ddtdcgT5qSblQ0lD8eBsicfLb3wdF1MGWnEwBPPEyul6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo5fjKk7; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo5fjKk7"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93cbee4b010so208388085a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 17:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791331475; x=1791936275; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B4Z22wO2kp+Fecjdee21OGa4188p/V4lv60Rq2qXt7A=;
        b=Mo5fjKk7ThwLpgAU8MUYSFw8kXs006IY0OuRI6G1+FcrrnGVHzfdvno4N9rvTEK0yl
         WpcigB9cTFTsqqi3jKRnXYs1YNW8PbGn4NQQMJuywM2A93bdqY3wYe5qqVDze7h4sLP+
         w5egGCUqwl1VVTySOxqn6O1HvXuk7gut7QIB/4zZH2vd9SuD90G32dPp+Jzi8s/arOK2
         j2xiM6Aply4P/wE3dcgy1CrzgBUI1sSYGBroAlUG6Z6x7ZDuOsb8uf3kZAzaHQrtW4pb
         tSBbHdNdLLP+X/1JCETdM/5d2viBZmIaN2ujeFMWOEmQWMBhGlvfP1hb4ZI9Yv1tH4ZL
         d8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791331475; x=1791936275;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B4Z22wO2kp+Fecjdee21OGa4188p/V4lv60Rq2qXt7A=;
        b=M1TO6PwWRwL82+BIJil3PPeq4gznKq5R95RZGvWF0KoLzHwXNOUyX0vcCunS2sYvNW
         ccVldeHhnDf9he79GRHPe5kb0O1ijFs7TR196dEEp0mqqlIXvxGoP/+SJnfNU/ma+Bef
         5KFa9LzfCHvofO7bxNiUmSGqAv4qcm1xriG/06ooYRi8f5E465LmTNP60F1NScQfRUx2
         tlmxQUFjwBYL0QC40fUQouloMB5n1kSZLdtAfo6ehXeB0SwQeEXNbMuuYp8H6P1hXu5m
         ywkloCpSa1MnBMmVgUffbCLWdCshQ1qXZg3Nrlndb9hrGQXFPVL5nwdq4XduhRuwiLym
         miHg==
X-Gm-Message-State: AFuF++li26j8VAVn6JpROX7g2L5s4QnkOKwLoy8jN8hceU1y0EwUEx/V
	nzdsDbOKRNOZw6qBQ9jf7Zzq9wTv7YolIkUZE/R4UUcVqys5E/+fz2wmrvb40EtVZsA=
X-Gm-Gg: AYBFou02yuoudacGpj5zjkl9wfE52llMoS0OwB9MngbAJMnNFN1xdJ/Vufqvd7TUIHe
	GY6WheT7AsrkYvR80J9zS3aS+DgmSeV0t2qvqRTiEtKwBU6C4HYovANr3osELopY+nVSg82gHMX
	6amHBWvJrV5/XD2IGB61VCoSKqElowi5CvfdNWhMKg1wjcR334HOAA2p6324pZEUK7KLZ+xM8+J
	nM7K0OiiWoezrzf2+RAB3cfWjN1epmc1QZHHuW40JAVtHzRMUYsABDCLXHEIY+j8NAWDq7uEmZs
	NgJbU7D5y+B1bnIuUbFJpYNL+2S+9HF+TnD97vFbkPuc9xN9OYcVUoZYf5RF6wLgvdMAte+oMvU
	vSFaX9BI+lfPaAcbf/TEKIKIyulHwQeYJJouu4dXoMgBsjVedp8hS18Al/9H4FZjSPU1ogMDkDU
	ut6hOJY1ImeGyQwe+X38h7yCelb77tY/PgSbzZ72w9hQZctUXTCilb/5kRNlRBt97ZB0Zz7jIph
	OkCTIe7
X-Received: by 2002:a05:620a:27cd:b0:93d:78e0:30b2 with SMTP id af79cd13be357-93e9b721dd7mr126271885a.29.1791331474500;
        Tue, 06 Oct 2026 17:04:34 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.102.151])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e991eeb5asm82225485a.41.2026.10.06.17.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 17:04:33 -0700 (PDT)
Message-ID: <6ac58c91.efb6fa4e.234119.07d0@mx.google.com>
Date: Tue, 06 Oct 2026 17:04:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5615874384673582027=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaroslav.voytovych@gmail.com
Subject: RE: [BlueZ,v2] a2dp: Fix crash on NULL stream in transport_cb
In-Reply-To: <20260921204711.211409-1-yaroslav.voytovych@gmail.com>
References: <20260921204711.211409-1-yaroslav.voytovych@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5615874384673582027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,v2] a2dp: Fix crash on NULL stream in transport_cb
   Pull Request: https://github.com/bluez/bluez/pull/2559
   Created:      2026-09-21 22:42:40+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============5615874384673582027==--
