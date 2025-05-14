Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAAC1EEE6
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747246548; cv=none; b=AlDXZxSZM4QY8C6Hktzd3QdVvt12eUP7yDxNMQkJqgw2MZlP5nhlOZqoBnrkEnE7RHLYINSRpAN/dLOgh7DmV7iYZVxhEQhntf5Lwxn/Nd7F3DswvzIH5CCfgVHTN1ont8hD/PiZyQq1dscJn92IOCUZtExVHtKD/23UdQYOBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747246548; c=relaxed/simple;
	bh=tXva4PjniajvL2+p6QTUaA+ExjWLBsnloyIxh7c3ruc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fK0/uIeo8KNuciYQYKj0TbGs27RL1Hg/qvPtD69oYA0XoIdp/OeXg9xQIZJGY7QCjFdMx0rDA0hPIzDTlPBS2kH2L7eX2wNiEpPIjSo6PXYqhsigWA+A831hmG+d01bvOyseYRzHazW/CmSdgEU76VBEJwjcLaR7rBdZ1A07wnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=W6bmrhww; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="W6bmrhww"
Received: from github.com (hubbernetes-node-9ec63ab.ac4-iad.github.net [10.52.152.34])
	by smtp.github.com (Postfix) with ESMTPA id D3B4A20157
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 11:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747246545;
	bh=mw0YP2w7Ca4Hj9smvZQsNcC2ZjlL62uAgMWpdojDakY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=W6bmrhww0gcWIGVDDythagQ331MvZakPzsB+eZwfMnFpBk516C8Yb5Jb2Dgjh4R5y
	 P8H07QjRiNh7R5S43AtZGOGj5i20mw6mYdkKQJrR1YuGw8o9RtHtiE0t6BwQ+bT/xP
	 /ajXcnJuLGpcPv+6iUUL9zvOQmGr0WVwvds+8n1U=
Date: Wed, 14 May 2025 11:15:45 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/962935/000000-81c21f@github.com>
Subject: [bluez/bluez] 9fcce0: avdtp: Fix setting in_use flag for local seps
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

  Branch: refs/heads/962935
  Home:   https://github.com/bluez/bluez
  Commit: 9fcce02783eeb2681cd6ed29a8dfdfa594914548
      https://github.com/bluez/bluez/commit/9fcce02783eeb2681cd6ed29a8dfdfa594914548
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-14 (Wed, 14 May 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/avdtp.c
    M profiles/audio/avdtp.h

  Log Message:
  -----------
  avdtp: Fix setting in_use flag for local seps

This removes the assumption that only 1 stream can be configured per
local sep which prevents multipoint setups where different devices can
be using the same local endpoint.


  Commit: 81c21f6180e2cbe80c51fd938ad0ab78af9818a2
      https://github.com/bluez/bluez/commit/81c21f6180e2cbe80c51fd938ad0ab78af9818a2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-14 (Wed, 14 May 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/a2dp.h
    M profiles/audio/avdtp.c
    M profiles/audio/media.c
    M profiles/audio/transport.c

  Log Message:
  -----------
  a2dp: Fix a2dp_sep mapping to a single stream

This removes the assumption that only 1 stream can be configured per
local sep which prevents multipoint setups where different devices can
be using the same local endpoint.

Fixes: https://github.com/bluez/bluez/issues/1037
Fixes: https://github.com/bluez/bluez/issues/1064


Compare: https://github.com/bluez/bluez/compare/9fcce02783ee%5E...81c21f6180e2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
