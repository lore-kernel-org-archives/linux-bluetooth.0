Received: from out-34.smtp.github.com (out-34.smtp.github.com [192.30.252.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA12D36EAAE
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030141; cv=none; b=tdZe5MJNa/JWiyrjvpXSyT9PXIJ0aWI9zN7AK2a2TebvDAsIcAPP0rS6Zq/81s3zS8NM5f90gjrFYkamHGumK8Bi40TMV6vTAMBonl/UUdUOZ7IJezXuoPVrvfRCcKCqd/e1QHmE4QlIMUerT3eSOsJPt5tQD1Zxk/lAe4IkN/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030141; c=relaxed/simple;
	bh=RaGkSvUDk+34zw3FsmKhHVoecIJpiET0WfkrPAWD4HU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SDsfkDepxg/Hbqmy0XwwMeGw4V/b09EmmtxeOEiu8tVMK9dLnFj3QCcj/lUTKInj3fxhi5WxZuIAo6Dxpq+SHGvlZo7A99SDh4v6eTwChmuuIIBwD6qRVdxWogKX2FJzYQCOc+1yvR8CJZv2x6h5y1w5lMCePuxl0Cmtf38LamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Hk408LQp; arc=none smtp.client-ip=192.30.252.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Hk408LQp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781030139;
	bh=QAUbpaXWhSPM7E9fK7ZGWchGab/YMP5EPt49CLjxyEc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Hk408LQpY3uwB/ZoB+qm1Vbv1cNsgOX4x3RnwSyoVPL/7YsJPwiQYpiGfWU5Lz9zG
	 ZtSuBKQl+clxnahh8KMJYxjXChUtddm6ASzckKNiai1R7lVhNmcO/jR4+8VQN6ILI/
	 wK+r29tDsc/Slv4SS8QvkC0xf+SEALbkCpn8RLD8=
Received: from github.com (hubbernetes-node-9f939f0.ac4-iad.github.net [10.52.160.26])
	by smtp.github.com (Postfix) with ESMTPA id 3456D74127D
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 11:35:39 -0700 (PDT)
Date: Tue, 09 Jun 2026 11:35:39 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108770/000000-c01f9b@github.com>
Subject: [bluez/bluez] 1fd31c: media: Add Mute property to MediaTransport1
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

  Branch: refs/heads/1108770
  Home:   https://github.com/bluez/bluez
  Commit: 1fd31cca12a6e9a34e93ec3d1fc1814ffce2a0e4
      https://github.com/bluez/bluez/commit/1fd31cca12a6e9a34e93ec3d1fc1814ffce2a0e4
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst
    M profiles/audio/transport.c
    M profiles/audio/vcp.c
    M profiles/audio/vcp.h
    M src/shared/vcp.c
    M src/shared/vcp.h

  Log Message:
  -----------
  media: Add Mute property to MediaTransport1

Boolean, optional, readwrite. Only present for LE Audio (BAP) unicast
transports backed by VCS. A2DP has no mute concept in AVRCP.

bt_vcp_set_mute() writes VCS Control Point Mute/Unmute for a client
session, or updates Volume State for a server session.
bt_vcp_get_mute() returns the cached value updated by Volume State
notifications.


  Commit: c01f9bd015cbe527b9f30a6338fb393da034e782
      https://github.com/bluez/bluez/commit/c01f9bd015cbe527b9f30a6338fb393da034e782
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add transport.mute command

Mirrors transport.volume. Accepts on/off, yes/no, 1/0.


Compare: https://github.com/bluez/bluez/compare/1fd31cca12a6%5E...c01f9bd015cb

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
