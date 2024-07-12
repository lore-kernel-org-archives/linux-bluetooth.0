Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9BFBE65
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2024 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813107; cv=none; b=cCXnwotBhvnLRw6nILlBkdQJzxDSBxjCQUsX0UlNfmWC4zRvOMyn3n5ypANWdgtFapSJ3IheokzIcUzwbObWU0rbfG5GFXezngPqpPo26kdwpUdz9fl1mB7EnqLSIQYWynkcsIiQ5ylHgerNeHOPhzk1+9sOz1bnX/tH1LuEhs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813107; c=relaxed/simple;
	bh=XhMtCADAAjltZksOMed/KsW/+pTLz7DkU1xxMDkJDzk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=T1MHD4dBaZppP8U9DbaCO21d5yHuJKfUUru29sT3MTUKKU1Jizdokv6BvYSjPlfmLnGivxI7Hm1GfigCrPmEzdErb3vRrMSjf+QBXKZdVtoAFWcOvkMU1EJI6cd5v0nnxaQIxgWe4INhHDtY4w/zFYuODgIbPcdSXgNM5GPFipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEuPemX/; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEuPemX/"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f2ec49e067so795878e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2024 12:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720813102; x=1721417902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KhVQRYOO4ydZcpN7jrCC8ZvRuqfzFGOskRfGsgGrylA=;
        b=iEuPemX/oq6YfvBakW2REsCMrQVkZOyrE1+0nndRCEd3TZDtlhFyQ27s5Imy+pL6xm
         4gzQX1WRut+B0VQMVuJ0ndv+SAhd9icxqHbpuSE+SICOPsIQ2PFmc6d71f8KseaQmVKy
         noQve0l1V7pWApYx/xdShRZuZbRmEr+nMI/tOELpR6ghOTCge5etOyZXs8FYpkAx3doL
         pp94Fd/iFTm6lZ/zkHPTje4ybqswmmzueasyP6eWxSwiWIu7CBU7jO/xhxWM8Ac59HGW
         etib/qhMvHf0JM1fD3rjWwftXU3OWzgw8CJyEp5ZLGuyi8iL/jd2lP0vXjm4WOHZsaWq
         sbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720813102; x=1721417902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhVQRYOO4ydZcpN7jrCC8ZvRuqfzFGOskRfGsgGrylA=;
        b=SBSGK0C5nUnjnfZ1Cjd3Vd9jsiJqV5toK8/w3RxIABYTDdhAM5ihU34m+VTPVJYJ3F
         9FS9zTw8+qVhOiwtCKnLgDYI45m1GYo1ix7bjER0XzMUhbMiWJR9Aarw5Wi1SNbtdIGP
         jRO9zE0vQICrgIcBoDTWvsLfgky19Q8J7kJ8yxMxmyRraSHiBfVfSPNRv6Ojp9m/lGvb
         dGB1KnsEky7YK2QGrpba8hzwhxkz305AqNmbBEa17WAeAMdKHSJgbaItBmoZVb0I7UMj
         r67376/rdQPxMJrLwaEoDAsCLrZQMkVqOAaIJdJC1oPn3eXvgIe2UZATuUf+V5qCUyR5
         x4cQ==
X-Gm-Message-State: AOJu0YxoDkmBpX2N7jzUWhAqcdZmzNbGUvvy0DnBfkcXTzSUaJfB/YYy
	l1u6UWhtAJXntanbft4RfvdT6UST8wAQVKyHu7RaEjHPONHCp83VqGA8Qg==
X-Google-Smtp-Source: AGHT+IHtBFDqyPyr3PKdrW2WtguZjOjNWpQy8htc62LD6JIR+5XsU4G4NMXtY6CnieIlJ25Cdn8+rw==
X-Received: by 2002:a05:6122:4109:b0:4d3:36b9:2c26 with SMTP id 71dfb90a1353d-4f33f31b0abmr15854648e0c.14.1720813102400;
        Fri, 12 Jul 2024 12:38:22 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f33dafcad9sm1313202e0c.53.2024.07.12.12.38.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 12:38:21 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/bap: Fix ASE notification order
Date: Fri, 12 Jul 2024 15:38:20 -0400
Message-ID: <20240712193820.3945762-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When processing a CP operation the CP shall be notified ahead of
the ASE itself:

  'If the server successfully completes a client-initiated ASE Control
  operation for an ASE, the server shall send a notification of the ASE
  Control Point characteristic value formatted as defined in Table 4.7.
  The server shall then perform the behavior defined in Section 5.1
  through Section 5.8 for that ASE Control operation and send
  notifications of any ASE characteristic values written during that
  ASE Control operation.'

So this delays the processing of notifications of ASE states so the CP
responses always appears first in the notification e.g:

