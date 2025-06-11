Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BAC230BEE
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749629830; cv=none; b=YeS7iYT7LhyyNxwjVwbCFYIb8fesXVKGXCwSqoRK08MzV1PrntLS+kDxtlOGkxPorDaiCZZdZlThB/mvsiZNMietDv398dxw5d+l5Xai0XCRTg7rJ3QCxfDNhY/mXc878lWPbAhssCKZoeN8+rZj6Zd57899e+jlxEWCBDHDtfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749629830; c=relaxed/simple;
	bh=DtrJk+FubWMKkJMVtHc4ScvKTP/CGeduksXGaBAj69Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=h2hdcdVQp1bwpGPvg3bSHxSjRZKGb59aBJcU3pQV5Kz9lTmIg0/7UtR+woudMS6YfX8cdDrJEpnEwx4BaB7xy3g3MpTdOTYry+SxeUJ8etUBATDWEoVyC9fi5VKtbNdh6Pksmm8ER+G+3fm52OAOv3stj3c+oY4J1ZVkCu1QB/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fWet03QI; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fWet03QI"
Received: from github.com (hubbernetes-node-196615f.ac4-iad.github.net [10.52.166.56])
	by smtp.github.com (Postfix) with ESMTPA id A92C36402F8
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 01:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749629828;
	bh=LnYfBeieSwg3irJE9hhK3XOyrAUzPSHuXKofg30MQHM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fWet03QIYUJfD+OAv/wt/dSiaq2hcxQaMk5dpNOvpD4Fp8QqtMfbTfysukXIyN8cF
	 TNlzyWBWz2NeJxk+ivb3ozgfZjEOewbpeVYuDK61Orp+Ec++x0gHgpbGpQtWRsr7Lf
	 AJwsYQKJ+nZ12GzMk8p0s3pTxLOBECbjL6hbrtow=
Date: Wed, 11 Jun 2025 01:17:08 -0700
From: Adrian Dudau <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/970691/000000-7d1b3a@github.com>
Subject: [bluez/bluez] 7d1b3a: tools: Expose the raw advertising data
 available o...
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

  Branch: refs/heads/970691
  Home:   https://github.com/bluez/bluez
  Commit: 7d1b3a88ee3dca27ef71af24991df52031afea3a
      https://github.com/bluez/bluez/commit/7d1b3a88ee3dca27ef71af24991df52031afea3a
  Author: Adrian Dudau <adrian-constantin.dudau@nxp.com>
  Date:   2025-06-11 (Wed, 11 Jun 2025)

  Changed paths:
    M tools/btpclient.c

  Log Message:
  -----------
  tools: Expose the raw advertising data available on D-bus to PTS tester

This patch extracts the AdvertisingData property exposed by
bluetoothd on D-Bus. It will iterate the variable message structure
and will construct the eir buffer in the format described in
BLUETOOTH CORE SPECIFICATION Version 6.1 | Vol 3, Part C.

Signed-off-by: Adrian Dudau <adrian-constantin.dudau@nxp.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
