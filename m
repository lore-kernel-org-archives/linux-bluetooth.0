Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54221360758
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630160; cv=none; b=hXIpdZPUmoSPiUkTeNXSnF9bRMkoFtKNwAYGKAvP6kCG+JRoRWVNNX8jMo5wHh+tSBdWKBMpx9MFlRG3MvaTNEJOxYCv6Pu1okvtJRnK9AKYuxhbR/RuaAT25sEsJoZEkq5rzzloZEQXUTBITFExaVyoZO9Pdxkkp0QgLb+dJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630160; c=relaxed/simple;
	bh=eUI7HpfxB41lXewnYRbIN3TKTi8RWFbDy5pm8ZctmwI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BuAH2+3Et4F+2DJgNLvFdd9ojGYcC7NChhegD5O0fC5eirITNDqQLeSe3PrzqrJf+DNM9weeBVQDq5etOkKDIqfz63kVT6cTXh8f14Eamok5/iyneDTA/c58PJUTe0r36K4nKy+U9qwqzGgYvK08hYxsKdMDOsIJq9TswXev484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOfNJoLV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOfNJoLV"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50b69bf5638so25772231cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 09:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774630158; x=1775234958; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eUI7HpfxB41lXewnYRbIN3TKTi8RWFbDy5pm8ZctmwI=;
        b=VOfNJoLVkJRM/Ed0UW54xvtky3nBC5csEkpL9B/1HLiezVoFFa7QGYzQXYt7QOOrBi
         /TKj/KyaYOj+sQ0n6oKvYGbZYmz9r1ImFhetH3Y2ef7tH2HVJM2Cjcy4MPoRHTygtyjw
         MkXCvi/twJ/Gj6zOOlz4KG9wLDdGFdkCdRQjV4e5u2ZkX7asxcQ2CVbJqzpz+6/MZ3Jl
         Hx+LS1V8nNpB+js4ErCEjRa1i0z0L0YuKQN/T1urKyLpJ8QbkrKGlggzRZEjAn6nTvhu
         0Fher1zEE0/vC7RP97KN0j8op2vUfifhqm+7ycqayW21+QIIl9L2BNJuQs6hRoZXtS/9
         GaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630158; x=1775234958;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUI7HpfxB41lXewnYRbIN3TKTi8RWFbDy5pm8ZctmwI=;
        b=Z0eCou3xRF2ayDTqOCsZne9nr0QQlRnP5KqJifztWJ7FiZaG+KVwRzJ0JwJrML4F/U
         mVYwswZGlrGEng4KhncrwJtZzFoxJFC5frPrws0pdZN6IRDRXNnuSiQCrldGFZDKajbe
         Oz4t0kl7BxZehPhuJN3pGZ6ptiemKxuwWIyHNylgWUhZTDqmrbjPFp5TC+Tt5H8pHt4J
         1n7wdEJzj9/DIK86EdfZgy+/WST2z2ZVGrNOegmwbxFwUAXWCtYDRbCPG48+F7YiKKqL
         EKLz/TYffSbukpBF8tIitzz8dezp1pMc9BIj2RH/GvrLPa/tHPsfwOsKF2Ya1UkeTwnA
         yLQQ==
X-Gm-Message-State: AOJu0YxLMc8FyNvSL7ARLDJRsdI95IN2q6zHVcE+VqnWgWKllTtPZoqN
	zD5qmgBB4C+TLuTM5/H3HshyLXejc17dERImjsSsUTidYpOp/lcMRIATXzpsLg==
X-Gm-Gg: ATEYQzxyZjFjkK2Bcd9TxOntVqPZIqel6GgR06/rIb3LfCJ3INhZuPVjSicRtlTJGiJ
	Nd7CyuHocqCVlxGZQdFRp7JuLhvTIxN2iUIBsbzquP7jNvbV2XeSy6kxIkYhCCURzlHefKp4HhD
	5ZwIb/vVYhR77PhuULk2U55we+23hL4RzmWIFDW2M5dF3fXd5JxOo0WRilzdwKcJ/mjVIu9gr89
	/PAolXvLhzRCGCRC5rbVPyeUMw/yriDwZG2oKEbMjVtpyscdF5ZH4LFqHz9vhMaBJ8hxR8MrWTJ
	5mDHHMcCjX9sJBBC3mJWELkcQC9nvpXN9frF1lPYuhT79fsUEOBNe24R9OHfnKpIzT/rAbQM/ZB
	sERfmIOkJscBTM2MvztbneVqB++w80VhHqPlXjbnK//h6Fp8te5mHMpHt3OxSZIZhiAHArGR3Ft
	iBWDbiFWtgJ/MgHOSSz7+2x8sETTc=
X-Received: by 2002:ac8:570e:0:b0:50b:6a6c:ed06 with SMTP id d75a77b69052e-50ba3936968mr44187411cf.49.1774630158059;
        Fri, 27 Mar 2026 09:49:18 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.151.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b920f77dasm55490501cf.3.2026.03.27.09.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:49:17 -0700 (PDT)
Message-ID: <69c6b50d.c80a0220.1e5fa5.4672@mx.google.com>
Date: Fri, 27 Mar 2026 09:49:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6607396381117414651=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Alexander.Feilke@ew.tq-group.com
Subject: RE: drivers: bluetooth: btti_main.c: replace quirks with new quirk_flags bitmap
In-Reply-To: <20260327152735.148923-1-Alexander.Feilke@ew.tq-group.com>
References: <20260327152735.148923-1-Alexander.Feilke@ew.tq-group.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6607396381117414651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: drivers/bluetooth/btti_main.c: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6607396381117414651==--
