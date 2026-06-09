Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3837268F
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040431; cv=none; b=TiWUMGtTTQQ41PP/End8HtmDktRVA07fRO2IG89l5HdugCb9/X4pj0nHo0oJz+mpQ+ok9cwAreHjHn+DcA6jIgeay25rxLpokpdXIqShCBXgGCFqr6YQFuKkbWGOGboAHzOxluaZZ88agEEwqO1aLZif9hJFDqAahbwDFCv14hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040431; c=relaxed/simple;
	bh=/+jGkkj/7JUjzSj6CQ3QPsXLLUw78o/GUOLRsBc01BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qn8e1omSNzQFwYPGXvUMgnpSssq0BlRvYxLf20nmLEgmGUIZvUtj+xj4j3aetMTwl/GjPp1vNWbXQm3+LxMsanoYSE5gKeKTeucRySDkDZ36bvhosmc2sYeON97dgpDgMS487uFhLhhXvfHxx3+CwATMCnKTbqRLxfj7V8dLBn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=xmgndfQ0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="xmgndfQ0"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso50237045e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 14:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781040428; x=1781645228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFRNTmR+YZqxY27sYWgVXnxvuoz8WXSmcQC62s72+bE=;
        b=xmgndfQ0YS7TxRD64QGMhloia1eyDsq9bOPGJSBx5GPXuMvaaBWoa2Z8Qml4XpKnR/
         7W6fSKt1dX4kh1Kz6A04te+GU2XwbmwDF+TzGNVslgXmLymown8qNQOiKSABH2NHfgWq
         rTEyoLQQS1mAqT2Fy15ij+fjd6Yk2MzUjtJwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781040428; x=1781645228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFRNTmR+YZqxY27sYWgVXnxvuoz8WXSmcQC62s72+bE=;
        b=ig6N7BLlCAQhb6xKQNEghHiN0sAa2h7+ex4wfRJZf645iEcArH/C0azNheB0ybB/Pm
         /ClWNzT6iU8A4BcOLxijM1Emdxz9X4ZI40+gBjxg+PktizJGrfTB1sVuzHBgDoaXVYnk
         CARw9AQepmSg21ql6z+Bvet6OjUe6cDPezaO+3x4oYLR23r8e4yzh7pLPDl0KiHvIjTU
         F9hTQUWILbG6O9DD///aEbozRC6AtC0Jw+gVkgomCbdLap8FVWxNbJgF6F2hMXpF2eCF
         pMwXqzn1W3FcRq/KpXs6R526P9P5cTt/2kfwrI8dNS8ar0s8hMZW5/25GGCg5mgwRD3b
         A75A==
X-Gm-Message-State: AOJu0YzQfULerfKRH5piPMTURR31BYqoDvI2WyLM7ImV5tzrDlbQk4No
	8vsB+e9s+p/gOidoRVENMDwdo7kduDy1UWreHH4ijKzewkoq9EVJrYbgSttfN1mNOk37HdkN3Rc
	Jn+Iq
X-Gm-Gg: Acq92OG8AhIERDVl8ns19p2GP+eiwYsbuEzkxzMT+iPGaLxKfuvuryZGxlJVyR1W4VC
	/bj2pMfXztaLR8ku0XgzNx0PjDjROXVXD/HSFVQ9IPZ7nsXkf7z0ZMUyLvsUKXC6ZC4GdGc67kO
	dA73XzcJtUvoZWyUSnsp1lXZS0VcLBjYFdTQ625MSHcdWl30G4Ts8LhbqDNcD5MmpfJ9PpZHBFf
	+tVrKG+Q1rw8sUSiKmz/hyNz4sOcVPi6Vx4mjyn6mcAv349LGk84cKcq9sge3U5uywZ1PCDdp2q
	EDhh+ZL92TZH2DOcjL8RXqnS6zBL4Hb5+aSEVpsNzn7tkcyk2opBplbSgllLK9PaKYWrL9Vu+Ux
	ufPptN0C1EZg5fJL8jp/ORmG62LkpvIpm+Rmx9LB4N2lHDaEz8LbRpJpmvF9hDbvDRP5O/8cRZS
	ZEDB/j00AsrBdnreX/Q6e8FSNgxIajpRqaQSjvATBUcwIzpXhPwP0+ae0=
X-Received: by 2002:a05:600c:4586:b0:490:5191:6e26 with SMTP id 5b1f17b1804b1-490d7223752mr52563775e9.18.1781040427951;
        Tue, 09 Jun 2026 14:27:07 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:e2e3:d5f1:fbcb:c827])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3918fcsm587514875e9.3.2026.06.09.14.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 14:27:07 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] avrcp: Abort continuing response on fragmented CT replies
Date: Tue,  9 Jun 2026 23:26:56 +0200
Message-ID: <20260609212656.3900190-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Send AbortContinuingResponse when a Get Element Attributes reply
arrives fragmented, as the CT side does not reassemble fragments.

Fixes PTS test AVRCP/CT/RCR/BV-03-C
---
 profiles/audio/avrcp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index b6823753f..56564dcab 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2473,6 +2473,24 @@ static void avrcp_parse_attribute_list(struct avrcp_player *player,
 	}
 }
 
+static void avrcp_abort_continuing(struct avrcp *session, uint8_t pdu_id)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH + 1];
+	struct avrcp_header *pdu = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_ABORT_CONTINUING;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+	pdu->params_len = cpu_to_be16(1);
+	pdu->params[0] = pdu_id;
+
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_CONTROL,
+					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
+					NULL, session);
+}
+
 static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
 						uint8_t code, uint8_t subunit,
 						uint8_t transaction,
@@ -2490,6 +2508,13 @@ static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
 	if (code == AVC_CTYPE_REJECTED)
 		return FALSE;
 
+	/* Abort fragmented responses as reassembly is not supported */
+	if (pdu->packet_type == AVRCP_PACKET_TYPE_START ||
+			pdu->packet_type == AVRCP_PACKET_TYPE_CONTINUING) {
+		avrcp_abort_continuing(session, AVRCP_GET_ELEMENT_ATTRIBUTES);
+		return FALSE;
+	}
+
 	count = pdu->params[0];
 
 	if (be16_to_cpu(pdu->params_len) - 1 < count * 8) {
-- 
2.43.0

