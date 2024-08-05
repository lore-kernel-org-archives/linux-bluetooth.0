Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE53811E2
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866926; cv=none; b=gcV4W70F4k5x1xoXWfD8jZedj3fEBnW2giE7HM0aePxSo+/DDW/K9QSpFtVE9qZiTlzzwupPwWlNQU5gfoUj5TAbIaCksv4j50eHSVnzvFFNdYJd2NHOR32eDrOovWxOwfZYTFnprX7Y4yHde8aDgoytSMf/BsVRJ4etHHxNVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866926; c=relaxed/simple;
	bh=6JFpXQZQ2Yvc8eAxLEiavBKVbaEu54L4ygtUbbkzmxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkvBbKkQqhX9ITwDvWDTCWY7DKJgE1IGREl2SDUMltIKRop5eCHQ6yeK+PVNzYsfAWi41oBoS0c11BPBPYxDmcUJeoqOXx3RlcJWqAJVjYAgCIx+PFnkv4MR/31BUHQSaUsppFSWACfyk+6mhfHELBiqxLiWVSKuwxu+eC+UUnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2C0B20009;
	Mon,  5 Aug 2024 14:08:42 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 5/8] mesh: Fix possible integer overflow
Date: Mon,  5 Aug 2024 16:06:43 +0200
Message-ID: <20240805140840.1606239-6-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805140840.1606239-1-hadess@hadess.net>
References: <20240805140840.1606239-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: INTEGER_OVERFLOW (CWE-190): [#def1] [important]
bluez-5.77/mesh/net.c:3164:4: cast_overflow: Truncation due to cast operation on "msg->len - seg_off" from 32 to 8 bits.
bluez-5.77/mesh/net.c:3164:4: overflow_assign: "seg_len" is assigned from "msg->len - seg_off".
bluez-5.77/mesh/net.c:3178:2: overflow_sink: "seg_len", which might have overflowed, is passed to "mesh_crypto_packet_build(false, msg->ttl, seq_num, msg->src, msg->remote, 0, msg->segmented, msg->key_aid, msg->szmic, false, msg->seqZero, segO, segN, msg->buf + seg_off, seg_len, packet + 1, &packet_len)".
3176|
3177|		/* TODO: Are we RXing on an LPN's behalf? Then set RLY bit */
3178|->		if (!mesh_crypto_packet_build(false, msg->ttl, seq_num, msg->src,
3179|						msg->remote, 0, msg->segmented,
3180|						msg->key_aid, msg->szmic, false,

X
---
 mesh/net.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 05ca48326fc5..ef6a3133859a 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -3149,13 +3149,22 @@ static bool send_seg(struct mesh_net *net, uint8_t cnt, uint16_t interval,
 	uint32_t seq_num;
 
 	if (msg->segmented) {
+		if (msg->len < seg_off) {
+			l_error("Failed to build packet");
+			return false;
+		}
 		/* Send each segment on unique seq_num */
 		seq_num = mesh_net_next_seq_num(net);
 
-		if (msg->len - seg_off > SEG_OFF(1))
+		if (msg->len - seg_off > SEG_OFF(1)) {
 			seg_len = SEG_OFF(1);
-		else
+		} else {
+			if (msg->len - seg_off > UINT8_MAX) {
+				l_error("Failed to build packet");
+				return false;
+			}
 			seg_len = msg->len - seg_off;
+		}
 	} else {
 		/* Send on same seq_num used for Access Layer */
 		seq_num = msg->seqAuth;
-- 
2.45.2

