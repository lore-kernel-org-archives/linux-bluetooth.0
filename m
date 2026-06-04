Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DD31F09A5
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780532398; cv=none; b=E7FDtgNMuUtO3Z4aWPyLzKAKJad1D9LsJOkMg5UWJAoBkBl/y+NDhMJNRDwXG9xG+czHR6beUAU+qfcKc8bdhjleanCj2o6IbEwI10hJHwDHHY/jKgDK6H4TLI92rtaeXkHmxp+xoAP1W1FaK98oPtyMGwVWmGSd1EBHYOTNxbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780532398; c=relaxed/simple;
	bh=p5xSh81CC59O3C+BW9oCoQheL9VMvJhxxYKi+siaNrI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lzXSz4xGa2qqWeQsYJ2zYj6zg9j3yE+RIIgXbEkdTfwCQCBBOd5/N6GJ4FrnZPdyNkrSj7gyzzYxGgegjaoDmd5Yq0cl0vuwHUp7j59jCNdwBTXt6nytOUvMhLWFFJ648o+L/uiZyh02xW2nzYTDn9/n4IUDprMkMlESK+sm8SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvmvf5Ps; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvmvf5Ps"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5175cb5946dso889841cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 17:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780532396; x=1781137196; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p5xSh81CC59O3C+BW9oCoQheL9VMvJhxxYKi+siaNrI=;
        b=gvmvf5PsgjbCMThU5oxh3pvzDeUGt2dvGeegUxX0Xxbs7Ljw5auR7zj8LOwvZIel1s
         lhr65wgo3gpxEj7oAx/FBMQaRIX9zjnw2PP/eEAcXHuzesSFUn4VNJsCQeR+fMCng5eq
         MInUQ06AJRy1fxTH1ieqNIRC0FkHZqNAdku+iJG5duQFf13+obw9EbovpwwB5TW1V9y3
         xRCh2MWQ6b6HkuhuHOvBkfXSLIw5oOcwHAIF+s7BQ7Hl/LxBjvs+5pQHPr41Udnb8x7m
         LzrEtWgRcNzJgTeiOiu4jDs2LWgsOympFScUa5myRTQZFNki9cH69tsNnf9UybB44qsY
         wIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780532396; x=1781137196;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5xSh81CC59O3C+BW9oCoQheL9VMvJhxxYKi+siaNrI=;
        b=k8cczPi3HxYXth9uLtu8ySzw/BMXe/Z9AofvALu8qh+vv68ppx2jinVTreWs9OMtPJ
         1Nwo1xYTO+cNuvkNFgtC0WMHPr1GGAaz6uRFW1lYO0s1XZ7/Cxb3FeoLXATcnCqqOD4W
         YA9GZr1SMoIGa5laM8uhZgXqMZXw743sqi5hL9//CJ+e1wVUrpoz74XVrAjNbTPoJbqT
         iDVZQuUlamb7asnsjdouvFNdcIA+a/e8pSw0m2EYy/ThRf8YgSJmKFD9LouH4koAVsTT
         zPiJGIsOJoYdGf5NAQtWU6oeG40RoCwrLLGXLGrompNSph4Q9TbRdtSyz5qzwOga8DMn
         T8QQ==
X-Gm-Message-State: AOJu0YwT0KoRILDQV8+lqOojqjPBqDtPa1mgEoJTw5UqDNXIHLS4saU/
	6vS3YSH5MoyAtwmj2M6S2xes9WROxzT5/k2UPcsPnnmE9fz7KF2Gb/bgBeS5rffq
X-Gm-Gg: Acq92OFEHhbBP05sJRZeA+6MoNustkR3v5U4E7wEu9C3rXEQcPvKHM1UL4ZZoGxAXQG
	zCcf2SOtRQUNaOr4mr5xJc/zegryyj5cjbTxb+uZPcFfMjiVswjtZVOu8XpdfiR48V2MdCteQnA
	kUBSTe1yVXR2VrCyOeBq0nOv4KUzUUudu+w8VCo8WfsyDYLpBnjAMkbeMEeVj43u8zNNcrQK4Cz
	rBceA7hULednt4AJ0wScyAf4VxyEKIABglMoaDRpwrnrtzialpd1232rBc3Qdwz0VT8FanHtrh1
	mRByxR5NcyZ0b1DPIvQGtzKym4gBAAuHzT/r+dofFVTBVWgG+VF/pJ9VEKviZV9ap1nLK2NjGsJ
	vfW3KtJIgNAqBqrmx2vxT941TaLGXj6G/lwEV60mMVw6ks+alaCu0PYFtysAI+jKLclxPKo78dx
	My8K1lBjWjZXkRKBw9hDYc27FGbfwHl6ri8hCTHQ==
X-Received: by 2002:ac8:5a13:0:b0:516:df09:b1f2 with SMTP id d75a77b69052e-517786c91e5mr83389701cf.44.1780532395793;
        Wed, 03 Jun 2026 17:19:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.10.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fe25sm36504926d6.3.2026.06.03.17.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 17:19:55 -0700 (PDT)
Message-ID: <6a20c4ab.65a8c23a.152d1f.4e73@mx.google.com>
Date: Wed, 03 Jun 2026 17:19:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2696283945678221896=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad102nikolaev@gmail.com
Subject: RE: [5.10] Bluetooth: hci_core: Fix use-after-free in vhci_flush()
In-Reply-To: <20260603234343.445-1-vlad102nikolaev@gmail.com>
References: <20260603234343.445-1-vlad102nikolaev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2696283945678221896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/hci_core.h:28
error: include/net/bluetooth/hci_core.h: patch does not apply
error: patch failed: net/bluetooth/hci_core.c:1040
error: net/bluetooth/hci_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2696283945678221896==--
