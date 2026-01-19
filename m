Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C71EE00A
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820186; cv=none; b=QxbPsf1/r0e++glNdG6e2oXPXlPp7f5X/nvf5gyBZzmYmSLurRVm03+y0P0KOauaiWmRdoAuPUr8NzWBL98GD2cyZgoEAdC53dvTM9wxLWZWEM1qrfE5ptPhuKl8VWBX4412j8bSfdaJWNlD3+Xc97mLUR1ISYn4HcEdVE0vhxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820186; c=relaxed/simple;
	bh=sLuqjGBFKRb1h4BDyS0v39xJJSKgaeqy5Dt2EGNNopg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M0YZynC5egNaDu9mWpUlxRs3S8GtpcPcEUOkJnlx93i/8yVgqk4Y8OQkHYiJqUfzLSKyYXLTfvMTwL7c54OsRf2kAwSB6NyDTm+BPqkvSuJmBJb0NF3Nf3bpOYyvOxe+W916She4h6hX3DGOisfEYZA+64pUThKhG2bP75fA7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVF2Lh3O; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVF2Lh3O"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c53198a65fso419285585a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 02:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768820184; x=1769424984; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sLuqjGBFKRb1h4BDyS0v39xJJSKgaeqy5Dt2EGNNopg=;
        b=HVF2Lh3O3vdJD0yccEDmygPuHEU3ZM2sNAX+roHHpQXVrCLMuxFiP+9SzEiZv7+DFo
         s+4MXzvri1wBOHIlnlT1JC+Z2OtKO4XK64zIsOXEHtcPPf70CiK/TL8NckvcW8Pwmanl
         q3U6yEZ6TPAtyKvyjyFCo/LT8vt1zl5K+70cxvZoi1Z7d6kKQ4ZLn9+e9HC/npw3deiM
         NCqKjvhEx6o1O69uXF+HY0PUpbQWwh0W1iMf/FLKG9K3t706jaJIfHfv8KQmMdubQGA/
         r3h7ELdUe5V6pJjZJ7GOQs8B1pJPTgajn8tZTKUpqWfOCrnc2VUmbZ7LUPlJlRpP0Iqa
         fNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768820184; x=1769424984;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLuqjGBFKRb1h4BDyS0v39xJJSKgaeqy5Dt2EGNNopg=;
        b=EE4PKCxr32u6pjOvlmUPMee21OI2J5rPqNjKe+BMyU9TkS82AMG2wkWU+xjvmSB3Ya
         d9z3WrERMuOFUIbgJo44znnwIwXiNJWen0HJjZPZO02d+PHwhgdmBeSPkWbT8DRQhq0S
         2jH47to/x45Ls1jW6hsr27UQkan/zJp/zvMEBltfhdQzleYhECWMaJ9SjM6yeu6DfAre
         kGhDznzQdBOFOoWIThp/z4c0pdjA+Q2n3GGWt8DFpfbvuqZZ9lJIBqKeWprha3DMlvDF
         9gTpZNuHcvZV0f/R/sxgTRK1Bn+k1y+tOjV5l1EgwUe5RDfJ/1eV3xCnhBPhJbacHQgb
         b3NA==
X-Gm-Message-State: AOJu0YzVJiLXB4b17Vho5b4LSYM00V45n403JSkofekdpDD7RuRqAQyG
	XpYx8JIU8zqNMV/SCx/W2ohaPF3Dr3YNJxnpYKzMiPhvWUGnFQNYWiUBbHaKvXBw
X-Gm-Gg: AY/fxX4xrbg8Ajf9/W5Fkv7rkCnKOtJzLFsDt3NvbD2Q6nIQ0MLzbE8rpjXvxCBJDcv
	cP6sUpEUFx97Hqe2i/67BkFrdNzwI6/tW5GtpUB9jn3gHfQt8m90Kp5QMHL/7SZRvjxcZlJs3JJ
	mZhx5dxFSwmDbiZSzR0JZUq6nuVT13Pn9Mn0lTaqX6O00QsbreYVLhVy1xDZop8yTWos/WdkzVg
	SQ2M9y106Nlyf1WOEIpmtjQi/g9KVihPhR+UKFzepajWlQCO2Jl3w/5NiVt9IRc9NbclMXGbFRJ
	01+/AWUBZYJtZNlrWvYT0o0Lige6VhQrcUDg0wwDvQUiEOV3f8l9XGiVMA5ESccDEb5TJO6+CjS
	bA/1aLvuolccqYi40HmIcHR151ZjM373viLL8Z+lK3EIR02lRYXTN0BLUY9Eot4lY4H1aUReMH4
	eqmgXucmHPJs8NnS5X
X-Received: by 2002:a05:620a:4482:b0:8b2:e6e2:9a0a with SMTP id af79cd13be357-8c6a6946f48mr1274003385a.59.1768820184128;
        Mon, 19 Jan 2026 02:56:24 -0800 (PST)
Received: from [172.17.0.2] ([172.172.87.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7295405sm767459485a.52.2026.01.19.02.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:56:23 -0800 (PST)
Message-ID: <696e0dd7.050a0220.3af2be.a5db@mx.google.com>
Date: Mon, 19 Jan 2026 02:56:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3096072517458088562=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: More CONFIG_PM* simplifications
In-Reply-To: <20260119102911.2465464-2-hadess@hadess.net>
References: <20260119102911.2465464-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3096072517458088562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btmtksdio.c:1472
error: drivers/bluetooth/btmtksdio.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3096072517458088562==--
