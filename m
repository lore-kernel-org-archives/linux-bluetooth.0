Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795028966;
	b=LuHG1Kcjwe67l49vvQKZ3W6tLllaqj21wAAgUcAG3S1pkSf56I1HtoFVE1NCv4dMSXj8
	 yVkHo5JJiNFRqPgbgcB6uNeBvi7qLcg3kLoXK2eWIG8YuxMpz9wAdziYEwX/pyxWeyCft
	 1HrE9VXXmd+sFYKon/5DSjJ0zue8LWEkKc0MJI8Wqy0ZWo35naguzE+5iUoBuMaB6goTp
	 Xb+2f34tikKJ9gCpukf2melCL184FrtPB7PG4bTRvzGM/m/ToK1ca7S9SphSFKOa0gTSR
	 GcHjQsmpmTtY8QWjvJ6tee2ITUFjOtidzI1lp1oie7ewvi0S0dkqiCXhA1nAv8P2wGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=KWnT06v+PBPS2eA5xPS+pgnZ06DNs3mlqYSfbbbc0lU=;
	b=xuGmuDY5cDOpsZL+JI6yINTWpV5DlAwpJM4tOMnhT5Qc2jyCiQI4Msgvh/F7ArS5Vk1J
	 Xudw5hVs77SKCDhF+LYrzprcuIYikI0Upvx9CW4P55xbjepHIFBcqnWwjRy2YE+K5RgTH
	 dpt/fFnNz4jQ7C0I09wkr+TGfA+ecFAIu3/sVHUCj0YGLzgUkIa3QhIJH0mYkPSSeJGB8
	 zUfg/u0ZH2TVhA+P9cd+Y01jZNOBlzdr3XJ40EovjS+XATaBIyo54JWRWBFL8CHoJC4w7
	 GGQb3Jn3fvPzeHla6tooZWDUuY1CGIpGoGhetliYEx7p+2HPFFfnR+m9OqFgHjZ5EtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nsm+HJkl;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2460A2604
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90E2460A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nsm+HJkl
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-382f4710a17so1707352eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795028965; x=1795633765; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KWnT06v+PBPS2eA5xPS+pgnZ06DNs3mlqYSfbbbc0lU=;
        b=Nsm+HJklJxfDeA3LBUOrYc2UVsKALFpWbA3OdOuwa7A0c3taNYbmIvCTXRbUTy2VMR
         mp9nF4FGTrZtyCQ6BHYoyjy258hcrfBVWoQTf3AGp3R3lPUerkM0Xf8yoI/s7TuJcTe3
         gzoOgp9gi0yvUbBa43unELGpg/uVO54J7h8Az1roZ70GQOaCYAPF78JxoXUTtHTxDyJu
         ymIB2YcgLzR7GJlRdjciHdxkkMorMXKwQwNuWJCFF+dXFEcELlte+GmEClbXnhllERvo
         tiM1JiWgvc6HDUfVOjHSvfvyhpuXXsECw9zo7l7gvm35u00gzxTva/wANjEkyQ98oRnX
         2qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795028965; x=1795633765;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KWnT06v+PBPS2eA5xPS+pgnZ06DNs3mlqYSfbbbc0lU=;
        b=xqTtwEA10ErYT8J0lsODjVjAufCQ1dmel62T6mpQJbzUd8k+TUv3xchrMZDwHiXBzw
         QhIiziM39K72ndyklxiXSvE4t3LLMkFno4vYq9CTrsDjXADgNgA8AT0kHLzLGDc1VArB
         rDpSXNI5jECCChtPy4Nm+0bCUs7EA2H8GEvY0kHkOEcaOAIDtVLx1V4ywrj5ItAPL//O
         cTL9Ax0jPpaxrjIZHE1eh8S1m9fJUmzvzf1YTZyOdu3CCTQYhALYmCuAdivpObOJlbNl
         /c8w7O4TpPv2hKtNsIBBZI3q5RGDTduBQxg3itEARgn5hwb/WLl18JsMFqmYcK+3MydM
         EPZQ==
X-Gm-Message-State: APuU4Z9xb6lLPZ7+ccxuN3ZzSFvHTNHWxm/odCfisfnU0tRYcCTfy07Q
	qYNRNMqgkIrPmhgPlMHIGMYfIssS0w2H709MTbdgTr7ByLH5dKze/l3MMksB7w==
X-Gm-Gg: AYBFou1iR865rH0bYvIKHG3g2J8qFAfulHRNO5Bms74oWCwM7qNn3pj1HSOXilT7Dgl
	SY26bWr/kmX0toj7PXhVsxVqd0AHoU6B0oisWXqlRkB+O1+kO20DVY3NHWdH4yuM3MzFPBGU52q
	03fy4nlso7q5cdsAt3whQgkjSfv7Jh6wt2EXlkoaSLvBwP/tIl4TAEPDz98yHT65xFwlcaoWRSX
	ZvvjXjvWoi/vOhm4Qy+1d2CrXOrCHsrK95T3r9rJN0+TGI/mBWhxaRPHHX2fK6P1JecPYesle+z
	Pey2g/waj+Y8DZliCTCbRLtR5uQKfackSbQbI1VnK8oA1HxiP6ITaShejM9xYYfZjwl0Ya4b/4R
	xTO3HHQXhlo0dy8kWqw5lNyZXEDKfWpCZj2u8wmZmACT7zxW4s40a2RCugBB7SChgKunxNrW8L9
	u3Thc1GyXOuNaOBAW4m5F/eLsxX5iNZoZxVKcVtHeZw3iyS53pDkMsjzJuX+Y1717//ie4ZuGRY
	il7aFl7AuYuTpkRJ+y6frszf3fwhesm3KG2IUMycVyYYX34uwmuZeq3ZMBa38w9MuGoSXLzPQqo
	uJonYMc=
X-Received: by 2002:a05:7301:140c:b0:382:105f:e7e with SMTP id 5a478bee46e88-38281bf902fmr3137721eec.36.1795028962798;
        Wed, 18 Nov 2026 11:09:22 -0800 (PST)
Received: from [172.17.0.2] ([20.168.111.85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a63059e3sm14531400eec.5.2026.11.18.11.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:09:22 -0800 (PST)
Message-ID: <6afdf7e2.85bacf15.15166e.b05d@mx.google.com>
Date: Wed, 18 Nov 2026 11:09:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6892088029085267000=="
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
To: linux-bluetooth@vger.kernel.org, mitar.git@tnode.com
Subject: RE: [BlueZ] mpris-proxy: Stop and start together with dbus.service
In-Reply-To: <20261103151724.598627-1-mitar.git@tnode.com>
References: <20261103151724.598627-1-mitar.git@tnode.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6892088029085267000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] mpris-proxy: Stop and start together with dbus.service
   Pull Request: https://github.com/bluez/bluez/pull/2753
   Created:      2026-11-03 15:58:26+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============6892088029085267000==--
