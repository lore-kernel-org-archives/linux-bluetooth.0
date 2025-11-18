Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC93101D2
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458605; cv=none; b=fLVJUk9MaYl+hOFK0rNCzh8CcYFNKjbrk5TCGBS7z5heuozytgoF16HvfBSlvadhWck27raPL9Wm+qwQyNilEZJNzPc5kcYDXT3coYAE9CwDD0+ibCqEcOpimpjWURnL1EPuxraJRj/jLOq1WOUz135srdUpFTlJBUQp4F2kefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458605; c=relaxed/simple;
	bh=hrb2YpSrbeEcFGPxa7cl6LZ4lt4hMWEuQoMF/+gjSgw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=R97oFaLsBICE4ixJPfcPgpWvx+5v/nROwwVFWZpd07+HxrXKNwnaSwd+IY80hec9/P3H8YJ2QYaw/buFF8v/SjOmNFmdOa8p2il9rPRxHI52Bzb8+YrQZH56DtkkN5MQd2D/ySbfE5MWhgR5v8z6Dn9JqDjqOpqOcOxgCFtJP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VUTBEaV5; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VUTBEaV5"
Received: from github.com (hubbernetes-node-c0f3d8e.ac4-iad.github.net [10.52.220.66])
	by smtp.github.com (Postfix) with ESMTPA id 72D7C4012E5
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 01:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763458603;
	bh=hMgoI76FkW3ZUeTYE06qxcsfJYumO+3LeMZ72uIYLzU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VUTBEaV5rcupE4fhbirEV2CtoVrpXkaVugaqoyCgfnu1LCQJd0TkBJUeK1GxcoOfN
	 SILzYPO+Tx7QWDgMbiHvzNPxTYivywUDOf2Lf6jE7Ol9vHTVUQBGzgvf+zviy2jjsP
	 oRqwpjUWrTolgyCM8nuNb0WpBfx5DrLv6TFUPcaE=
Date: Tue, 18 Nov 2025 01:36:43 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1024759/000000-d052ff@github.com>
Subject: [bluez/bluez] d052ff: bearer: Implement Connect/Disconnect methods
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

  Branch: refs/heads/1024759
  Home:   https://github.com/bluez/bluez
  Commit: d052ff503d0ee1e77292187fe788b80ec079f571
      https://github.com/bluez/bluez/commit/d052ff503d0ee1e77292187fe788b80ec079f571
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-11-18 (Tue, 18 Nov 2025)

  Changed paths:
    M src/bearer.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  bearer: Implement Connect/Disconnect methods

This patch provides implementations for the Connect and Disconnect
methods of the org.bluez.Bearer.LE1 and org.bluez.Bearer.BREDR1
interfaces.

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
