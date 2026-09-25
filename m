Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F8C493643
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790332164; cv=none; b=RMgThOeQHw0UiSS7GdjT/bSEKTc2CdDA2csFTPff5Ydzesm7UA6djE/T9RT6wCQ6hxsvCSldVs7hHhvvexSIj9tmsWCr3dOS5Zsu6/j6MaTySAfFsPmtWJVMLU9yU0PMC7mFmGwP5OEstzfPuMf7IwSRNWMEeMNqSjYpq1dldtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790332164; c=relaxed/simple;
	bh=Ro5mRpRK8VPPGQSuM/7dDMbrAcx3dt/XUGGOPa/t+6Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=U7isqzCXvVShONg5sjq3mg0H2yxl5UsABnmR12G7PyG5ARn8rhiPUTQLvaEvLzvgTQ8+H7AaAoK/i/Jz3qthRhLjT7kAaY9ONHf+8cqqoOMYzMOM1dJO5p4CzrbmdxiCNjAXtlcSgoBN00Gc1qtuHS9WtBDuG0L9n5/zOdEtC7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SE7M+8fJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SE7M+8fJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790332159;
	bh=Ro5mRpRK8VPPGQSuM/7dDMbrAcx3dt/XUGGOPa/t+6Q=;
	h=From:To:Subject:Date:From;
	b=SE7M+8fJF8L9lmnm82QeCmkTkFKtyTI7Fj1W59xQg9eE110LYYWvmQ6HIljEJJ43c
	 VhxiQ2MVQ/1PR5a+HrJ3uKW9dLvzS7SMVRfeBumSxuLAYN3kG3qWh3fl3q/Oz0nW3U
	 1MHq+B85troiMWOTFasQZklmrxsSbvat0YZhtzP2qRVBJEVKJxJo2ut8YpzwHz/vtD
	 hqSENKn41r1zM6OUdtWLczi7jcJR/5+PnVNPd3gwIT75nRz8j97C1Cj4yRRVEcZb8/
	 Qh3V8IlL2Qd0U1XMD4u+LCz6PrUzg6vHctYnE9CfLCfKRyqNkAl3nIav7Mq3x7H///
	 h7TfwXOkiTxOA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5961517E007B
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 12:29:19 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 RESEND 0/6] mgmt/device: report link security level to D-Bus clients
Date: Fri, 25 Sep 2026 12:29:08 +0200
Message-ID: <20260925102914.3282319-1-frederic.danis@collabora.com>
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

[1] https://lore.kernel.org/all/20260925101853.3278769-1-frederic.danis@collabora.com/

v1->v2: Fix struct mgmt_ev_security_level_changed definition
v2->v3: Re-work Security Level possible values in mgmt-protocol.rst to be in
        with other *-protocol.rst files

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

