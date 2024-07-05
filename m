Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786B145FF8
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169987; cv=none; b=B5H5oyuQTq0KEDyLch1j5+lDRH86CfyMRIiH4qV6BOhpGsVLL2T3xGZIw78fVkwD9rxBC02XnaYTiOpeNhBmF8vgkUQMetltx8XqgS74D3dAuXU+q0DEgLgM6UWDdIb9gXnqn+vXyZB3vLBjjmrkyomodk573A433TQAHDE13X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169987; c=relaxed/simple;
	bh=E0SSEybmdjBxLSSaKZC832oxacklCxLzNzdU7QbqVes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tb9AHVaEC4NPBBldE3ISO9GSU/aesw3YHGHWTMb1s22PsvNcf1rN+xDR1muG+oSLAxFguAWAeJNOOGkdyaEls2dmZomO+8aIvPheFJCmMjmxITMNMX3D8Ha5VB8+BcNZOdFV248WJKvDBmhUS7SU0IdswZotEAneH3iS4JStjd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4C9860012;
	Fri,  5 Jul 2024 08:59:37 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 07/11] emulator: Fix integer truncation warnings
Date: Fri,  5 Jul 2024 10:57:35 +0200
Message-ID: <20240705085935.1255725-8-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705085935.1255725-1-hadess@hadess.net>
References: <20240705085935.1255725-1-hadess@hadess.net>
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

