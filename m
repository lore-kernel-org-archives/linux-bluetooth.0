Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04676328611
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 21:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770758854; cv=none; b=ni/uT8840lC4oIICFdH/rcsfyFc7QkrUu1updeANvyoTU3KlOk3bq168xhuEvTsn+kzOSx8UNLL724r39RvDuootKjSxcGSJltOe2QvAD5P2fa+1j1FFuEcape2PfyjHMLWXSxqsP7s8Iy1GUE328XUKiAi87JSCjb2sOg468C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770758854; c=relaxed/simple;
	bh=wdjagKylrsXhAv2rVcMefRa/jf8mau5Me8Sc+WuXu5o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HOr76OM/YNspoUwPXnjovhIt5vhQdCbqDQPN1DwP3BLMN6s9tVtCnh+3WUr/LfPtfynkjR3qv+H7ADfIO+jvamA59agsJAh890tEaF/NTrfElRGfxKna4jaQ0J684WmZSNMgWSyiMz09P1DDo63VhQMEjSA6Ykn9Tdpl0JqHn6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJPYc8Ne; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJPYc8Ne"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5f94f5ca9faso3872117137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 13:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770758852; x=1771363652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Px020aYtxms596ToLgoGzdciVCq+vBNKLJk1CCRLYWY=;
        b=IJPYc8NeD1r30Q/S9GdkUHtl6RHIFgh7NQZHg+aBobyUxbFQwUrsjpZ2/Io9AM1z8V
         kDds2PzLtNhtt/t1KwNYvNwy362/RGreDrw1121BNKEWSJOu9BelRqJ574h2WZaptiqp
         U3CNi5wTd21pXvmGf1dbfoVf1i6vdJUjfzvOYcJ9Go/To/K4uadJ4xmUGmz9IlWD91hU
         2dFVHCoT+1fyjE6K+kGVmyp3Gqugjtw8AMzkl7vam94UQj5nfwAvNMX6Gy3wut2d9paX
         xA6PbPZE4A9kpvk082u41wYscZfOHc6xeSzaMcuTZ+/Pd+xiFpQss0V1S1nSw0xflWwU
         lPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770758852; x=1771363652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Px020aYtxms596ToLgoGzdciVCq+vBNKLJk1CCRLYWY=;
        b=o2JIPJOgRIVVeh6X71ZWmRnPK3aeU8w/ziGnJ4e3PIkYuA7GtqmM5Okkh8HfCNrMFw
         P7euiF5Kbn+yEJXg6Yb9p0+JCnjUsQVHV9DLQ0UCD9zbsLrzwHP7f7jaXXVaSV1Sufol
         c3F0AoAN8NRFOqxukEonsaU93Inq9k5ANaRjYnjr2DnvbwkHwHePazcdDoQ6pJaOkuE6
         EfofJBMZCQfBf+uY8ru8VQmmQ1iF/nt/q4RQXcJlBR0Scwki8f+iocp9OrMn4H/U0uXt
         DdooxxRvIKzrECLNv/HM89+bHz5zMufY755ged2Ae4qUfYTApGVCrP3QbfyF5kCBBFTH
         uoNA==
X-Gm-Message-State: AOJu0YyeE6aGNbvQxegOGTu0E94/2/BjrcwG7vahfeAbUUeHSiM7npPK
	uzPZMUuUn1TkKFRq0kXs1S+P6DEkmxkzIGf9dMqFI3EG9KbMC8alwyNlB3lF3Q==
X-Gm-Gg: AZuq6aJRpAWA60zJrGS5P6EOY7aCPNp7s4W2MY6Oddfn5McwF+0dQ6KqgXIvZc8OprS
	lYXOsy6HccfHWZ8lnMAWyKp4tBpydib50rCvQfyNor/hcet3CCKNX5EAbTd7IlG2zqUyrEE2pi5
	EQjeiiYS5HHbiimMaRka4HyXoVncvPQOe3XUsLJDYI+XEsBpHcpKQq3akb1CXkTX4jniYqZBQ71
	LXyQRql/ViDck2lzWUu8FyInAqNRbRWSTe+4Jg/2EIyruJ2yBjBYHiKbakyA47FFmGpm6DvkCrf
	oferYdBzYoUaWRubXIFKmO1RoZeD6vwgFaA8H4Jh8w38Cnx+HhHP+VzxEj72AIaS8LVIUttKUAj
	TN9sBt9n96fa+KfcRixQwQSQoQHPm3LLkl3hMDUn+2KqUru+amEsVoIJM0f9XiV/H+72IuyIIFG
	JJSPUTclpdyJRnbird7fXs3VrgOTSVym6sGOT2f0B10MA8kOB5DyhG7be8lcB1TC2BS018/PX2l
	7GJUHBgOMTptSYaXCZqL4rPC6/b
X-Received: by 2002:a05:6102:3913:b0:5f5:4d37:8118 with SMTP id ada2fe7eead31-5fc48c15b1bmr1295809137.2.1770758851622;
        Tue, 10 Feb 2026 13:27:31 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afd343306sm8822241.9.2026.02.10.13.27.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 13:27:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short
Date: Tue, 10 Feb 2026 16:27:22 -0500
Message-ID: <20260210212722.1250596-1-luiz.dentz@gmail.com>
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

