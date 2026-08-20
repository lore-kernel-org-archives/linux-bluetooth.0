Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496141837D
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223164; cv=none; b=uggHIF1aqRWqUygOi7cJEoStHTchpfdc+9RKGWVyvi08LDC4Rhei8e9wXNfg48+A9S0JiCWEMnLQ6F53Ss+QRyeSSxl9b5NZoQKzOhHsqiBvmJ5YYHuCTnhe5COJE1vn9PNMjc81K9uOZW+cWRgIs5mVGGqBpecKix2iUl9JhQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223164; c=relaxed/simple;
	bh=IncphVL8OLyBbILDZPJ4oATIB4PygdJLOU86z/S+Z7Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=ZuV45a4UEBLJKmVqTaDl7laO1pRQoNRcLVLyxbIw5dWPZTyj+uo0eqxGGoE6egqrLCW2yi2GhhFyo5tZ/R7p1BSAhpfw9U2G93M7XBhc6wIWKH1WFLMwo76xreSXoXnab6fngjM7M+kdnT8A2ikEjG4UmBgS6+7suxXQp1XTPAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cHsXrJ+B; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cHsXrJ+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787223161;
	bh=IncphVL8OLyBbILDZPJ4oATIB4PygdJLOU86z/S+Z7Q=;
	h=From:To:Subject:Date:From;
	b=cHsXrJ+BdP9rsk9kWz+lQTBAoD7eNuR/F0lyYSHhf7uQzjlBdaF7pq3bTQSWge7As
	 kKquzWxT01pOQdaqecyV3WZL759yLDwr/41sobHpgknoh8T57d6P8VEKqyrqcM3OLb
	 BLv+eeAm1Wj4KoE3ITl6iS5Sr/ZGJNvZyvcbrhWVBHuwxxocOFlS3/JW5vfctqCgVW
	 x2ydjIjUoi249NvWYygZWvth6HP9lH8mi1TUHt6g95hCtHUwHcxZEPPtft3ZYH+0WB
	 kA1uZ4kh412grh74O9TS1ytM27Rn27HPuWzrVL//ogi6ImRFI0kTY3dpqv2rOSzL1t
	 IxHL271XybT4g==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E849D17E085C
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 12:52:40 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/6] mgmt/device: report link security level to D-Bus clients
Date: Thu, 20 Aug 2026 12:52:28 +0200
Message-ID: <20260820105235.1190318-1-frederic.danis@collabora.com>
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

