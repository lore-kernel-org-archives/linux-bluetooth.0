Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971401;
	b=Movr0okgVbtXTJcgGz2Wl0sTHMoY0emWttnNYQVzu9npA+FhYXZ/YOGpBz204QgpZO+D
	 S1a1QAcC8b5rNQZ5zdlCzEBrak9GF7Vp0bHjI7AUxTsVSb9EEu94z/WQE8M0UbYFOBdYn
	 zFGxdR+4Sx+P/tkl1M/A+gRacucY6RisA6AZ3kXfHhX3Qx3PvYrBQpuUKa7OU9jBQq0vR
	 iOgjWBhMxFapU1O61PsbnUZweLuQthqBip+WDPdRCUOay/WTsjuF9Im3/HpAtRNB3kPuY
	 AfJ7HTCVf+va7OSehOYFMQD0ZGeZjb/h2FtKWqDTW1lIFLijVHSr0w8ErWAob6piI5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=9zO88jYn8pefB1IFjMe53K6ujS9Ce7fz79PVkBoXpB4=;
	b=Qu4W0ykYEwgtF9AI9N8cwZTWhXN5QTiFA2XJpQADkxDy9sSGZzHaQO5LikRQtxpSaHzX
	 QmrDqnYWHl8CV3iHdhwq/f7KMuUIbKi+Ba3DGKKNxVqaj1KbhAReAjNmmZ700K9+UX/AN
	 WxQADP9WMTM6mQZfVCQRxHhJABQU1AzpR7Sn6OjANYfTacSZ3wuOJ6K+U3nGAaCCLtI9a
	 NGowy7+/0thspQ1bXMyELeen+erzGhkZ4YBmZlHzp9Vy9Uwr7/jDNSuJZXt0OOg9CLC3s
	 tEDROvoJGEhM/eQg/fML6yLov/Au+AxbP+75itX98wEjAh2c/dg78o0g/oWMZ3ZQQJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TSTJEDu2;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E04606A324
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 23:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5E04606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TSTJEDu2
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-84d5e56f876so1621875a34.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 16:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792971400; x=1793576200; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9zO88jYn8pefB1IFjMe53K6ujS9Ce7fz79PVkBoXpB4=;
        b=TSTJEDu2V83uSJJwln792tozXKFSSTaUbXxx7vVJRasz3Fay4vmV0+q6aRgklbMPXF
         CvdYftSN56HJ15Nq+nESAm29SKOxIjISIAV39Jl64l+g3LcCqTqUbEVpnXHROH7gvFaB
         2kpWW652P1MXYk/tQyXQ5ivqtyvzei5Tqvn1RvffKqgpD++V38ZIliPJutvJMOkYEICl
         BfYY/10H36zRe5jpEd3Smw9nDODq2SmvF7l5Xnt+0DdAf4kNCTtNDBZzH8ShxH2O32ea
         +9IMBGYaFrwJUdRlQUnjWtliA7aWHN3VOJx+g0M2t8FLMVc99LN0+nmEFfSClUHEg+pt
         nhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792971400; x=1793576200;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9zO88jYn8pefB1IFjMe53K6ujS9Ce7fz79PVkBoXpB4=;
        b=GtiwVApfmEDKJ68j1ck0Az659/0zE5zDqYz2I+LG//T4lfNLXN/O45NvGCnQuHpwBr
         8/DCY4KJQv7ZoyhFuOWiwTOF7mtBcVo7W5QkeJV6ZlWl0W2POQtPM9YwIyoCQXvd6+Fn
         Ur5IJJFY6uDC6HKhnPbyssoP3u9jJZtMb37cu8Ot//zqwyRwa6wTDNa+FAFznTr0hMOn
         Twn/J8/uZKDN8AJznjCk3MMBP6YEEsyqSXCEBgIpMs7lFgwKUqkm1Ku+t+Ryy2V+Dour
         SxjcU0VgN8KEP6N+TcoixXmGA/qyEIgzRZtP1lOaVsatGQ/rtf+a8xsz65tlcAXHTEOL
         0nMw==
X-Gm-Message-State: AFq9FYJaO014PxZUpDbPplHuMpuEJBJsdbg6MVXPq6z4fY2AYL8aXlBI
	foZEmh3l9OaWtrwPmueBJVGamBE3iHNLD2jKXfBOlLStIAMT3Whxz5hLiCgJqgWB
X-Gm-Gg: AYBFou32jrRS663oDkPNLIEiZKl5R7BytaG3XEzhvdPVCCSYL5xixRVRypslkLVpxWi
	yXGOpX5g0bnxRYkX8hAKThzc082+IE9HCnsCYHZnb3ACU6S2PbtLo3/pQXI5WTkE6yFKlgGJq81
	lqR0BJX8gx3JIYiLyYYIV+cdDLVuOrOss05hHdfsJ2SjcILwYpFny6lJi0/nvfc33E4GFtODMas
	4V8YXhxhUTeu+QmxcBYOpsneBCSu6lSlFLO1j286IV29Rh0soC28LklTJ8MuobKI80c7IZ1e4M7
	imfjTVe/3JTTnKEVlY1ObQegAVBF+uxrTfbDGIiq+7oauMvtmr4/vwsp3mL+xSKtzFbn5YpCbC4
	AvEBllU2+mAFVhwAp2WBlAfW4UDJ6foPb2mfq/hymw8S9tpsC5SqTj7K+zGMl595LUYAKJdyE+F
	F5NbYt6ROn/MmB/2Y6eeM4T4VVg1kEX1iON6n/ccB5W5TwlJS+Yg6DO9J9Z2HYyEhi7cYIyO1S5
	c88VFXWhG7uYvvlweFBsAw4toJHX5coWnAcH43VVy1mM1giuJvacQ0O0Clsfg==
X-Received: by 2002:a05:6830:3e01:b0:846:5d82:8bc8 with SMTP id 46e09a7af769-850f8c2560emr4094754a34.0.1792971399688;
        Sun, 25 Oct 2026 16:36:39 -0700 (PDT)
Received: from [172.17.0.2] ([70.37.74.129])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850f8458d8esm6197725a34.1.2026.10.25.16.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 16:36:38 -0700 (PDT)
Message-ID: <6ade9286.e9977bba.1e78f6.52e6@mx.google.com>
Date: Sun, 25 Oct 2026 16:36:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1751107283371191510=="
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
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] test: functional: retry pairable when Busy
In-Reply-To: <32b040dbaa0b8bffa4746203c5232791574604ee.1791671481.git.pav@iki.fi>
References: <32b040dbaa0b8bffa4746203c5232791574604ee.1791671481.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1751107283371191510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] test: functional: retry pairable when Busy
   Pull Request: https://github.com/bluez/bluez/pull/2659
   Created:      2026-10-10 22:45:48+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============1751107283371191510==--
