Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793255520;
	b=iNgaRWB0m4KTjzdO4kod8C+IEGws/rJLKJtz99a+onbbF7DUimpYUi8Skr75e5kdU1dE
	 /9yHdRJio+fGz0V7P3vD5htDPw0KLnlVtH8MDjUP114LVmR/kefonwz4OIxgGN10Gf40O
	 8rtvNuIUwSp+GIGFyZLlkRJHwVIr8h+h5N+PNGV/tyVdvH2kuKIcLnVhx9vFe4trJXp6z
	 GAlKllHr/tX81iavkxpZg1hECatA6FuOa2lfu+TVSmpPakgPOmRYrRfmiTuBuaQq31XeD
	 K13MEG5YMg5UcKJ75MlmfyWTaWmufWjqzLlHhlaFJZCt/WVLgVCLWK9O+RQOeBtBGTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=X0nORoTRXF9e2SdJ5265d3oai2dqiBDQQPpukQvB43U=;
	b=kbLi5MCOFLuT5zjfGPVOxQdLaoov4PnFfQjv0qfV0hrRKLCUp37hsDmKohRi7sa02Mu6
	 bJpVfvVuHLhCCF8gNQYYrC5iLVUMl9iGKjnsU3V7S2ckzX+wYKN/QzmXaOTvawjHFy0v5
	 WWvJzWDzqse606y7fhLrNOP55eHg0tgMgcS91K55rnQBTwG0gNPlzabMLYOeJQcQl2wJN
	 7Ojuw0TCZx+bhAidBCzFZ7dN+9/0oCbz9VUPBK6yCbTYUigjZdrsowySRnFx/mAll+WCK
	 xoeP21rJBpYTiwq79b6OPGV7RT77WXpz+kVS7R4Oh7LjYz+wAjKgTct2JA8cxh3AIqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jBVYJ0XX;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC43606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 06:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BC43606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jBVYJ0XX
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-170135e43c7so912167c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793255520; x=1793860320; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X0nORoTRXF9e2SdJ5265d3oai2dqiBDQQPpukQvB43U=;
        b=jBVYJ0XX0h88BFxnuhf7HKGX/YykGoLDiK0FfzvZndvikEmsGKzuiQhsjxTXreXp+Y
         My5j0/sxvKimuFXHea75lu/DEs0gfwekM2zqjL/Zlp9c4Dt2RF5jZcEoXeTufY45UFUx
         YqYXMn/d0FwJJPkKQUE4+2QdqPXA8jHZ/7T7RYdLaInmdoURaeVe1weIC0BkHVUypLnT
         FYr+i8NSQ/JmwjV909hGpkuhnfNQlHnTf0A0CefjmZIb8FhOHloQfTzx88rpmQP6yUDB
         epSVjvDgEQ+Y1sj+m+0uoaotZqEYfz/doWagessYspOsaapWhIvmYWhmJSl3/mrbY/ch
         7Kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793255520; x=1793860320;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X0nORoTRXF9e2SdJ5265d3oai2dqiBDQQPpukQvB43U=;
        b=vjrAzJVk1u3zb3MCvpw2wGGcJw1u2NnK1MSdq3rA8vnbLxEch5Ea7/+fj38nZtMeBq
         EOph872UpJNyNntYFFoyhuq9WrShQF/jZW5J6xmGsLL0ynpKpS+O1pZcc0LyMkB405aH
         b8afZf4y03Gym51j1OXaGnGqoX4+7jbVGf6KPGLV1Gj0LKb5F0f7W+xDeQGIxPDIX3Zb
         H/0U/L7mPROp+c2/SafaDU0EfkXfCz1gfiGQk1a09E2g/jshGBAgFnmbD5wohMtWH3tB
         NC8xVO1aaFqX1KdAGK1HBP0DUP2jAFZrq575MKtSBoYNqJ3wGYWM9Zt4E9mgK0SxnLgx
         FqoA==
X-Gm-Message-State: AFq9FYI+11JIKAywuVyxbINDtRASPZ6+bBc0XiNQkDOqeM2XE1p3gNvM
	WS/mogXWNwJgQ2CwLfwliK1KaQeCWAZsW52FY+w+Mh168OZSpV4wPc6DovV4Sw==
X-Gm-Gg: AYBFou3xuU70QTCaLxvKvfkkKS7hh6H0+1kYP/9kBgdQulyPE45RR8uSsrMu7FbKNHT
	Y0mV1iYo0q8KKossIqeN++EARUXh1KhhTuZFZArCGsY+lwOxItvywjkNRzpIMzUhGSOW3m917z0
	vJ7nFSw8p8ub/j0Vq7lU/KmWAoNHqFsetcPpRCkoyL1WjQwyFDRzsd0/eithJ/DvQB+rF9z/d5t
	WwuQc6Cy8gZuD1z92ZCjtDUtAcC+VmRsVBAGi4FRdDgeiLEBWU4PNPDfm+TEzRMmzKpWHsQukS7
	zVpjORpKf4PotXVeg+zn8N+CvQwO3jx0kuAwlQzAI+2+tc8vbDx+FwFE+Y9EEUldkqAKGJDOuIt
	74I0a99a/SeANFx8uM9HAbPgtQINal+x8CXQafQXApxUrBZIOZ0GZkxFQx/xBIx0f6x+WBBTrYq
	3pc8nZNS61Ce0hZNPuSc2ZP7SNh6/deRplPzGXF00VIYQqZ3CN0vED1SVUUtszXeRfieVM1MFZ/
	0NH4udyEPD4D3MPU+hT+U+lYI/rnMX9s0VHc6Ta5FEnEJXj3V2k4XzG3IJSfw==
X-Received: by 2002:a05:7022:3c15:b0:190:d0d9:3110 with SMTP id a92af1059eb24-1a6cfa0d714mr4922330c88.45.1793255519331;
        Wed, 28 Oct 2026 23:31:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.62.228])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d76814bsm11758524c88.10.2026.10.28.23.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:31:58 -0700 (PDT)
Message-ID: <6ae2e85e.b97a138d.f11bd.cabb@mx.google.com>
Date: Wed, 28 Oct 2026 23:31:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0306877599205062237=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [v3] asha: allow LE 2M PHY on the audio channel
In-Reply-To: <20261029030037.1300725-1-cochcoder@proton.me>
References: <20261029030037.1300725-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0306877599205062237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195855/

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      16.84 seconds
BluezMake                     PASS      235.93 seconds
MakeCheck                     PASS      3.36 seconds
MakeDistcheck                 PASS      122.53 seconds
CheckValgrind                 PASS      124.41 seconds
CheckSmatch                   PASS      229.54 seconds
bluezmakeextell               PASS      77.72 seconds
TestFunctional                PASS      971.42 seconds
IncrementalBuild              PASS      239.67 seconds
ScanBuild                     PASS      869.28 seconds



https://github.com/bluez/bluez/pull/2734

---
Regards,
Linux Bluetooth


--===============0306877599205062237==--
