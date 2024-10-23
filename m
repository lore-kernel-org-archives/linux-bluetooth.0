Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784B41B86F7
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692054; cv=none; b=EUoidAv+YHXU1FWoqnHtTmHbhNGBHKewspUUICqlFs6cYQXAJ9cFSWDd/ougz9g+yjf2hNoJXJqH0QEol4dKNTGH1N/AlLubvHsIpAsy8bLy/EzXo8YjL6wHZzPGN6vjEJrydkxQnzxZqgELDDO8Gb4wvat8hBM9dS6o/oFYJ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692054; c=relaxed/simple;
	bh=l9d99mG6yGPvA8PBQAfQjjwYYGmW27IQUc29BEA577E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SJmZZ3h9NlLT6Yzsho2b01A7T4eKHfgegop5VqFnjPn91VNlbE2Vk7CWvjpwVe4g5vX47Q28YBLHUW886bbp1cG/I5xU5siGhGihn47PUYCRHTvDtKvCoX2bp8jKD+B+1kOpOg7tY8/ebx2pIJmRz6C3OUOykIcXZaPmGuF5X5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH6LG6S6; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH6LG6S6"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4a487a7519fso1954404137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729692051; x=1730296851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V1sxamB/Y6CbdKZl/8YUMfAL9hCw16eFxBbeaUNzhN4=;
        b=PH6LG6S6c8p1oPSYp8YHmqQS8CREp0/hlztovItmrij6MIFz+ELwTe1gpx8qnMMrlY
         YHunmhwUV5RLJqDoHs4ouvYxSHa9EaeziBj/1+ft+3E6/0pU4Fe4sKB7kqKZgLy5wPRt
         hlyuICYgoeA7HFZRV0X1eivQXwvWEceV/Mam6H5A8fuTWA8EZFMFhdt1YpU/tsYceYCv
         A40vsGHGxnDt2SIorHv2NElJ/ryetMoTRU1QqeXBxRur8IW3EP57kqASb7HxlTawj9Qt
         qFVqWOGVd/bo/IKZQ4RVRU97/vOLNuNqYwnyxTebm8UmJCppGvukbju5hl7ja4SvitgF
         XAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692051; x=1730296851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1sxamB/Y6CbdKZl/8YUMfAL9hCw16eFxBbeaUNzhN4=;
        b=eC8o6PksueJjaNcF/npsfdAyzH6acHYZz+XbtSr0fYDjUGAluJMt25eVKw9HQ1Xi9O
         kqv/cNogtGiXRSWdWnniHajYo6JaDoQ/u6dpMx3M98S7+UnQCflUJf9kvC7i0FT/djSG
         l9GMi3q88OZOB/O6s9owBLhw7pjksd9E1IqhXpkh1abNbdT9iwGGlIKUH/tbkcksG+Kh
         wvE5J7Iqs3rmHYrzE9nRXl/9sL2tONJyPL/OJ73MNPfCkAe1BSUIXC+sf5KkqyGkUpus
         s3tyg+mbYl7xwxBPtIzXtGxBkDKADoTE+v0TrY8qUhlAbBlcgvWc45i2NxXAKrdhGwW4
         511A==
X-Gm-Message-State: AOJu0YxcIBSwGRr5HhvUQ3u4GmIViC7fpoCtfxW2J47bG2at40OwdtEI
	ElYrjntes0IXIUmNF3x5vMXzsov3SJq0Ak9DDmynz0twNhXJF0tpHBW4Ig==
X-Google-Smtp-Source: AGHT+IFZNIrL0kvMwD7Etq0J+iurcZbWJOIg1VCNHpb90ba5XIMmoREK22mOEy/rlmPMeSE2xADPEA==
X-Received: by 2002:a05:6102:ccd:b0:4a4:7312:9131 with SMTP id ada2fe7eead31-4a751c0c27emr3362711137.15.1729692047144;
        Wed, 23 Oct 2024 07:00:47 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a5f0d2edb2sm1240120137.23.2024.10.23.07.00.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 07:00:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/bap: Fix crash on bt_bap_stream_disable
