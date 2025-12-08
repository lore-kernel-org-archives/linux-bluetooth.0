Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8ED281376
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218222; cv=none; b=Nbw+REQaZXr9jYTf0Nr8AQoOLtqhZPQ2mvSe1YU6xHBOTMVvZc7yvN0uBkoGAdy44MzGNzas1GhbhgBtplJfpHYW6cAr5+Un9BRPpBcKDMT0Ojpv+wVWe8AfbmOa9U4kuNWwwUIaTpRfD7kusuWMzrcWAAO9tJcn2W8MGjg1ho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218222; c=relaxed/simple;
	bh=V3EDIjzYwMkSz0rAZHpZvE6En2p0zMlVCef2tlCvAsQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CTTQAZ8wZ+zrD2ohsdd6EFKm81YS2TXtjO3Kwv7R8NHP8YerfnhO7T16/tNDCXJsWyoCfBAH3u762hNkP9mXeskyZ3t+UM+5fA54bXTBBEOOC8Q/H10hzZzNM/pCFpUCS1NZbJ4Kyq2gywhP0ZF8AnwynuKcNlePFpPIAv/Y4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=I9VkYSzK; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="I9VkYSzK"
Received: from github.com (hubbernetes-node-fe181c6.va3-iad.github.net [10.48.151.31])
	by smtp.github.com (Postfix) with ESMTPA id 6BAF8E04E1
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 10:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765218220;
	bh=F5hjIBhlnP4ETYYiFSBp/4gu7wWOg9LEW9aC3HjqtyI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=I9VkYSzKKvrWFqpXedgIGAiioj5CUiDMB7A+JGhF0qE49wApemCIKeFgqGbNuoQky
	 FYn7OcN7dcMSouo86PRUtoNerTQ+pqr8860P+ix+hgAbMItCOIIsJrinSu30cWQBEv
	 93tADWK3cmOff6JvBEParUfOSQTxK89e39Sw3DwE=
Date: Mon, 08 Dec 2025 10:23:40 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031462/000000-50b5e0@github.com>
Subject: [bluez/bluez] 50b5e0: shared/bap: fix invalid BAP server transition
 rele...
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

  Branch: refs/heads/1031462
  Home:   https://github.com/bluez/bluez
  Commit: 50b5e0a3f7b881b32d71dc3d16671787b4c315d3
      https://github.com/bluez/bluez/commit/50b5e0a3f7b881b32d71dc3d16671787b4c315d3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: fix invalid BAP server transition releasing -> qos

When remote BAP Client requests Release during streaming, our upper
layer calls bap_ucast_disable() when releasing the transport.  This
causes invalid releasing -> qos transition.

Fix by properly checking valid states in stream_disable(); bail out also
when in DISABLING and RELEASING.  This leaves the valid states ENABLING
and STREAMING, so write them explicitly.

Log:
profiles/audio/transport.c:media_transport_suspend() Transport /org/bluez/hci1/dev_FF_FF_FF_FF_FF_FF/fd0 Owner
profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci1/dev_FF_FF_FF_FF_FF_FF/fd0: TRANSPORT_STATE_ACTIVE -> TRANSPORT_STATE_IDLE
src/shared/bap.c:stream_disable() stream 0x7c41327f1060
src/shared/bap.c:bap_ucast_set_state() stream 0x7c41327f1060 dir 0x01: releasing -> qos



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
