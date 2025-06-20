Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1C830E830
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412245; cv=none; b=tWQF+K1G8C8cJGIlazSf31p91wwV71Yxf8wD7ZSu9NwPH9+42h1yaTRENoYUm2CYN7TDTK6kAnBCsYLY7cV9HKa48fm2Tslsp/EBjB1KiM7DwwHGYq4rD6L4SLj4Wtsr7Kg0kOrHE3YUOS9LKJJ3xNmJmmUneyd0Mvwg6BiSPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412245; c=relaxed/simple;
	bh=lE2lsJWmM8SOJTP0WklVcBg23LnBo+9sDjsAh/aMoKI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iH5i7RtV8HcaLNsuLO28DfoGA9wjVvk4rG8grEJWtDpcyN4JmBhSmDxX0zWyzi10Kp5EpfHMsWvCwrROx8+2lwG0Y7ZL9c4LpIw0c/fUjSnJ9m7ZFnWGd3/uMsPK34FAz/0HtMRtkpLEfD8xpzlyRX9jyGF4ZW0ClOjK8zHmiYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RwX3LBng; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RwX3LBng"
Received: from github.com (hubbernetes-node-e940f9c.ash1-iad.github.net [10.56.176.16])
	by smtp.github.com (Postfix) with ESMTPA id A1CAD920445
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 02:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750412243;
	bh=aKkR2Li+LEeOeEV1o6TyTNjndlINJurfNsjgERC5q08=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RwX3LBngKqvQ9dIYCRpYH7M2jChHJ6RMq1DBsCQqgLUsCJZw2rwpe0x3BMYy9waHj
	 qVN0ShEnIQlpFWgLtoBY63WORwgOdTJLZfkQOR6ApJhUxpFf9BxxLRtN6Vs+syc84M
	 GEUIHr1ChHk9bXiPVXzGB5gD5yhVK384eTCP978Y=
Date: Fri, 20 Jun 2025 02:37:23 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/974159/000000-dcb59d@github.com>
Subject: [bluez/bluez] dcb59d: device: Add bearer info to
 Connected/Disconnected ...
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

  Branch: refs/heads/974159
  Home:   https://github.com/bluez/bluez
  Commit: dcb59d21c0d425d2bcffe251f6eb15e489151e29
      https://github.com/bluez/bluez/commit/dcb59d21c0d425d2bcffe251f6eb15e489151e29
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-06-20 (Fri, 20 Jun 2025)

  Changed paths:
    M doc/org.bluez.Device.rst
    M src/device.c

  Log Message:
  -----------
  device: Add bearer info to Connected/Disconnected signals

This patch adds the Connected signals and updates the Disconnected signals
to use a dictionary instead of individual arguments, allowing additional
information to be conveyed in a backward-compatible way.

Specifically, a new "bearer" key is added to both signals to indicate the
transport type ("le" or "bredr"). This is useful in dual-mode scenarios
where it is necessary to distinguish between BR/EDR and LE connections.

The original Disconnected signal was introduced in BlueZ 5.82 and has not
seen widespread usage yet, so this change minimizes the risk of breaking
existing applications. By adding both signals to a dictionary-based
format now, future extensions can be added without requiring further API
changes.

Fixes: https://github.com/bluez/bluez/issues/1350

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
