Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048BA28850D
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 01:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776215538; cv=none; b=Dgx/sT3zeSKwFvJKkQuY0+9uUDivyTctykN63lNiDgyVeXdrF793WlJVCr61TVIbCvOAp0hE0j61ti2wMPzvhZG2lnjzXg4CkHVw5iuA12jjrL+VFAEHH1z+X+0xdKgCnndP47YBrfIQeh1aJ+7SJ/q0TTjuAW26kLJa5xHMzgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776215538; c=relaxed/simple;
	bh=QFifgtdB6En/hGFPs6oXQeg9KyWnIFc1jCRBXf9kRkY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GDVa+Xgm/r0AhK7OVlHMIyD6QlJYg5lr2Mprz5bcLpyb+REPzugLbHrLZK+HxdDCDykGhl9zaNWch1HV5trptYuxQxdVOr9GlCkfNukIKLq33CP0KBZ51o63LbJfnLMHalwMGeYZyRmyop6tKcvtL8cM8o8+MExJB7/4cGZpfgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pfVYMZJk; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfVYMZJk"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c19d23b19so7281030c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 18:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776215536; x=1776820336; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QFifgtdB6En/hGFPs6oXQeg9KyWnIFc1jCRBXf9kRkY=;
        b=pfVYMZJkiuT26cxo5igeS9+02j40wK9V3cYfKWzfxkR3i7QYyHIRxUlL6beGjTIFS+
         5LwN+kZABFwBBnWKYY+wNhwCN7YfaGybGwGycdz/2C4mBhpl8BFwvppM/OQscgJM3F9l
         rYX+pAWp01gItwSbfVUVO9hfvEDHZZBsWjkT/UhkalifHYiKujXFs1iLSEjHemaU+ppO
         20fXCHF3o6Lm5ZXzwGCy63vlx0GoVvlDuoKZY+lusQs1rFrhGIM208K2JcT2lrC6GYUl
         LizTJOXPN5qq/m1aas4Uu0JQ9DeVw1sV/wSib7UHRVXHxsN0zK0XKyA9FeB5laYV2Lc/
         H+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776215536; x=1776820336;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFifgtdB6En/hGFPs6oXQeg9KyWnIFc1jCRBXf9kRkY=;
        b=gMQ7Kwm49QttImm00pYYJqjqs0vXnNHGXjcduHI3tJAqGdcbtwCLiFdFfP8E6vRFw0
         pRZaTl1sheqLlHXXPYtOZNA7J7TL4xtSYBZyHCVW4LuGDAjF8MQyplGp+7M37MD/iuyZ
         SoBBHinAsTtKgaIR1O9h59Y5zaKcQVie04pOFUVq6EhhzwVDEsIuZbIE87JE7GHeesjX
         hbBslR4wE4p3bM/GddVhT5TBNXY0O9QAZz79HAMa+9YFBYavwQhKLohsuExUfV/GUkQz
         cbqV/9okOPhOIKSlzpBfoxChg8DhbvINkfUS/xTj+CQmtnJuM5QIVo7j8UuBjzPhCDQF
         c4Xg==
X-Gm-Message-State: AOJu0Yw+C7p17f4WPXcfmVlCDNo3hRJni1AFjtw3AtG1JgUoAOxAwgl2
	ZXkQX3Zv8eTYkR8vJFJoEJJCRyBy1PRbHKPnrwka+FE5LbGdDJA8oqU/ocoF1g==
X-Gm-Gg: AeBDiesrwVh2G9BWL+aaA/7KK1TPfaJ4fRlqAIxTBZ6PxKUPhw8jUQR07Vx3bsdCxVr
	bNwwKaApr5Lcu/0GJUErytd6d4NLSPMSFcNSfdjVMb5eujPk30Vp40SHampYYCcp7kjIi4tAWCu
	K8X8ayZ0awt76r8aKG+xdd1lcp9z/+K8KG9stA7G+UgGThXoftRVCryXafCFGnTz441xixWcslh
	ea9hLk6xb7DwgauMTInyCq0Rk+bReBb4NbL02HLgqFI8jjoTeEQZ1A7HrKYllpgWT0K5+9bjXil
	Z0I60PiNA/+UWEFPgWLGW66OOAmN6AnSFDCqbdB9yIXZxN/J5PDMMWk85752okBZJmYjvc9PsFQ
	yV4yZUlbIXnuFKtFNOdu9YZIzMpaEZ/PPpYUVQfnuULuEIc+z5ay6xl9m8eS5B44gvbRV+4arui
	Q5FjsZQOQ4zcWM2Lzo4lHVGpR9aROI6YlJS7aodjUujLk4XvVD+aE=
X-Received: by 2002:a05:7022:7f0b:b0:12c:3d3c:ac08 with SMTP id a92af1059eb24-12c3d3cb6a7mr5028789c88.4.1776215535560;
        Tue, 14 Apr 2026 18:12:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.74.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e6a860fsm98831c88.11.2026.04.14.18.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 18:12:14 -0700 (PDT)
Message-ID: <69dee5ee.050a0220.29f842.6c94@mx.google.com>
Date: Tue, 14 Apr 2026 18:12:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2290608501428029137=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, feng@innora.ai
Subject: RE: [v2] Bluetooth: L2CAP: Fix ECRED reconf rsp channel teardown race
In-Reply-To: <20260415004725.39215-1-feng@innora.ai>
References: <20260415004725.39215-1-feng@innora.ai>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2290608501428029137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/l2cap_core.c:5473
error: net/bluetooth/l2cap_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2290608501428029137==--