Date: Wed, 23 Oct 2024 10:00:42 -0400
Message-ID: <20241023140042.2249809-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Calls to bt_bap_stream_disable with unicast stream shall result in
stream_disable if when acting as a server (!stream->client) otherwise it
may lead to the following trace:

bluetoothd[104990]: src/shared/bap.c:bap_queue_req() req 0x555555732470 (op 0x05) queue 0x55555571e850
bluetoothd[104990]: src/gatt-database.c:send_notification_to_device() GATT server sending notification
bluetoothd[104990]: src/shared/bap.c:stream_notify_state() stream 0x55555571b7f0
bluetoothd[104990]: src/shared/bap.c:stream_notify_qos() stream 0x55555571b7f0
bluetoothd[104990]: src/gatt-database.c:send_notification_to_device() GATT server sending notification
bluetoothd[104990]: src/shared/bap.c:bap_process_queue()
bluetoothd[104990]: src/shared/bap.c:bap_send() req 0x555555732470 len 3

Program received signal SIGSEGV, Segmentation fault.
bap_send (bap=bap@entry=0x555555730c50, req=req@entry=0x555555732470) at src/shared/bap.c:1490

Fixes: https://github.com/bluez/bluez/issues/991
---
 src/shared/bap.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 00c3b9ff6a1b..8d04290f88ae 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1872,6 +1872,27 @@ static unsigned int bap_ucast_start(struct bt_bap_stream *stream,
 	return req->id;
 }
 
+static uint8_t stream_disable(struct bt_bap_stream *stream, struct iovec *rsp)
+{
+	if (!stream || stream->ep->state == BT_BAP_STREAM_STATE_QOS ||
+			stream->ep->state == BT_BAP_STREAM_STATE_IDLE)
+		return 0;
+
+	DBG(stream->bap, "stream %p", stream);
+
+	ascs_ase_rsp_success(rsp, stream->ep->id);
+
+	/* Sink can autonomously transit to QOS while source needs to go to
+	 * Disabling until BT_ASCS_STOP is received.
+	 */
+	if (stream->ep->dir == BT_BAP_SINK)
+		stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
+	else
+		stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
+
+	return 0;
+}
+
 static unsigned int bap_ucast_disable(struct bt_bap_stream *stream,
 					bool disable_links,
 					bt_bap_stream_func_t func,
@@ -1881,6 +1902,9 @@ static unsigned int bap_ucast_disable(struct bt_bap_stream *stream,
 	struct bt_ascs_disable disable;
 	struct bt_bap_req *req;
 
+	if (!stream->client)
+		return stream_disable(stream, NULL);
+
 	memset(&disable, 0, sizeof(disable));
 
 	disable.ase = stream->ep->id;
@@ -2790,27 +2814,6 @@ static uint8_t ascs_start(struct bt_ascs *ascs, struct bt_bap *bap,
 	return ep_start(ep, rsp);
 }
 
-static uint8_t stream_disable(struct bt_bap_stream *stream, struct iovec *rsp)
-{
-	if (!stream || stream->ep->state == BT_BAP_STREAM_STATE_QOS ||
-			stream->ep->state == BT_BAP_STREAM_STATE_IDLE)
-		return 0;
-
-	DBG(stream->bap, "stream %p", stream);
-
-	ascs_ase_rsp_success(rsp, stream->ep->id);
-
-	/* Sink can autonomously transit to QOS while source needs to go to
-	 * Disabling until BT_ASCS_STOP is received.
-	 */
-	if (stream->ep->dir == BT_BAP_SINK)
-		stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
-	else
-		stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
-
-	return 0;
-}
-
 static uint8_t ep_disable(struct bt_bap_endpoint *ep, struct iovec *rsp)
 {
 	struct bt_bap_stream *stream = ep->stream;
-- 
2.47.0

