Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B021FF36
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 02:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756435373; cv=none; b=RwjX9vJYwA5Z5IvJjdokzdIwoKlxhEjIJ1zax7abflWYW5rOHqwdilWGBjy0lD+D2iCTuTx0ImvtL/C3+SA8nb0b74mCVS9PKP69gtI3L3xc5PVvz8RJUGoREudcEuaLuG9oCZzaMDEVcjO0vM6BOLAT1+eOp2+fjX4/KAzlsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756435373; c=relaxed/simple;
	bh=/41gLka47My1MCeveWcAM5KbRubNhTBCGeEs7u/0YVQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=f5HWSg1DRQQCvPWrRxKJSEu0ctMR+GTUhJtCNwe3hqGDqAGRVkQTMya4dWAl/Gu7tbyZ39Hm74GiV6bfR0lwizX/zJf8GpfsQolv88VDz+keHz4k0LlQk2ZbdbIKC1faCoTntDQYHhy4gw+m8NvVmF1mPVPIUKNP2UhLZkvi7Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqJ7/n5z; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqJ7/n5z"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b307179ea4so7846891cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Aug 2025 19:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756435371; x=1757040171; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/41gLka47My1MCeveWcAM5KbRubNhTBCGeEs7u/0YVQ=;
        b=RqJ7/n5zkutOkqfq8eg9oClF7/I7k/jpzP372B0C63qG0zaL+/FUpouOw9utdLnNoE
         0MzMm3PPcJHLfIrrAe8KYvHwkI7t9H3mH1UvLkmJ8HvH9I6zilckO7L1yPzBli+8pI4b
         NWKJAJ7FNiCIvwGd7r0GIFdIOoouwYyug9ob3JWoUDiKXTBsMaab5ArGDkufr0DsSher
         cdozzXYa+Y1PS5aq5vtT9X35a3cdYMu8wPnOmxeJZ0d+nK7KPpJFo43TuIfOrIXKvgjV
         IL3K5U48Y4Fq4ZBmGgjbPAS3R6E/Nu3J+wtVLPqBU8LgzkShMCG+5mi3FbOFybjka5XG
         DNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756435371; x=1757040171;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/41gLka47My1MCeveWcAM5KbRubNhTBCGeEs7u/0YVQ=;
        b=SzJZPX/l99+6r27iFhRQv3Sxg9szWxcvqv3znvvuQk1M7qfsGM/ekaPrplGu4HVFFA
         ZZsanczBXj0P8ZV9zPTQzBvN3/+phZ4jAMMXTqqQNJTSkAfpcRY/yfWUL5hmdPUf2D04
         k83o6BBgh1RqjRw8nNdEcP0bYAYdeWkWMGJ0GPcTq2LHA1RwbLO7h7fU+cSCHaU7PydH
         DlsEnwqzeSN3778GRC9U5bfZfldfFuipQB1EmCTqzeuHxnJd2C1IHXzzXdp+uZv+zqWB
         s40i2k5z5jUR+i2jT9WbgnaHW/Lx8GaxM245h9sYr0dxHQQgqVBA55Ala4uf7OZfYz2O
         vdGg==
X-Gm-Message-State: AOJu0Yz3HRKExRnMxg/LCZvWhWBdJ5BZMIzjB9v78FdYZwKH93n5IRzP
	+JhKFKGmBiTJMTUwB58U3dmAIcj/6vE7kAsmi8f6juXgP83U27p8YzbP3SuYx10z
X-Gm-Gg: ASbGncvqEG6xNT58+KeFDjk+tXXVbyANs91TIUKLgbQzv13v5pPVsO/3kvsuWjBsx6u
	qjD49/gUC1n/vyrZCJkasyg0lXK0P7MpfLpuDoSFWrT4MsFINwOVedx3TosCgWQS60ZSyNNOjGo
	sP4gVLihAdef98UpvshItsZrU/jXZjSpN2veWSWfEHo24WKxIEO8P4mS8LyrOUDvClBI+WsMu27
	UrGkynwN/JwVLJjDB8b18TJwPQl5nSMwa4I0hMBs08t2zfsP7lngo0SVTbvcgLfdO74hBJKrthh
	rJK9VTNjL3qcVV+PVQaH0Us18NxwnYyge4APpig4s3piXm+x41gjv/2cvNhelYr15MUA5DHXzMY
	V+BHBK/K4kMwjxdCgsC7p56iep0zsVXHC96mILSLypg==
X-Google-Smtp-Source: AGHT+IH6B5T8O8r3hcsGCwPsHLPDDYFy+pcLjfHPAdisP2q4DKNqBOPWZGnQggENEFXULw8IqlO4UA==
X-Received: by 2002:a05:622a:1a15:b0:4b2:d4d2:1124 with SMTP id d75a77b69052e-4b2d4d21918mr188633911cf.42.1756435370973;
        Thu, 28 Aug 2025 19:42:50 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.127.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b67d068sm8145311cf.28.2025.08.28.19.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 19:42:50 -0700 (PDT)
Message-ID: <68b113aa.050a0220.298d46.2c8f@mx.google.com>
Date: Thu, 28 Aug 2025 19:42:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7237730673838978181=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wangxinpeng@uniontech.com
Subject: RE: 
In-Reply-To: <20250829020128.949863-1-wangxinpeng@uniontech.com>
References: <20250829020128.949863-1-wangxinpeng@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7237730673838978181==
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


--===============7237730673838978181==--
