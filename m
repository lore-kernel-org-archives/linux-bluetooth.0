Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A2BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 21:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70FA860F4C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 21:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347312AbhIXVUD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Sep 2021 17:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhIXVUC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Sep 2021 17:20:02 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E106C061571
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Sep 2021 14:18:29 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id m21so10993680pgu.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Sep 2021 14:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=820GNTOJT4J+HSWHU2q3Ca+6SK5sZEeyFivGidgkOcY=;
        b=RQWWqODU08NP+FABI4dJySoMQKtAbA1thliePKeTtQx1Tek3xQiZPSvkw/Qfo05Pv4
         TLMC7wtnGpQV0ZymnAODhdRgaJmglWQ8Gji/DmZ1qgfvEBtz04lXj7pbFUZPUDMQ4Mug
         dBz1FRhdOJlnnTfT3a+PT1+kDdOeeyW/FgKvVUTAixgyZIRH0KxHAjiBI/JxS8NA1nzJ
         RWpUGvYJogfNnjRKLKTgaZN+46ksdmDWXvPqi3g/OeHY0Tp+lrdVIDAgBzgXS4aYV+23
         NgW2ri192Bob7RwCETay6912NzIOFWSNAaejEUaUfjeFEGRZ1t1/De1TPLCINUbAbFor
         9ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=820GNTOJT4J+HSWHU2q3Ca+6SK5sZEeyFivGidgkOcY=;
        b=q9f5TIsOvI8lCCbhcmZW8ETEPZuw4eeNTtRUmhvgwxOIVvAqsNgLUOmpIge3PjguFx
         KE9G95W9mdWiV3CagZnDlqMjBJtAhUP3LDa8/X99YKgF4qkMbf4zoLMyBYypaX0V5Bgs
         1G9cZvYMt9FZHyuUomJ+jOSQYF3P+Iue2MZ/12u9YsgubzgGTbLG7z0nX1Udpvh2YZae
         ZzJ61gNgKD4rdXKGbsTyp0dLgCDyByE70ytgjtpC1k5znzUeHzOeDa9f50jAuq7qIqg5
         qu2hwPdigpz9HURKecVOd1AciWYhKWZV3W1YV4aauoEvcC6RvXQuMryaWwwPSehthSSy
         VEHw==
X-Gm-Message-State: AOAM531fdaOpprITWXK3Gus+oeTCuox6HrRdr4YEZZQxhmmWPW7el44E
        bwDEySKunSew7TswJJ+AhnH7k9pRK+U=
X-Google-Smtp-Source: ABdhPJybHu8cV5VjvoOAHaOMxAlJMLNIzbYTVIvBkfeRU8RMKSQxWpro+hTbpNvsTlYM4xcR+9EIRg==
X-Received: by 2002:a65:6a0a:: with SMTP id m10mr5529150pgu.82.1632518308457;
        Fri, 24 Sep 2021 14:18:28 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h18sm9946138pfr.89.2021.09.24.14.18.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 14:18:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] avrcp: Fix browsing support in SDP record
Date:   Fri, 24 Sep 2021 14:18:24 -0700
Message-Id: <20210924211824.2318562-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924211824.2318562-1-luiz.dentz@gmail.com>
References: <20210924211824.2318562-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Browsing features shall only be marked as supported when ERTM is also
available.
---
 profiles/audio/avctp.c |   5 +-
 profiles/audio/avctp.h |   2 +-
 profiles/audio/avrcp.c | 101 +++++++++++++++++++++--------------------
 3 files changed, 57 insertions(+), 51 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 81320de1b..72509edec 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1636,7 +1636,7 @@ static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean central,
 	return io;
 }
 
-int avctp_register(struct btd_adapter *adapter, gboolean central)
+int avctp_register(struct btd_adapter *adapter, bool central, bool *browsing)
 {
 	struct avctp_server *server;
 	const bdaddr_t *src = btd_adapter_get_address(adapter);
@@ -1649,8 +1649,11 @@ int avctp_register(struct btd_adapter *adapter, gboolean central)
 		g_free(server);
 		return -1;
 	}
+
 	server->browsing_io = avctp_server_socket(src, central, BT_IO_MODE_ERTM,
 							AVCTP_BROWSING_PSM);
+	if (browsing)
+		*browsing = server->browsing_io ? true : false;
 
 	server->adapter = btd_adapter_ref(adapter);
 
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index ca5ff9126..02712bf0e 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -145,7 +145,7 @@ unsigned int avctp_add_state_cb(struct btd_device *dev, avctp_state_cb cb,
 							void *user_data);
 gboolean avctp_remove_state_cb(unsigned int id);
 
