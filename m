Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1948191F9C
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958522; cv=none; b=LwXvwxxkHECklHQmrfj5MRchEX+krGlu/v1Pv7jMJHBXymaKsnYTxu3h0GH/jclP7nQ3ipI64RhQL2JHDhsJtJIZlVmZ0Rf4QAAm56VnD2t4mOuQdFKZ2WDSdYvmrpoT7U6l9pjOYRnapPGrbXG09n2X1f5xHqoMw1jWBf1IUCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958522; c=relaxed/simple;
	bh=TaktkT510E4kq4zdZnXT8SZ6iJtpQsQIUgo232nD6Po=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=SoIqfAMaE7gpifnwfvIMq/uJ2tsjK9G95DHNBLJz4OAW6ff0eNQI2aXIXX+4bsV/+abOYaCxUQaCBU8ee2a+eKMJQq270SPsgf85njYaWXf9MJN+69SPV5fnqvhwFCHJqyy0k8dhZxOsaBCO7qrl/E3w25cJpp2pQYNMCCHyoRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nVgLV6gR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nVgLV6gR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751958518;
	bh=TaktkT510E4kq4zdZnXT8SZ6iJtpQsQIUgo232nD6Po=;
	h=From:To:Subject:Date:From;
	b=nVgLV6gRgrFTkcnIOgLsY8ELN4yaEDul+W4WlVBhgjUT1j7u+gBnTZ7QwWvaVC+QP
	 /DZPASjmEtNJdnh+bo64+fuYBxnle2IjxBcSwD3Et8aWS+szzyy3sqWeWPxXDUvssd
	 wOBuznlEV3laeZxpLVBQJSbOuHRsZSRWO7VGzRIqfFRGlcLEqnt8Ek6Aa0HJPLjlHw
	 OkELBy/YmWwQNe03ngoZtxbqO3+JnVSmddJUGGqOwRSU8dcpcCumuh0UauGoQF+pJs
	 YX+w5Wy5rdDdydiibimDcNi/aoG3J88a6/lfu79+FN528DHpkLfhoxxYj9Dqj8nHS4
	 Uz1BxMPe0VB+g==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-A903-AfF7-D14E-7699.rev.sfr.net [IPv6:2a02:8428:af44:1001:a903:aff7:d14e:7699])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A02F617E017D
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 09:08:38 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/5] audio/avrcp: Fix crash with invalid UTF-8 item name
Date: Tue,  8 Jul 2025 09:08:17 +0200
Message-ID: <20250708070822.185375-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

As stated in AVRCP 1.6.2 chapter 6.10.2.3 Media element item, for the
Displayable Name Length property, the target device may truncate the
item name:

  Length of Displayable Name in octets. The name shall be limited such
  that a response to a GetFolderItems containing one media player item
  fits within the maximum size of PDU which can be received by the CT.

This truncatation may occur in the middle of a multi-byte character,
at least with Samsung Music app, which triggers a DBus assertion and
crashes bluetoothd:

  profiles/audio/player.c:media_folder_create_item() Din Dhal Jaye
      Haye with lyrics | "दिन ढल जाए
      हाय" गाने के बो� type audio uid 1
  profiles/audio/player.c:media_folder_create_item()
      /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
  profiles/audio/player.c:media_player_set_metadata() Title: Din Dhal
      Jaye Haye with lyrics | "दिन ढल जाए हाय"
      गाने के बोल | Guide | Dev Anand, Waheeda Rehman
  …
  arguments to dbus_message_iter_append_basic() were incorrect,
      assertion "_dbus_check_is_valid_utf8 (*string_p)" failed in
      file dbus-message.c line 2775.
  This is normally a bug in some application using the D-Bus library.

v1->v2:
  - Introduce new strtoutf8() util function to truncate a string before
    the first non UTF-8 character.
  - Use strtoutf8() for AVRCP media element name
  - Use strtoutf8() for MCP player name and track title
  - Use strtoutf8() for Audio GAP device name
  - Use strtoutf8() for EIR device names

Frédéric Danis (5):
  shared/util: Add strtoutf8 function
  audio/avrcp: Fix crash with invalid UTF-8 item name
  audio/mcp: Use strtoutf8 for player name and track title
  audio/gap: Use strtoutf8 for GAP device name
  eir: Use strtoutf8 for device names

 profiles/audio/avrcp.c |  4 +++-
 profiles/audio/mcp.c   | 11 +----------
 profiles/gap/gas.c     | 11 +----------
 src/eir.c              | 11 +----------
 src/shared/util.c      | 42 ++++++++++++++++++++++++++++++++++++++++++
 src/shared/util.h      |  1 +
 6 files changed, 49 insertions(+), 31 deletions(-)

-- 
2.43.0

