Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935420D4E9
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787480000; cv=none; b=cV209va8LjGKOdLfsbsMVGjaCknt0S1JFBVzvUgXMcKpfU3hIjdZFuPBDRv4QxGeQ3QU6muWhH3kceSScEtVTUSB9RZBWsS/fz2wyy0eS36eT/jT4wgSzycBpd2UWkQP7AQONTrcbq0FT1JGtZCZQPp2Yy3MkRZVwQUic/P/nos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787480000; c=relaxed/simple;
	bh=IDjBE1mjbNtMiJI1XVR3zYLp2TW2RHtkWHXGWbHZT5M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Mj9FxMMAn+YT0ljkF04iIMMG/2WtuN+1YaJi38FFEDStds3Bb/Wh3RSBrEPJnRd0ruvFDFHUbmkIjqO0o1zSGe4RnoiJeobkfrqTzJq4f4Xu8jJtlYMZbab1seqbFW7DDnUBFjrXp38bWmo/YN98vvA33V0Ar0m410Yrn02eDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKFuDoXf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKFuDoXf"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d530328efbso20926625ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 03:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787479998; x=1788084798; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IDjBE1mjbNtMiJI1XVR3zYLp2TW2RHtkWHXGWbHZT5M=;
        b=kKFuDoXflsInb0iM0q5QP+MP8+LUwDMhsBsLRHqgMRO/4yy1P6NzYCAZvwVfLV/Dm1
         K5F+39kOZ5oQfVnYwEeQpjixj7hwh7QY5+FvZCN92FNhcpMm48ACZHGwlhiabN4hUYc6
         7ceq16mDRgAt29PeuuHd9/X9vgneojh8O/svH9GvJSRc+3MEOudZSr9WY6OMkc2nh0Nd
         321CLXqYci05P/3KS4a9GRqsnHWNFfaFp6ggtEaCwIN6wKyA2Yp5an1l8bUZoWt3rM/b
         HM9BpSeQUPhU+0ErSfdrnRUygHPTP/W+OAqmqyV172fQHtZih01MvurKQaTNtfL6uAjR
         HUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787479998; x=1788084798;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IDjBE1mjbNtMiJI1XVR3zYLp2TW2RHtkWHXGWbHZT5M=;
        b=nRw7WTywnIz8ilCxQTcuKOyXbOvoYe+8n1qEZFKW/SsUv/Cx4ipHincfQ45pCERxKA
         YfbNYPQohSqdkOWg9/I1J+/D10Lr4gRKZjhOxB0D3aezehrUiQzK6XKmjr2cc0mpOeTy
         Rq6JAfqy9Yss49a7/uGgCwyOp9emEq6km37k7k25+UeGcc7fPVIv5AMlZp/lD1mO9816
         t6uXr/jOm/dDpFn3XqIiEfdGXTts7OhU/QlZ8g1jJ7WvuRYjFbDTJnzuIrZhaWghV/ou
         2S6fXr17qG/Yd7P4wHZEU+Z9T2Vs6dn5ksKvT9hOza4Bq4kKLmgXIf00MOr35SvEx53g
         G64w==
X-Gm-Message-State: AFuF++kVZrQyUFs79ljhU9yUkjJyLmvByY1gh8eJQqYCHS4BhZjb+rJJ
	JtWUrZ5miq7vAHJpAX51uS74YFS8lvWWvjuvFzjyLmrQ2KGmK9xFSWihLIgj+w==
X-Gm-Gg: AR+sD11XCLM/8Ip/gEEX0LOMRwHyOtGlpJ1xvNiDRKy1waUGLuyZviX4lcUEU5iMBgb
	rh8K9KNuHti8OwCrXYFtFfMA58Vu8ZlYUbJZVKGC8ebIxq7Sz3ea14i4Vk99hSXIY0iJBGUOL9y
	2np2UcfDz9KngjdLPaeZxW3FrHTx1IWEzdsKWckBTKPUZJjLplRaOVorb2/dHkHNbjSOm/jHDJn
	dqK4tKVPS3OVrtZEdrphShATf6qEcI4Qpv9JqXUbMYd+QCiCkmW+TmnKsOG/L2fv+6w49vOPsjT
	+PEvNMqmBobX3GtuViy6j36gzwB6vsEH38t5WAzC1toUMcn+nY6PZmQvr/sxor3982rZhJcS/j0
	Wt0g0XJF5kxGjHWOuSlI8qbp3vO2CiPMAPitWQyS4FaQwJFkWXh4D5BZeDFn+AJFGyCFWTBGEvc
	giqD8UNAvrdjDVwxrcdJyHbAPCIKwOpA8u7pEG6T1/U4oOL8cYafuAfqJFJE8FGWhh
X-Received: by 2002:a17:902:f78f:b0:2c9:9a2e:dab0 with SMTP id d9443c01a7336-2d64ad92e17mr340007165ad.3.1787479998431;
        Sun, 23 Aug 2026 03:13:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.3.167.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676761d3esm8897615ad.3.2026.08.23.03.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 03:13:17 -0700 (PDT)
Message-ID: <6a8ac7bd.ab778b9c.17726e.a3b7@mx.google.com>
Date: Sun, 23 Aug 2026 03:13:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5365597665026803237=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, triet.hoang.dev@gmail.com
Subject: RE: Bluetooth: Remove unnecessary braces
In-Reply-To: <20260823095527.57473-1-triet.hoang.dev@gmail.com>
References: <20260823095527.57473-1-triet.hoang.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5365597665026803237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/l2cap_core.c:4618
error: net/bluetooth/l2cap_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5365597665026803237==--
