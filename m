Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325BD34678C
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392816; cv=pass; b=qVKPp/SZ/s6CBOzl+dN7yiKAKcaoQcTBtoNAxU+I00kUhe9nfy+3oLo2cuE7bJX8wHXVo5BH+12d7STt1eaaZY3dQSNj4bVKzIPaA+206v9jOrgT40fBPOWI90/n+zzZ7ScXQnyCY0bInLEysUGM6ZIfHMocsVYL8cw+jjgg4uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392816; c=relaxed/simple;
	bh=QMBaLG2jS6/47MMjt16Bfe5E1s/fDYexmP9jJmqWlNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+33OGv8avdFSLYkmWSiIymc3qHt7bE6t6mtAVsKq7gn6kwZ4JxBZX2NuiF/t01zd/rjrC34sTo/kjjURIiR60DIlIBC0kRs1oB3/iH6GVj9xltR3IQTssQIq/sgJmj4DghRUf5F/6IXKE+W6QHRIxZmPOgLnexU7qEGKjI+FKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=VjW5yq+z; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="VjW5yq+z"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpX9N1sCqzyWt;
	Sun, 05 Apr 2026 15:40:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etXI9lFLgJAq4RUNmFhf6AC05X/Hg9Qz7CIBq8EmsEc=;
	b=VjW5yq+z6MLQIwm1rNhe+DZCG6n47VMfh9e75CkOJMk+AmsJjcZcIP5E7MmCuqClbBsOhT
	4ocBxAssSIyYsCUfGUpV00EF60U/Jg1VSZphQRwjdgLfqzTjWXuao93xUZpAdc+0klv+v7
	XV4sEZlghqfmoWsiVPnGEVr5JgRZr+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etXI9lFLgJAq4RUNmFhf6AC05X/Hg9Qz7CIBq8EmsEc=;
	b=dRXdIvm5iCuu8DT9S8BAbjvWE/MKAlI6bGwfCNoD0YWr9OUzOfBan4AXHiUHGk74Cy85Dj
	gHWLjrryZ972z2sMlTkbE/yzx66I18EOc7jDqa/Z2MU7V3r2WQtBu1TtVVG+KNUsXfPNj0
	7FhiAXAmvEAhubViOph3KWiobbNOAzc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392808;
	b=jUswJEJYmyPak1giUeYa9dJtDjUTeM5qPFbIjYabW1PoAMmcdxoBaJL2Y0ctoU0avvcpj/
	NkEh4IiyBZgfpYlrWD2mRmEX2W9CYOKxJbgkU/V/BL46/sBBow/RgKLnqE5T5a8JJtaVxT
	L0bhKvJEM3bQAX7QsIAHB6Bq8aKvX/U=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 04/20] emulator: btdev: clear more state on Reset
Date: Sun,  5 Apr 2026 15:39:45 +0300
Message-ID: <80f7ab856a0ff8917be104da54f58d2e365bb8d3.1775392680.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775392680.git.pav@iki.fi>
References: <cover.1775392680.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On controller Reset command, initialize most fields in struct btdev to
zero, similarly to the state just after btdev_create().

This excludes some fields like command bitmasks, which hciemu may have
adjusted.

To make this easier, add struct_group() macro similar to what kernel
uses.
---
 emulator/btdev.c | 117 ++++++++++++++++++++++++++++-------------------
 1 file changed, 70 insertions(+), 47 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 3a295b679..ad2e025d1 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -50,6 +50,12 @@
 #define has_bredr(btdev)	(!((btdev)->features[4] & 0x20))
 #define has_le(btdev)		(!!((btdev)->features[4] & 0x40))
 
+#define struct_group(NAME, MEMBERS...) \
+	union { \
+		struct { MEMBERS }; \
+		struct { MEMBERS } NAME; \
+	}
+
 #define ACL_HANDLE BIT(0)
 #define SCO_HANDLE BIT(8)
 #define CIS_HANDLE SCO_HANDLE
