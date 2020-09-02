Return-Path: <SRS0=7X4B=CL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324C8C433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Sep 2020 04:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 080A820767
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Sep 2020 04:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EZetdeYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIBE5z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Sep 2020 00:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgIBE5x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Sep 2020 00:57:53 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E594DC061244
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2020 21:57:52 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id g6so2025471pfi.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2020 21:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=CiNatQYsu0DXAewi6I/opfSYQc435ZU+DaUdqjz8hA8=;
        b=EZetdeYBqr+u9lyboK0cd8KX94wz8IXufDLVq3QKXTb8Re/D27qIf+xerwS4y6joFF
         cn9PKzDd2MTlXx+ouW8wGo2784Ab8fUHI2Hj02cu7Wxv56P9zAVhWpbin1RchiiqMxvO
         06d09SpU1JClj/9OF5fa5NYzGndZgb8WkqUsZyU0a0DfRtOM4Gd7l81Y7775O0UcIp8j
         /0uEUosa6LD8pjCy/9NQuCCFhNnG9NnoTiS8ufiF/kiN2WUvYI/i32lBEYEkcIGKquqJ
         o9Kjv0mFF6lbBI+plG35GDdYr8JUcsnC//t8Z0CcXkt6v+bD9mm32FFHwA5Gr0uX81Ym
         n82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=CiNatQYsu0DXAewi6I/opfSYQc435ZU+DaUdqjz8hA8=;
        b=bjvnMmFCQGF2ch3ReZomsUO5mFFul7QC5CDRZV9xY5c6Kont+L6wDV9aktqzLtPXOd
         ehozVGFJq97cQUF8oMNlFyNxE6ezRqsIdnGsjV8xC5ua+IOHALvw5fPiKUteeLi7b+t+
         wMRCUi0hCibY7EhRv9gTlHP2vudxXvQhhktFo6Mq1UQk+8JRNk4xwkCMs1/nEqfkaeKD
         sdcIJzk5+bqOZ0yHqwt1D558eUFoQrXiD2hEBRSaOTDZYR6tCO/u2i1IzGHh4KEstLgH
         qjHlCcRbm2jC9BTL9WVPVqE9YpYoY9nV5/fYhxRO4KyTO4U4rvFa08Y8DPHoezdoswai
         X4Aw==
X-Gm-Message-State: AOAM531KIqiQtoLY+vLewp1zINpd73t4CuwzLlrOmHZU1/bkaEXv8fLR
        BFG9rqoGtH6pfYKJv9g4HrqkPyFzCmDfFy/hAPXOAJmH2Qxf76/KGLElVaApEP0yFlHgrL3zcAv
        QyHkx2JJ/c/x79pGOOsw9uvY5Tn/XaV7FCQvuEfhl7SBQi2jkFzqdInkmE+80fbyTCpgf6OBejk
        5O
X-Google-Smtp-Source: ABdhPJy7nyNGkcVVM+aSaLAgmC9pK0Y95ZmdPQXvt2LGhBqSXlT5GlzZUpKZM3OG7/mPayevaufL8x8gBC+3
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:902:a581:b029:cf:9367:8d9d with SMTP
 id az1-20020a170902a581b02900cf93678d9dmr2167593plb.0.1599022671913; Tue, 01
 Sep 2020 21:57:51 -0700 (PDT)
Date:   Wed,  2 Sep 2020 12:57:45 +0800
Message-Id: <20200902125726.Bluez.v1.1.I732df55cd70d552fc48e87686fb53c3f8ccbefa5@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [Bluez PATCH v1] avrcp: Add handler for GET_TOTAL_NUMBER_OF_ITEMS
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to the AVRCP spec, section 4.5, GetTotalNumberOfItems PDU
is mandatory for TG supporting category 1 or 3.

