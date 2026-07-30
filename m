Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8742CCB9
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413900; cv=none; b=cOL+CaO9YQspC7gSUofD7EMAZXz0wOyWsvULdQBaUHS/7OiD249pukP3dFZviaSLo9sDmE1n1AF2IQWlZkJH38J5zvhqw2gifGditS7V+z/B3ItO9vPj4f9Y7NMspA5jPtEloMseE9iO915JFcH7mSlvvt/Fs39ijKxpIOUb+Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413900; c=relaxed/simple;
	bh=kSsN03GnxoJBIoQA0nCO5cNxUI5HxHRIdApveJYZoOc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MvzYI42iE6L+NxcYqKVH4pM6QBUkd9HErWKlvzq3BavZc/7oVS+SNijOCZlH/HISMLJ8lnFk2Kf795QvEySVJSJsEpGWEAam+4/rTO7zpWDpAjHVI9qgsIcPqGIK6xk6t8qxeIs++Q4T6rTabQRHH9AwPmZetj1Cy0RHz4iGiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gjQI/Ius; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gjQI/Ius"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785413898;
	bh=Z7PzcCvIyTUVW6OkJb2/sPB8hx1kKXYzFBE+aK/BL3c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gjQI/Ius1C65vRlZpM9I2H/PRrX9QkO3VR8370vmf/K9HvR4L+gbqQs0VzU0Q/JaO
	 paJT7leVhOvVoAXJIBVyPoqL/ZcQJNscbEOQ8pW49958A1u2WlxrZRoZbmzeOwEipH
	 TyJn4sGSTr2eJSoOgkg6UPO0EgYnVwPU0eEIRxJw=
Received: from github.com (hubbernetes-node-db697ad.va3-iad.github.net [10.48.67.64])
	by smtp.github.com (Postfix) with ESMTPA id 17EE7281308
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 05:18:18 -0700 (PDT)
Date: Thu, 30 Jul 2026 05:18:18 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1137365/000000-8ac88e@github.com>
Subject: [bluez/bluez] e45e34: doc: Add org.bluez.ChannelSoundingDistance1
 docume...
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

  Branch: refs/heads/1137365
  Home:   https://github.com/bluez/bluez
  Commit: e45e34bc67bf179f59f7a3f03ba4d88d3417685c
      https://github.com/bluez/bluez/commit/e45e34bc67bf179f59f7a3f03ba4d88d3417685c
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.ChannelSoundingDistance1.rst

  Log Message:
  -----------
  doc: Add org.bluez.ChannelSoundingDistance1 documentation

Document the org.bluez.ChannelSoundingDistance1 interface, which
exposes the DistanceMeters estimate computed by an external ranging
provider registered via ChannelSoundingDistanceProviderManager1.


  Commit: 607387474769ac7f362acf38c3c3beedc319786a
      https://github.com/bluez/bluez/commit/607387474769ac7f362acf38c3c3beedc319786a
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.ChannelSoundingDistanceProvider.rst

  Log Message:
  -----------
  doc: Add org.bluez.ChannelSoundingDistanceProvider documentation

Document the org.bluez.ChannelSoundingDistanceProvider1 interface,
implemented by external clients to expose per-device Channel Sounding
distance estimates that BlueZ reflects onto the corresponding device
object.


  Commit: 8ac88e45b986c1a60e4f6d34d95f623485e72811
      https://github.com/bluez/bluez/commit/8ac88e45b986c1a60e4f6d34d95f623485e72811
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.ChannelSoundingDistanceProviderManager.rst

  Log Message:
  -----------
  doc: Add org.bluez.ChannelSoundingDistanceProviderManager documentation

Document the org.bluez.ChannelSoundingDistanceProviderManager1
interface, used by external clients to register and unregister
themselves as Channel Sounding distance providers via
RegisterDistanceProvider/UnregisterDistanceProvider.


Compare: https://github.com/bluez/bluez/compare/e45e34bc67bf%5E...8ac88e45b986

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