@@ -149,15 +155,6 @@ struct btdev {
 
 	struct queue *conns;
 
-	bool auth_init;
-	uint8_t link_key[16];
-	uint16_t pin[16];
-	uint8_t pin_len;
-	uint8_t io_cap;
-	uint8_t auth_req;
-	bool ssp_auth_complete;
-	uint8_t ssp_status;
-
 	btdev_command_func command_handler;
 	void *command_data;
 
@@ -196,6 +193,18 @@ struct btdev {
 	const struct btdev_cmd *emu_cmds;
 	bool aosp_capable;
 
+	/* State zeroed on reset */
+	struct_group(reset_group,
+
+	bool auth_init;
+	uint8_t link_key[16];
+	uint16_t pin[16];
+	uint8_t pin_len;
+	uint8_t io_cap;
+	uint8_t auth_req;
+	bool ssp_auth_complete;
+	uint8_t ssp_status;
+
 	uint16_t default_link_policy;
 	uint8_t  event_mask[8];
 	uint8_t  event_mask_page2[8];
@@ -249,25 +258,26 @@ struct btdev {
 	struct le_cig le_cig[CIG_SIZE];
 	uint8_t  le_iso_path[2];
 
-	/* Real time length of AL array */
-	uint8_t le_al_len;
-	/* Real time length of RL array */
-	uint8_t le_rl_len;
-	struct btdev_al le_al[AL_SIZE];
-	struct btdev_rl le_rl[RL_SIZE];
 	uint8_t  le_rl_enable;
-	uint16_t le_rl_timeout;
 
 	struct pending_conn pending_conn[MAX_PENDING_CONN];
 
-	uint8_t le_local_sk256[32];
-
 	uint16_t sync_train_interval;
 	uint32_t sync_train_timeout;
 	uint8_t  sync_train_service_data;
 
 	uint16_t le_ext_adv_type;
 
+	); /* reset_group */
+
+	/* Real time length of AL array */
+	uint8_t le_al_len;
+	/* Real time length of RL array */
+	uint8_t le_rl_len;
+	struct btdev_al le_al[AL_SIZE];
+	struct btdev_rl le_rl[RL_SIZE];
+	uint16_t le_rl_timeout;
+
 	struct queue *le_ext_adv;
 	struct queue *le_per_adv;
 	struct queue *le_big;
@@ -617,15 +627,52 @@ static void le_big_free(void *data)
 	free(big);
 }
 
+static void btdev_init_param(struct btdev *btdev)
+{
+	unsigned int i;
+
+	btdev->page_scan_interval = 0x0800;
+	btdev->page_scan_window = 0x0012;
+	btdev->page_scan_type = 0x00;
+
+	btdev->sync_train_interval = 0x0080;
+	btdev->sync_train_timeout = 0x0002ee00;
+	btdev->sync_train_service_data = 0x00;
+
+	btdev->acl_mtu = 192;
+	btdev->acl_max_pkt = 1;
+
+	btdev->sco_mtu = 72;
+	btdev->sco_max_pkt = 1;
+
+	btdev->iso_mtu = 251;
+	btdev->iso_max_pkt = 1;
+
+	for (i = 0; i < ARRAY_SIZE(btdev->le_cig); ++i)
+		btdev->le_cig[i].params.cig_id = 0xff;
+
+	btdev->country_code = 0x00;
+}
+
 static void btdev_reset(struct btdev *btdev)
 {
 	/* FIXME: include here clearing of all states that should be
 	 * cleared upon HCI_Reset
 	 */
 
-	btdev->le_scan_enable		= 0x00;
-	btdev->le_adv_enable		= 0x00;
-	btdev->le_pa_enable		= 0x00;
+	if (btdev->inquiry_id > 0) {
+		timeout_remove(btdev->inquiry_id);
+		btdev->inquiry_id = 0;
+	}
+
+	queue_remove_all(btdev->conns, NULL, NULL, conn_remove);
+	queue_remove_all(btdev->le_ext_adv, NULL, NULL, le_ext_adv_free);
+	queue_remove_all(btdev->le_per_adv, NULL, NULL, free);
+	queue_remove_all(btdev->le_big, NULL, NULL, le_big_free);
+
+	memset(&btdev->reset_group, 0, sizeof(btdev->reset_group));
+
+	btdev_init_param(btdev);
 
 	al_clear(btdev);
 	rl_clear(btdev);
@@ -633,10 +680,7 @@ static void btdev_reset(struct btdev *btdev)
 	btdev->le_al_len = AL_SIZE;
 	btdev->le_rl_len = RL_SIZE;
 
-	queue_remove_all(btdev->conns, NULL, NULL, conn_remove);
-	queue_remove_all(btdev->le_ext_adv, NULL, NULL, le_ext_adv_free);
-	queue_remove_all(btdev->le_per_adv, NULL, NULL, free);
-	queue_remove_all(btdev->le_big, NULL, NULL, le_big_free);
+	btdev->le_rl_timeout = 0x0384;
 }
 
 static int cmd_reset(struct btdev *dev, const void *data, uint8_t len)
@@ -8130,7 +8174,6 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 {
 	struct btdev *btdev;
 	int index;
-	unsigned int i;
 
 	btdev = malloc(sizeof(*btdev));
 	if (!btdev)
@@ -8195,27 +8238,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 		break;
 	}
 
-	btdev->page_scan_interval = 0x0800;
-	btdev->page_scan_window = 0x0012;
-	btdev->page_scan_type = 0x00;
-
-	btdev->sync_train_interval = 0x0080;
-	btdev->sync_train_timeout = 0x0002ee00;
-	btdev->sync_train_service_data = 0x00;
-
-	btdev->acl_mtu = 192;
-	btdev->acl_max_pkt = 1;
-
-	btdev->sco_mtu = 72;
-	btdev->sco_max_pkt = 1;
-
-	btdev->iso_mtu = 251;
-	btdev->iso_max_pkt = 1;
-
-	for (i = 0; i < ARRAY_SIZE(btdev->le_cig); ++i)
-		btdev->le_cig[i].params.cig_id = 0xff;
-
-	btdev->country_code = 0x00;
+	btdev_init_param(btdev);
 
 	index = add_btdev(btdev);
 	if (index < 0) {
-- 
2.53.0