Reviewed-by: Yun-Hao Chung <howardchung@google.com>
Reviewed-by: Michael Sun <michaelfsun@google.com>
---

 profiles/audio/avrcp.c | 58 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 5d0256c52..6da73394f 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -79,6 +79,7 @@
 #define AVRCP_STATUS_SUCCESS			0x04
 #define AVRCP_STATUS_UID_CHANGED		0x05
 #define AVRCP_STATUS_DOES_NOT_EXIST		0x09
+#define AVRCP_STATUS_INVALID_SCOPE		0x0a
 #define AVRCP_STATUS_OUT_OF_BOUNDS		0x0b
 #define AVRCP_STATUS_INVALID_PLAYER_ID		0x11
 #define AVRCP_STATUS_PLAYER_NOT_BROWSABLE	0x12
@@ -211,6 +212,12 @@ struct player_item {
 	char name[0];
 } __attribute__ ((packed));
 
+struct get_total_number_of_items_rsp {
+	uint8_t status;
+	uint16_t uid_counter;
+	uint32_t num_items;
+} __attribute__ ((packed));
+
 struct avrcp_server {
 	struct btd_adapter *adapter;
 	uint32_t tg_record_id;
@@ -566,6 +573,9 @@ static void populate_default_features(void)
 
 	/* supports at least AVRCP 1.4 */
 	default_features[7] |= (1 << 2);
+
+	/* supports GetTotalNumberOfItems browsing command */
+	default_features[8] |= (1 << 3);
 }
 
 static unsigned int attr_get_max_val(uint8_t attr)
@@ -2048,10 +2058,56 @@ static void avrcp_handle_get_folder_items(struct avrcp *session,
 	case AVRCP_SCOPE_SEARCH:
 	case AVRCP_SCOPE_NOW_PLAYING:
 	default:
+		status = AVRCP_STATUS_INVALID_SCOPE;
+		goto failed;
+	}
+
+	return;
+
+failed:
+	pdu->params[0] = status;
+	pdu->param_len = htons(1);
+}
+
+static void avrcp_handle_media_player_list_num_items(struct avrcp *session,
+				struct avrcp_browsing_header *pdu)
+{
+	struct avrcp_player *player = target_get_player(session);
+	struct get_total_number_of_items_rsp *rsp;
+
+	rsp = (void *)pdu->params;
+	rsp->status = AVRCP_STATUS_SUCCESS;
+	rsp->uid_counter = htons(player_get_uid_counter(player));
+	rsp->num_items = htonl(g_slist_length(session->server->players));
+	pdu->param_len = htons(sizeof(*rsp));
+}
+
+static void avrcp_handle_get_total_number_of_items(struct avrcp *session,
+				struct avrcp_browsing_header *pdu,
+				uint8_t transaction)
+{
+	uint8_t scope;
+	uint8_t status = AVRCP_STATUS_SUCCESS;
+
+	if (ntohs(pdu->param_len) != 1) {
 		status = AVRCP_STATUS_INVALID_PARAM;
 		goto failed;
 	}
 
+	scope = pdu->params[0];
+
+	switch (scope) {
+	case AVRCP_SCOPE_MEDIA_PLAYER_LIST:
+		avrcp_handle_media_player_list_num_items(session, pdu);
+		break;
+	case AVRCP_SCOPE_MEDIA_PLAYER_VFS:
+	case AVRCP_SCOPE_SEARCH:
+	case AVRCP_SCOPE_NOW_PLAYING:
+	default:
+		status = AVRCP_STATUS_INVALID_SCOPE;
+		goto failed;
+	}
+
 	return;
 
 failed:
@@ -2065,6 +2121,8 @@ static struct browsing_pdu_handler {
 							uint8_t transaction);
 } browsing_handlers[] = {
 		{ AVRCP_GET_FOLDER_ITEMS, avrcp_handle_get_folder_items },
+		{ AVRCP_GET_TOTAL_NUMBER_OF_ITEMS,
+				avrcp_handle_get_total_number_of_items },
 		{ },
 };
 
-- 
2.28.0.402.g5ffc5be6b7-goog

