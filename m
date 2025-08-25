Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9442AA6
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151830; cv=none; b=Ixt/YHVVfI74MgwQUiUMIhRDWD3EP54qyjYA69bRJvRLisSWSjSVJ8c0A5HshtLpWtog6b8125sZJVHU1+TH+TaJiJI9xIm2GthZpjrlwsTd7QzmXvFfxbKFQx6bd/9/Ln/OmLVwFk1hzaUKbYrytBEULxQhjQsECcPy41O9+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151830; c=relaxed/simple;
	bh=D0xJtbHDYEG+J61/tCCvxAlXRfUqnRKXjZOEBswhHLg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WIJt6zg4SleO9mfxGz94QuoVeLPFJFAPsWLMDCJNMrLy6HmAjaHVrwn7Nog9UVYGRQnM2jNikUuBKzMcVMpsztfaCxDYFhojTDenJjB5DAfRvPy0hSrAK2bnY0nCctZiY/7Yi+LKD1ooIa+iKIHLzlf5mlEus71GDcWYyM2mMBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BM5zP6Ch; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM5zP6Ch"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ec25655e38so9061935ab.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 12:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756151828; x=1756756628; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SDPcc8Fqovmd5Tee1q8QJeEDXPoNWVkuIdym3LfG1o8=;
        b=BM5zP6ChYO43jrKWnm91xsCVbA6dKZQsQ0FfD8y1vN8jjxurTf/UohO5VlvX+aZJPv
         Icho/ICHW8rWrLOBfejLq9RGlwZRW49DwmoepYQdboP6K2VFqlbHtmkJa64Gt2IA9u8A
         bOxs1OwIifwfc3sI4ywbh9vbQNh69+arMh+fokVWutXmY02//q2sxgpV5BkLkske41sM
         8fgE2UXOkanXG0T6kfXCyB65GxTHxM2PvRb5FxabxNYLwsdgLDuX3z7/AT4XxUZByp6T
         7V7a7NXQFge/fAiDpx2E0vPoBFQEgiO7ZYqTJJxNDQfhrHbP8XvQeDcTCuljqpO+FIgH
         iU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151828; x=1756756628;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDPcc8Fqovmd5Tee1q8QJeEDXPoNWVkuIdym3LfG1o8=;
        b=uyAQwhvOZEBGO9vk652JsY8rkyP2CkV8L7pb0o8AQyqXdI5mPL5lvRE2pvAbIuUBg5
         ggCSzs271Iaj9NXUs4r8IN5b+HSdaZkv1C1jnXL5vCQxKC/l4QIn3DpOk9EEHQ1oqgaQ
         laLKFY8DgRvMpKJ2Fak2gdDPh5w7qnii1zosr8KJPBrzn+anTXeVuhRRv/2GOK19nNYk
         pzx7zp3JTQzqZUaFGEv5moYKz3PSHwlCcAuCOzvt4pqM3rDCSSFv8bSyZazVMBdYEPnv
         e1P5QO0TEMvy91SicpGYoOJhuz9VOoU54KPN0mK4Q8KUmoCucS69AlK+pQjHXWtUq6eQ
         vXnQ==
X-Gm-Message-State: AOJu0YyIn4pW4M6vUEsYF2l6FpKCzZmBx3RUzXcGh6XWT1N+fnHjAhKr
	t92euL9w5cWv7quMQsShzE98/7AJmSnr4HJbsvMlfxnQJo0d9g7nJ3dWKBsS7A==
X-Gm-Gg: ASbGncsRqt/xRhItER0cW61YOF7NB6Lngu7WB7L7+escFat3HB2aX6EvE6nNiIdeDOw
	mTzWZLKTKPoOAaV1c8kBGWnNYS05bHSZzcgEIaOXnKqFHskX5s5YOZ5v/1ovFSyX1psL/cV4nnH
	8BiuQoJC4J97QvcBUqpKJF8G/joM2hSz7Kne4F33iX3eN2lCn7f55M8y3dxEVoGHGUoSixowgTi
	IVrLsAJ7mkX/0W6ouGmlOs9EFKZDTnrdRhX6OAhoN37xXbn7Fr4rm9aep8Av+92NwShVVqow6Ha
	fAQhs9P8RArfT5mAMjIugN9iapCRRJmQzvDsGQFkXiAbBnEKYbGZVnCOHOkJc/jBKOzyqt5xXlM
	Zf48VbYCd3EyiobKwLNfBajg3OCTfY/KaleBg64jV
X-Google-Smtp-Source: AGHT+IGQ0KYPR1nFzzLR87GPLPbfANGSe5ZdUKdSftnOMNfADiji9VP49Gq6oKItRYPGmOywVMxGjg==
X-Received: by 2002:a05:6e02:1807:b0:3e9:e1fd:2fa with SMTP id e9e14a558f8ab-3e9e1fd23efmr159617175ab.30.1756151827580;
        Mon, 25 Aug 2025 12:57:07 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.142.128])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4c75cfd7sm55086195ab.22.2025.08.25.12.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:57:07 -0700 (PDT)
Message-ID: <68acc013.050a0220.66548.b106@mx.google.com>
Date: Mon, 25 Aug 2025 12:57:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1225367149989642748=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ,v2,1/2] lib: Add missing includes in bluetooth/hci.h
In-Reply-To: <20250825183159.340527-1-arkadiusz.bokowy@gmail.com>
References: <20250825183159.340527-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1225367149989642748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=995364

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.05 seconds
BluezMake                     PASS      2587.60 seconds
MakeCheck                     PASS      19.93 seconds
MakeDistcheck                 PASS      183.20 seconds
CheckValgrind                 PASS      234.35 seconds
CheckSmatch                   PASS      306.05 seconds
bluezmakeextell               PASS      128.11 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      901.26 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1225367149989642748==--
