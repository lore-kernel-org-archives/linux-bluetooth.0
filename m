Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DFFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jan 2022 22:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiANWKC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jan 2022 17:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiANWKC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jan 2022 17:10:02 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26977C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 14:10:02 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id n11so12290156plf.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 14:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jLAZSKsgfQZKDfjnqdem8mQfPKe/ptmSW43CQVsj7IM=;
        b=qA5UiTgYIzgmws1CXSzPeQ8fJNxoc7AH78/QW321wXsyNQQ70c4OFqmNhurKzAlNiu
         Z66R7Rr12ix1rjeGOed5lql0pQtlo9SLC/D6VZ4wTWbpx8Q0WSnewP9IXV3nU/qDxuue
         RvwIKSXV9FQkqsNsq3SvkFZZN5tBXz/i4UQyeGlaQR4oCs+efCMtP4MiNx4smIOD4fzp
         LIPfV6eNGEEFwA8LvoOf3504xMbYRRRf1X0igJ3NVG6uz0BATzMAhRz07fywPONb+zT1
         ubOF0HvgVSOexc7KENSnHy8m9vpOuxwQAu1/z4C7zoApNJBskYDiAAFPshF9dJ79Qeui
         M8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLAZSKsgfQZKDfjnqdem8mQfPKe/ptmSW43CQVsj7IM=;
        b=Hkp9o5i4QorON8X/C+2ePmw9MMM3L+Ktbu+vAWSkaEsbXY5j1CVZ/X5Nt+8fZpJil2
         4Jl9wi076lR9MTVC8atbJkW649fcc/QIRyVLhXHyLBNCEArNhuuqOEzouBFeRg2i8xF8
         Ko37iowjj9VQyKN7t7rSCIRmCSLMhSAwcNixa9N4WE4EpmKHu3JrStsqPcLhEP1Ians/
         lYR3dbDybY0fp7bAcQ4IUPELYzFhjcHPt12QOjEtOGQtTVtBFx0JQBGIrWEW4J5Covw0
         iGiM/9lOVSR/i9j9B5hnEUNHG8vh9RVI7e59RnLT88UPt/Xk3FhGrPjh1vbRyEZh/V0G
         q9Yg==
X-Gm-Message-State: AOAM531ZKqr+1tcNZJ+egqFGkEa/rorPIDB58pTkO4Sg26N5vm6487js
        VWvpv6gHk0oBzINPOymE2jfeW1oRdpY=
X-Google-Smtp-Source: ABdhPJzCC29MNRbcN3lQs/+8aCULZypiWI1aXDDn0bKC5HkaRnn1TrO2U53E5rFmPGSy5UC9zgHz6g==
X-Received: by 2002:a17:903:248:b0:149:c231:3e24 with SMTP id j8-20020a170903024800b00149c2313e24mr10910445plh.99.1642198200995;
        Fri, 14 Jan 2022 14:10:00 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k19sm7220081pfu.178.2022.01.14.14.10.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 14:10:00 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] avrcp: Fix unaligned access
Date:   Fri, 14 Jan 2022 14:09:59 -0800
Message-Id: <20220114220959.917157-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220114220959.917157-1-luiz.dentz@gmail.com>
References: <20220114220959.917157-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the access to struct media_attribute_header which needs to
be packed and it also replaces the use of ntohs/ntohl to byteorder
conversion helpers which are a lot more clear on what byteorder shall
be used.
---
 profiles/audio/avrcp.c | 229 ++++++++++++++++++++---------------------
 1 file changed, 111 insertions(+), 118 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index d4e19ffc0..5eb182b76 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -835,7 +835,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 	}
 
 done:
