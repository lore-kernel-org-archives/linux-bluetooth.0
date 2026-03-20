Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B936923B
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041082; cv=pass; b=K4jWNSj3aZ30RZ6hJfpXNe1KuVuLiE3lBMTV37Y6HKKE9UDwwXftayAFafGBDybb9mrT8mm6I3AY+TOp74yxnr+77bISSG4D0aaMWhr17Br2wsbcDt5iZQdIxKhPtkLPr6TE1TpQyqX2Eise0DFraviY7UTCCYsEvja0hFLVtpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041082; c=relaxed/simple;
	bh=sjULSBV+9WBLGdy0S5JDApZKesEm3xjq8zdCYrsE74I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQf5rDFg8p0rJegoktTEqH9oIiLeHY0sM/wNBqpc23SeXTz6CrZHNxRwMr0MVqJFhEXuhoAQ7SdBacerfEX1mZKPCDaJA7RqKiYXyT66ACm3PN90ARvYI5QhITrwKAegD6ESc2CrAhC+adkLdZo3tmBlhdPD7oaZbMOCjK8t600=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=wW9QbDSk; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZCLYDIeI; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="wW9QbDSk";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZCLYDIeI"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4fcwGb55gNz49Q5W
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 23:11:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1774041079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GL80HgcQhUeZ/UzcOw83oeua7QrtL1IuSRx7BPMYfAE=;
	b=wW9QbDSkj6EoEtlGi4CMsvEqZMgjS10Iz9Dk4/v362sS74nSorrJPNs1Z/59wg9/wCzOrz
	rce1qLtyGSiPvVuYxXNXnUpkPq+1uaQxMrqMEFwtiLBRc0ss3h9w3UT+3Xm8ej0LyYHhmf
	bNbQp2bEwY3z8ezCi+Pj8mD0HcLiRBdwX3Rc4jA2xT41R9pGu+mHhIx0Qzr/qGtX6FlJ1R
	4VyGWltoXtoP/cGTTIRBg7rXwSo4cmhvOEbeY1xdoQN0VePJJgAsZ9MkaEB3knJqrvQ5s7
	WYkmtswc/LdhBwGTwcuhyRtpJ8uIxaXioJaBPegRg6jTCHyHXus0Wb4/G1cqPw==
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fcwGR6F31zyTn;
	Fri, 20 Mar 2026 23:11:11 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774041072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GL80HgcQhUeZ/UzcOw83oeua7QrtL1IuSRx7BPMYfAE=;
	b=ZCLYDIeID6PYQzcvf+fi63Fo51bwS+ZJTtI5YyA7K+zzUZlxiqnEKSGWA88MMtROSakFgv
	OwU+XBdExQGlcjn+F2EnkrR4HI6iZIwhVS8USIOKO91Z2aR1sVBqnNAXDZVCnzD7FnS6fx
	JOKnDq1QmxSM65dxUu+Gixn1uBJFEjE=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774041072;
	b=UTIIOdGs6SlWCQBv/YOHUa5TG4Dvdfp9FAyozCTaWV6XsBlwyTNoe77DAcyjSq8yxbm5b0
	4OcwhgbvcHhm0WnJRVFBQRdZYoakEhRRjfdfCtkWzpx9GNc9Jm6eStsGmfjLXsoD9h7lfp
	/CZJNClWOBvwvxiJcR5EhdikOwvu10Q=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774041072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GL80HgcQhUeZ/UzcOw83oeua7QrtL1IuSRx7BPMYfAE=;
	b=ij6j1P3bh3+bibzi57vPGZ1tfvXiItMnNYdTxreSbOw7tNisVETOKgO/yj/FAZSb/GrE/a
	DKPubTQ8+zcL1Mh8w9f4Hm93Yp4SMiT8JvhKh5Gg442REF/VutBNaAJkKCnZSTFz97n7GN
	SqJkoEgJxFD+qV6DaY6Xa1rE2PEpYEM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 04/20] emulator: btdev: clear more state on Reset
Date: Fri, 20 Mar 2026 23:10:48 +0200
Message-ID: <600b7c258cea63f8ba6ffc2e4013c8791e25cae1.1774041047.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774041047.git.pav@iki.fi>
References: <cover.1774041047.git.pav@iki.fi>
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
index d3a9c6735..55747d0ca 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -52,6 +52,12 @@
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
@@ -151,15 +157,6 @@ struct btdev {
 
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
 
@@ -198,6 +195,18 @@ struct btdev {
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
@@ -251,25 +260,26 @@ struct btdev {
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
@@ -619,15 +629,52 @@ static void le_big_free(void *data)
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
@@ -635,10 +682,7 @@ static void btdev_reset(struct btdev *btdev)
 	btdev->le_al_len = AL_SIZE;
 	btdev->le_rl_len = RL_SIZE;
 
-	queue_remove_all(btdev->conns, NULL, NULL, conn_remove);
-	queue_remove_all(btdev->le_ext_adv, NULL, NULL, le_ext_adv_free);
-	queue_remove_all(btdev->le_per_adv, NULL, NULL, free);
-	queue_remove_all(btdev->le_big, NULL, NULL, le_big_free);
+	btdev->le_rl_timeout = 0x0384;
 }
 
 static int cmd_reset(struct btdev *dev, const void *data, uint8_t len)
@@ -8132,7 +8176,6 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 {
 	struct btdev *btdev;
 	int index;
-	unsigned int i;
 
 	btdev = malloc(sizeof(*btdev));
 	if (!btdev)
@@ -8197,27 +8240,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
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

