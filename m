Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208F713B298
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683162; cv=none; b=QN6KmDy+AFgWBvV/KwI4IRd96FQ3YCQLU2q7F+hreXf11+09KBaDD/7c2bHvI8lKkFCUY91LmAgRua3b3lA7jGIy7X5saR7GvwfSmGz5pJjAlekXLZ5ns7rhu+H4WJpCiRmWLa7q/4lL0IJhwCLGE0ZZ0/S1dUJJbINVhgKZOfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683162; c=relaxed/simple;
	bh=eFfnlasveL6+Oo/ZKtj71mwi3UBZRjfth8Lidi6t8JE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Zsn90aoqIcucOXPIr/LAqGDcJ1FjeHHSeI9b1cvYsMidBIEtLLFYnnzuqG5HX3TPgdwaeN2T/UzzBgngsNOOkMQHEcf0LTHP6XqvyF7PmdqQ2zuY8k1B5Rfe1Gp9pZ1PQFK9NxzI8WE/P7MFQel3cVvXiIEV8x8wOH1JwI12pRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/X4QKBq; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/X4QKBq"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso3268272a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 03:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715683160; x=1716287960; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eFfnlasveL6+Oo/ZKtj71mwi3UBZRjfth8Lidi6t8JE=;
        b=k/X4QKBqIHbKD2KQ9oztEEIxInR1fAKoN13TPDt/lqG3mgcUn18CbIxAY4shiTRFhP
         /dGna6WwUGKyAVyO3m/TBZYQqMV+Xhs34jC1Zg49AwK3R+suOlz5h84n8GiZUT+kp867
         ksoFLdD16GB7CjA9WDIRiPrevKv5MDiadv1awhvyVRDWzyeYdrFGQn9HirdrmbXzjkmw
         9Tejt+8g8d0Q6SiuCmSN/bZOaBUR8m9MH17z65+OANdH2VyqnAHMFZTqWSNULQmaV4ug
         T99t6rzfl7vSm0XeCAEbhRaFDJ9g5vyLWHuBFOSSMtxFDaZScxvzpJuO4vkFprOhVRJz
         8HzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715683160; x=1716287960;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFfnlasveL6+Oo/ZKtj71mwi3UBZRjfth8Lidi6t8JE=;
        b=K5R8ZDKCLwHVJ4mWE3J0hHMY7rHvOD2N+14aofd1PKqhJaQ46gNADg8w+CrBSd04+J
         PyYK4ucMClu3GqHhYDQmUECFK9dCZ5/aEaFoi9BUJQYLIUbClM2tt7OykHxNOuJ6KDYZ
         vWY6NX+I9E0uerchcfMY61vf2dGeacPG0w/8xKNoFPOt/7xvvq4QCOq0qefGCusKb9iM
         6NeX2pVGeTQYUpKb13fxJm1jM5Jw4TFDF1k0OhwFLP+nBKWcG0bxKKZ1afPbXpnRn725
         DAXc38wvjuDk4uDx/T55o4R3pF/6TnYEu2yOnhL0FT+l7LVph9TJ9KyLpVUP4kgqiv+f
         j/8Q==
X-Gm-Message-State: AOJu0YwWzkBNsEoPiquBFIqksO+Gts1lMcO7O2lBLn5dLYWzQFbXVNju
	B5pvIX+MN/jKJA4Wl8KYkd3sSfuhAA2dobpw5erSlXh/CEoG6B17I2f95w==
X-Google-Smtp-Source: AGHT+IEj6N094gLhdA191FaSGVTdx31vrxjGomMQFgWs8+8UzkZnInwyuCdkAhk2WiwiFD8N7wns3g==
X-Received: by 2002:a05:6a20:430e:b0:1af:dd77:86ab with SMTP id adf61e73a8af0-1afde1faeadmr12216076637.54.1715683160219;
        Tue, 14 May 2024 03:39:20 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.28.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af58b8sm9105325b3a.142.2024.05.14.03.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 03:39:19 -0700 (PDT)
Message-ID: <66433f57.a70a0220.85fb2.772e@mx.google.com>
Date: Tue, 14 May 2024 03:39:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4178972998562610148=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, SoloSaravanan@proton.me
Subject: RE: Bluetooth: btusb: Add device 13d3:3606 as MT7921 device
In-Reply-To: <sp2Jnio8wbTlQGoA5ti6LOAwDtdur_uZqdZYbXJL8wXHF0h_GVTL8Fr_b9oqmYVl2y7jeT-CgNt5Neg-RWjyKs4LXfKsg_uN_YO0_NFOxmQ=@proton.me>
References: <sp2Jnio8wbTlQGoA5ti6LOAwDtdur_uZqdZYbXJL8wXHF0h_GVTL8Fr_b9oqmYVl2y7jeT-CgNt5Neg-RWjyKs4LXfKsg_uN_YO0_NFOxmQ=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4178972998562610148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4178972998562610148==--
