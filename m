Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC905286D73
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766559501; cv=none; b=IeAnLlmhJet0AEXJkFnBx+F3xSW0+Z8mVQi01WWULwZ3XGzu/u0ox7yO9DilWqYuf7c/i66OmAKltL/Q0e8DCiJYpJwRaOU9qRS8HIu2YlusHR+JlrrWziHTT2kgWmbKAXOQ/GDtCwsce30gETQ5mMpUpdJApbAovVUaaq+uHJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766559501; c=relaxed/simple;
	bh=WIYBtQW/NpGI8itPa6PLLE/QL1pqUbCxuBzgPawGxV0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dFM6MGNdfAOO4vS8VOWs6Ji+Dxle1w0iyKb5pzCsYdm+iRb2u8y5hqPN0/Qf4Gs5Wc2+kh7Frsg4taFyiYZ0biYh1b61yzxh1hrevQQxlOx9Hj/KrRSyHsoPOaL0CrbuMs4KB7oMlsWw4aLY3nYwCBKi6tS68c6r5YljJazz8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiKhJecv; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiKhJecv"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c0f15e8247so473512785a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 22:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766559498; x=1767164298; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WIYBtQW/NpGI8itPa6PLLE/QL1pqUbCxuBzgPawGxV0=;
        b=DiKhJecvpSWp72Bc+JMiPhUqgihX726BCJhvs1lOSkaKuivpnybhY1ABpi+d+oFBFs
         k9iszYBsrtcD1nuoS+LnW44oukC/RF0RnjqnQJM7r/b22jlseJuc9emCyCDyOcdG+AM0
         5gOS1gp/kcoGVoQEj4SX6E6UziE39loYUHPozYDn1yuAWa2QUw3/3V2vAJusf5UxWe9e
         laT9sOQtQTeTn1iWtrnFwDOu2j8qjB+2p/2hNlJf+JINqvf1S2wslp2zbruUG+Zy7bPx
         lFutiv5zuucC3YhW+rkUZQ0z2TKPZmlGCQU7ylTHRaPaGFLpxwxamDYs8SH9dtGWy9zB
         FZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766559498; x=1767164298;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIYBtQW/NpGI8itPa6PLLE/QL1pqUbCxuBzgPawGxV0=;
        b=UzJ8uFTI2HocWWoMwXcTL3ii2fz9CeB/beX4ZjxuWeMIpEQP6rDaEf+JJDUQ7cypt/
         o3OzQvQpVAmsSaO6r26FErki4aFILlx7Os5+GubOc2Ba7eKzermbCqs4ilmNEQYyrpTD
         5pK/XaZanr2cStT6RNjVNpXey2R4S3kZ/tagR3jpfHpmbGmack6UUlKny1WEnz9Mjmc+
         YngWLKWnwoO06y1M4A+7Mm1z38lSHvx66ZKJ6TFV/56xgKgEWCgZeP9z7J/ADLBnkIbC
         IRwZYEAir+d49GAJNgBGZvBQZhu0EnL+nP1HnIiL1yi5LNcri4n8LWzkOJBEjBGzOSGy
         DpyQ==
X-Gm-Message-State: AOJu0Yz1WiEUO8WobF+fbVm2cHcdf+0rkCI/cMFLlpfr8JQjgc20GG+h
	LVi1RWullYifGoxu0sNjWKKUmWm7mvUZKKAMtngKmfgq/HOZAY7KfL84XId59eMEcSg=
X-Gm-Gg: AY/fxX4TcW9Vs8MmY/kP/KegcrsaaC60w2DbYUPEnZIMY1kiY0BelMwrd7qCHWt4tZX
	MyGHLMu/dD5K0EjTPRo2V7/kY4eZZRtHpYPSn/GRyT3RqM6u0+E2oLovv1wJolW8YJx77+oyirK
	gKkeUFE9N1vRdVnmefa7EowEvO19npErDcuUm4aMluJSx6/Sgst/G3uJYWzjiBADjL9EIkBxgRu
	FeGvmzpcHwwvly1CKr/3VGjSoDeLf0k/d7dO/NQC4iDU5Ls3438H6ZdPT9kM3/3z2mZO963DCe4
	9o6GtOw9b+fGhrEoYM8yV/FtYxHW7LG6O9pTSqQSjP2kZAuqiYKoGNfxWrwSuUC3gHNnYqBNU56
	kg12jGW6zt+HBEjrR0dT9mXoGDcotEmcxKzkZDG3XDD4akGh1yc1pwMoq3NzhS+DIrmVqK2gVXs
	A499B5Y3ce5gibn+h4
X-Google-Smtp-Source: AGHT+IEgyygU8byL6cnQcLS1AHdOBzfzZxyNUEZT/2F/QteJ3wi9P1kh2r/OXzKryEs0Qaa8g/Yyaw==
X-Received: by 2002:a05:620a:f03:b0:8a3:87ef:9245 with SMTP id af79cd13be357-8c08fd1a9d5mr2438321585a.85.1766559497832;
        Tue, 23 Dec 2025 22:58:17 -0800 (PST)
Received: from [172.17.0.2] ([20.161.68.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d96fcc024sm120633976d6.21.2025.12.23.22.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 22:58:17 -0800 (PST)
Message-ID: <694b8f09.050a0220.2900c8.14dc@mx.google.com>
Date: Tue, 23 Dec 2025 22:58:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4858504111596170702=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mahesh.talewad@nxp.com
Subject: RE: Enhanced or Legacy Accept Synchronous Connection Request command
In-Reply-To: <20251224063150.2476968-2-mahesh.talewad@nxp.com>
References: <20251224063150.2476968-2-mahesh.talewad@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4858504111596170702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/hci_sync.h:189
error: include/net/bluetooth/hci_sync.h: patch does not apply
error: patch failed: net/bluetooth/hci_sync.c:7077
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4858504111596170702==--
