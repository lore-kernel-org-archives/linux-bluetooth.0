Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F13B6BE5
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230695; cv=none; b=aqR4xCTmpnl20dzAOZhYRLcaHr1EK0RHmsYjtRPLgczQvJ7P8BOxyKudLryCtw+j9sXVHboN+c/rxk+FtJwifLqY4u57mIvSbubHlFxWpNvhnIpHWCAscQOzwa8BmC2BiqhZVjfDLx4JS7vSmss21Rm66BgvpdSOk7DiKQLXIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230695; c=relaxed/simple;
	bh=oAvgwQGeKpL6NnUY4JwStv/9ibKbkL2ISiif/2ubc08=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=fHY9BtbSSz9vDsDyOZANmvac1oJCck2mqOtfzSnt7nlJf2PNUpcjET+O8PZphm/GUE436xc8lqgB/QW/B13G7eQwllc1m0gLN5Yjgo6Vv0aNfmBp7E6HRTR84/cGOicjbbH8yO7KDCAZpdS3A254MZtLmsRCJezxKxtCC04WuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BcHI+cOb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BcHI+cOb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787230692;
	bh=oAvgwQGeKpL6NnUY4JwStv/9ibKbkL2ISiif/2ubc08=;
	h=From:To:Subject:Date:From;
	b=BcHI+cObzWypZ+m6fkCdrtNR+wzeKoVi1aMWVZFPWxt79U0WzuNJbUQRA/3qVygWH
	 V8wG8tuXGyBAq/klXFX8v0/qKN/xMhG/BiTnRJK3Glp1weyNheB0An9qOgLbfPq4fb
	 o0oJz0aTn1Zb30RX1SwAaGlYgTbvXu6S/a9cp7TgHMKQrKnyfDB3d6XpvcQcAYobLh
	 zwzlqLnEzcyFxNypX2Qd8MRYANyXyTC/DRiYA2DMDm+10guuwu4oQ2umgkzKgMGCgj
	 0Vc9KB7jcYyTsulcB+nxnh10sh8bCMuG/VT47uCNRcbcMx3SdbE9HkAq2M1B8yms6f
	 4At3nXFN19KIQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E281817E085C
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 14:58:11 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/6] mgmt/device: report link security level to D-Bus clients
Date: Thu, 20 Aug 2026 14:58:00 +0200
Message-ID: <20260820125806.1253547-1-frederic.danis@collabora.com>
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

[1] https://lore.kernel.org/all/20260805132203.176213-1-frederic.danis@collabora.com/

v1->v2: Fix struct mgmt_ev_security_level_changed definition

Frédéric Danis (6):
  mgmt: Add Security Level Changed event
  mgmt-tester: Add Security Level Changed event tests
  monitor: Add support for Mgmt Security Level changed event
  device: Add SecurityLevel properties to org.bluez.Device1
  org.bluez.Device: Add Security Level related properties
  client: Display SecurityLevel in device info

 client/main.c            |   2 +
 doc/mgmt-protocol.rst    |  45 +++++++++++++
 doc/org.bluez.Device.rst |  36 +++++++++++
 lib/bluetooth/mgmt.h     |  15 +++++
 monitor/packet.c         | 117 ++++++++++++++++++++++++++++++++++
 src/adapter.c            |  33 ++++++++++
 src/device.c             |  84 +++++++++++++++++++++++++
 src/device.h             |   3 +
 tools/mgmt-tester.c      | 133 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 468 insertions(+)

-- 
2.43.0

