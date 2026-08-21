Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047AE446C18
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303363; cv=none; b=oitC1Q5Bn2veuVzlaC7Ul/Pk8hRD7FNp/zdRoDjFfOTBrM3WW+W3+SSZUGjmRQp3/9BRI+3zE0kbIH/iEj6A5UohvQZWKXoC1PJEEjPq7oqO/j/8caMUwZb9VtOFiJ2tQdlP09mpve0Zz0g/K/uFAvK6hB34DQRQusQIGeqXWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303363; c=relaxed/simple;
	bh=RK1k9NV5VOobkuE0CSWwoHnduYzaMbt1RvVUc/3FztE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=bAxLfh9EYLgjoY2PxhUdbjuEpcPe/L7OjHcH9j7myXRwE10YAddjyhRXPsdKTlVIpiaVpSoIefKaTj3jn0wJ6YCEdymbNJTgWL0nuZh3R6YK68WvuQhXDqcgaOjHJt+e89gmdDDZxfAnxbY1U02/chw0fItqJKoKkkNsU9Ky40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PPif8ySn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PPif8ySn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787303353;
	bh=RK1k9NV5VOobkuE0CSWwoHnduYzaMbt1RvVUc/3FztE=;
	h=From:To:Subject:Date:From;
	b=PPif8ySnl7Sw69QH8uXtIc8zAAFaMl/5Fk2QUAHUE6/bWGGUdMbMn7kUk5K3mgj4F
	 qK85qWCEpjgwAO8fSENX6Lpv5Z5AsjFIBFaWTbhx9JYBBbZbuUcrO8C+votOMZTUry
	 Bk+FAZoT9Q/9OMCHECmy2wmGnvUcrQcVFhYK7riIuLRkSWBnO3xj6OHyKlNdKj+fal
	 pAbCck1q7V71PFdWbFpvAmGA/xHMAqgclRxFAkhHowpobqKHIR/lx2LH+rUljzJvHE
	 WeyJW6V3xKzZ2Czp1rRKyHJiK56RNOtbvdFRTMd1RQ5oZ27EGAZU8doQqAuXse4RI8
	 DXD29M9gBED8w==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1387117E07F7
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 11:09:13 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/6] mgmt/device: report link security level to D-Bus clients
Date: Fri, 21 Aug 2026 11:09:02 +0200
Message-ID: <20260821090908.1546451-1-frederic.danis@collabora.com>
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

