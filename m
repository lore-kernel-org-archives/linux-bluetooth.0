Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1D4BFE7E
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677209; cv=none; b=nH7zHIhSxsF+dMAV95AoFgOIV0c3U2QCV9U5G6wMppGZHkfGYRr8Lv3WiPFX6ZBTdjnw+ToU5HyJDueP/DdLbjpeBcARMgf177wlGzmASVOxoQ1HFvLViR4KOPQHL+xTUuYyziBpWFsSRmx7GjFwWV2mMZ1xU97vV1Gy3vBo8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677209; c=relaxed/simple;
	bh=vS04qtRU7y5wwnDccFGbGt2zUQXwror+6mDbhXzLOUY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=iDyr9jigci1piw4YlGuOOdVGxWidi3qBJWcMSvO6I6LzKwvlTl61IWqA/rW1dupHlzSP5iqPB8O/JqJDkGuDoEEpBFBALIfi7PxZld/tXYFPD3pBC+l6jA7n6DjUyaEoE80gepBXig9XI4tuPCstX1180cLRnDpuY6EsTDEdmz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LUtALtIe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LUtALtIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790677200;
	bh=vS04qtRU7y5wwnDccFGbGt2zUQXwror+6mDbhXzLOUY=;
	h=From:To:Subject:Date:From;
	b=LUtALtIeWxySl+/7ZYwJ35ToOjs9BQacSI/hbFzsIsJfsYWfSow+frpoNB/pYlNrQ
	 lQ7PbrPMWiWElBduINZxLB4CWso7rREVpXzmVzwFcsSg0z0aQzsmEGvggntJyqYYsw
	 iW/92+0CmWPtS/3qh5JU+anOr0mrVAf14R+4qkpsIv+XrCS0/2RkRqPtpThp+bT4SE
	 XEQ0S79lXF+rf/+4ZvGWiE3PWuxDeEYpQNyoO0eG6Ab4fbng5OK9EGM0mbF4EQTspk
	 ImdOamNxzkj2AUuyuKgCUD66a3zUui5tRzupd49rM0FG9LfI8VKIBi6IV8gh7xr1l6
	 LEPyj6LYskRlQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 18A2617E007D
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 12:20:00 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 0/6] mgmt/device: report link security level to D-Bus clients
Date: Tue, 29 Sep 2026 12:19:47 +0200
Message-ID: <20260929101953.254969-1-frederic.danis@collabora.com>
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

This series adds connection security-level reporting.
The new MGMT_EV_SECURITY_LEVEL_CHANGED event [1] is documented and
org.bluez.Device1 is updates with new experimental read-only properties
SecurityLevel and EncryptionType.
Those properties can be displayed using "bluetoothctl info".

This is intended to let clients (including test tooling such as btpclient)
observe effective link security changes.

[1] https://lore.kernel.org/all/20260929100923.252597-1-frederic.danis@collabora.com/

v1->v2: Fix struct mgmt_ev_security_level_changed definition
v2->v3: Re-work Security Level possible values in mgmt-protocol.rst to be in
        with other *-protocol.rst files
v3->v4: Following changes in kernel patch, replace tlv_count by tlv_length

Frédéric Danis (6):
  mgmt: Add Security Level Changed event
  mgmt-tester: Add Security Level Changed event tests
  monitor: Add support for Mgmt Security Level changed event
  device: Add SecurityLevel properties to org.bluez.Device1
  org.bluez.Device: Add Security Level related properties
  client: Display SecurityLevel in device info

 client/main.c            |   2 +
 doc/mgmt-protocol.rst    |  45 +++++++++++++
 doc/org.bluez.Device.rst |  36 ++++++++++
 lib/bluetooth/mgmt.h     |  15 +++++
 monitor/packet.c         | 123 ++++++++++++++++++++++++++++++++++
 src/adapter.c            |  33 ++++++++++
 src/device.c             |  84 ++++++++++++++++++++++++
 src/device.h             |   3 +
 tools/mgmt-tester.c      | 138 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 479 insertions(+)

-- 
2.43.0

