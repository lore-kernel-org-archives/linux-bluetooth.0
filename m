Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239112;
	b=SSdkcDhCTt1p3s5e0C9jru7zNfHbUyaZAgrrnPrLgffjiy8yLTa/9bnqW4vcrbYIE4cl
	 1Vu+082bDgZfCyrLfsVq7mGio1iP/nzcckPGyguoAOOulxQZXgIiyj0olhaGYhoqXZM4v
	 stPA/NUrQeaY4BJJ/iRkRrnwIp1MNWTVWaEaYQQTE/Zto3iBa4dV1CLY54uBMrzBhMScv
	 n++56A0P6V3CIHsQt8Dpp+sZVaShige67RjUJXr/SK18x04EcpzfMOSZ/d2QRz4NAIRA2
	 cUkAJQxAeF0oA/YnmJozWTGuNG7AhQtPXu7SZdZW3SjO993HOhHWW2J0U4ZQy/Bmd4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zi793JYghXbO91i+/upzqtPZO8kG7ZO9o1nr5PPqhIU=;
	b=dfXCYkyQhw4aBm0LKlZHZuGOIYl092+LO2OLDeaQrhy+PyT1ZxmAVUSJFtW2oRGO94/x
	 Qi3nhmdEOPyk9ZRyJ1quoNCYz0rc1Cenzcm+qE0ETdUPRy3zz4zG7UY6lsX/tClCgdEm9
	 RTloCGzjmuGTjJEvRUahLd6bYMqL72IRJWEJQ4GAnPQzXqvku/80geGJxmkV0ngkBFfMc
	 mW/Kv9RZFsjSb7EfHbcbohSslIMjhaFwZGqp7ALhRbjFglbksbJuApCWx9WuTqSPrQCO6
	 XliUmsKM5xs50DhqnsPDgkIg0nV5+baPGuHdNhSWAQbPBVXGrTzAZogHKBlQbuGCy5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gE7d+pSy;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0E606A333
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 15:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD0E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gE7d+pSy
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7cc013095d4so341985137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 07:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239106; x=1794843906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zi793JYghXbO91i+/upzqtPZO8kG7ZO9o1nr5PPqhIU=;
        b=gE7d+pSyta07Eu7Q2NhdR2Xoxst6sa0efH5TcmSeLqnz43S73g3HA87T1jgHVFzaBf
         jtfXX7rjwjWlWO3ivL6YGR5nlvhq0EC8ZuUKIJSKrvAk6vpyds08rrnfMgLBIF/uBdHL
         17a/QeGQv2m9jV9W94fId7ljGB1NZfNMLCPgySfpeyWUS4o3tC9BIZhwH/zCBF+xX6Ma
         3MbryiNf8mUgrCCYalmbv9HLM7+JbDo+zj2sfe2hGwCUUel2lAj+F6hRLs9qMCBCFC1J
         7QAPhreL2ecpXqZLI9h57XW9Ur3W4BmqGpY68odFSudMD/LrEI51qh3MJx7ZfG+N0O8n
         XcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239106; x=1794843906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Zi793JYghXbO91i+/upzqtPZO8kG7ZO9o1nr5PPqhIU=;
        b=cOojMoaBX1whe0gRTDNDK3z8IpWF/wrBvWxwCLwVRUacx1Nnb9kjpwAWp/z6/xSTla
         Qn2c2N92HC2mpCvUotvte1n5uKCEHbUZC1PUnAZ/eVOSWew1zO6n/47VBI5KJZnaMH0O
         Ja9xO6VTKvnTFBKp3NWT0+BIUteZ4qmGNUkU+IKpf3vIRONrbga+jBKvjkWrID4kPaCO
         P7BxXeuFR2E4eGlh5JWM13gYPRIeuKEJcs1Nb/d7rrCuaaSl9Qp7aIKsQEFncOyg2sbL
         G3gw1Q4e0fEALOoukFSuC8uRw1gdI0vU6dMKExigL4BNszZ1i8tLTMe9NED8BeUDDXnR
         BWSQ==
X-Gm-Message-State: APuU4Z/NjpEQIiAnHnCTSd71nckPG0fPnbvlEupvoUEEeUfebTgE1XlQ
	x0OJG0SMHlGUag0IBYGLBRGotskFvgzLTXXpHvQVQiI4H5NZld1v3sY0/KRGvw==