-	pdu->params_len = htons(size);
+	pdu->params_len = cpu_to_be16(size);
 
 	for (l = player->sessions; l; l = l->next) {
 		struct avrcp *session = l->data;
@@ -933,15 +933,17 @@ static uint16_t player_write_media_attribute(struct avrcp_player *player,
 	return attr_len;
 }
 
+struct avrcp_media_attribute_hdr {
+	uint32_t id;
+	uint16_t charset;
+	uint16_t len;
+} __attribute__ ((packed));
+
 static GList *player_fill_media_attribute(struct avrcp_player *player,
 					GList *attr_ids, uint8_t *buf,
 					uint16_t *pos, uint16_t *offset)
 {
-	struct media_attribute_header {
-		uint32_t id;
-		uint16_t charset;
-		uint16_t len;
-	} *hdr = NULL;
+	struct avrcp_media_attribute_hdr *hdr = NULL;
 	GList *l;
 
 	for (l = attr_ids; l != NULL; l = g_list_delete_link(l, l)) {
@@ -953,9 +955,9 @@ static GList *player_fill_media_attribute(struct avrcp_player *player,
 				break;
 
 			hdr = (void *) &buf[*pos];
-			hdr->id = htonl(attr);
+			hdr->id = cpu_to_be32(attr);
 			/* Always use UTF-8 */
-			hdr->charset = htons(AVRCP_CHARSET_UTF8);
+			hdr->charset = cpu_to_be16(AVRCP_CHARSET_UTF8);
 			*pos += sizeof(*hdr);
 		}
 
@@ -963,7 +965,7 @@ static GList *player_fill_media_attribute(struct avrcp_player *player,
 								pos, offset);
 
 		if (hdr != NULL)
-			hdr->len = htons(attr_len);
+			hdr->len = cpu_to_be16(attr_len);
 
 		if (*offset > 0)
 			break;
@@ -1062,7 +1064,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	uint16_t len = ntohs(pdu->params_len);
+	uint16_t len = be16_to_cpu(pdu->params_len);
 	unsigned int i;
 
 	if (len != 1)
@@ -1077,7 +1079,8 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
 							company_ids[i]);
 		}
 
-		pdu->params_len = htons(2 + (3 * G_N_ELEMENTS(company_ids)));
+		pdu->params_len = cpu_to_be16(2 +
+					(3 * G_N_ELEMENTS(company_ids)));
 		pdu->params[1] = G_N_ELEMENTS(company_ids);
 
 		return AVC_CTYPE_STABLE;
@@ -1090,12 +1093,12 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
 			}
 		}
 
-		pdu->params_len = htons(2 + pdu->params[1]);
+		pdu->params_len = cpu_to_be16(2 + pdu->params[1]);
 		return AVC_CTYPE_STABLE;
 	}
 
 err:
-	pdu->params_len = htons(1);
+	pdu->params_len = cpu_to_be16(1);
 	pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 
 	return AVC_CTYPE_REJECTED;
@@ -1114,11 +1117,11 @@ static uint8_t avrcp_handle_list_player_attributes(struct avrcp *session,
 						uint8_t transaction)
 {
 	struct avrcp_player *player = target_get_player(session);
-	uint16_t len = ntohs(pdu->params_len);
+	uint16_t len = be16_to_cpu(pdu->params_len);
 	unsigned int i;
 
 	if (len != 0) {
-		pdu->params_len = htons(1);
+		pdu->params_len = cpu_to_be16(1);
 		pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 		return AVC_CTYPE_REJECTED;
 	}
@@ -1136,7 +1139,7 @@ static uint8_t avrcp_handle_list_player_attributes(struct avrcp *session,
 
 done:
 	pdu->params[0] = len;
-	pdu->params_len = htons(len + 1);
+	pdu->params_len = cpu_to_be16(len + 1);
 
 	return AVC_CTYPE_STABLE;
 }
@@ -1146,7 +1149,7 @@ static uint8_t avrcp_handle_list_player_values(struct avrcp *session,
 						uint8_t transaction)
 {
 	struct avrcp_player *player = target_get_player(session);
-	uint16_t len = ntohs(pdu->params_len);
+	uint16_t len = be16_to_cpu(pdu->params_len);
 	unsigned int i;
 
 	if (len != 1)
@@ -1161,12 +1164,12 @@ static uint8_t avrcp_handle_list_player_values(struct avrcp *session,
 		pdu->params[i] = i;
 
 	pdu->params[0] = len;
-	pdu->params_len = htons(len + 1);
+	pdu->params_len = cpu_to_be16(len + 1);
 
 	return AVC_CTYPE_STABLE;
 
 err:
-	pdu->params_len = htons(1);
+	pdu->params_len = cpu_to_be16(1);
 	pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 	return AVC_CTYPE_REJECTED;
 }
@@ -1215,7 +1218,7 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp *session,
 						uint8_t transaction)
 {
 	struct avrcp_player *player = target_get_player(session);
-	uint16_t len = ntohs(pdu->params_len);
+	uint16_t len = be16_to_cpu(pdu->params_len);
 	uint64_t identifier = get_le64(&pdu->params[0]);
 	uint16_t pos;
 	uint8_t nattr;
@@ -1273,11 +1276,11 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp *session,
 	}
 
 	pdu->params[0] = len;
-	pdu->params_len = htons(pos);
+	pdu->params_len = cpu_to_be16(pos);
 
 	return AVC_CTYPE_STABLE;
 err:
-	pdu->params_len = htons(1);
+	pdu->params_len = cpu_to_be16(1);
 	pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 	return AVC_CTYPE_REJECTED;
 }
