Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F331626D4CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756465807; cv=none; b=oZYpfzxQvVM4aCBMmste3swtP/uwPD9mUfG+7/AY5pGx6Owcjn80bqQE0dRl97QVxfbTgYYJoqFNsqKJQj7twy+oycoiFMY5+Dz1MNPzOUgs/1Dd7C4l4Xo/32xrawsrfvgG0BrJHkU+BMOfIoZZyDIsRSqyTi3eL5sOuWOLHt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756465807; c=relaxed/simple;
	bh=e7uplDjajstv3vNv/ZPZV1EOvN85vLVTe3hEI6At36Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o8Gokdpd76ppMNSKzQ5maXjizUiKnm3oewGmX0uD57aeQOCgCfJE6kgZdN+8dC8yLfLIqwfqISfdIYVS3Xe/OoN8DDhgtBVOAFORH3BTNuz4Mu3fBTk08VeY3pENndzNlG93SUsMBVSOP2YMYUfbxaDLTzoDD05OJ2lzIcgxU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhGKpURO; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhGKpURO"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70dd6c93071so15701126d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 04:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756465804; x=1757070604; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XpwpJqHSVH93cQz2P5cijdvUk7Xt6DUQ6HlfgNbDKvE=;
        b=DhGKpUROR0XjQbD2+xIQeMuRQC/Em176kbUaeu9yGIJVighyAh0JWfL7v7OqO09rxY
         Eb0xrZHPRLRW+IqP7wEE6WtUDQfYr56gwfIgcKhvhwUAz6qnfp84O7WdtWJF1OnSUBjL
         rDYh6yjF6EorRFoHAchNC/XZdxkUW/cvkKS1OY6CXKv6Pi0s7ZQIWaF3gs818fmTwE6A
         CekIQRGNZNhzruOymVXCeAn4vIhlXqo40hSHDIgRaIET2rLK9W3sh+tFec/YRn6688Kz
         /8INNXw1PNiPv8Ch6pJSyLKDntBm8B+lzdM8K6cvxlx433OBA2U8hq7J2k3pDvlMnz2B
         X6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756465804; x=1757070604;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpwpJqHSVH93cQz2P5cijdvUk7Xt6DUQ6HlfgNbDKvE=;
        b=Sd/jUZfOTBh/6oqNheyaALOHyHnqUSORfeA6LRC5ZBkmw+EQNnD66n+qQreCHB7CwM
         l7eFFCg919GV7LvOS/M/37QwYCVgAyO3hJ90qz0wSDEx3rw42n/1cWSicLy6OhlJG6w9
         QCFVsJfbXfWFQVt3NxoYgQwKdvdWaR6fZ5nvh53lqD/k1kNjGHAP1RY7HRJf3dQlsA+N
         870CyK86b9KUhEti3c1toQuY8dsCzRgkqXQ2NczeFrHhChRzpoKHBCBfyYZ5BXAmCV4g
         1oRjHt/WuvtWsLP3YOcf1IfwemrfQws5DuUV1JgafHyoYcfyFC5eXt7Oxr8rwApPUiQq
         uXtw==
X-Gm-Message-State: AOJu0Yzz+yXE4Bd2b4CUQAQiS6+ouEQfpP5L41m90FEPCcazNKLfFwYo
	ipzUeWCjDrf388yGG3FiNHMTF/XfhDg1ZPJNYZRbq+8OXKNTdSFUUJQ2/pNL+g==
X-Gm-Gg: ASbGncsL7XDXv9RQhg5T4jx/8j5dQ4HqHgTw8wgQQbYcFcPU77bSpx4TSpjhHFwF17u
	NnSfbCEGLVPjsduFoaE7vFmqyRV/NFmcnAM8V4WSrcbcEa+V422TOEqyvSMLPZvMoMEgzLdMkWK
	vuf06hWe6LA4ZaNNtY7M6z2GT3TlUjsVCli79q7TEEQEvp70kdQBz8e99XabqMQjKm3xrXqs2Vf
	RdJE6jozX5niXv30s7+yN3TG6ZDpQr9snJa5PSMT4TGoVnoFERyqwlFBx/RsE8HfMec1XkQV9qI
	IRmoN8R++prMjgsglldLDdbvzA/W0YOCSbTKzGZYgxHUGk452pV5cpvayJGbOJFs13KtxNd00Zn
	8awNXO9d2CNypCmLsGcZ0p5biAGJthY/xL8UcXLU=
X-Google-Smtp-Source: AGHT+IFBIoGrrYKFVjT0VbhgpHyC3f7jFuRHyzZbkvnmdnTjNdxHLaaUqKUPcBx+sYKdbv0OBwqxRQ==
X-Received: by 2002:a05:6214:c67:b0:70f:a0eb:fa01 with SMTP id 6a1803df08f44-70fa0ec045amr11039286d6.19.1756465804296;
        Fri, 29 Aug 2025 04:10:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.30.232])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc16536012sm148310385a.66.2025.08.29.04.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:10:03 -0700 (PDT)
Message-ID: <68b18a8b.050a0220.1e608f.44f0@mx.google.com>
Date: Fri, 29 Aug 2025 04:10:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2327141294215455604=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wangxinpeng@uniontech.com
Subject: RE: device: Fix device recreation after failed restore
In-Reply-To: <20250829094808.32709-2-wangxinpeng@uniontech.com>
References: <20250829094808.32709-2-wangxinpeng@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2327141294215455604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=996842

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      19.97 seconds
BluezMake                     PASS      2536.81 seconds
MakeCheck                     PASS      20.07 seconds
MakeDistcheck                 PASS      183.38 seconds
CheckValgrind                 PASS      235.79 seconds
CheckSmatch                   PASS      306.13 seconds
bluezmakeextell               PASS      127.95 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      909.52 seconds

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


--===============2327141294215455604==--