X-Gm-Gg: AYBFou1bamEQP6db942Zeab0aMAdQiaVSvm5prJrDFWHYoVRDFgXBM9Dq9cFBoJJkJM
	aSAdo+EBsyMgUrIb9DIrYFiXDNMjNXAUdRQIrrxShnStL1SGTRP/9FL4W5FDboc1unNkz8EKhzB
	t0weZWa4wa5WfI9huVgUxPyLjlC2uC3kppyp2GoxTFncg1GIhI2jWuXY12dSMtbzFNLZKRqDIPn
	I4gXhHHdU9Mi88LNntBbzNhuHDm9aFlxG2xHNDouYsG47b6kfORJ+OYgXQj3kQnnny1Na2w56/j
	mIEqE80WIIvLUQ1gOhpXqJd7he74jF9LwNSD39juB08oNXZi3WuZnbVZ+hbNR0yrJRSb+f0LXRm
	MJuAPtAZtemKyBLe1GV5EblabcpbBR6FN44mmKLrjsgFhm4WfDSPi9lDTbBSY1LbMHey7DFa4O8
	dpAuiDQI3RvH8q7cfSgqvtS0/f4U+DJ9Gie2gU3QsG5PPnaxLexYc4ZOMyKUsnHAP2UKdeBmPOt
	W9w3wEHLZdExMdwfovG4Q1LUgjSpangUt2HhFRDbDA3YxiauGu9702O9Uh7tcpP4kBqEoBqq+++
	nTBGcYvdHTXFG3GHGM8KphA6eTvcB1qMzNrkUR9gGJb3iBk5O4x0SHun5yHGzQzOzPG5lwXdeIV
	KLC0+AmGpuRwj3ToiVxA/XsxY2hhw9zLeTq43UFOJUMibztJcqpnjpwMtg38coThXA0MmTPdpMv
	X5uqE=
X-Received: by 2002:a05:6102:604f:b0:7cc:2152:4f95 with SMTP id ada2fe7eead31-7d2daab2792mr1110046137.3.1794239104956;
        Mon, 09 Nov 2026 07:45:04 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c02a60a83sm4097474241.10.2026.11.09.07.45.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:45:04 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 01/10] shared/att: Use util_iov helpers to build and parse PDUs
Date: Mon,  9 Nov 2026 10:44:52 -0500
Message-ID: <20261109154501.1362649-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109154501.1362649-1-luiz.dentz@gmail.com>
References: <20261109154501.1362649-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Build the PDU in encode_pdu and read the signature counter in
handle_signed with util_iov_push/pull so the length checks are done as
part of the access.

Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/att.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 3055f291f8f1..4fa69e597556 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -338,7 +338,9 @@ static bool encode_pdu(struct bt_att *att, struct att_send_op *op,
 {
 	uint16_t pdu_len = 1;
 	struct sign_info *sign = att->local_sign;
+	struct iovec iov;
 	uint32_t sign_cnt;
+	void *sig;
 
 	if (sign && (op->opcode & ATT_OP_SIGNED_MASK))
 		pdu_len += BT_ATT_SIGNATURE_LEN;
@@ -354,9 +356,12 @@ static bool encode_pdu(struct bt_att *att, struct att_send_op *op,
 	if (!op->pdu)
 		return false;
 
-	((uint8_t *) op->pdu)[0] = op->opcode;
-	if (pdu_len > 1)
-		memcpy(op->pdu + 1, pdu, length);
+	iov.iov_base = op->pdu;
+	iov.iov_len = 0;
+
+	util_iov_push_u8(&iov, op->opcode);
+	if (length && pdu)
+		util_iov_push_mem(&iov, length, pdu);
 
 	if (!sign || !(op->opcode & ATT_OP_SIGNED_MASK) || !att->crypto)
 		return true;
@@ -364,8 +369,13 @@ static bool encode_pdu(struct bt_att *att, struct att_send_op *op,
 	if (!sign->counter(&sign_cnt, sign->user_data))
 		goto fail;
 
-	if ((bt_crypto_sign_att(att->crypto, sign->key, op->pdu, 1 + length,
-				sign_cnt, &((uint8_t *) op->pdu)[1 + length])))
+	sig = util_iov_push(&iov, BT_ATT_SIGNATURE_LEN);
+	if (!sig)
+		goto fail;
+
+	if ((bt_crypto_sign_att(att->crypto, sign->key, op->pdu,
+				iov.iov_len - BT_ATT_SIGNATURE_LEN,
+				sign_cnt, sig)))
 		return true;
 
 	DBG(att, "ATT unable to generate signature");
@@ -978,7 +988,7 @@ static void respond_not_supported(struct bt_att *att, uint8_t opcode)
 
 static bool handle_signed(struct bt_att *att, uint8_t *pdu, ssize_t pdu_len)
 {
-	uint8_t *signature;
+	struct iovec iov = { pdu, pdu_len };
 	uint32_t sign_cnt;
 	struct sign_info *sign;
 	uint8_t opcode = pdu[0];
@@ -991,8 +1001,10 @@ static bool handle_signed(struct bt_att *att, uint8_t *pdu, ssize_t pdu_len)
 	if (!sign)
 		goto fail;
 
-	signature = pdu + (pdu_len - BT_ATT_SIGNATURE_LEN);
-	sign_cnt = get_le32(signature);
+	/* Skip to the signature trailer, the counter is its first field */
+	if (!util_iov_pull(&iov, pdu_len - BT_ATT_SIGNATURE_LEN) ||
+			!util_iov_pull_le32(&iov, &sign_cnt))
+		goto fail;
 
 	/* Validate counter */
 	if (!sign->counter(&sign_cnt, sign->user_data))
-- 
2.56.0