> ACL Data RX: Handle 42 flags 0x02 dlen 59
      ATT: Handle Multiple Value Notification (0x23) len 54
        Length: 0x0008
        Handle: 0x0036 Type: ASE Control Point (0x2bc6)
          Data[8]: 0202030000010000
            Opcode: QoS Configuration (0x02)
            Number of ASE(s): 2
            ASE: #0
            ASE ID: 0x03
            ASE Response Code: Success (0x00)
            ASE Response Reason: None (0x00)
            ASE: #1
            ASE ID: 0x01
            ASE Response Code: Success (0x00)
            ASE Response Reason: None (0x00)
        Length: 0x0011
        Handle: 0x0030 Type: Source ASE (0x2bc5)
          Data[17]: 0302000010270000022800020a00409c00
            ASE ID: 3
            State: QoS Configured (0x02)
            CIG ID: 0x00
            CIS ID: 0x00
            SDU Interval: 10000 usec
            Framing: Unframed (0x00)
            PHY: 0x02
            LE 2M PHY (0x02)
            Max SDU: 40
            RTN: 2
            Max Transport Latency: 10
            Presentation Delay: 40000 us
        Length: 0x0011
        Handle: 0x002a Type: Sink ASE (0x2bc4)
          Data[17]: 0102000010270000025000020a00409c00
            ASE ID: 1
            State: QoS Configured (0x02)
            CIG ID: 0x00
            CIS ID: 0x00
            SDU Interval: 10000 usec
            Framing: Unframed (0x00)
            PHY: 0x02
            LE 2M PHY (0x02)
            Max SDU: 80
            RTN: 2
            Max Transport Latency: 10
            Presentation Delay: 40000 us
---
 src/shared/bap.c | 53 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 3a4c1f9d3a98..d59eac8cca16 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -169,6 +169,7 @@ struct bt_bap {
 	unsigned int process_id;
 	unsigned int disconn_id;
 	unsigned int idle_id;
+	bool in_cp_write;
 
 	struct queue *reqs;
 	struct queue *notify;
@@ -266,6 +267,7 @@ struct bt_bap_stream {
 	const struct bt_bap_stream_ops *ops;
 	uint8_t old_state;
 	uint8_t state;
+	unsigned int state_id;
 	bool client;
 	void *user_data;
 };
@@ -1102,6 +1104,8 @@ static void bap_stream_free(void *data)
 {
 	struct bt_bap_stream *stream = data;
 
+	timeout_remove(stream->state_id);
+
 	if (stream->ep)
 		stream->ep->stream = NULL;
 
@@ -1579,20 +1583,17 @@ static bool bap_queue_req(struct bt_bap *bap, struct bt_bap_req *req)
 	return true;
 }
 
-static void bap_ucast_set_state(struct bt_bap_stream *stream, uint8_t state)
+static bool stream_notify_state(void *data)
 {
+	struct bt_bap_stream *stream = data;
 	struct bt_bap_endpoint *ep = stream->ep;
 
-	ep->old_state = ep->state;
-	ep->state = state;
+	DBG(stream->bap, "stream %p", stream);
 
-	DBG(stream->bap, "stream %p dir 0x%02x: %s -> %s", stream,
-			bt_bap_stream_get_dir(stream),
-			bt_bap_stream_statestr(stream->ep->old_state),
-			bt_bap_stream_statestr(stream->ep->state));
-
-	if (stream->lpac->type == BT_BAP_BCAST_SINK || stream->client)
-		goto done;
+	if (stream->state_id) {
+		timeout_remove(stream->state_id);
+		stream->state_id = 0;
+	}
 
 	switch (ep->state) {
 	case BT_ASCS_ASE_STATE_IDLE:
@@ -1610,6 +1611,31 @@ static void bap_ucast_set_state(struct bt_bap_stream *stream, uint8_t state)
 		break;
 	}
 
+	return false;
+}
+
+static void bap_ucast_set_state(struct bt_bap_stream *stream, uint8_t state)
+{
+	struct bt_bap_endpoint *ep = stream->ep;
+
+	ep->old_state = ep->state;
+	ep->state = state;
+
+	DBG(stream->bap, "stream %p dir 0x%02x: %s -> %s", stream,
+			bt_bap_stream_get_dir(stream),
+			bt_bap_stream_statestr(stream->ep->old_state),
+			bt_bap_stream_statestr(stream->ep->state));
+
+	if (stream->client)
+		goto done;
+
+	if (!stream->bap->in_cp_write)
+		stream_notify_state(stream);
+	else if (!stream->state_id)
+		stream->state_id = timeout_add(BAP_PROCESS_TIMEOUT,
+						stream_notify_state,
+						stream, NULL);
+
 done:
 	bap_stream_state_changed(stream);
 }
@@ -3069,8 +3095,15 @@ static void ascs_ase_cp_write(struct gatt_db_attribute *attrib,
 
 		DBG(bap, "%s", handler->str);
 
+		/* Set in_cp_write so ASE notification are not sent ahead of
+		 * CP notifcation.
+		 */
+		bap->in_cp_write = true;
+
 		for (i = 0; i < hdr->num; i++)
 			ret = handler->func(ascs, bap, &iov, rsp);
+
+		bap->in_cp_write = false;
 	} else {
 		DBG(bap, "Unknown opcode 0x%02x", hdr->op);
 		ascs_ase_rsp_add_errno(rsp, 0x00, -ENOTSUP);
-- 
2.45.2

