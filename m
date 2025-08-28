Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1CF22173F
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Aug 2025 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394234; cv=none; b=owIvQj5tghK3ImiqWi1Fl4Ho30MtyjHm3H0bPsviR8AJir7XLQKAgw/5Ea7+loTEkxXZSwJcP7QMLi04B54k+Zxmk+nMHAhc3CRieu2a2gQ8ScoEl2un+MRnaEYRJYVg0WuT4AJp4wVCReiHAdaZOpYu/UdTp9jYeMpFabUo6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394234; c=relaxed/simple;
	bh=Z9Otd+eE/i4QE7cHMdK0ZL4QPbX+SBE7tIiTLzmM3mE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GKGY5psPPspW321PH5UZL5enzZD7duQ+WlayL3lJHW/5bbR8oX1nfqJieCrzjTSKXhhGLrjaV+UoHBC8vO6aH+ReRJ7v4HNPBH7MVmsMAoiizY7xHPJ5TaC3EzsPljbO/Gz1ibgDZmn+CHLU/T8wCSUG/h32b8aa2FI+z4FmeGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKnhvoFX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKnhvoFX"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-771eecebb09so1500382b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Aug 2025 08:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756394232; x=1756999032; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9Otd+eE/i4QE7cHMdK0ZL4QPbX+SBE7tIiTLzmM3mE=;
        b=UKnhvoFXy5QBebuyu3Rm6BQ30cHKVeKwZfKqGGLEO95NdJyVE7OH7OLmGi33n6wS1j
         NVgacNZH46Kis3gPdjaFrwmDhrxAl5+7KGm9OwJSPGKJ6vspDoUkwskvahW5UxyKkHlI
         kif0Xi629WGb28XLTM1U3TKVJefybXvcLCzeiLQs+NrngXmEVPQ0D9RlbTogJmY+W4OC
         LIkdzIWexxeOV02iGf8kXrj9AbU4bO1QR0UStMoYmnRrPJ3jINtQhTeO1md5OD5jZe4a
         0rAvM1znS+iAMLB1bSXm8xI4MHxIgb35JM/DT/izaYeOFOSrVbfe2oCGZ//pA49PMfHK
         lT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756394232; x=1756999032;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9Otd+eE/i4QE7cHMdK0ZL4QPbX+SBE7tIiTLzmM3mE=;
        b=qVQoUzzB0VpiYQTcRmOYvRleXI8iLACM0sTSmi0+YFMYq6KVTC50KO0x/zYf0VWqtl
         +xhB618FrhVVPXN8KHK0vf3UvDBv7Cigp8eGFd9Od84pnc1CfweumYTY/vVSU7OnlHGS
         Bf760InvX3dfUOFDu2sKwOiGT0ssAuSkcsjxuIHNU7uytFf9ndgKtkOIVCigObirpc8T
         CcNszP0Pha8hLz4judBzVR7H2FGZ/ml+qr+KKEtjiCpydzYiC0G5zA40aZGaiUleiU+X
         PZxXSw22x8SX6ssLV6YCf4JO95Zry6yifQ+NFZ0YCmIpzHtD1M49zLnN/ydnJlseqm3p
         T6vw==
X-Gm-Message-State: AOJu0YzCR0kqV1T2rRiqOxGwRzrKDs6mecZunKpWgRyqgyRELTJatUqU
	WZtnBYZ8vtlmmqG2MKUgfxvFzdgrkCbl/DgSqMNB5sFxi3lxtnU5AV9ziNvfvg==
X-Gm-Gg: ASbGncsbEz7+g/m5NrVXPS6bACKmFDtq7U4uEv4DNR67ZEFg3jZkL0eNrh35BEcVPGz
	/9CCRAKqxZ00F8JpocNHGtJSYFaP18quVLLzy49gxwYsflsp3dJAFTUxvHg/KaPa0wLH/zQdjsE
	dqnPcnn2tknuJxLffwi+8OE+72JM8FRMKskSy4AFG8/BQqXZAB2Lb9IG2ir8pSh7+OR7vOvXl2G
	VwB2I5+q/jZHh79C4oCUZpQ2SSYA/yr1aCq7X9wi7R1AL+4ibcWNjJZx7TSByzDvELqQVfv/JzT
	LTNsppL9wXu9QLisG2woNM/EQiKOAszs6hx8J3HU/8mKUuCwdz/JN28Fs6Ki9R0DY7k20s3bFPx
	uYaWfapE9yirXAb0wum7jOLvL8SY=
X-Google-Smtp-Source: AGHT+IFBI4vb+mLvZ1XsZjf/XDt+ERu+ko6bTcumDfZ4iqddfQUwtIoKpq/SLMfSOOJqHJP5iZEX6Q==
X-Received: by 2002:a05:6a20:938c:b0:243:b5eb:9cf0 with SMTP id adf61e73a8af0-243b5eba06cmr2186388637.31.1756394231528;
        Thu, 28 Aug 2025 08:17:11 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.56.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e814cbccsm10983453b3a.35.2025.08.28.08.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 08:17:11 -0700 (PDT)
Message-ID: <68b072f7.050a0220.1080c5.faf8@mx.google.com>
Date: Thu, 28 Aug 2025 08:17:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1652041916233550660=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, j@jannau.net
Subject: RE: [31/37] spi: apple: Add "apple,t8103-spi" compatible
In-Reply-To: <20250828-dt-apple-t6020-v1-31-bb8e1b87edef@jannau.net>
References: <20250828-dt-apple-t6020-v1-31-bb8e1b87edef@jannau.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1652041916233550660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/apple/t600x-j375.dtsi:12
error: arch/arm64/boot/dts/apple/t600x-j375.dtsi: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1652041916233550660==--
