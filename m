Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.69.30.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794111612;
	b=Rewavxl7sR95f1QAEh06hcjeXx3m0KDoTGFNGvTlMT3kMccgRPDxHUd4d55WgE/jvlvL
	 6UNKWrAJLfCwMN63xyWOVpm48cst+8EPmieErIf9f/R3V2C4v2HBHSXsTqum4PUniAuCf
	 fkD7hbbKk4cY3yIpF2DHbDLQEIhpy2AG6ESI8rlgBhYqRGAQAizfd7hQ7EhO/zJxClsID
	 dDhBrz/MMXo3yXRglKnCvuGtCT06pUsVSEEBWI2/vGeeK85kzeDUPZJmhCPUTbpd9ONoc
	 aY3HPMk4x0yD15aFcEqc2ByHh1RMhBdkXrfg4dLzISZWPa5UJIdcip0DDOjGrCcwQPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794111612;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=P5wjwTweeB4uSgju3y4R3MfnL8tG0LbUuhk6pEANCaA=;
	b=20KpN0lJtaHpc8WSoRNt/es0AsEcmkeVN2Yg1kjy/m/jrZ8CQaf32laCs+aFH9wjhxqL
	 C+O8r2q9Iyn2j4lDEeuV+j/mSBYyRrkKxfg/6U/wAmPJPMD2Qc4296zwiQ/mxxnDNS8Ik
	 DPKKHOJCjGGT31Ogt+Fql7hoVuZYYx7L2q5Y3e5ybl8J3JYTXi+Up31+IYusSTLLzGFRv
	 StvUwBJb5UhIhkDJTVUQFCzmb+tJvVzJMqlYzYQ23KW+vh7ssoSOkhO25Z2xliQ2zTPOQ
	 5RBCpA/cbhJW88FIqbbGLrnBiAsWk8WRQ+M2w6McLa6SbO9H6SChCMPDKiveoUvRsxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=freenixos.com;
	spf=pass smtp.mailfrom=freenixos.com;
	dkim=pass header.d=freenixos.com header.i=@freenixos.com header.a=rsa-sha256 header.s=mail header.b=KjSTir3i;
	arc=none smtp.remote-ip=54.69.30.187
Received: from mail.freenixos.com (mail.freenixos.com [54.69.30.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2759606A31A;
	Sun,  8 Nov 2026 04:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2759606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenixos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenixos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=freenixos.com header.i=@freenixos.com header.a=rsa-sha256 header.s=mail header.b=KjSTir3i
From: Hex Lindqvist <hex@freenixos.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freenixos.com;
	s=mail; t=1794111610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P5wjwTweeB4uSgju3y4R3MfnL8tG0LbUuhk6pEANCaA=;
	b=KjSTir3ii2wmBI/AsBKxFmmAWNjdD4h3As+LluTyaugqCP63wEEmF6tpQwdq1G6k+8voB8
	1AVSjP+YfpRKsrveNuwraDx0Cy5eodGKGXH5pCAEA/r3TS2XuKuy8PiJAvojOO3XjC3xwa
	+3mwenhbQF4BKrhQd2KfEwoyeG9V5dyPCFK/LtqVb+QL17t+t9HU/6NVGqec+45LPC1hJT
	tbJ5fncGfDJWK/oAA8R3b5/k1rXeel+62k9SuDGNXhxr2oFG1AUOhqsM2RgdmzLLOUsXmo
	iaXZle6HpnPQXBb++KdjoTeHXU63B/TlLK/opGSllxGnseljIM8Huz76pPwuBg==
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun.hu@oss.qualcomm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Use DECLARE_FLEX_ARRAY() for memdump segment data
Date: Sat,  7 Nov 2026 20:20:08 -0800
Message-ID: <20261108042008.226295-1-hex@freenixos.com>
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

struct qhci_vse_memdump declares segdata as a zero-length array in a
union. Zero-length arrays are deprecated [1], so use DECLARE_FLEX_ARRAY()
instead.

No functional change: segdata is only used with offsetof(). With debug
info stripped, btusb.o is byte-for-byte identical before and after,
built with GCC 16 and Clang 21 on x86_64 and GCC 16 on arm64, with
UBSAN_BOUNDS and FORTIFY_SOURCE enabled.

An AI assistant helped find and check this change and drafted this
message.

Link: https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays [1]
Signed-off-by: Hex Lindqvist <hex@freenixos.com>
---
 drivers/bluetooth/btusb_qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb_qcom.c b/drivers/bluetooth/btusb_qcom.c
index cc4cfcde2afa..97be9078e045 100644
--- a/drivers/bluetooth/btusb_qcom.c
+++ b/drivers/bluetooth/btusb_qcom.c
@@ -533,7 +533,7 @@ struct qhci_vse_memdump {
 	__le16 seqno;
 	u8     subsys;
 	union {
-		u8 segdata[0];
+		DECLARE_FLEX_ARRAY(u8, segdata);
 		struct {
 			__le32 dump_size;
 			u8 first_segdata[];

base-commit: ebdfe8561b5496b7eafedccd13a000a7261bc52b
-- 
2.56.0

