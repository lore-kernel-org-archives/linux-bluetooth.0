Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792468623;
	b=5D9dhuhZ2UlIeDZYUpBh2ZKQIpjkW/iXUebr/vTGH0WWLPu3fJplzw8g65Tf2rSgNPt+
	 +gCMSlAyk42XHQdDToZv63s4rmQZdmyI+iw4y0Is1uyxf9mfEM3kPU3gAh6E6q4ps4pms
	 /42Nl7ztHbNMv7GlVMgNwQ28jBiBYveSeqUJ9KiZEbixl5mlsK9bTB4aAnlmP/qZBE7LC
	 Q6igdhKB0FNOx6SzvWM7EfO1gUEUk1zB4K8+gSa7HQO3pC8Vo28md3EF+XeUcuMBe0zcB
	 DX9GFFBbikxGe+lh/eTmXqDheyRgUt8nfFRdIRHT82kP/+NewpFrPE0dIy/9v+xRXyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792468623;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=m7qg2VtC9EGCcaTyRCExQWAQz+km7u/Yezoq//C5ejw=;
	b=dlua5/YDun60k1VmlIfPMZipsPMyksJHBb8c1MkxJdaBbuwC5tHz/6g8XYGyvUjF11/w
	 lRGhRjop2byaVAG05Qfv+7TixGkQTGI/UavhBWMWOH4WtYMM1aMkrIl85KZZNWZE7Qsyq
	 2oG/c2c8b9zSiRQ5LjAuRC84RL7kOdckZgabZofbh56voE9pa0u1Yxtyw2iLpSrJUlNkR
	 VUUSybhBTd6M5GW+FYqZPaf3rYa+8ml9/3RRL9F9Nnp3fBcufpoVLZkIEBjprRv7Fw/cY
	 FqzYjioL5jG7oCEO9HWe+oCZ8wm8d5bAIPr9h+p74C1akeYEzwEOMRqbCojChrFpc8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sadiqpk.org;
	spf=pass smtp.mailfrom=sadiqpk.org;
	dkim=pass header.d=sadiqpk.org header.i=@sadiqpk.org header.a=rsa-sha256 header.s=MBO0001 header.b="N8OPKyQ/";
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C29606A319
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 03:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63C29606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sadiqpk.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sadiqpk.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sadiqpk.org header.i=@sadiqpk.org header.a=rsa-sha256 header.s=MBO0001 header.b=N8OPKyQ/
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j7zBF2BPhzKnQs;
	Tue, 20 Oct 2026 05:56:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sadiqpk.org; s=MBO0001;
	t=1792468613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m7qg2VtC9EGCcaTyRCExQWAQz+km7u/Yezoq//C5ejw=;
	b=N8OPKyQ/Et9a5CE6xp2FYmo/jfIOWobfbFarbUK++1KuP2VyLvY0vUDBojOAMSwn4e7Bna
	gXgOzDMbpU3fTvAQlAGOcU697lXTGF0e9l5eNpm5+tl4NHJINyHQQLziLvKU8iRiD/3wsb
	OXEQQg2QP37WPoj9frMBKOLEtt260t8YhgiHHV4Gq+g9B+gYz406kSeiKbJVU4HFZcNBLB
	Qy2967i+WLha9dCPWFft+etP+NrR9hrqYeAjiNPfALSL9AFCcSVsB16GeVTq/rFSXkasTe
	S+LJchC37Uxg2qkxLhzALUTOLvD4kkkJWVpeMHCjHXt03qsTobFDOILXdMzrIQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of sadiq@sadiqpk.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=sadiq@sadiqpk.org
From: Mohammed Sadiq <sadiq@sadiqpk.org>
To: linux-bluetooth@vger.kernel.org
Cc: Mohammed Sadiq <sadiq@sadiqpk.org>
Subject: [PATCH BlueZ] obexd: Handle message read status change events
Date: Tue, 20 Oct 2026 09:26:17 +0530
Message-ID: <20261020035617.1089331-1-sadiq@sadiqpk.org>
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
X-Rspamd-Queue-Id: 4j7zBF2BPhzKnQs

obexd is advertised to support Extended Event Report 1.1.  But it was
not handling "ReadStatusChanged" type which made those events being
mismarked as MAP_ET_NEW_MESSAGE.  This resulted in existing message to
be replaced by new message with only "Status" property set instead of
updating the "Status" of the existing message.
---
 obexd/client/map-event.h | 3 ++-
 obexd/client/map.c       | 3 +++
 obexd/client/mns.c       | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/obexd/client/map-event.h b/obexd/client/map-event.h
index bb127b0f4..ab185eadf 100644
--- a/obexd/client/map-event.h
+++ b/obexd/client/map-event.h
@@ -19,7 +19,8 @@ enum map_event_type {
 	MAP_ET_MEMORY_FULL,
 	MAP_ET_MEMORY_AVAILABLE,
 	MAP_ET_MESSAGE_DELETED,
-	MAP_ET_MESSAGE_SHIFT
+	MAP_ET_MESSAGE_SHIFT,
+	MAP_ET_READ_STATUS_CHANGED
 };
 
 struct map_event {
diff --git a/obexd/client/map.c b/obexd/client/map.c
index 955db9315..487354252 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -2148,6 +2148,9 @@ static void map_handle_notification(struct map_event *event, void *user_data)
 	case MAP_ET_MESSAGE_SHIFT:
 		map_handle_folder_changed(map, event, event->folder);
 		break;
+	case MAP_ET_READ_STATUS_CHANGED:
+		map_handle_status_changed(map, event, "read-status-changed");
+		break;
 	case MAP_ET_MEMORY_FULL:
 	case MAP_ET_MEMORY_AVAILABLE:
 	default:
diff --git a/obexd/client/mns.c b/obexd/client/mns.c
index c7f86afdc..6408e48d3 100644
--- a/obexd/client/mns.c
+++ b/obexd/client/mns.c
@@ -168,6 +168,8 @@ static void parse_event_report_type(struct map_event *event, const char *value)
 		event->type = MAP_ET_MESSAGE_DELETED;
 	else if (!g_ascii_strcasecmp(value, "MessageShift"))
 		event->type = MAP_ET_MESSAGE_SHIFT;
+	else if (!g_ascii_strcasecmp(value, "ReadStatusChanged"))
+		event->type = MAP_ET_READ_STATUS_CHANGED;
 }
 
 static void parse_event_report_handle(struct map_event *event,
-- 
2.47.3

