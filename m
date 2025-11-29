Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBE222759C
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Nov 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764434469; cv=pass; b=JeExrWaC8yEvPWrldvUCxI6lPI84NcllV5296f//TBLYtpteqxYsco9ieJvz2w7JisYcyyfB/7EYcZZ8fVO1uVDa/7Pg9FazC62DQixZXiKe0IggxcMGhrqKp55wpz0myEq5XdTXzEknGeq7KCrCK0ok3zjkD7eZe471lpYfgZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764434469; c=relaxed/simple;
	bh=73tEKxuhVp4SYZZPoil2tsvj6n94pcpkZApzsJ26wd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEtLOSL1d7r8MzpEG9vT2jNr+hdL6pER+DtRllTldkbJByL4M9lWPwZx9tYPSFnfk9c58fQ9k65/KF+SZv9OZf2KzTT62o3bSUHlOp9RE7Whn35QwRxIdvkAXbOGXBVKcqTZbz8hw1tYeMuzJE8uj6D3TPMFX+33pXmmLJxyO3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=nFbwwl7L; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="nFbwwl7L"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dJbX146HmzybB;
	Sat, 29 Nov 2025 18:41:05 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764434465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3OJuMMef1m6fBs7HkrxWlr5JMm8VZBpddi0degFzT8=;
	b=nFbwwl7LKDpBkyqjuF6fIjkzvhfoGlXHN+lUEVFq27EcWkGSpobjnyGbCYeJ953rG721IG
	XLarysp1lydSTvcJh2WTQT/OhWI7X49ME+nMF/OXBFP9ajPwknG6VddG14bxNzERw2M482
	dYmd0JKolBw3Q+ACb9X6U3Lg0wht/54=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764434465;
	b=niEKcn3rT0R/H1ortlzpvxA/ZY5ci4J7uKKNe9lQ66j+b1lG6/dd14ktpTjEorOHBSstTJ
	6HYmaAQV9W5h1u93+DxL7we4LfHjj5LB9iTsC39YHUYv3z+kHHhu8mrRWceuBmoD3GanQZ
	VnWddVO/sMIP/BV311saJMRK2Fk2JWM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764434465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3OJuMMef1m6fBs7HkrxWlr5JMm8VZBpddi0degFzT8=;
	b=DP2Ir8ANJkyociymrnsCdyEJxPxsMCRxHVzPvQYSqasKaD3kHl0DRCUBXCYaoycHb3aiRm
	/40yrXqlncQYP6ZhXDq8xo4q9RhI00LfuF0q7TGkeINDwg2YcWptNLugvY/W4veUcKM+Sk
	4kFKb6wOAMtbkeuAcQRAFX2SLUwub64=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/4] bthost: add bthost_setup_sco() and accept incoming eSCO
Date: Sat, 29 Nov 2025 18:41:01 +0200
Message-ID: <f1ac0d4f8cd5c1c86a7bbb07a6635c003297bf34.1764434454.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <ab1a4fceca2948a2844dbac64fbca08ee7514f3e.1764434454.git.pav@iki.fi>
References: <ab1a4fceca2948a2844dbac64fbca08ee7514f3e.1764434454.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for bthost initiating SCO connections and accepting eSCO
ones with BT_HCI_CMD_ACCEPT_SYNC_CONN_REQUEST.
---
 emulator/bthost.c | 63 ++++++++++++++++++++++++++++++++++++++++++++---
 emulator/bthost.h |  3 +++
 2 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 9f9538d0d..935b4ba60 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -20,6 +20,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <endian.h>
+#include <errno.h>
 #include <stdbool.h>
 
 #include "bluetooth/bluetooth.h"
