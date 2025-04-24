Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6613E19F47E
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745506176; cv=none; b=TXHVRpjeX9+O8QYKBwh3dqOkkNDiKzjFr1R91aBjisursZ1yjGr29uGftd8VMeL5JVSKXYe9gQ74o9sYSmL/HlsONKkJ0oSENH78K/r30K12yFYJCr9s9OiRoxGgGbYvfiFAgGRMwbTOG1pD45sS7tAy9igBLo0qK6Sc1K4tPmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745506176; c=relaxed/simple;
	bh=TdKrhlELeuj4BLov1BiitT8X8OYNuWvLi6t2WogZkbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OVkbYSIAlUyVyZYEmY2njcLBcb8b74VTWAMzVhFIoUYth4wgBlRc8T/ppUW7MpT58bgvY2034h3jS6RBqjZUerxhbgda0kfMtik/LWKDWGD6LntIj2XFgeTaxO7IAswKwBZm6WxkPDFsboLYkh6nxQp5XTVQlV87NORgZpSsvMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BXh+piIg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BXh+piIg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745506166;
	bh=TdKrhlELeuj4BLov1BiitT8X8OYNuWvLi6t2WogZkbA=;
	h=From:To:Cc:Subject:Date:From;
	b=BXh+piIgGz47YM5IWjxAD/GnJj/q/43lkBmnwuln2rrWH7yRKTuTyHALp4LRjEuNw
	 QM9p+1M9zShlQYKQ5Pk2Rgi2L46Jo8OI9xv53JP178XIJk4fP8eCvQw5tmz3MBi9EQ
	 tJXlyzNaENtkdZ4VZbUmTsS0k9PuTFZH0WHGZI8i8/pfF0srS2Pn1bvuxFKedsYQYS
	 9qXTfNzpqpBDRdcMgWMT2dclnIMct27Hv2H9UyW1yJlUjzDX2VaKBCEgzCkYLzvluG
	 TonSbfj383ecXGPs6Pj8ptin3vbcT3UQE2U2jSyV9x1zLfpZUVcIUKq1EQxsPUYFxp
	 1Tdqo9tTy2I9A==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BA5B317E0987;
	Thu, 24 Apr 2025 16:49:26 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v3 0/7] Support Sixaxis gamepad with classic bonded only
Date: Thu, 24 Apr 2025 16:48:24 +0200
Message-ID: <20250424144831.95766-1-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new "CablePairing" property to allow us to
indentify devices that have been paired using a custom USB cable
cable method and that don't support the canonical bonding with
encryption. With that information, we can dynamically enforce
encryption to drastically reduce the attack surface, compared to just
disabling the "ClassicBondedOnly" property.

The "CablePairing" property is exposed via D-Bus to allow
clients to potentually show this information to end users.

As far as I can tell, starting the listening input server with
BT_IO_SEC_LOW and then bumping it in `hidp_add_connection()` should not
have any negative effect regarding the overall security. However,
please let me know if it turns out not being the case.

Addresses https://github.com/bluez/bluez/issues/1165

Changes in v2:
 - Start the listening input server with BT_IO_SEC_LOW only if we
   actually have a known sixaxis device

Changes in v3:
  - Change the property from being sixaxis specific to a generic
    "CablePairing"
  - Remove the manual validation of Sixaxis HID report descriptor
    because we already replace it with a pre-dermined SDP record
    in `sixaxis.c`

Ludovico de Nittis (7):
  src: Add new CablePairing property
  client: Print CablePairing property
  sixaxis: Set CablePairing when pairing a Sixaxis with USB
  adapter: Add btd_adapter_has_cable_pairing_devices()
  input: Automatically use sec level low when using a cable paired
    device
  adapter: Set server security level in load_devices()
  sixaxis: Set security level when adding a sixaxis device

 client/main.c            |  1 +
 doc/org.bluez.Device.rst |  7 +++++
 plugins/sixaxis.c        |  8 ++++-
 profiles/input/device.c  |  9 ++++--
 profiles/input/manager.c |  3 +-
 profiles/input/server.c  | 63 ++++++++++++++++++++++++++++++++++++++--
 profiles/input/server.h  |  3 +-
 src/adapter.c            | 24 +++++++++++++++
 src/adapter.h            |  1 +
 src/device.c             | 40 +++++++++++++++++++++++++
 src/device.h             |  2 ++
 11 files changed, 153 insertions(+), 8 deletions(-)

-- 
2.49.0

