Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB5031619C
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961595; cv=none; b=nVSJupmZPznhrHZLeHJRlSoc/EEaskBuwrnCrIA2rdtVp7klKxlybR8FDpoOaUUbUqt3OIwiQGWKCpxPn1X3bimg+bD5AlVBCOhz421uvFgmuTjoiWyBKuJc00OLOGONnK7CEWPkXqPhMaEyEEPmJ/IrgCMdWG1Q4au6Gvr8puc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961595; c=relaxed/simple;
	bh=VhM+6yBMxLlmIeQa2itjRUB0wc4wpTxrjjhUrDgJoDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W16wcLiCtvj/skCPDu42KeMjML9mUrTPY22R26VlqXdtS+4mzAHisTGeB9Dgl5ThMo2qNBhwMEamI4S8uL49ClmfpiaP7kXZ+96SLoNAYMivAOpbjOrQiFgFv9gVMGeXwY7khGMNkL0NOFDYaA+60g93Kr1I+3vZ3YpZBYPpVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQRB3t+Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQRB3t+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 426F4C16AAE;
	Wed, 21 Jan 2026 02:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768961595;
	bh=VhM+6yBMxLlmIeQa2itjRUB0wc4wpTxrjjhUrDgJoDA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=OQRB3t+QezMcvSXjPhNuX4ySDuacfVaTOwRF58ZcKoDZ5AfQVdSj5dM+qehca4skN
	 BXGa/Z7O6V89AC8aGf5xXw3eXGeaayq2xqpgplV59/z5R51KUeH4jOIQorTFHUzzIp
	 OiIWm564ktUDp0aOiFyWdaMdqX/iLCMyNkHVucz1yK/qyYwDY+b6Vns9KHK/uwyemw
	 q0NuM3sadMre5CsYJLbVYcR2khSJpUxnDkldrKVbZlMCLDfIlbv83mG02tYp/CI608
	 hUkcJGVW8FZ8+vfzeo3tCmpVn+w67SN0n9OcCy38/BK8jNhdO6y5IX9s7isXFa/Ady
	 l8pvQoWJfFjOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C8AD262B1;
	Wed, 21 Jan 2026 02:13:15 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Wed, 21 Jan 2026 10:13:09 +0800
Subject: [PATCH BlueZ bluez v2] bap: reduce ISO sync timeout to 3.6 secs
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-iso_sync_timeout-v2-1-efa52fdba244@amlogic.com>
X-B4-Tracking: v=1; b=H4sIADQ2cGkC/3WNQQ6DIBREr2L+ujQCbaNd9R6NMRY/+hORBpDUG
 u5ewr6ryZvJzBzg0RF6uFcHOIzkya4ZxKkCNQ/rhIzGzCBqcas5F4y87f2+qj6QQbsF1qBEpS9
 ybARCrr0davqUySe8lg2/0GV7Jh+s28tR5CX8vxk546wdJLatuGbVj8EsdiJ1VtZAl1L6AeQDW
 2G5AAAA
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768961593; l=1152;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=1u27ix1kl7OQvyW8a2HLNDg5ot2OEQvP578EPXDjjL0=;
 b=ZimwYJ4/Mrcqvzo5MZA/Dr6vwctNQVs+AZ+jYiGlXXcfLvrL+JQ1eis031pvL9i7qrFRgd1bA
 hM73pFh8z/GAwI+DApubk7WQ0n2mw1j8Fn/WgtYor2Lx6apJJPOwxfF
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

The ISO sync timeout was previously set to 20 seconds,
which is too long for PA sync. This could leave the userspace
flow pending for an extended period of time.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Changes in v2:
- Modified the BT_ISO_SYNC_TIMEOUT to 0x0168 (3.6 secs)
- Link to v1: https://patch.msgid.link/20260112-iso_sync_timeout-v1-1-9a3e99259a3f@amlogic.com
---
 lib/bluetooth/bluetooth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
index f9f22c3f7..b9ea34847 100644
--- a/lib/bluetooth/bluetooth.h
+++ b/lib/bluetooth/bluetooth.h
@@ -152,7 +152,7 @@ struct bt_voice {
 #define BT_ISO_QOS_BIG_UNSET	0xff
 #define BT_ISO_QOS_BIS_UNSET	0xff
 
-#define BT_ISO_SYNC_TIMEOUT	0x07d0 /* 20 secs */
+#define BT_ISO_SYNC_TIMEOUT	0x0168 /* 3.6 secs */
 
 /* For an ISO Broadcaster, this value is used to compute
  * the desired Periodic Advertising Interval as a function

---
base-commit: c24f0b487ca3d4e0ca315114a889dad4d2c3bb26
change-id: 20260112-iso_sync_timeout-8e3ecf43d82e

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