-int avctp_register(struct btd_adapter *adapter, gboolean central);
+int avctp_register(struct btd_adapter *adapter, bool central, bool *browsing);
 void avctp_unregister(struct btd_adapter *adapter);
 
 struct avctp *avctp_connect(struct btd_device *device);
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 22bd5df20..7c280203c 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -208,6 +208,7 @@ struct get_total_number_of_items_rsp {
 
 struct avrcp_server {
 	struct btd_adapter *adapter;
+	bool browsing;
 	uint32_t tg_record_id;
 	uint32_t ct_record_id;
 	GSList *players;
@@ -367,21 +368,49 @@ static uint32_t company_ids[] = {
 static void avrcp_register_notification(struct avrcp *session, uint8_t event);
 static GList *player_list_settings(struct avrcp_player *player);
 
-static sdp_record_t *avrcp_ct_record(void)
+static void avrcp_browsing_record(sdp_record_t *record, sdp_data_t *version)
 {
-	sdp_list_t *svclass_id, *pfseq, *apseq, *apseq1, *root;
+	sdp_list_t *apseq;
+	uuid_t l2cap, avctp;
+	sdp_list_t *aproto, *proto[2];
+	sdp_data_t *psm;
+	uint16_t ap = AVCTP_BROWSING_PSM;
+
+	sdp_uuid16_create(&l2cap, L2CAP_UUID);
+	proto[0] = sdp_list_append(NULL, &l2cap);
+	psm = sdp_data_alloc(SDP_UINT16, &ap);
+	proto[0] = sdp_list_append(proto[0], psm);
+	apseq = sdp_list_append(NULL, proto[0]);
+
+	sdp_uuid16_create(&avctp, AVCTP_UUID);
+	proto[1] = sdp_list_append(NULL, &avctp);
+	proto[1] = sdp_list_append(proto[1], version);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(NULL, apseq);
+	sdp_set_add_access_protos(record, aproto);
+
+	free(psm);
+	sdp_list_free(proto[0], NULL);
+	sdp_list_free(proto[1], NULL);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(aproto, NULL);
+}
+
+static sdp_record_t *avrcp_ct_record(bool browsing)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
 	uuid_t root_uuid, l2cap, avctp, avrct, avrctr;
 	sdp_profile_desc_t profile[1];
-	sdp_list_t *aproto, *aproto1, *proto[2], *proto1[2];
+	sdp_list_t *aproto, *proto[2];
 	sdp_record_t *record;
 	sdp_data_t *psm[2], *version, *features;
-	uint16_t lp = AVCTP_CONTROL_PSM, ap = AVCTP_BROWSING_PSM;
+	uint16_t lp = AVCTP_CONTROL_PSM;
 	uint16_t avctp_ver = 0x0103;
 	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
 						AVRCP_FEATURE_CATEGORY_2 |
 						AVRCP_FEATURE_CATEGORY_3 |
-						AVRCP_FEATURE_CATEGORY_4 |
-						AVRCP_FEATURE_BROWSING);
+						AVRCP_FEATURE_CATEGORY_4);
 
 	record = sdp_record_alloc();
 	if (!record)
@@ -415,19 +444,10 @@ static sdp_record_t *avrcp_ct_record(void)
 	sdp_set_access_protos(record, aproto);
 
 	/* Additional Protocol Descriptor List */
-	sdp_uuid16_create(&l2cap, L2CAP_UUID);
-	proto1[0] = sdp_list_append(NULL, &l2cap);
-	psm[1] = sdp_data_alloc(SDP_UINT16, &ap);
-	proto1[0] = sdp_list_append(proto1[0], psm[1]);
-	apseq1 = sdp_list_append(NULL, proto1[0]);
-
-	sdp_uuid16_create(&avctp, AVCTP_UUID);
-	proto1[1] = sdp_list_append(NULL, &avctp);
-	proto1[1] = sdp_list_append(proto1[1], version);
-	apseq1 = sdp_list_append(apseq1, proto1[1]);
-
-	aproto1 = sdp_list_append(NULL, apseq1);
-	sdp_set_add_access_protos(record, aproto1);
+	if (browsing) {
+		feat |= AVRCP_FEATURE_BROWSING;
+		avrcp_browsing_record(record, version);
+	}
 
 	/* Bluetooth Profile Descriptor List */
 	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
@@ -441,15 +461,10 @@ static sdp_record_t *avrcp_ct_record(void)
 	sdp_set_info_attr(record, "AVRCP CT", NULL, NULL);
 
 	free(psm[0]);
-	free(psm[1]);
 	free(version);
 	sdp_list_free(proto[0], NULL);
 	sdp_list_free(proto[1], NULL);
 	sdp_list_free(apseq, NULL);
-	sdp_list_free(proto1[0], NULL);
-	sdp_list_free(proto1[1], NULL);
-	sdp_list_free(aproto1, NULL);
-	sdp_list_free(apseq1, NULL);
 	sdp_list_free(pfseq, NULL);
 	sdp_list_free(aproto, NULL);
 	sdp_list_free(root, NULL);
@@ -458,23 +473,20 @@ static sdp_record_t *avrcp_ct_record(void)
 	return record;
 }
 
