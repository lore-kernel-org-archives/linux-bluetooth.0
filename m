Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D9EEEBD
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959532; cv=none; b=JihRrA1WkBS5aqVmix0B52m6FZTeMfrmNlu+ULd0RLfI7k/7jhsWUwWzgYgKfRXGeeCdGZiN+ADjbcBp7nTMmTSUD6lUOQqhqFllus/zUvxw+pYYCFdA/V7PgBh6LePjIsxyISUFy4QNg0eSGWRvj3csW0j3FKDx5NKQ3WLtSvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959532; c=relaxed/simple;
	bh=qX7EYWgbpJWXcYZx7sh79TuGMWzJK9jJOhvRfSyb8Xg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XXbLoRmvsL5gwEnwdKX/tqqW+0+Y+bZfiv9bI3MZt4/Z44VvybcRYqLch0DAHkLZPE0wgSvEJOBGcHsO4Lm3msRr/z9eExIhMoFzV2MQwv6oh61q26+pxihYLh6KPOM0lZw2fTQcl19ouO4tkv7o+i9OVBL3yQ0H2B23IHhvRoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xv67w5dk; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xv67w5dk"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-80a6937c8c6so537033185a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 11:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757959530; x=1758564330; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gav24+q/u5ApZbgSEyr0rOQUxwofdGAwAYdGcuqTyTA=;
        b=Xv67w5dkB8QVYcsl1UNpjzYqJhv3CkVHLwYjQp/+y/Dn4hckMyolXFrcCzSvdnn5kh
         Vxz3lzWXU/i/uN7caaqD/XvQZ0UYfTIOjpWIMTHTaqJpIEnpH3QXtISP7n4Uvi0GlHm8
         A1/tAeSJlxWIltUJ8qf3kct1Ltp+PJg3uysKGYTxFf82HWJ1+N9OkRmUebgcNZcoy2xf
         rG6th/AzwCEC1OUXs30Tp/gb9JC1G8O5rt/6k0M0S03es15d7p9MORmdm5+WH/Uwl20/
         RSfcSzovCKAqn03uUlXS+EmXcg3t865WgPGAos/nscepdCKvZ09+r+ofSKg84yBGTxXQ
         X4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757959530; x=1758564330;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gav24+q/u5ApZbgSEyr0rOQUxwofdGAwAYdGcuqTyTA=;
        b=HWJ95PmSZYhRGJLkNvkLRmB6GTIvE6aPh2YE/mRDZc+OwbXOpK2BXG6vKvO4ylGAxI
         MTSYXXDn9ekNqh+bK/f6h1Nx9BAvFTuBAS/DV5FiKs09HtK1sVN8e2XgmgONXG+ylUtt
         VZG6h8bkrSe2dY818HK0NG0syQ+7jkORzZkNG9j2G4OO9YwxtjZOjXBVCI7w1W2o3Kdy
         qUczEUTptYzsNn5gKSMZwU90eaJQofbuP8XxgYqPUy5HN5tQogKZamJ5lRKnLReiAyof
         2qV1zNb+1smsGxzcEIaROMK6xzEpRaVMZ/cgYd5PnRIQjH4VUjerjREp6rYV+BeYOQji
         iWhg==
X-Gm-Message-State: AOJu0Yz2zgerFZs+8ZjMgZ/WuFEAoqMp7ePBuecrK5Bspjw7RpJoLVjp
	xZr3WuveInxM5NNT2GRX2YK9S/2Wr+xnEbEo+KazEu24UAVqdmjSk1s0097hwA==
X-Gm-Gg: ASbGncsPirTPogex6k9B3WKP2bevqCFqqbdthvC9OCGtsH4PbIXLZSwak7lDO7m0/yx
	EwxqAb0ACQTlmiphP/QXgkONZrfii7gmzBrYdpLIsZzEyODmTEd3jPcnwlvHyDhR7vLnHeR+SQm
	iOCB8JzWlca1bl1QzQA30rLEyhUUWErE/hLmYzDkrpL0gXi20XFE0/YDauQXcOOceNU180Dgjz+
	LTGjp/7u8mA8NACcBEL6H3XPUk7slD33WhT98yoliZYYVw5SvvUkFAU0Xw6g0vyLLnKzuJVip2J
	oeYzyUOc0Mtxb7lQP2ST+pMAympMWH7zt0PcuMBC6YFzjxdcXijWwB+y3g4WPfGK9YxM1HmbuC6
	C6obWAQIogMn/8TAHGfOXhsABfZYKeauJCd6s4g==
X-Google-Smtp-Source: AGHT+IGCbYzZCuIvOmR22oAfVpfqSazHdDS2mAKpqdVGkfyBMy1BjMOWZ/bST4CyltooiCogS144iA==
X-Received: by 2002:a05:620a:400d:b0:80f:2813:59dc with SMTP id af79cd13be357-823fb82623emr1639816385a.3.1757959529589;
        Mon, 15 Sep 2025 11:05:29 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.38.20])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dab3e8sm70913201cf.24.2025.09.15.11.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:05:29 -0700 (PDT)
Message-ID: <68c85569.050a0220.9b190.92d0@mx.google.com>
Date: Mon, 15 Sep 2025 11:05:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2432338284710942620=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2,1/4] shared/hfp: Add Operator name support
In-Reply-To: <20250915163427.3589748-1-frederic.danis@collabora.com>
References: <20250915163427.3589748-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2432338284710942620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1002593

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      20.37 seconds
BluezMake                     PASS      2704.90 seconds
MakeCheck                     PASS      20.31 seconds
MakeDistcheck                 PASS      183.99 seconds
CheckValgrind                 PASS      235.42 seconds
CheckSmatch                   PASS      306.75 seconds
bluezmakeextell               PASS      129.04 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      913.73 seconds

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


--===============2432338284710942620==--
