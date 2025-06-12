Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E071798F
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 05:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749706273; cv=none; b=D6RLw2KQpCAvVdYiN0cZebF+9gVvYdfhCi9GTXN/W89pC//9BJ6eAzltaznfW9ClqZnpOo25cBXXVcP768LWhFA4ofyCtgoNANeeFw5aZpKJfuHBS5z9eVJjkAC5mZw9cj0fIU3uCXYdoChOPtaXrCXi6IduwM6KZ8FdDTpRDEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749706273; c=relaxed/simple;
	bh=5FZPpUp06QAsKttb8r5t8JfnlbptX7fcGW9WJApaHVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZM0dx8HX6yX6Hl0a2RTU1GytvqA/P9dPNSCz/AbzJDGE75JIQTd7UeqlU1eNlBmsoVuZOxNOuy5ev5Xa9Xur3ctz+O2gJuoY3Z59gmQt4Zj8rVkEhJqkeccwctWd9/f0zp26VePyUdnECtXf+sqaBn2eSOj7B0ngzd5WfqzrLzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoR6ji4W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoR6ji4W"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2390C4CEEB;
	Thu, 12 Jun 2025 05:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749706272;
	bh=5FZPpUp06QAsKttb8r5t8JfnlbptX7fcGW9WJApaHVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DoR6ji4WnQNCUQj5Lw8zfMrNpR+yMd7VA2+GRuD6wH4+YFyAlqzD4nBjCk2qNO/QM
	 T8Zxft6gqBR+Ehjpcis6eJqpa8DAi6B4NZ3giJBenGi7s7Zvl38a8ph9tnferWeNuw
	 qurDMUdaTpE3ldy+h5jCYop5/+Gsdk6R+0gmoA3/joIvZQoGf3om/pTJtnuZKkI5AN
	 6F5EUIMtULA/ZIPy1FMvqablpSg316QZXugSXOhpdDiQJ1/fGwP8kr2allzJiKAU3+
	 jNj4owaE9iQIfa43L4wnWr0c+GR1rxvwOBBgQdFaKwfeMPDHBX1LcC1egfQlZmwYEx
	 6JPQ2OHesn3LQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BEDC61CE8;
	Thu, 12 Jun 2025 05:31:12 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Thu, 12 Jun 2025 13:31:02 +0800
Subject: [PATCH BlueZ bluez v2 2/2] shared/bass: Move cb->handle earlier in
 the flow
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-bass_for_encrypted_broadcast_source-v2-2-9128a437b595@amlogic.com>
References: <20250612-bass_for_encrypted_broadcast_source-v2-0-9128a437b595@amlogic.com>
In-Reply-To: <20250612-bass_for_encrypted_broadcast_source-v2-0-9128a437b595@amlogic.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749706270; l=1602;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=uizwlgQnQ9OZFKNg9Um1+6VAFUiT2zcih49bxU5xeUU=;
 b=dJ+51dHo2iyOeip4qbM5GpmSZhRboHJtzCMAuH4sq7k2ylztAdpsY8URFxoTVomvIffzqacGq
 Tbh2h6IB8G+BylTrjyrbZIOIRoiT1VG2/cAXVLpeB2M5MUEr5R17hDw
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

This change ensures cb->handle is executed even
if the function returns early in the attribute_notify
section. It also allows the stream status to be updated
before notifying the client, improving efficiency.
---
 src/shared/bass.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 7b9e0da63..11ad59e3b 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -964,6 +964,20 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 
 	gatt_db_attribute_write_result(attrib, id, 0x00);
 
+	for (entry = queue_get_entries(bass->cp_handlers); entry;
+						entry = entry->next) {
+		struct bt_bass_cp_handler *cb = entry->data;
+
+		if (cb->handler) {
+			ret = cb->handler(bcast_src,
+					BT_BASS_SET_BCAST_CODE,
+					params, cb->data);
+			if (ret)
+				DBG(bass, "Unable to handle Set "
+						"Broadcast Code operation");
+		}
+	}
+
 	if (!bass_trigger_big_sync(bcast_src)) {
 		bcast_src->enc = BT_BASS_BIG_ENC_STATE_DEC;
 
@@ -977,21 +991,6 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 
 		free(notif->iov_base);
 		free(notif);
-		return;
-	}
-
-	for (entry = queue_get_entries(bass->cp_handlers); entry;
-						entry = entry->next) {
-		struct bt_bass_cp_handler *cb = entry->data;
-
-		if (cb->handler) {
-			ret = cb->handler(bcast_src,
-					BT_BASS_SET_BCAST_CODE,
-					params, cb->data);
-			if (ret)
-				DBG(bass, "Unable to handle Set "
-						"Broadcast Code operation");
-		}
 	}
 }
 

-- 
2.42.0


