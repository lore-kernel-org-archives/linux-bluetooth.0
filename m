Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAD02AE68
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765386083; cv=none; b=YEWMi6M+89PTlnr3OgAGGnI2S4JBvG52UWbI9WzaXVF8+AYmOcsDqToVdtQ2Q3WRmFawyp0PawcRsaoaz45o3fXHp4m6Z7XiuNmbJoabnz4caofVhnQrMxrICHOzPgSEOzw2W9bIWpea85YofCZci9/p6epRtCuxF4bclMBafjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765386083; c=relaxed/simple;
	bh=xhbi9tP/1KoXbejtOorNvpLML8waHfElqJX4uL4GB/Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DEaXLAiL8Az4E7g0YQ5CKr1ENJjp4j3I8Hhu1L8loiZgx0BbvxzX59UUKzL7iJXwiANYXYAZ6tQFAd3gMexoYwQAqQcAlBdq49JTJwdxAz9Qe53yDxGZtsRdagsSvmnIvpqZ7ZbnJ3zdoEv+jzCQ77z2DXst/V5HTj+KOHsCMxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=B3DMwafl; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="B3DMwafl"
Received: from github.com (hubbernetes-node-b248d88.va3-iad.github.net [10.51.90.40])
	by smtp.github.com (Postfix) with ESMTPA id 9B0164E117E
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 09:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765386081;
	bh=B4054iSuYzei98rrJfdUWngYttYu5MnWBUSBSqJuHl8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=B3DMwaflSeyDKuL+f/Qd/2GKoOx3LZDBA748Fre0qDOnNNxW6Fu6pn4pXNmRb/hBu
	 hFo+NYRnYQceeXPTNB6pvkzzzBc6pQeRUbJS7M0vI0FZIMrXfqINnrLN2C9hNhvLdm
	 eKDEEaOMucMU2sQmj/aDGouUhNOxfkdbpofdxbNM=
Date: Wed, 10 Dec 2025 09:01:21 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032038/d1aa17-000000@github.com>
Subject: [bluez/bluez]
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1032038
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