@@ -1317,11 +1318,29 @@ static void evt_conn_request(struct bthost *bthost, const void *data,
 	if (len < sizeof(*ev))
 		return;
 
-	memset(&cmd, 0, sizeof(cmd));
-	memcpy(cmd.bdaddr, ev->bdaddr, sizeof(ev->bdaddr));
+	if (ev->link_type == 0x01 || ev->link_type == 0x00) {
+		memset(&cmd, 0, sizeof(cmd));
+		memcpy(cmd.bdaddr, ev->bdaddr, sizeof(ev->bdaddr));
 
-	send_command(bthost, BT_HCI_CMD_ACCEPT_CONN_REQUEST, &cmd,
+		send_command(bthost, BT_HCI_CMD_ACCEPT_CONN_REQUEST, &cmd,
 								sizeof(cmd));
+	} else if (ev->link_type == 0x02) {
+		struct bt_hci_cmd_accept_sync_conn_request cmd;
+
+		memset(&cmd, 0, sizeof(cmd));
+		memcpy(cmd.bdaddr, ev->bdaddr, sizeof(ev->bdaddr));
+
+		/* TODO: emulate these properly? */
+		cmd.tx_bandwidth = cpu_to_le32(0x00001f40);
+		cmd.rx_bandwidth = cpu_to_le32(0x00001f40);
+		cmd.max_latency = cpu_to_le16(0xffff);
+		cmd.voice_setting = 0x00;
+		cmd.retrans_effort = 0x02;
+		cmd.pkt_type = 0xff;
+
+		send_command(bthost, BT_HCI_CMD_ACCEPT_SYNC_CONN_REQUEST, &cmd,
+								sizeof(cmd));
+	}
 }
 
 static void init_conn(struct bthost *bthost, uint16_t handle,
@@ -3538,6 +3557,44 @@ void bthost_hci_disconnect(struct bthost *bthost, uint16_t handle,
 	send_command(bthost, BT_HCI_CMD_DISCONNECT, &disc, sizeof(disc));
 }
 
+int bthost_setup_sco(struct bthost *bthost, uint16_t acl_handle,
+							uint16_t setting)
+{
+	static const struct bt_hci_cmd_setup_sync_conn settings[] = {
+		{
+			.tx_bandwidth = cpu_to_le32(0x00001f40),
+			.rx_bandwidth = cpu_to_le32(0x00001f40),
+			.max_latency = cpu_to_le16(0x000a),
+			.retrans_effort = 0x01,
+			.voice_setting = cpu_to_le16(BT_VOICE_CVSD_16BIT),
+		},
+		{
+			.tx_bandwidth = cpu_to_le32(0x00001f40),
+			.rx_bandwidth = cpu_to_le32(0x00001f40),
+			.max_latency = cpu_to_le16(0x000d),
+			.retrans_effort = 0x02,
+			.voice_setting = cpu_to_le16(BT_VOICE_TRANSPARENT),
+		}
+	};
+	struct bt_hci_cmd_setup_sync_conn cmd;
+	unsigned int i;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	for (i = 0; i < ARRAY_SIZE(settings); ++i) {
+		if (settings[i].voice_setting == cpu_to_le16(setting)) {
+			memcpy(&cmd, &settings[i], sizeof(cmd));
+			break;
+		}
+	}
+	if (!cmd.voice_setting)
+		return -EINVAL;
+
+	cmd.handle = cpu_to_le16(acl_handle);
+	send_command(bthost, BT_HCI_CMD_SETUP_SYNC_CONN, &cmd, sizeof(cmd));
+	return 0;
+}
+
 void bthost_write_scan_enable(struct bthost *bthost, uint8_t scan)
 {
 	send_command(bthost, BT_HCI_CMD_WRITE_SCAN_ENABLE, &scan, 1);
diff --git a/emulator/bthost.h b/emulator/bthost.h
index ce6bd820f..c88ea0329 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -69,6 +69,9 @@ void bthost_hci_ext_connect(struct bthost *bthost, const uint8_t *bdaddr,
 void bthost_hci_disconnect(struct bthost *bthost, uint16_t handle,
 								uint8_t reason);
 
+int bthost_setup_sco(struct bthost *bthost, uint16_t acl_handle,
+							uint16_t setting);
+
 typedef void (*bthost_cid_hook_func_t)(const void *data, uint16_t len,
 							void *user_data);
 
-- 
2.51.1

