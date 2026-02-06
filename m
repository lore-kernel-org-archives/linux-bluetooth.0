Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD5E3EBF32
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Feb 2026 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770409277; cv=none; b=Q9gOEigN9fvPX4/f5f8XTwamYCZDI/qwUVIYoEWMxZlMesnnM/ULcrwmfLH9X29t9bOGrbBaYv7Wc/8zvZ7/VTrF4rJXNTxb9Orx5UjSGmfTg4CwEAiBh4D5qTNtBXMkmoHZcK7EmOiXlSgCHH/DR2VS1Jo38WEd9Jd5HMWYvkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770409277; c=relaxed/simple;
	bh=i/0uS0gvGaPIPq0ndaiY2/g6vkUKunp9kOQC/lifTYE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nZC3fVfmnGc9UiZt48xXC8Apb4nj3LtZKWjnsnkReGGqXkR6v6mLtY1f9DLtgL8+jypXFdHzTm4RwCZYHGwu7ceQl+4Nu0APNE7EGdsCHd8mfLoBuETdzPiM34X/c/DwmsO0W6B1fU7DeamjAucW8raxU5ZVrZ6/d4AbJOxX1hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqKBdrET; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqKBdrET"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-566360cab07so438642e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Feb 2026 12:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770409276; x=1771014076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qjW6xA4zn9p7gdbxIBAnlT2P6jmLUw5pu2gfTRPwTTk=;
        b=DqKBdrETK9sAi896J0kKqX9x33E4iK5U8VzXMiZhjimc8kXw7+c1y+X+a5zA3f/mrQ
         YatQxY1jJkqtH3kZELd1ICPU7CNjtRZmXPbu6fQLup49Awj/WJAI+UIJdv1NRFgw1L4u
         oxxuz3DU/EKnNt0oc7QIAn2ou4zke1NMFmmMY48m+Sb3K6SHSjgrBvRLlZgxtDn49FZN
         nNPXDP4IIse0MxLL4j0ogx8F6iftyrH9dAG9meUEawVBWKdKZmqBZp8PKglsI3AUF9F/
         bTKqG9pTLc9dIeTf2zoCcOg5Q/ci4jgTHNV9xQWbjXK6zcd+V8OINE9ab2oAIEt0o7fW
         wjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770409276; x=1771014076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjW6xA4zn9p7gdbxIBAnlT2P6jmLUw5pu2gfTRPwTTk=;
        b=nHIx+ipzi6VrnKIz1biEOmjmtyn6LDhLay7OOFMs7kdy69VnENOSvRl7X2Z6JRK5Ta
         R1Lj+RIVo959R62vY+7WYqQ1uHHg6eI6Pbu/HMUbuXzCVxWdKLdohuWvGP0Cf1+YaPrY
         OBqImITwaiTUK/QZnYCOLopxAFPapQYO1+GnXtme/qVYqkjuARrJRdOUf0Gc/UxKlVuw
         EsabMb6TOKXrhdaKZCc8PExMJtp8mJ1QWLSnhw6cfubBh1ibHG9MGLd1bPAYNOYniDzv
         tjhv0Vv/cT9zopyAs3A1hWHNWNGrpgrd4NyU7HOcqavjxxMaNWJC7JXmEwOwaPQboJOJ
         h64w==
X-Gm-Message-State: AOJu0YzIaCrEmuxzR9hepgsq+wla+ZfWMl24uv9V1dpinEvKpd9CNXfg
	0xZJcIcjHzHexQTDxSjzSBAUYb/g0H+eGEw44bLvxG0gS3YqlVpmqzVo6kFyinrW
X-Gm-Gg: AZuq6aLr8QyaLSERlwQDzGLUgikaVTzMkbC07+bY1taIrRAlYSiw+kaIGAsbmQWOcZI
	eq45AkLBam3yjMEtqbXLD5lY2+Y2nxtk7U+lvEK0W1rqvCfghjllfR9XwjmvdbZBRa1fkEqfDFj
	sQayTCJR848WkRV9Pd5JraeSZ3dMHM8AAYe6PDV2szQc2pobHt2LuoB/uv9fWiyQz2iEUwpvUS8
	6cKKyjp/zJsU2RbW5A99mv5tP1QIjQAxLKFFWdVbA6ZcHEWVI6KJvwnhXvra/c+Z3DfEpAYyxPh
	e2eCwlWfaFVVMbf8TeAYxXTy+cwArhll5iVypMwZn0gznQp1rnVDM0qOjNXEJfmDKEhW+BiXK5s
	wY/AWpm0QXRCrAudiQAK1nGwKeMC+mN+uzExxs53EOSsmq8YavSHnx9uIezf3hlvt1pPBf/+L1G
	Va2XBqmyhn9cbOCnYnnzOswfxBhBzM5sxf1j7ACo71+dor2RGvu92Sga3qgXwWMGxBMHFV3FlXC
	Fn/Fg==
X-Received: by 2002:a05:6122:181b:b0:559:67df:5889 with SMTP id 71dfb90a1353d-56705ed27c9mr1317540e0c.6.1770409276336;
        Fri, 06 Feb 2026 12:21:16 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-567072e966asm1199795e0c.4.2026.02.06.12.21.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 12:21:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short
Date: Fri,  6 Feb 2026 15:21:06 -0500
Message-ID: <20260206202106.337275-1-luiz.dentz@gmail.com>
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
 net/bluetooth/l2cap_core.c    | 11 +++++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

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
index 81038458be0c..0b9753df802d 100644
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
-- 
2.52.0

