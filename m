Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF11286D5C
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Feb 2026 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770410955; cv=none; b=CPxK1Zq0g8LskzCPT9v0zUIzkypRO8uXx2TegMDJSK3pOJBBNmjuceLVErftB2tYuoMec1omzMEB9f9TkUmJYutD+4e8qYPOMpeHkOPbDK6jkHJcUTk/pfCykoZ9DyrcWJNrX1sObRKy930UxQKkNVaVX1cP0bAaB0gYuLyn8C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770410955; c=relaxed/simple;
	bh=wdjagKylrsXhAv2rVcMefRa/jf8mau5Me8Sc+WuXu5o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=V1ffBvHT6nGzHGY/9eI8owOE01pqYQ80VCU6FW3BcEMLsJDrJE2IsPY5atjEWJno4KobR+ikyimlBXJklflY95FB8+rQg3gHlsIh2TNhwdK7A2xEf6rZvyEIYeiw6ieU/N2E7Kk/HUavqFipxb2wJ8+Xg7311YXV61d7XRJMYls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmEfjrAZ; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmEfjrAZ"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-948bd416c7eso663203241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Feb 2026 12:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770410953; x=1771015753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Px020aYtxms596ToLgoGzdciVCq+vBNKLJk1CCRLYWY=;
        b=KmEfjrAZ934RlzVnwP1F4dW6dYGwdc7zhd8aQsHnpxBs58K0Mfh9Kq5H5EF3dgJmD3
         7z3g0oLqx6V8UjiWIJAs1F0vQSsztoi9FJTrP492gu510b6SHbL2Qx4FWKHixV2EBhbr
         a1zQmZN/hmMbC48AVsyGKE6ahkzkMIRZK6naaoTNDN/MQqkF+tBHQx/TEWp42bgv7M0c
         JyPKIeEoZyWZ34tLugnZ6XN4bkMUHCsYILebbyr4wrn+xnV0QwG3T6jAD1pbVhrRgXls
         fezk/XMQfQDj/uy30t+3HEhaByfxL4kh2NNCUjezmPlp3bAKgELHMD9NbFV+FcNVI3AS
         BAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770410953; x=1771015753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Px020aYtxms596ToLgoGzdciVCq+vBNKLJk1CCRLYWY=;
        b=YxFbxfNHunDMCYTq8nErBPw4ghXsQYqCfdoxAHz9gd0v64rpPLEeFlKCF2bZkjeXVj
         JxxTB5hy7Pq5saR7siM+5BuRBonth4/53+RIx0EnUqWu1ieFwB1SSmzSovozhsTlZjbs
         2xzyxYY+SUgzU/u5evtbh7f1+NXF/2cgJU/ZSJVm9NQlMeWTEAzareQzZJ+e/3cRp1ZH
         rZprfH3W/hwxZPY0ZPKNB7P5GgJaewWwlWSAUUEYCBZPUw3941FBf3rzr4bqRg85hUaF
         Yr4VDhI0yeLjRLL8stjyhaTZkZIw0FXVPCnpPfmjAq8vw2oRJKW5cTMAAmPRNvEyBkT3
         8wJg==
X-Gm-Message-State: AOJu0Yx30xnmQfbgGBpqHUfMA6ozA8WBP6KiT6rFqxuRaQeGcBX+hRZG
	ANvBKZr29gPLsY8J/aNq711HR4UMmWuTsE0WjtOI2dEP2SQXUaWrG9uz6PH7hcnR
X-Gm-Gg: AZuq6aLQ+B6RnE9Vzs2u+H5EQ3QyhbdooK4NMdyMpt1EC7xd7JmzG3XT4Q6N8OhHfgd
	2aMH0ISP26+MOyGGBgCllbHpDXqnLFYOhO937IoRCUp8QNQ2TZndRI+loHOaQB+MRxGaLFRAtUL
	tUf89SH49uQTVo3sqOmDy7Fce+U2cLvymG6dJ2m705JPhnOI452uxx6ryRr01YgFvC25XwTXz+H
	OFt24pYHv6XQqgF7xE6wgpvm8bqs4tFzW8twGvHSAACesNzuTZ5DfkiVDQkKxwCddrg7MnDaqL7
	KkB5Ek5649YnjCXIkf1Iu76JGnX10yMdc8ZLvRBuWmtWo31nE0KIjc65oWSJ6egwIjs5mo78jYn
	51ndzv7SCZ9Q7UguwSQN4I6pAB3HfAU+f3z7/18VCQgRSS65vkcDRpNdXz4G01wy6u4hx4bs5OX
	zZW5fUEHf5VgRSAhpOaRcn53pQTMMdCyJ0TLBbv48t4pAaZCkazA5owYxe2N6pGV4Ad12xKtqzz
	+sozg==
