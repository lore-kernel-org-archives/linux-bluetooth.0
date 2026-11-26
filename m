Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686914;
	b=cPO/DDLqRHuiaNjFQWEs3vaQFEU09NCiTGlsGAREZhUGuiNT8YEBO/JjgIbHXz0jBV5w
	 LLkRJMEyjJskdULZ9OU4ME6qEne6SpASCBtT24hmH3400DChxi6bkpyaLtcQR3hOcv2RW
	 fiXMrZEBnP1ii7s9sJx4cSelNEMJZChFbR30zb3VaPyqzXDiVsDTdFuT5BeQ9btNa+Uek
	 s4WyEB6x03jzNLETPRCzsjCVSmsMIa3CvBba/ZE86n2q4LgGKuawq030cK7rd2BVWQurb
	 o0P00xAPFrMb6XnimNOZI8Tpj00pb8sPTyBdfHAM0205Q05MjAlCCTZohPLfbynfGXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686914;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=cxMTvhp4KxMIv3AS2FQ2cXDvfB1lJLgMGFyMw3+XA1U=;
	b=dbqMjp+4HEHQy89ifN3wHtTk1gKJRpG00nNkv59yZaMdpoOSpPcjT8qhksAdtsC1LIoY
	 03FjHTGqr1vqBVtWQd4IHuReyfxRwJBOyt+9X/pV2NR3rmlidpZQJs5VKY0MUO/iKddOY
	 9RUd8t6q3MhtX9pDqzh2jCv4qzCcMi0sLN3NK0DKrmtV69fE34JwkX+0sdui93tfHi7TC
	 JkFOo0QeWf3lGhwEkPcn0Grtn2SY0ypht8kQDTQO8vXstJqnJ/1VNjuJXD+NwqsNKP7Jw
	 AdfahOWC1RM142EgrxssB5ZECTGkTumdCd4I5KopeWpluBp9j1BJkvv0oruHSQ193/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sadiqpk.org;
	spf=pass smtp.mailfrom=sadiqpk.org;
	dkim=pass header.d=sadiqpk.org header.i=@sadiqpk.org header.a=rsa-sha256 header.s=MBO0001 header.b=AQqXACsc;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B754606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 09:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B754606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sadiqpk.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sadiqpk.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sadiqpk.org header.i=@sadiqpk.org header.a=rsa-sha256 header.s=MBO0001 header.b=AQqXACsc
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jZsNZ41ryz8sgZ;
	Thu, 26 Nov 2026 10:55:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sadiqpk.org; s=MBO0001;
	t=1795686910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cxMTvhp4KxMIv3AS2FQ2cXDvfB1lJLgMGFyMw3+XA1U=;
	b=AQqXACsceLz1m2k6drfGk9LsFfNk0PqCAsU1iJUtfNhKdMBtyrg3TWC3QnvxxWyJXTtfX3
	W1/JI974LbznJSKaGN6R/2xG7AW+Tr4PtaJ3WlzUNkfNiH7O1AoAHS8QdvYlpLI14B/vhJ
	oHavPhPFN89EJh0TPP9ZzNxe5AvyGhpPUCDlZGDsWgVDuSJq4WDh3ydwfI0QIZJ3qfg3E9
	Zp6qr2PHLTRy4ex+kUYg/288lheh393N3GMr3S2ewnxKm0sgRePaSn0o/jz4vWrc0hfzvo
	NYhm8MndE0qZhws+UaCtbejCAl3LysF68YpiKEfCUwXWGm0japO4TVGZpw7SmA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of sadiq@sadiqpk.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=sadiq@sadiqpk.org
From: Mohammed Sadiq <sadiq@sadiqpk.org>
To: linux-bluetooth@vger.kernel.org
Cc: Mohammed Sadiq <sadiq@sadiqpk.org>
Subject: [PATCH BlueZ] obexd/map: Populate new messages with event data
Date: Thu, 26 Nov 2026 15:24:39 +0530
Message-ID: <20261126095439.2113609-1-sadiq@sadiqpk.org>
X-Mailer: git-send-email 2.47.3
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
X-Rspamd-Queue-Id: 4jZsNZ41ryz8sgZ

notifications for new messages shall contain various details which are
already being parsed by mns.c, but are ignored when creating the message
object.

Fill new messages with those details from the notification event received,
if available.
---
 obexd/client/map.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 6702aa333..e9dc198e2 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -2069,7 +2069,16 @@ static void map_handle_new_message(struct map_data *map,
 	if (msg)
 		g_hash_table_remove(map->messages, &event->handle);
 
-	map_msg_create(map, event->handle, event->folder, event->msg_type);
+	msg = map_msg_create(map, event->handle, event->folder,
+							event->msg_type);
+
+	if (msg) {
+		parse_datetime(msg, event->datetime);
+		parse_subject(msg, event->subject);
+		parse_sender(msg, event->sender_name);
+		if (event->priority)
+			parse_priority(msg, event->priority);
+	}
 }
 
 static void map_handle_status_changed(struct map_data *map,
-- 
2.47.3

