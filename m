Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC17C433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD242220B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrQUzovl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgIPX0F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 19:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgIPX0C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 19:26:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FB2C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:26:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v3so386271yba.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=RDn4qmzaK+DPbn7H086U+3kMev3mJs6C/TacCte6F1o=;
        b=ZrQUzovlfLclHjijnf3c0MwYzd7EtyV1jNyxR97xAwpM1zKcq5it0WwVwUtVoJWy7z
         9ep4Ds97ODBev9BUViAomluXpjLP2Lxgf6DiIQ4BM74rp791inS5F9UiJFjMSWql7zkA
         C2SIgSFHjHPyYixcdOvjuGbA64IAkclxir89T0hMz/qahu8PDHj/2sereroYi2t8+02q
         +mA5PSRgktoyQzl6nKISOodxWGyrkYFlNQeBDe1bUC32r9oKlybxC4ryUeHXs6QNUha6
         502M0jwfUStjmHCzVwf3yha/xRojV1Dgc37YbcUKy1GqLNpPakHN9UaOEkkWEIG3h/QK
         ahkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RDn4qmzaK+DPbn7H086U+3kMev3mJs6C/TacCte6F1o=;
        b=AJLxK6B1kqxCKsc3Hn+F1sRpN8CW95NQFvMAYqb+8jrK9l0d1ymGO/gGJCVQeSaZEb
         zV2dTi+bTP7+OZf0iHtGL1KzXRdGLvIWgbPk49toq6PSfJG9qugAZdQ/pcGG9sMiHR26
         nhWOwvzIQXBKn3/VTnc5axp8v3w/Obh+hwCYngSNrBgnzBGwNa/Uk38YRNBX7DmJukqQ
         6NFtmhy858tZXgSOjtuSjbIUToI9DvaIzpufPDfee11aRx413u+JB2gElFs3Qlnw8U+X
         7B7qGmB8UUgK0VsT53eIS/ACK4PfgvgW4S+4nMi9oqmT8N+0a/M6KtlDPfS38H7Py0bq
         v83A==
X-Gm-Message-State: AOAM531G+crXUrsvA5gOT3GtZROli7yNS12FLEg8euj2XMHD2T7YBl64
        KucNqXw/OQF1TJ+L+LbPFp93bKi/0pb6KIrhnLBq
X-Google-Smtp-Source: ABdhPJxYBlMUSl2gGaVuCpcMYKztsQYUb9Ky1V8qms2lZouU442XpUqu67XjDaxG2BCMJZw/xTlCctN/RbMseeu1P7Va
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:3585:: with SMTP id
 c127mr8325177yba.374.1600298761623; Wed, 16 Sep 2020 16:26:01 -0700 (PDT)
Date:   Wed, 16 Sep 2020 16:25:37 -0700
In-Reply-To: <20200916232542.1584854-1-danielwinkler@google.com>
Message-Id: <20200916162155.Bluez.5.I187f71748b9bd93f6bf97ec4a195216109c3ea06@changeid>
Mime-Version: 1.0
References: <20200916232542.1584854-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [Bluez PATCH 05/10] advertising: Query LE TX range at manager initialization
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch calls the new MGMT command to get controller capabilities,
and parses the min and max LE tx power range when the manager is
initialized. This will be used to populate a client-facing dbus entry so
that the client will know the advertising capabilities of the controller
before registering an advertisement.

This patch is tested by manually verifying the data is parsed correctly
from the MGMT response.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 lib/mgmt.h        |  8 +++++++
 src/advertising.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 97f8dd9b4..dbabb513f 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -744,6 +744,14 @@ struct mgmt_rp_add_ext_adv_data {
 	uint8_t	instance;
 } __packed;
 
+#define MGMT_CAP_LE_TX_PWR_MIN	0x0001
+#define MGMT_CAP_LE_TX_PWR_MAX	0x0002
+
+#define MGMT_OP_READ_CONTROLLER_CAP	0x0056
+struct mgmt_rp_read_controller_cap {
+	uint8_t capabilities[0]; /* mgmt_tlv */
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
diff --git a/src/advertising.c b/src/advertising.c
index 0269c9224..02aa11934 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -58,6 +58,8 @@ struct btd_adv_manager {
 	uint32_t supported_flags;
 	unsigned int instance_bitmap;
 	bool extended_add_cmds;
+	int8_t min_tx_power;
+	int8_t max_tx_power;
 };
 
 #define AD_TYPE_BROADCAST 0
@@ -1750,6 +1752,54 @@ static void read_commands_complete(uint8_t status, uint16_t length,
 			      manager, NULL);
 }
 
+static void read_controller_cap_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_adv_manager *manager = user_data;
+	const uint8_t *ptr = param;
+	uint16_t offset = 0;
+
+	/* Both capabilities we care about are stored as int8_t. If we later
+	 * want to track other types, this structure will need to change
+	 */
+	const struct {
+		struct mgmt_tlv entry;
+		int8_t value;
+	} __packed * cap;
+
+	while (offset < length) {
+		/* Since TLV entries can have variable length, offset tracks how
+		 * far into the member we are, so that cap is always pointing
+		 * to the beginning of a valid struct
+		 */
+		cap = (void *)&ptr[offset];
+		switch (cap->entry.type) {
+		case MGMT_CAP_LE_TX_PWR_MIN:
+			if (cap->entry.length !=
+					sizeof(manager->min_tx_power)) {
+				error("TX power had unexpected length %d",
+					cap->entry.length);
+				break;
+			}
+			memcpy(&manager->min_tx_power, &cap->value,
+					cap->entry.length);
+			break;
+		case MGMT_CAP_LE_TX_PWR_MAX:
+			if (cap->entry.length !=
+					sizeof(manager->min_tx_power)) {
+				error("TX power had unexpected length %d",
+					cap->entry.length);
+				break;
+			}
+			memcpy(&manager->max_tx_power, &cap->value,
+					cap->entry.length);
+			break;
+		}
+
+		offset += sizeof(cap->entry) + cap->entry.length;
+	}
+}
+
 static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 						struct mgmt *mgmt)
 {
@@ -1770,6 +1820,8 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 	manager->clients = queue_new();
 	manager->supported_flags = MGMT_ADV_FLAG_LOCAL_NAME;
 	manager->extended_add_cmds = false;
+	manager->min_tx_power = ADV_TX_POWER_NO_PREFERENCE;
+	manager->max_tx_power = ADV_TX_POWER_NO_PREFERENCE;
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					adapter_get_path(manager->adapter),
@@ -1793,6 +1845,13 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 	mgmt_send(manager->mgmt, MGMT_OP_READ_COMMANDS, MGMT_INDEX_NONE, 0,
 		  NULL, read_commands_complete, manager, NULL);
 
+	/* Query controller capabilities. This will be used to display valid
+	 * advertising tx power range to the client.
+	 */
+	mgmt_send(manager->mgmt, MGMT_OP_READ_CONTROLLER_CAP,
+			manager->mgmt_index, 0, NULL,
+			read_controller_cap_complete, manager, NULL);
+
 	return manager;
 
 fail:
-- 
2.28.0.618.gf4bc123cb7-goog

