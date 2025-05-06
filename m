Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7902797A5
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543411; cv=none; b=lO6AGK7U6ha8n5J8pXwH8RWrU3yvDCcCsas3AaUOH2QL+lByfTErtoR4aCfI+V3XfWls8lq2WoGxD6OiFcS8HWOTJPisieZn3Ot9vYKsvk4kB+3IKVHDU1d/Or5MxGyqF9W/Sku/1riGar0oftAnle+TosAgb2+FtytpF70Lpsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543411; c=relaxed/simple;
	bh=xJMJ9f5eVrg6LPeOevS+GLtV8QDo+24inSKmRYv/Yp0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ifHO9lsGFTGa7wqvYDjIyE0SqZtyBELsg6wghsyKou2UhEl9QTO2LevQcyBYX1mghOVgd/upfzXJI9VEIIEOzBKjkdjduZF9NWuarem+cO4rCs9c3mXvHI3Rh18+GcIhIMnrdg+21nEV98ve3TpSE3Y2X7awiqypjO4DgJUdQNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Q/4slGf/; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Q/4slGf/"
Received: from github.com (hubbernetes-node-4e823fa.ac4-iad.github.net [10.52.145.25])
	by smtp.github.com (Postfix) with ESMTPA id 90237701318
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746543409;
	bh=mrJ7oxqRCYzTOcJs6veJKC0a1wcF5EcxxEB8v0YLsWQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Q/4slGf/kmNDU+z5g+08grwUzZKL9A3m2WggCtsQiRSc4hEkO1imB9mU+RmFz/JnP
	 VMuEhgy5u8XJOaSGNgJqw6+hfXRSUaBwhn3g3VOfrR+s+1HBDwqdCH5M8W/mzbLxfw
	 HOGe+APgcDD3WaXH4+NKWDdTURMjOfqfZNfM1FKs=
Date: Tue, 06 May 2025 07:56:49 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/960073/000000-ad14db@github.com>
Subject: [bluez/bluez] ad14db: main.conf: Fix documentation of
 TemporaryTimeout=0
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

  Branch: refs/heads/960073
  Home:   https://github.com/bluez/bluez
  Commit: ad14db88d6eec2585b073030c9baf2b562278c4a
      https://github.com/bluez/bluez/commit/ad14db88d6eec2585b073030c9baf2b562278c4a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-06 (Tue, 06 May 2025)

  Changed paths:
    M src/main.conf

  Log Message:
  -----------
  main.conf: Fix documentation of TemporaryTimeout=0

Setting TemporaryTimeout to 0 never enables temporary_timer which means
device_disappeared will never be called and the device will remain
temporary forever (until the service is restarted).

Fixes: https://github.com/bluez/bluez/issues/1100



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