@@ -1287,7 +1290,7 @@ static uint8_t avrcp_handle_get_current_player_value(struct avrcp *session,
 						uint8_t transaction)
 {
 	struct avrcp_player *player = target_get_player(session);
-	uint16_t len = ntohs(pdu->params_len);
+	uint16_t len = be16_to_cpu(pdu->params_len);
 	uint8_t *settings;
 	unsigned int i;
 
@@ -1327,7 +1330,7 @@ static uint8_t avrcp_handle_get_current_player_value(struct avrcp *session,
 
 	if (len) {
 		pdu->params[0] = len / 2;
-		pdu->params_len = htons(len + 1);
+		pdu->params_len = cpu_to_be16(len + 1);
 
 		return AVC_CTYPE_STABLE;
 	}
@@ -1335,7 +1338,7 @@ static uint8_t avrcp_handle_get_current_player_value(struct avrcp *session,
 	error("No valid attributes in request");
 
 err:
-	pdu->params_len = htons(1);
+	pdu->params_len = cpu_to_be16(1);
 	pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 
 	return AVC_CTYPE_REJECTED;
@@ -1346,7 +1349,7 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp *session,
 						uint8_t transaction)
 {
 	struct avrcp_player *player = target_get_player(session);
-	uint16_t len = ntohs(pdu->params_len);
+	uint16_t len = be16_to_cpu(pdu->params_len);
 	unsigned int i;
 	uint8_t *param;
 
@@ -1375,7 +1378,7 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp *session,
 	}
 
 err:
-	pdu->params_len = htons(1);
+	pdu->params_len = cpu_to_be16(1);
 	pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 	return AVC_CTYPE_REJECTED;
 }
@@ -1384,10 +1387,10 @@ static uint8_t avrcp_handle_displayable_charset(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	uint16_t len = ntohs(pdu->params_len);
+	uint16_t len = be16_to_cpu(pdu->params_len);
 
 	if (len < 3) {
-		pdu->params_len = htons(1);
+		pdu->params_len = cpu_to_be16(1);
 		pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 		return AVC_CTYPE_REJECTED;
 	}
@@ -1404,7 +1407,7 @@ static uint8_t avrcp_handle_ct_battery_status(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	uint16_t len = ntohs(pdu->params_len);
+	uint16_t len = be16_to_cpu(pdu->params_len);
 	const char *valstr;
 
 	if (len != 1)
@@ -1419,7 +1422,7 @@ static uint8_t avrcp_handle_ct_battery_status(struct avrcp *session,
 	return AVC_CTYPE_STABLE;
 
 err:
-	pdu->params_len = htons(1);
+	pdu->params_len = cpu_to_be16(1);
 	pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 	return AVC_CTYPE_REJECTED;
 }
@@ -1481,12 +1484,12 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp *session,
 						uint8_t transaction)
 {
 	struct avrcp_player *player = target_get_player(session);
-	uint16_t len = ntohs(pdu->params_len);
+	uint16_t len = be16_to_cpu(pdu->params_len);
 	uint32_t position;
 	uint32_t duration;
 
 	if (len != 0) {
-		pdu->params_len = htons(1);
+		pdu->params_len = cpu_to_be16(1);
 		pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 		return AVC_CTYPE_REJECTED;
 	}
@@ -1494,14 +1497,11 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp *session,
 	position = player_get_position(player);
 	duration = player_get_duration(player);
 
-	position = htonl(position);
-	duration = htonl(duration);
-
-	memcpy(&pdu->params[0], &duration, 4);
-	memcpy(&pdu->params[4], &position, 4);
+	put_be32(duration, &pdu->params[0]);
+	put_be32(position, &pdu->params[4]);
 	pdu->params[8] = player_get_status(player);
 
-	pdu->params_len = htons(9);
+	pdu->params_len = cpu_to_be16(9);
 
 	return AVC_CTYPE_STABLE;
 }
@@ -1609,7 +1609,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 {
 	struct avrcp_player *player = target_get_player(session);
 	struct btd_device *dev = session->dev;
-	uint16_t len = ntohs(pdu->params_len);
+	uint16_t len = be16_to_cpu(pdu->params_len);
 	uint64_t uid;
 	int8_t volume;
 
@@ -1670,12 +1670,12 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	session->registered_events |= (1 << pdu->params[0]);
 	session->transaction_events[pdu->params[0]] = transaction;
 
-	pdu->params_len = htons(len);
+	pdu->params_len = cpu_to_be16(len);
 
 	return AVC_CTYPE_INTERIM;
 
 err:
-	pdu->params_len = htons(1);
+	pdu->params_len = cpu_to_be16(1);
 	pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 	return AVC_CTYPE_REJECTED;
 }
@@ -1685,7 +1685,7 @@ static uint8_t avrcp_handle_request_continuing(struct avrcp *session,
 						uint8_t transaction)
 {
 	struct avrcp_player *player = target_get_player(session);
-	uint16_t len = ntohs(pdu->params_len);
+	uint16_t len = be16_to_cpu(pdu->params_len);
 	struct pending_pdu *pending;
 
 	if (len != 1 || session->pending_pdu == NULL)
@@ -1711,11 +1711,11 @@ static uint8_t avrcp_handle_request_continuing(struct avrcp *session,
 		pdu->packet_type = AVRCP_PACKET_TYPE_CONTINUING;
 	}
 
-	pdu->params_len = htons(len);
+	pdu->params_len = cpu_to_be16(len);
 
 	return AVC_CTYPE_STABLE;
 err:
-	pdu->params_len = htons(1);
+	pdu->params_len = cpu_to_be16(1);
 	pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 	return AVC_CTYPE_REJECTED;
 }
@@ -1724,7 +1724,7 @@ static uint8_t avrcp_handle_abort_continuing(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	uint16_t len = ntohs(pdu->params_len);
+	uint16_t len = be16_to_cpu(pdu->params_len);
 	struct pending_pdu *pending;
 
 	if (len != 1 || session->pending_pdu == NULL)
@@ -1741,7 +1741,7 @@ static uint8_t avrcp_handle_abort_continuing(struct avrcp *session,
 	return AVC_CTYPE_ACCEPTED;
 
 err:
-	pdu->params_len = htons(1);
+	pdu->params_len = cpu_to_be16(1);
 	pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 	return AVC_CTYPE_REJECTED;
 }
@@ -1750,7 +1750,7 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	uint16_t len = ntohs(pdu->params_len);
+	uint16_t len = be16_to_cpu(pdu->params_len);
 	int8_t volume;
 
 	if (len != 1)
@@ -1763,7 +1763,7 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 	return AVC_CTYPE_ACCEPTED;
 
 err:
-	pdu->params_len = htons(1);
+	pdu->params_len = cpu_to_be16(1);
 	pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 	return AVC_CTYPE_REJECTED;
 }
@@ -1821,7 +1821,7 @@ static uint8_t avrcp_handle_set_addressed_player(struct avrcp *session,
 						uint8_t transaction)
 {
 	struct avrcp_player *player;
-	uint16_t len = ntohs(pdu->params_len);
+	uint16_t len = be16_to_cpu(pdu->params_len);
 	uint16_t player_id = 0;
 	uint8_t status;
 
@@ -1837,7 +1837,7 @@ static uint8_t avrcp_handle_set_addressed_player(struct avrcp *session,
 	if (player) {
 		player->addressed = true;
 		status = AVRCP_STATUS_SUCCESS;
-		pdu->params_len = htons(len);
+		pdu->params_len = cpu_to_be16(len);
 		pdu->params[0] = status;
 	} else {
 		status = AVRCP_STATUS_INVALID_PLAYER_ID;
@@ -1853,7 +1853,7 @@ static uint8_t avrcp_handle_set_addressed_player(struct avrcp *session,
 	return AVC_CTYPE_ACCEPTED;
 
 err:
-	pdu->params_len = htons(sizeof(status));
+	pdu->params_len = cpu_to_be16(sizeof(status));
 	pdu->params[0] = status;
 	return AVC_CTYPE_REJECTED;
 }
@@ -1911,7 +1911,7 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 	}
 
 	DBG("AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
-			pdu->pdu_id, company_id, ntohs(pdu->params_len));
+			pdu->pdu_id, company_id, be16_to_cpu(pdu->params_len));
 
 	pdu->packet_type = 0;
 	pdu->rsvd = 0;
@@ -1924,9 +1924,9 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 	operands += sizeof(*pdu);
 	operand_count -= sizeof(*pdu);
 
-	if (ntohs(pdu->params_len) != operand_count) {
+	if (be16_to_cpu(pdu->params_len) != operand_count) {
 		DBG("AVRCP PDU parameters length don't match");
-		pdu->params_len = htons(operand_count);
+		pdu->params_len = cpu_to_be16(operand_count);
 	}
 
 	for (handler = session->control_handlers; handler->pdu_id; handler++) {
@@ -1952,10 +1952,10 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 				pdu->pdu_id != AVRCP_ABORT_CONTINUING)
 		session_abort_pending_pdu(session);
 
-	return AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+	return AVRCP_HEADER_LENGTH + be16_to_cpu(pdu->params_len);
 
 err_metadata:
-	pdu->params_len = htons(1);
+	pdu->params_len = cpu_to_be16(1);
 	*code = AVC_CTYPE_REJECTED;
 
 	return AVRCP_HEADER_LENGTH + 1;
@@ -1972,7 +1972,7 @@ static void avrcp_handle_media_player_list(struct avrcp *session,
 
 	rsp = (void *)pdu->params;
 	rsp->status = AVRCP_STATUS_SUCCESS;
-	rsp->uid_counter = htons(player_get_uid_counter(player));
+	rsp->uid_counter = cpu_to_be16(player_get_uid_counter(player));
 	rsp->num_items = 0;
 	pdu->param_len = sizeof(*rsp);
 
@@ -1992,22 +1992,22 @@ static void avrcp_handle_media_player_list(struct avrcp *session,
 		pdu->param_len += sizeof(*folder);
 
 		item = (void *)folder->data;
-		item->player_id = htons(player->id);
+		item->player_id = cpu_to_be16(player->id);
 		item->type = 0x01; /* Audio */
-		item->subtype = htonl(0x01); /* Audio Book */
+		item->subtype = cpu_to_be32(0x00000001); /* Audio Book */
 		item->status = player_get_status(player);
 		/* Assign Default Feature Bit Mask */
 		memcpy(&item->features, &default_features,
 					sizeof(default_features));
 
-		item->charset = htons(AVRCP_CHARSET_UTF8);
+		item->charset = cpu_to_be16(AVRCP_CHARSET_UTF8);
 
 		name = player->cb->get_name(player->user_data);
 		namelen = strlen(name);
-		item->namelen = htons(namelen);
+		item->namelen = cpu_to_be16(namelen);
 		memcpy(item->name, name, namelen);
 
-		folder->len = htons(sizeof(*item) + namelen);
+		folder->len = cpu_to_be16(sizeof(*item) + namelen);
 		pdu->param_len += sizeof(*item) + namelen;
 		rsp->num_items++;
 	}
@@ -2016,14 +2016,14 @@ static void avrcp_handle_media_player_list(struct avrcp *session,
 	if (!rsp->num_items)
 		goto failed;
 
-	rsp->num_items = htons(rsp->num_items);
-	pdu->param_len = htons(pdu->param_len);
+	rsp->num_items = cpu_to_be16(rsp->num_items);
+	pdu->param_len = cpu_to_be16(pdu->param_len);
 
 	return;
 
 failed:
 	pdu->params[0] = AVRCP_STATUS_OUT_OF_BOUNDS;
-	pdu->param_len = htons(1);
+	pdu->param_len = cpu_to_be16(1);
 }
 
 static void avrcp_handle_get_folder_items(struct avrcp *session,
@@ -2035,7 +2035,7 @@ static void avrcp_handle_get_folder_items(struct avrcp *session,
 	uint8_t scope;
 	uint8_t status = AVRCP_STATUS_SUCCESS;
 
-	if (ntohs(pdu->param_len) < 10) {
+	if (be16_to_cpu(pdu->param_len) < 10) {
 		status = AVRCP_STATUS_INVALID_PARAM;
 		goto failed;
 	}
@@ -2069,7 +2069,7 @@ static void avrcp_handle_get_folder_items(struct avrcp *session,
 
 failed:
 	pdu->params[0] = status;
-	pdu->param_len = htons(1);
+	pdu->param_len = cpu_to_be16(1);
 }
 
 static void avrcp_handle_media_player_list_num_items(struct avrcp *session,
@@ -2080,9 +2080,9 @@ static void avrcp_handle_media_player_list_num_items(struct avrcp *session,
 
 	rsp = (void *)pdu->params;
 	rsp->status = AVRCP_STATUS_SUCCESS;
-	rsp->uid_counter = htons(player_get_uid_counter(player));
-	rsp->num_items = htonl(g_slist_length(session->server->players));
-	pdu->param_len = htons(sizeof(*rsp));
+	rsp->uid_counter = cpu_to_be16(player_get_uid_counter(player));
+	rsp->num_items = cpu_to_be32(g_slist_length(session->server->players));
+	pdu->param_len = cpu_to_be16(sizeof(*rsp));
 }
 
 static void avrcp_handle_get_total_number_of_items(struct avrcp *session,
@@ -2092,7 +2092,7 @@ static void avrcp_handle_get_total_number_of_items(struct avrcp *session,
 	uint8_t scope;
 	uint8_t status = AVRCP_STATUS_SUCCESS;
 
-	if (ntohs(pdu->param_len) != 1) {
+	if (be16_to_cpu(pdu->param_len) != 1) {
 		status = AVRCP_STATUS_INVALID_PARAM;
 		goto failed;
 	}
@@ -2115,7 +2115,7 @@ static void avrcp_handle_get_total_number_of_items(struct avrcp *session,
 
 failed:
 	pdu->params[0] = status;
-	pdu->param_len = htons(1);
+	pdu->param_len = cpu_to_be16(1);
 }
 
 static struct browsing_pdu_handler {
@@ -2137,7 +2137,7 @@ size_t avrcp_browsing_general_reject(uint8_t *operands)
 	pdu->pdu_id = AVRCP_GENERAL_REJECT;
 	status = AVRCP_STATUS_INVALID_COMMAND;
 
-	pdu->param_len = htons(sizeof(status));
+	pdu->param_len = cpu_to_be16(sizeof(status));
 	memcpy(pdu->params, &status, (sizeof(status)));
 	return AVRCP_BROWSING_HEADER_LENGTH + sizeof(status);
 }
@@ -2151,7 +2151,7 @@ static size_t handle_browsing_pdu(struct avctp *conn,
 	struct avrcp_browsing_header *pdu = (void *) operands;
 
 	DBG("AVRCP Browsing PDU 0x%02X, len 0x%04X", pdu->pdu_id,
-							ntohs(pdu->param_len));
+						be16_to_cpu(pdu->param_len));
 
 	for (handler = browsing_handlers; handler->pdu_id; handler++) {
 		if (handler->pdu_id == pdu->pdu_id)
@@ -2163,7 +2163,7 @@ static size_t handle_browsing_pdu(struct avctp *conn,
 done:
 	session->transaction = transaction;
 	handler->func(session, pdu, transaction);
-	return AVRCP_BROWSING_HEADER_LENGTH + ntohs(pdu->param_len);
+	return AVRCP_BROWSING_HEADER_LENGTH + be16_to_cpu(pdu->param_len);
 }
 
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
@@ -2172,11 +2172,11 @@ size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
 	uint32_t company_id = get_company_id(pdu->company_id);
 
 	*code = AVC_CTYPE_REJECTED;
-	pdu->params_len = htons(1);
+	pdu->params_len = cpu_to_be16(1);
 	pdu->params[0] = AVRCP_STATUS_INTERNAL_ERROR;
 
 	DBG("rejecting AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
-			pdu->pdu_id, company_id, ntohs(pdu->params_len));
+			pdu->pdu_id, company_id, be16_to_cpu(pdu->params_len));
 
 	return AVRCP_HEADER_LENGTH + 1;
 }
@@ -2227,18 +2227,16 @@ static gboolean avrcp_get_play_status_rsp(struct avctp *conn, uint8_t code,
 	uint8_t status;
 
 	if (pdu == NULL || code == AVC_CTYPE_REJECTED ||
-						ntohs(pdu->params_len) != 9)
+					be16_to_cpu(pdu->params_len) != 9)
 		return FALSE;
 
-	memcpy(&duration, pdu->params, sizeof(uint32_t));
-	duration = ntohl(duration);
+	duration = get_be32(pdu->params);
 	media_player_set_duration(mp, duration);
 
-	memcpy(&position, pdu->params + 4, sizeof(uint32_t));
-	position = ntohl(position);
+	position = get_be32(pdu->params + 4);
 	media_player_set_position(mp, position);
 
-	memcpy(&status, pdu->params + 8, sizeof(uint8_t));
+	status = get_u8(pdu->params + 8);
 	media_player_set_status(mp, status_to_string(status));
 
 	return FALSE;
@@ -2335,7 +2333,7 @@ static void avrcp_get_current_player_value(struct avrcp *session,
 	set_company_id(pdu->company_id, IEEEID_BTSIG);
 	pdu->pdu_id = AVRCP_GET_CURRENT_PLAYER_VALUE;
 	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
-	pdu->params_len = htons(count + 1);
+	pdu->params_len = cpu_to_be16(count + 1);
 	pdu->params[0] = count;
 
 	memcpy(pdu->params + 1, attrs, count);
@@ -2361,7 +2359,7 @@ static gboolean avrcp_list_player_attributes_rsp(struct avctp *conn,
 
 	len = pdu->params[0];
 
-	if (ntohs(pdu->params_len) < count) {
+	if (be16_to_cpu(pdu->params_len) < count) {
 		error("Invalid parameters");
 		return FALSE;
 	}
@@ -2449,7 +2447,7 @@ static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
 
 	count = pdu->params[0];
 
-	if (ntohs(pdu->params_len) - 1 < count * 8) {
+	if (be16_to_cpu(pdu->params_len) - 1 < count * 8) {
 		error("Invalid parameters");
 		return FALSE;
 	}
@@ -2471,10 +2469,10 @@ static void avrcp_get_element_attributes(struct avrcp *session)
 
 	set_company_id(pdu->company_id, IEEEID_BTSIG);
 	pdu->pdu_id = AVRCP_GET_ELEMENT_ATTRIBUTES;
-	pdu->params_len = htons(9);
+	pdu->params_len = cpu_to_be16(9);
 	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
 
-	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+	length = AVRCP_HEADER_LENGTH + be16_to_cpu(pdu->params_len);
 
 	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
 					AVC_SUBUNIT_PANEL, buf, length,
@@ -2695,12 +2693,11 @@ static void avrcp_list_items(struct avrcp *session, uint32_t start,
 	struct avrcp_player *player = session->controller->player;
 	struct avrcp_browsing_header *pdu = (void *) buf;
 	uint16_t length = AVRCP_BROWSING_HEADER_LENGTH + 10;
-	uint32_t attribute;
 
 	memset(buf, 0, sizeof(buf));
 
 	pdu->pdu_id = AVRCP_GET_FOLDER_ITEMS;
-	pdu->param_len = htons(10 + sizeof(uint32_t));
+	pdu->param_len = cpu_to_be16(10 + sizeof(uint32_t));
 
 	pdu->params[0] = player->scope;
 
@@ -2711,8 +2708,7 @@ static void avrcp_list_items(struct avrcp *session, uint32_t start,
 
 	/* Only the title (0x01) is mandatory. This can be extended to
 	 * support AVRCP_MEDIA_ATTRIBUTE_* attributes */
-	attribute = htonl(AVRCP_MEDIA_ATTRIBUTE_TITLE);
-	memcpy(&pdu->params[10], &attribute, sizeof(uint32_t));
+	put_be32(AVRCP_MEDIA_ATTRIBUTE_TITLE, &pdu->params[10]);
 
 	length += sizeof(uint32_t);
 
@@ -2823,9 +2819,9 @@ static void avrcp_set_browsed_player(struct avrcp *session,
 	memset(buf, 0, sizeof(buf));
 
 	pdu->pdu_id = AVRCP_SET_BROWSED_PLAYER;
-	id = htons(player->id);
+	id = cpu_to_be16(player->id);
 	memcpy(pdu->params, &id, 2);
-	pdu->param_len = htons(2);
+	pdu->param_len = cpu_to_be16(2);
 
 	avctp_send_browsing_req(session->conn, buf, sizeof(buf),
 				avrcp_set_browsed_player_rsp, session);
@@ -2853,7 +2849,7 @@ static gboolean avrcp_get_item_attributes_rsp(struct avctp *conn,
 
 	count = pdu->params[1];
 
-	if (ntohs(pdu->param_len) - 1 < count * 8) {
+	if (be16_to_cpu(pdu->param_len) - 1 < count * 8) {
 		error("Invalid parameters");
 		return FALSE;
 	}
@@ -2877,7 +2873,7 @@ static void avrcp_get_item_attributes(struct avrcp *session, uint64_t uid)
 	pdu->params[0] = 0x03;
 	put_be64(uid, &pdu->params[1]);
 	put_be16(player->uid_counter, &pdu->params[9]);
-	pdu->param_len = htons(12);
+	pdu->param_len = cpu_to_be16(12);
 
 	avctp_send_browsing_req(session->conn, buf, sizeof(buf),
 				avrcp_get_item_attributes_rsp, session);
@@ -2921,9 +2917,9 @@ static void avrcp_set_player_value(struct avrcp *session, uint8_t attr,
 	pdu->params[0] = 1;
 	pdu->params[1] = attr;
 	pdu->params[2] = val;
-	pdu->params_len = htons(3);
+	pdu->params_len = cpu_to_be16(3);
 
-	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+	length = AVRCP_HEADER_LENGTH + be16_to_cpu(pdu->params_len);
 
 	avctp_send_vendordep_req(session->conn, AVC_CTYPE_CONTROL,
 					AVC_SUBUNIT_PANEL, buf, length,
@@ -2959,9 +2955,9 @@ static void avrcp_set_addressed_player(struct avrcp *session,
 	set_company_id(pdu->company_id, IEEEID_BTSIG);
 	pdu->pdu_id = AVRCP_SET_ADDRESSED_PLAYER;
 	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
-	id = htons(player->id);
+	id = cpu_to_be16(player->id);
 	memcpy(pdu->params, &id, 2);
-	pdu->params_len = htons(2);
+	pdu->params_len = cpu_to_be16(2);
 
 	avctp_send_vendordep_req(session->conn, AVC_CTYPE_CONTROL,
 					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
@@ -3189,7 +3185,7 @@ static void avrcp_change_path(struct avrcp *session, uint8_t direction,
 	pdu->params[2] = direction;
 	put_be64(uid, &pdu->params[3]);
 	pdu->pdu_id = AVRCP_CHANGE_PATH;
-	pdu->param_len = htons(11);
+	pdu->param_len = cpu_to_be16(11);
 
 	avctp_send_browsing_req(session->conn, buf, sizeof(buf),
 					avrcp_change_path_rsp, session);
@@ -3257,7 +3253,7 @@ static void avrcp_search(struct avrcp *session, const char *string)
 	put_be16(stringlen, &pdu->params[2]);
 	memcpy(&pdu->params[4], string, stringlen);
 	pdu->pdu_id = AVRCP_SEARCH;
-	pdu->param_len = htons(len - AVRCP_BROWSING_HEADER_LENGTH);
+	pdu->param_len = cpu_to_be16(len - AVRCP_BROWSING_HEADER_LENGTH);
 
 	avctp_send_browsing_req(session->conn, buf, len, avrcp_search_rsp,
 								session);
@@ -3323,14 +3319,14 @@ static void avrcp_play_item(struct avrcp *session, uint64_t uid)
 
 	set_company_id(pdu->company_id, IEEEID_BTSIG);
 	pdu->pdu_id = AVRCP_PLAY_ITEM;
-	pdu->params_len = htons(11);
+	pdu->params_len = cpu_to_be16(11);
 	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
 
 	pdu->params[0] = player->scope;
 	put_be64(uid, &pdu->params[1]);
 	put_be16(player->uid_counter, &pdu->params[9]);
 
-	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+	length = AVRCP_HEADER_LENGTH + be16_to_cpu(pdu->params_len);
 
 	avctp_send_vendordep_req(session->conn, AVC_CTYPE_CONTROL,
 					AVC_SUBUNIT_PANEL, buf, length,
@@ -3372,14 +3368,14 @@ static void avrcp_add_to_nowplaying(struct avrcp *session, uint64_t uid)
 
 	set_company_id(pdu->company_id, IEEEID_BTSIG);
 	pdu->pdu_id = AVRCP_ADD_TO_NOW_PLAYING;
-	pdu->params_len = htons(11);
+	pdu->params_len = cpu_to_be16(11);
 	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
 
 	pdu->params[0] = player->scope;
 	put_be64(uid, &pdu->params[1]);
 	put_be16(player->uid_counter, &pdu->params[9]);
 
-	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+	length = AVRCP_HEADER_LENGTH + be16_to_cpu(pdu->params_len);
 
 	avctp_send_vendordep_req(session->conn, AVC_CTYPE_CONTROL,
 					AVC_SUBUNIT_PANEL, buf, length,
@@ -3447,7 +3443,7 @@ static void avrcp_get_total_numberofitems(struct avrcp *session)
 	memset(buf, 0, sizeof(buf));
 
 	pdu->pdu_id = AVRCP_GET_TOTAL_NUMBER_OF_ITEMS;
-	pdu->param_len = htons(7 + sizeof(uint32_t));
+	pdu->param_len = cpu_to_be16(7 + sizeof(uint32_t));
 
 	pdu->params[0] = player->scope;
 
@@ -3715,7 +3711,7 @@ static void avrcp_get_media_player_list(struct avrcp *session)
 	pdu->pdu_id = AVRCP_GET_FOLDER_ITEMS;
 	put_be32(0, &pdu->params[1]);
 	put_be32(UINT32_MAX, &pdu->params[5]);
-	pdu->param_len = htons(10);
+	pdu->param_len = cpu_to_be16(10);
 
 	avctp_send_browsing_req(session->conn, buf, sizeof(buf),
 				avrcp_get_media_player_list_rsp, session);
@@ -3935,9 +3931,9 @@ static void avrcp_register_notification(struct avrcp *session, uint8_t event)
 	if (event == AVRCP_EVENT_PLAYBACK_POS_CHANGED)
 		bt_put_be32(UINT32_MAX / 1000, &pdu->params[1]);
 
-	pdu->params_len = htons(AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH);
+	pdu->params_len = cpu_to_be16(AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH);
 
-	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+	length = AVRCP_HEADER_LENGTH + be16_to_cpu(pdu->params_len);
 
 	avctp_send_vendordep_req(session->conn, AVC_CTYPE_NOTIFY,
 					AVC_SUBUNIT_PANEL, buf, length,
@@ -4015,7 +4011,6 @@ static void avrcp_get_capabilities(struct avrcp *session)
 {
 	uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_GET_CAPABILITIES_PARAM_LENGTH];
 	struct avrcp_header *pdu = (void *) buf;
-	uint8_t length;
 
 	memset(buf, 0, sizeof(buf));
 
@@ -4023,12 +4018,10 @@ static void avrcp_get_capabilities(struct avrcp *session)
 	pdu->pdu_id = AVRCP_GET_CAPABILITIES;
 	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
 	pdu->params[0] = CAP_EVENTS_SUPPORTED;
-	pdu->params_len = htons(AVRCP_GET_CAPABILITIES_PARAM_LENGTH);
-
-	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+	pdu->params_len = cpu_to_be16(AVRCP_GET_CAPABILITIES_PARAM_LENGTH);
 
 	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
-					AVC_SUBUNIT_PANEL, buf, length,
+					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
 					avrcp_get_capabilities_resp,
 					session);
 }
@@ -4535,7 +4528,7 @@ static int avrcp_event(struct avrcp *session, uint8_t id, const void *data)
 		return -EINVAL;
 	}
 
-	pdu->params_len = htons(size);
+	pdu->params_len = cpu_to_be16(size);
 
 	err = avctp_send_vendordep(session->conn,
 					session->transaction_events[id],
@@ -4590,7 +4583,7 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
 
 	pdu->pdu_id = AVRCP_SET_ABSOLUTE_VOLUME;
 	pdu->params[0] = volume;
-	pdu->params_len = htons(1);
+	pdu->params_len = cpu_to_be16(1);
 
 	return avctp_send_vendordep_req(session->conn,
 					AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
-- 
2.33.1

