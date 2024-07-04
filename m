Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964F91AB90B
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088785; cv=none; b=oXfLDSA+/IR7viDvCc+ri9bWLsuMm3k7Lb7mazLEIt8A5T7LC8nkqz31otOi4soB//XRS598yh1Qo3rz08tH5ln1HXT5EWG5A37jZ9UJJS9rI8gxNp6/qT5us9ruKpY7YS6bXUjVs87pqf7xznn/EAKlg8pKasm6lz37kA338xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088785; c=relaxed/simple;
	bh=E0SSEybmdjBxLSSaKZC832oxacklCxLzNzdU7QbqVes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPl/ngEY+1mnrxmELN7tjz5/CXvbQjahZCD3QISShqS6tb00c+dHhcX3QETsOoTs6xZmHc/1beyaXfAkEUtUH8WNEPKnM1L9Jz36YbIySVKtPdjouFVeHbqnsBJ7iHm7STcuE+5gawOjeriVrvf+moUnSSlXL6D9f6+0OpPnXko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id DC21124000F;
	Thu,  4 Jul 2024 10:26:21 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 08/12] emulator: Fix integer truncation warnings
Date: Thu,  4 Jul 2024 12:24:39 +0200
Message-ID: <20240704102617.1132337-9-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102617.1132337-1-hadess@hadess.net>
References: <20240704102617.1132337-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: INTEGER_OVERFLOW (CWE-190): [#def1] [important]
bluez-5.76/emulator/amp.c:693:2: cast_overflow: Truncation due to cast operation on "(remain_assoc_len > 248) ? 248 : remain_assoc_len" from 32 to 16 bits.
bluez-5.76/emulator/amp.c:693:2: overflow_assign: "fragment_len" is assigned from "(remain_assoc_len > 248) ? 248 : remain_assoc_len".
bluez-5.76/emulator/amp.c:698:2: overflow_sink: "fragment_len", which might have overflowed, is passed to "memcpy(rsp.assoc_fragment, amp->local_assoc + len_so_far, fragment_len)". [Note: The source code implementation of the function has been overridden by a builtin model.]
696|	rsp.phy_handle = cmd->phy_handle;
697|	rsp.remain_assoc_len = cpu_to_le16(remain_assoc_len);
698|->	memcpy(rsp.assoc_fragment, amp->local_assoc + len_so_far,
699|							fragment_len);
700|

Error: INTEGER_OVERFLOW (CWE-190): [#def2] [important]
bluez-5.76/emulator/amp.c:701:2: cast_overflow: Truncation due to cast operation on "4 + fragment_len" from 32 to 8 bits.
bluez-5.76/emulator/amp.c:701:2: overflow_sink: "4 + fragment_len", which might have overflowed, is passed to "cmd_complete(amp, 5130, &rsp, 4 + fragment_len)".
699|							fragment_len);
700|
701|->	cmd_complete(amp, BT_HCI_CMD_READ_LOCAL_AMP_ASSOC,
702|						&rsp, 4 + fragment_len);
703|   }

Error: INTEGER_OVERFLOW (CWE-190): [#def4] [important]
bluez-5.76/emulator/bthost.c:3309:3: cast_overflow: Truncation due to cast operation on "len - offset" from 32 to 8 bits.
bluez-5.76/emulator/bthost.c:3309:3: overflow_assign: "cp->data_len" is assigned from "len - offset".
bluez-5.76/emulator/bthost.c:3317:2: overflow_sink: "cp->data_len", which might have overflowed, is passed to "memcpy(cp->data, data + offset, cp->data_len)". [Note: The source code implementation of the function has been overridden by a builtin model.]
3315|		}
3316|
3317|->		memcpy(cp->data, data + offset, cp->data_len);
3318|
3319|		send_command(bthost, BT_HCI_CMD_LE_SET_PA_DATA, buf,
---
 emulator/amp.c    | 3 ++-
 emulator/bthost.c | 8 +++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/emulator/amp.c b/emulator/amp.c
index 49d2df7b39df..6daf00189f3a 100644
--- a/emulator/amp.c
+++ b/emulator/amp.c
@@ -680,7 +680,8 @@ static void cmd_read_local_amp_assoc(struct bt_amp *amp,
 {
 	const struct bt_hci_cmd_read_local_amp_assoc *cmd = data;
 	struct bt_hci_rsp_read_local_amp_assoc rsp;
-	uint16_t len_so_far, remain_assoc_len, fragment_len;
+	uint16_t len_so_far, remain_assoc_len;
+	size_t fragment_len;
 
 	if (cmd->phy_handle != amp->phy_handle) {
 		cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS,
diff --git a/emulator/bthost.c b/emulator/bthost.c
index cc9bf7240531..95160506d0c4 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3290,6 +3290,7 @@ static void set_pa_data(struct bthost *bthost, const uint8_t *data,
 {
 	struct bt_hci_cmd_le_set_pa_data *cp;
 	uint8_t buf[sizeof(*cp) + BT_PA_MAX_DATA_LEN];
+	size_t data_len;
 
 	cp = (void *)buf;
 
@@ -3299,14 +3300,14 @@ static void set_pa_data(struct bthost *bthost, const uint8_t *data,
 	cp->handle = 1;
 
 	if (len - offset > BT_PA_MAX_DATA_LEN) {
-		cp->data_len = BT_PA_MAX_DATA_LEN;
+		data_len = BT_PA_MAX_DATA_LEN;
 
 		if (!offset)
 			cp->operation = 0x01;
 		else
 			cp->operation = 0x00;
 	} else {
-		cp->data_len = len - offset;
+		data_len = len - offset;
 
 		if (!offset)
 			cp->operation = 0x03;
@@ -3314,7 +3315,8 @@ static void set_pa_data(struct bthost *bthost, const uint8_t *data,
 			cp->operation = 0x02;
 	}
 
-	memcpy(cp->data, data + offset, cp->data_len);
+	memcpy(cp->data, data + offset, data_len);
+	cp->data_len = data_len;
 
 	send_command(bthost, BT_HCI_CMD_LE_SET_PA_DATA, buf,
 					sizeof(*cp) + cp->data_len);
-- 
2.45.2