-static sdp_record_t *avrcp_tg_record(void)
+static sdp_record_t *avrcp_tg_record(bool browsing)
 {
-	sdp_list_t *svclass_id, *pfseq, *apseq, *root, *apseq_browsing;
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
 	uuid_t root_uuid, l2cap, avctp, avrtg;
 	sdp_profile_desc_t profile[1];
 	sdp_list_t *aproto_control, *proto_control[2];
 	sdp_record_t *record;
-	sdp_data_t *psm_control, *version, *features, *psm_browsing;
-	sdp_list_t *aproto_browsing, *proto_browsing[2] = {0};
+	sdp_data_t *psm_control, *version, *features;
 	uint16_t lp = AVCTP_CONTROL_PSM;
-	uint16_t lp_browsing = AVCTP_BROWSING_PSM;
 	uint16_t avctp_ver = 0x0103;
 	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
 					AVRCP_FEATURE_CATEGORY_2 |
 					AVRCP_FEATURE_CATEGORY_3 |
 					AVRCP_FEATURE_CATEGORY_4 |
-					AVRCP_FEATURE_BROWSING |
 					AVRCP_FEATURE_PLAYER_SETTINGS );
 
 	record = sdp_record_alloc();
@@ -505,17 +517,12 @@ static sdp_record_t *avrcp_tg_record(void)
 
 	aproto_control = sdp_list_append(NULL, apseq);
 	sdp_set_access_protos(record, aproto_control);
-	proto_browsing[0] = sdp_list_append(NULL, &l2cap);
-	psm_browsing = sdp_data_alloc(SDP_UINT16, &lp_browsing);
-	proto_browsing[0] = sdp_list_append(proto_browsing[0], psm_browsing);
-	apseq_browsing = sdp_list_append(NULL, proto_browsing[0]);
-
-	proto_browsing[1] = sdp_list_append(NULL, &avctp);
-	proto_browsing[1] = sdp_list_append(proto_browsing[1], version);
-	apseq_browsing = sdp_list_append(apseq_browsing, proto_browsing[1]);
 
-	aproto_browsing = sdp_list_append(NULL, apseq_browsing);
-	sdp_set_add_access_protos(record, aproto_browsing);
+	/* Additional Protocol Descriptor List */
+	if (browsing) {
+		feat |= AVRCP_FEATURE_BROWSING;
+		avrcp_browsing_record(record, version);
+	}
 
 	/* Bluetooth Profile Descriptor List */
 	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
@@ -528,12 +535,6 @@ static sdp_record_t *avrcp_tg_record(void)
 
 	sdp_set_info_attr(record, "AVRCP TG", NULL, NULL);
 
-	free(psm_browsing);
-	sdp_list_free(proto_browsing[0], NULL);
-	sdp_list_free(proto_browsing[1], NULL);
-	sdp_list_free(apseq_browsing, NULL);
-	sdp_list_free(aproto_browsing, NULL);
-
 	free(psm_control);
 	free(version);
 	sdp_list_free(proto_control[0], NULL);
@@ -4364,12 +4365,14 @@ static void state_changed(struct btd_device *device, avctp_state_t old_state,
 static struct avrcp_server *avrcp_server_register(struct btd_adapter *adapter)
 {
 	struct avrcp_server *server;
+	bool browsing;
 
-	if (avctp_register(adapter, TRUE) < 0)
+	if (avctp_register(adapter, TRUE, &browsing) < 0)
 		return NULL;
 
 	server = g_new0(struct avrcp_server, 1);
 	server->adapter = btd_adapter_ref(adapter);
+	server->browsing = browsing;
 
 	servers = g_slist_append(servers, server);
 
@@ -4687,7 +4690,7 @@ static int avrcp_target_server_probe(struct btd_profile *p,
 		return -EPROTONOSUPPORT;
 
 done:
-	record = avrcp_tg_record();
+	record = avrcp_tg_record(server->browsing);
 	if (!record) {
 		error("Unable to allocate new service record");
 		avrcp_target_server_remove(p, adapter);
@@ -4770,7 +4773,7 @@ static int avrcp_controller_server_probe(struct btd_profile *p,
 		return -EPROTONOSUPPORT;
 
 done:
-	record = avrcp_ct_record();
+	record = avrcp_ct_record(server->browsing);
 	if (!record) {
 		error("Unable to allocate new service record");
 		avrcp_controller_server_remove(p, adapter);
-- 
2.31.1

