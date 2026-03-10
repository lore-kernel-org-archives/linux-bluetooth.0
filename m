Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E33E868B
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146841; cv=none; b=oUYCzNp1on48TLJzu+i9pv4criUhIIA2TF1qtEV9f1MZNlMph8aHWoicoyJ/q3Ql/dAeQhT+i42mqakToJC1oC6xlNHxo58+UWtfpBI/MGovcE1wZZ8LN0OF9kFmKasOlWAdnuG7YH/EQ/euU4tbZEIgBT9aiYI6usgdFUchT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146841; c=relaxed/simple;
	bh=8F/KzqIomhbm4U2+FI2/OFnUNWrtYRgSkU29Ye0xf7k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IC/dqmDJWKeAc96rgT5PsxasVNc/o/CHIr01dynDDg9f1WqFRRekt/2Z3iuRlQekrAaeCnQwvjW98BRIDexymGyxSqvJUNqXPsxPL9lUvkiw20tu2DBi5Mv8L+TW9WOTn62CAw9FCvNm/AtTKodtaIqBoCZgJKO7t9hywfHLJqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGQKLiVp; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGQKLiVp"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c6f21c2d81so1202985385a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773146839; x=1773751639; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8F/KzqIomhbm4U2+FI2/OFnUNWrtYRgSkU29Ye0xf7k=;
        b=NGQKLiVpS4gJfV94GrEzqxkfqltTGLPQRm3AVQ3pUZJMZguPdPD+hCbgXL158nLCUf
         vNLFuwyEGsQs/BMLR5MlgSvNIzdjQ/EirabA8Z+ao5TqgSP8DsIKNj5jWJWQJYMyZ07D
         SyyF/MfG+fMIhiWsJdn//6n1TaMLFf7pBKDJG5pOQa6RbFvFzdIHKRFEKz8OqfARj8zN
         yZmyasDxj0tFJShKZU2/p5Bn1tQkrqnK26gOiVuQA3g8k3hy6OAF3qEieQttpIPYmdLX
         NNJW673e/4OSiTVOmKO8QrNhcNrWHAXFI4KFl9ax4shWD/guHkQyqdQGzvr5blhNfTjN
         kgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773146839; x=1773751639;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F/KzqIomhbm4U2+FI2/OFnUNWrtYRgSkU29Ye0xf7k=;
        b=rz620Wt6s2hdzwK6rIyigrwscS2DiOdSrwR6IeiBUPX8wLeuo2D7/3Idwg23Zacfla
         wz2BBZ6ePsfypPcWxIkXpZ5HcAwBNrBn1xVEh+peMssZxWPgwSpy8v6qifd6e5Nv8sIL
         6eU7Ep1FH2o2Qt98geSv6LImB9PxIRc85BpomehWtfyR8wKX+iHWhy+uYLpX+z9rjNvV
         h2UW48b8FoajNCcH9OLa7pvYpViOgCVF7uO4BOwOQQFB/DFHnQaMjtxC2zI9WRCDSYEk
         biGVtzp6cMr8uJDKdU2AWu8Av+pzph8v81ZW0DJn6gkVmCLHYcDMCI6euZjvG+oe5G2t
         rlVw==
X-Gm-Message-State: AOJu0YyBNRdCUVL2+gTsqFvNM6tmC7aP0AD8ntNYW+Lx7KkLiPbmjPFa
	bwIeGxZG3ILVlaXsEifIcDidbkqE/5oPOJxAiP+mgwFBz8Eabc4DNXCcy3WdBA==
X-Gm-Gg: ATEYQzxPFlEk4pjenjuj5ak4vQNtXX9Na/v/04NZ8xfA/DObIW8GTWJ+kWA/1jBL83Q
	uXN1dQPFv2aHPibupQwDjpHFH9w+F5F4BS7bwA7hOWKXdpym7pTTnq7bpW0eHH70KGGcwcVf3Zy
	CWz6UUwRfQ2DqS3qqYmgfsSNUcKqv/FMdWAeFU650gBzxLf1leHxNtOLZeunpnSOj/yqCCB40JE
	VRkSW6qEpHpSUZg30XiCKW9pSpYGEo1ghxOWyqbyqVvawQeCudCq+witu2Dt84v5ccZ17R3c6IF
	ULCW00qDe0E/mZev/VsZI9NTjXGmV5eAgGgnoK3cwsNjzD/seK1BKZNWl3le/vDEETEXmmSJJci
	JqYSR9tVd9QKx4MevAf8DW7B9CxVzAgPJst68IYooUm770Xn5ZfbPWVuAulU1BpQ8El9YsHEE+y
	ob3MMfI/vXZgzKAu4Na3ucVZbAId+gyA==
X-Received: by 2002:a05:620a:1a14:b0:8c6:a72f:fd56 with SMTP id af79cd13be357-8cd6d40d38bmr1938609385a.29.1773146839034;
        Tue, 10 Mar 2026 05:47:19 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f54bb7csm869291685a.38.2026.03.10.05.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:47:18 -0700 (PDT)
Message-ID: <69b012d6.050a0220.13143a.3259@mx.google.com>
Date: Tue, 10 Mar 2026 05:47:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3064233230097665983=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, phahn-oss@avm.de
Subject: RE: treewide: Use IS_ERR_OR_NULL over manual NULL check - refactor
In-Reply-To: <20260310-b4-is_err_or_null-v1-1-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-1-bd63b656022d@avm.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3064233230097665983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: fs/btrfs/transaction.c:1737
error: fs/btrfs/transaction.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3064233230097665983==--