X-Received: by 2002:a05:6102:3587:b0:5f5:487c:83cd with SMTP id ada2fe7eead31-5fae8c48843mr1051133137.40.1770410953354;
        Fri, 06 Feb 2026 12:49:13 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5fae8ff1d5esm1255658137.10.2026.02.06.12.49.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 12:49:12 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short
Date: Fri,  6 Feb 2026 15:49:03 -0500
Message-ID: <20260206204903.345595-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Test L2CAP/ECFC/BV-26-C expect the response to L2CAP_ECRED_CONN_REQ with
and MTU value < L2CAP_ECRED_MIN_MTU (64) to be L2CAP_CR_LE_INVALID_PARAMS
rather than L2CAP_CR_LE_UNACCEPT_PARAMS.

Also fix not including the correct number of CIDs in the response since
the spec requires all CIDs being rejected to be included in the
response.

Link: https://github.com/bluez/bluez/issues/1868
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |  6 +++---
 net/bluetooth/l2cap_core.c    | 14 ++++++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 6f9cf7a05986..010f1a8fd15f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -284,9 +284,9 @@ struct l2cap_conn_rsp {
 #define L2CAP_CR_LE_BAD_KEY_SIZE	0x0007
 #define L2CAP_CR_LE_ENCRYPTION		0x0008
 #define L2CAP_CR_LE_INVALID_SCID	0x0009
-#define L2CAP_CR_LE_SCID_IN_USE		0X000A
-#define L2CAP_CR_LE_UNACCEPT_PARAMS	0X000B
-#define L2CAP_CR_LE_INVALID_PARAMS	0X000C
+#define L2CAP_CR_LE_SCID_IN_USE		0x000A
+#define L2CAP_CR_LE_UNACCEPT_PARAMS	0x000B
+#define L2CAP_CR_LE_INVALID_PARAMS	0x000C
 
 /* connect/create channel status */
 #define L2CAP_CS_NO_INFO	0x0000
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 81038458be0c..390d25909104 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5051,13 +5051,15 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	struct l2cap_chan *chan, *pchan;
 	u16 mtu, mps;
 	__le16 psm;
-	u8 result, len = 0;
+	u8 result, rsp_len = 0;
 	int i, num_scid;
 	bool defer = false;
 
 	if (!enable_ecred)
 		return -EINVAL;
 
+	memset(pdu, 0, sizeof(*pdu));
+
 	if (cmd_len < sizeof(*req) || (cmd_len - sizeof(*req)) % sizeof(u16)) {
 		result = L2CAP_CR_LE_INVALID_PARAMS;
 		goto response;
@@ -5066,6 +5068,9 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
 
+	/* Always respond with the same number of scids as in the request */
+	rsp_len = cmd_len;
+
 	if (num_scid > L2CAP_ECRED_MAX_CID) {
 		result = L2CAP_CR_LE_INVALID_PARAMS;
 		goto response;
@@ -5075,7 +5080,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	mps  = __le16_to_cpu(req->mps);
 
 	if (mtu < L2CAP_ECRED_MIN_MTU || mps < L2CAP_ECRED_MIN_MPS) {
-		result = L2CAP_CR_LE_UNACCEPT_PARAMS;
+		result = L2CAP_CR_LE_INVALID_PARAMS;
 		goto response;
 	}
 
@@ -5095,8 +5100,6 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 
 	BT_DBG("psm 0x%2.2x mtu %u mps %u", __le16_to_cpu(psm), mtu, mps);
 
-	memset(pdu, 0, sizeof(*pdu));
-
 	/* Check if we have socket listening on psm */
 	pchan = l2cap_global_chan_by_psm(BT_LISTEN, psm, &conn->hcon->src,
 					 &conn->hcon->dst, LE_LINK);
@@ -5121,7 +5124,6 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		BT_DBG("scid[%d] 0x%4.4x", i, scid);
 
 		pdu->dcid[i] = 0x0000;
-		len += sizeof(*pdu->dcid);
 
 		/* Check for valid dynamic CID range */
 		if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN_END) {
@@ -5188,7 +5190,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		return 0;
 
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_ECRED_CONN_RSP,
-		       sizeof(*pdu) + len, pdu);
+		       sizeof(*pdu) + rsp_len, pdu);
 
 	return 0;
 }
-- 
2.52.0

