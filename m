Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0003E5A18
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106145; cv=none; b=UeO7zHgJcRf+BdDgp37igDU2wnx+pDYl6hXeLpKTra+J3gW2gZBIB7mZs+cRFLsnxYtCVnVwACaNSCh1yTZ7A6dtknbQvgc71ylu/hmp/NDlsh+Oj7NcKD/uGr/2xDSbuOLP9YFuJyG06irVTyt8zkPPakwoxievXaXWryYn7vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106145; c=relaxed/simple;
	bh=+V/eeusjVH2yoBpHBsJX7+S7BJTYKKjLiV3AruSJr5M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwYqW0aa+uGIBIqSHqASrgOYmtQmVh+xz0ek3nPcG6yZxXtxqwpbsEtLajES3QG8mlyY6sFFbqjDgSaHZPmlbQzaplh/J3Hm5OEfasqxSF8IDnPHD2+MNnaAFDR+vvU6e/64fTHALXcxTgMXyNb+J1K4e6z/UxlJ9rmPthQfRts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NxQTAWY4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NxQTAWY4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784106134;
	bh=+V/eeusjVH2yoBpHBsJX7+S7BJTYKKjLiV3AruSJr5M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NxQTAWY4SkJQlUhFVrJr156u5vXke3ndFf7xgQNDCSJROIg0OGxinFv0QLBDxFmo7
	 WDdBoGwEaxPBFb8hNAVCnxbKLLgmfPQVZKZdE5rQT7XSSnmcQTbOST5vsK/v4QrPWi
	 0TDF+0RzCYSZS8TO88HVKEDXvre3mjCpGW3eQ4BvQgnjQH2ESpciaQ+agb8K4jFjVY
	 zxI9jxtr6wEjyfhFhAp9yWv8yS6GOefI6PncvlX91i5M7n2ZArJsyHJMR4SzxzYlc3
	 ZA9VC4Rr/stMOSxfLSkQuOKKLYIKP8Nf5u3NRKJehmdcpk+KqateLYLO+npTS8f7M8
	 H0A/wGyRj17Bg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7666417E0D7E
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 11:02:14 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/8] doc: document admin.allow optional controller argument
Date: Wed, 15 Jul 2026 11:02:01 +0200
Message-ID: <20260715090206.212130-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715090206.212130-1-frederic.danis@collabora.com>
References: <20260715090206.212130-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Update bluetoothctl usage to 'admin.allow [ctrl] [clear/uuid1 uuid2 ...]'
and add explicit controller examples.

Refresh AdminPolicySet examples to include the controller-qualified
admin.allow form.

Assisted-by: GPT:GPT-5.3-Codex
---
 doc/bluetoothctl-admin.rst       | 13 +++++++++++--
 doc/org.bluez.AdminPolicySet.rst |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/doc/bluetoothctl-admin.rst b/doc/bluetoothctl-admin.rst
index d4446ce95..ce15b8728 100644
--- a/doc/bluetoothctl-admin.rst
+++ b/doc/bluetoothctl-admin.rst
@@ -9,7 +9,7 @@ Admin Policy Submenu
 :Version: BlueZ
 :Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
-:Date: November 2022
+:Date: June 2026
 :Manual section: 1
 :Manual group: Linux System Administration
 
@@ -30,15 +30,22 @@ allow
 
 Allow service UUIDs and block rest of them.
 
-:Usage: **> allow [clear/uuid1 uuid2 ...]**
+:Usage: **> allow [ctrl] [clear/uuid1 uuid2 ...]**
+:[ctrl]: Bluetooth controller address (optional; defaults to the selected controller)
 :Uses: **org.bluez.AdminPolicySet(5)** property **ServiceAllowList**
 :[clear/uuid1 uuid2 ...]: List of service UUIDs to allow, or "clear" to remove all restrictions
 :Example Get current allowed UUIDs list:
 	| **> allow**
+:Example Get current allowed UUIDs list for a specific controller:
+	| **> allow 00:11:22:33:44:55**
 :Example Allow Serial Port Profile only:
 	| **> allow 0x1101**
+:Example Allow Serial Port Profile on a specific controller:
+	| **> allow 00:11:22:33:44:55 0x1101**
 :Example Allow Serial Port Profile and LAN Access Profile:
 	| **> allow 0x1101 0x1102**
+:Example Allow Serial Port Profile and LAN Access Profile on a specific controller:
+	| **> allow 00:11:22:33:44:55 0x1101 0x1102**
 :Example Allow Serial Port Profile, LAN Access Profile, and Dialup Networking Profile:
 	| **> allow 0x1101 0x1102 0x1103**
 :Example Allow Advanced Audio Distribution Profile only:
@@ -51,6 +58,8 @@ Allow service UUIDs and block rest of them.
 	| **> allow 00001101-0000-1000-8000-00805f9b34fb 00001102-0000-1000-8000-00805f9b34fb**
 :Example Remove all UUID restrictions:
 	| **> allow clear**
+:Example Remove all UUID restrictions on a specific controller:
+	| **> allow 00:11:22:33:44:55 clear**
 :Example Allow SPP, LAP, and DUN using mixed UUID formats:
 	| **> allow 0x1101 00001102-0000-1000-8000-00805f9b34fb 0x1103**
 
diff --git a/doc/org.bluez.AdminPolicySet.rst b/doc/org.bluez.AdminPolicySet.rst
index db132b7de..29fe3bdf7 100644
--- a/doc/org.bluez.AdminPolicySet.rst
+++ b/doc/org.bluez.AdminPolicySet.rst
@@ -55,3 +55,4 @@ Possible errors:
 Examples:
 
 :bluetoothctl: > admin.allow [clear/uuid1 uuid2 ...]
+:bluetoothctl: > admin.allow [ctrl] [clear/uuid1 uuid2 ...]
-- 
2.43.0

