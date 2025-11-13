Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311EDDD2
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763015119; cv=none; b=frcF6Fnvm7HeVYv0Ob6VezoO8lgmu0oAb4rxvFjk052/pOEAsBwABYL0FFf7f4nD8mCnXnKvh89E6LLGfnwhrEvpKAFIPPSBs/xuGib7r64TRNj9BBwS3hDC6CHxi8QfHUlnYEmXG3p9dzLl8XW/neLrtQQo+hPHkgzW2UIwVGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763015119; c=relaxed/simple;
	bh=mHDPbQQvsbdcGmH5P/Hww1zM/znCof8YGwLiCAe3tXA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fvHtq8j/r8/RUrQE4bNCoAGDlsX25sy0hOsj/L3zylSS6qFJkr6EyyKcT4286mTuNJP4Wm66EMHavwjKbRJwsciMwHYwHvwClFd/AQv2buPfdQQWS14t3UjsanJJG1Xz9NsYEEUWEqmkHKuUyhhBwmP8DzYwqbrL2IdQCQNmxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6+zER6s; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6+zER6s"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-433692bbe4fso2580085ab.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 22:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763015116; x=1763619916; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mHDPbQQvsbdcGmH5P/Hww1zM/znCof8YGwLiCAe3tXA=;
        b=Y6+zER6sUirqBDD2F1DDs7Yp/KxErqAoN/4binSB4JKjL3dZ1gzfkV5ebGen3JmvDd
         Nj+nFhVkHKitXsqJR5Xp1X04phUrRhYMKi/8hkidDX37XyzTiEZCKPUXMFbn4I37y6lI
         wUzKYRaGsqo6bquMWCY3VGALRPKEuSnmpEn8Due7XMUpQBxOOuF5uUCdfzWmT6qpW5hL
         aSs5GUwOYEHgFL4UDaeKmWSnWg4RjCgvLQIqcLND1TyZ1/ORw2lCf4GomlI6e5p2wX5B
         W1MzkP11Lr3ock1UdMDkg+7daBOCeuf1NGZRebUlM5Ak/uLDR2mG2gy+ARi4l3tTWFqU
         cbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763015116; x=1763619916;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHDPbQQvsbdcGmH5P/Hww1zM/znCof8YGwLiCAe3tXA=;
        b=pp3qietsnOpWMjczU6g+x4+u9DjXQzOkbCXhbHA1qggoRS8dBLOtCrVAuDNzcZOA18
         zBhhoS13DCyjxWZ5iROitjgIZlleI9cElGpsW3spY6/Q8rGKKyiyCvASvw5RTndJ4+WI
         i0by7C++nwq5iqfqozso8NT18Ak8y04aAUq4wUnLqajrDJWtS/C7qbsK1vPA05rN1dVb
         AgalXigDoK9L3r3F4QrNQdpvqQjYfR/9uxk+nQ/7S0rF9sYWVTUUUXVr5TMsBADs21JL
         XhNX3PVkHBhv8mNa2zO+tKLe8e+SCFG8cSQgKaJ5T3xEiJJMUI9sM05xM1g/rK8RC+YO
         cbkw==
X-Gm-Message-State: AOJu0YzMcxBF5+Go/AAQKIjrsGaOJ5p3jhPauTT6nIHGgxdHqJREJHNP
	5liAepNo4FZjIK7ami84NZgANqwL65iEaUr0q7A9rEU8377ppWN0h3Vcs6hgkw==
X-Gm-Gg: ASbGncsZGdtxdz132ld22g5cbJthB6s56JNMjYQ2KsM7N5p6yN7MnkYUs+9dcIiJwR9
	cBqbtGz0K1QZe0CTuki8/YU77Pzc6ieIkB3pjz1A0YFEpUntc1M4NL9FEOkDBUYObu70YVcph2U
	wg8DPKX3zQUmKxqZcXktlC6P2E9Fu07maL76sTxuy4YppVFPmhWAU+ZgqwWMQ40I1MFI9ejcW6q
	TkdXq4elys74oGQ6G3qpu/eUxrGsA9k4shtE/0PbMFZf3A2uVzTGxVyaqfghMUz9WpFUgXphG0i
	lI1xca87pcwOFRTtnK6jlNG4mKmBNiQenOthUqzfUFaE7FXQHGzRu6gYWq9omsKBW9ZpVxCbWP+
	+43LAgRnDjaakFF9RVQNNUPJkyYCBmPDHXUkKuEDl7abwqw5ugHLtQUXZ6wEo0c//R1DDw6D8yS
	R+5e0dTHQLLfA/ee+gUQ==
X-Google-Smtp-Source: AGHT+IHFpis6NU0nZPiGewNs6drxNpfMEONyTnKHyOUbLcLthAzHxUicUBzICnUMCIVJ0uVaYRTyUg==
X-Received: by 2002:a05:6e02:4714:b0:434:74a6:48fa with SMTP id e9e14a558f8ab-43474a64b2bmr53197665ab.22.1763015116411;
        Wed, 12 Nov 2025 22:25:16 -0800 (PST)
Received: from [172.17.0.2] ([64.236.134.160])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd24dadesm415250173.1.2025.11.12.22.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:25:15 -0800 (PST)
Message-ID: <691579cb.050a0220.e726b.0acb@mx.google.com>
Date: Wed, 12 Nov 2025 22:25:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8406387750551962526=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 13875017792@163.com
Subject: RE: [v2,2/2] Bluetooth: Process Read Remote Version evt
In-Reply-To: <20251113061117.114625-1-13875017792@163.com>
References: <20251113061117.114625-1-13875017792@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8406387750551962526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/hci_core.h:750
error: include/net/bluetooth/hci_core.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8406387750551962526==--
