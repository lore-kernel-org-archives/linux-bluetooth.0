Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C4D3D4122
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868066; cv=none; b=PKrqPII0wXmdLyxz+zBwwtme8YsMk2RD8XyUEHyBSJ1szyuiyJUxId5RaUO7JFSf9g6B3MNgfWa0EjC0yZoRDf5KthbnQVr6LvUAEB6dnELezmGOaouQN9fHon4Ht78N5CmC83cIJvTHGm84dRQDvo2eiGBAnHFFdAnppQk3YDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868066; c=relaxed/simple;
	bh=0KUa8Anpvq+vGwPJaiTddJ537wMBh/i8Y7kL+BhctsY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WSJm9CX30xUNtqHIS1M+1WECXGxeDRXWtgEtdoXq4YEUIlAL/irQKQ5gOsmyaOQWNklzhgSJUZ+Z0BumB1VuskfSHhpAmhrVGJvYSe2nv6QpYO19XfkQro/eiwvKP2nkIZEsGgL7woiphsyT0xACD5oMlGdRpor5xXWW7Sy6yt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ipOqvBf+; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ipOqvBf+"
Received: from github.com (hubbernetes-node-d4d7c44.va3-iad.github.net [10.48.201.121])
	by smtp.github.com (Postfix) with ESMTPA id 02A93E111E
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 02:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767868062;
	bh=uX8tdlo+5yPa9A8Cghz13G7ULL1ac7WJPTAdGaTQXEQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ipOqvBf+S7NKm+QcHV1aigvpew/mLcGziLOPHWPVgaTpIT5KMZmOlNregmomAc1i0
	 yxGEfA6BbVP4b/ep3flTbPq9nGyIo/7r+HRLyvhdxgjMpEobmgf4kp++gpJwH3sxD7
	 G0rVY16Nba/MDQrMCuYOf61dWj7zMu4CrgHxLEFk=
Date: Thu, 08 Jan 2026 02:27:42 -0800
From: dalegaard <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1039830/000000-a16613@github.com>
Subject: [bluez/bluez] 36962e: gatt-client: fix use-after-free
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

  Branch: refs/heads/1039830
  Home:   https://github.com/bluez/bluez
  Commit: 36962eb519785db34582aeaca7b86de06c7151c1
      https://github.com/bluez/bluez/commit/36962eb519785db34582aeaca7b86de06c7151c1
  Author: Lasse Dalegaard <dalegaard@gmail.com>
  Date:   2026-01-08 (Thu, 08 Jan 2026)

  Changed paths:
    M src/gatt-client.c

  Log Message:
  -----------
  gatt-client: fix use-after-free

Clients with an acquired characteristic subscription would free the
client during disconnect. When notify_io_destroy then tries to remove
the client, it'll use-after-free.

Add another reference when allocating the notify_io and unref it again
in notify_io_destroy.


  Commit: a1661374ddb955ea63ac5da6f0fa5c33d3ef6cf0
      https://github.com/bluez/bluez/commit/a1661374ddb955ea63ac5da6f0fa5c33d3ef6cf0
  Author: Lasse Dalegaard <dalegaard@gmail.com>
  Date:   2026-01-08 (Thu, 08 Jan 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: fix memory leak

device_add_eir_uuids creates a list of added UUIDs, but it was never
freed.


Compare: https://github.com/bluez/bluez/compare/36962eb51978%5E...a1661374ddb9

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
