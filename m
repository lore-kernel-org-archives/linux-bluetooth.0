Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74C73B9D93
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222068; cv=none; b=M8ygtnQpXt0X5Gd2zE/xlHQ0LkeafITkrWJf8kXlcHj3Xo8FpoEyA4I0nZckapU6a8kGZo1DX9NugoyemtmrHiPCJsNvl8gcNqWlNEjMh5QpTxgUNxogEXTKbhulbmmkQ/iarmT4uq9LBcvl/s0SiMFalsCs7KyuWSxu6taH4OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222068; c=relaxed/simple;
	bh=kz/7wagzhvrXP9wB7qPxNFDdurPm4EeKc2Fn8lm4DbM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QrUfQ7j3ywBmBCow4Zjs02D0ffD1cO1/j5t4Czk+hRs68Pnb4HGltDeoV1waNvo7dLs5ke00bhDHnmX9HmjOczQyxL0JWV0OsRF1OEioSGr9LE6wic5DD/6V2b8zSaavq7YNvo/K5u44+sa+jO93FdvWcvEYS6eZAj6Iq1jKx9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1KWRDzQ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1KWRDzQ"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb4136d865so1862100985a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 02:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773222065; x=1773826865; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kz/7wagzhvrXP9wB7qPxNFDdurPm4EeKc2Fn8lm4DbM=;
        b=W1KWRDzQVqbQ/Qc0aFZa8rDfE1e5ASo0D2F6sW6WKPTZB86vsT8SIQ7y0fw/sq6KOL
         aPLhMVOGbIZo1Rm1CJ9QABNt53sEuF9TECeJtSugJbzqkkaKC5SpzoTrh3z24bVcVcU7
         2swmxIjdHQNQAXSRzbjiIxHiCsW7rJRJFbhv9YUoPfSLoM1Q8O1LMLlEJwWmWAVBwn1l
         Njq6c1DkAKiZnl3+hIGk9s/pBa7wlUBZ6DFk41fAhuz9Wnfd/uaD/GOLstiN8rty8ive
         R4e1ukq5qnXfMdhaqoBkhlYjxOq+NN3nk1yyILev15STUgs0e9m3ZfUpqIYZp2qniomN
         +8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773222065; x=1773826865;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kz/7wagzhvrXP9wB7qPxNFDdurPm4EeKc2Fn8lm4DbM=;
        b=RiNGOfh3eKfP+wXp6n+guWkt6Kqv+ZFpgdY/GYzB+iPPI+uEr/kDqojuVvecXT5dzj
         Za2irmpAM3hUQxQGmwyJQf9i9dzgxqhftVZYcHF5m0WtB307ILJ5OKguxQVncMR42DGl
         /lP1styWmuGVsAWiRV9W545SEFWDh76QLe8GMvh+dy9/ENvKx6TuZ85i5cCJmvoDuIb0
         TYWne1O4rSEbd7BAVZAJQ8fd/wRbNQP7NrCOsNLOEhrXgUgb7Lp8XS2Ej8QQ1EE4eKO8
         vzF1sjMnWE9YiwAMsCtw8gq94Rk5M1krHuFgT8Flun8RHmoPCdhYqXBhb2nr7d5aGJTY
         iGHw==
X-Gm-Message-State: AOJu0YydMxpNPonHYY60JwSIyyxaH211nSrGHva54hIJlxhTzp5UVSgi
	gGAEGjyP8pAZJDVdSSMPeFct/pXHpT4xnywgY3sDK0k3FWc4sgr2fRAXGM1jpg==
X-Gm-Gg: ATEYQzyQDenjfl5NFDHIUYU6PkJy4jXvjYEX8Rvw/YPSuX8bRul+XI4dwzTQjL7G0mQ
	VrA5yj0kq2YZ51PlL6bBpKjgLJnJv7SJu5Far22Nfd6Alq71Z/ZD2FhbbbREIGNCcNHebL+0Xjv
	MpYJ3MeNBzW5WAoXzX3Pt2a7y1iTjeE8Kvr8m5K4n9f76zl2vNE1kH5I8JKbUVmp4mNAHabRSU3
	acBCkG1QkCKXKT+5jmvik26qhp37G8/0PfPCsW3xMuAULwU2RZFxVdIBK74dV5XaLnMafNVf8h0
	/8tX9yWFcOA1uwVfgv5TuQWNPKmC7JSolW9bUHPpZ41u/R8VPtXZePo07ztZwbJNS3JHo+dVfsl
	vlulv9omPIYAMkyvGGr8QpyuyhOZxl/LvMEA++rQKSPUdkJn5d69zCNk93CY3RFBrosTXlVvENO
	z/cBUK1aKJRmZA2d751Bw/WRiFWMRTWWrjXY0gJCGG
X-Received: by 2002:a05:620a:2848:b0:8cd:91b3:47a1 with SMTP id af79cd13be357-8cda1a87e62mr237536785a.41.1773222065478;
        Wed, 11 Mar 2026 02:41:05 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.55.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fbe54bsm104244585a.9.2026.03.11.02.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:41:05 -0700 (PDT)
Message-ID: <69b138b1.050a0220.150531.c76a@mx.google.com>
Date: Wed, 11 Mar 2026 02:41:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4139217085383416856=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v1] arm64: dts: qcom: hamoa-iot-evk: support Bluetooth over both USB and UART
In-Reply-To: <20260311090921.1892191-1-shuai.zhang@oss.qualcomm.com>
References: <20260311090921.1892191-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4139217085383416856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts:647
error: arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4139217085383416856==--
