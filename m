Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E06C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E34B20B80
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ciCE58r7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgCaI2M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:28:12 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:33670 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730099AbgCaI2L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 04:28:11 -0400
Received: by mail-wm1-f50.google.com with SMTP id z14so1450377wmf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lhpsPY4jlAN7Ykwz9dJPh8jnrQJzpF+87K6jrmmQP9I=;
        b=ciCE58r7hn/nTcSA/xIX322uSzAEmd4QmW1ybXkoYbCRwgrZ7O4YdpSV1HccMQ+RXX
         aNLt8lYn3uC7QhCAkPqcCx8Vw3kGYg14AaCy00+Rtt5+FgkVjJ76otLttJ8s2igl5Dgd
         MAdV+pCIHGLAQ8n4OXnvFh7LrIqhjpQlDEG9Fr101xX5nh1wLlBPnGfuefUNdWHuH1Kt
         a+1X06tE22NZHp/Yzbao99gSSqchWeGaBb9m8YlsNimMnOP1z+lHrdQ1D+0nfpsWOX81
         qsOyeCy4KQlVnh6tum4hjqzFfUXxk05r1WOkR/lhdF6NPW7t7VLzhbBrVCCKWRRbWGxS
         yy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lhpsPY4jlAN7Ykwz9dJPh8jnrQJzpF+87K6jrmmQP9I=;
        b=gTSGKm2kdn79qq4QHE5ZbnHlXSvI8ZQlWWPgXrS4wbuirz7bLGgMpjD5EK+sDT0Pk8
         T/BBkuaCbn06Iebu+AfglIihKO0IhAHhQmkr3vGPrQL275etrXu/3jCQjvNxTADyjfvk
         hLm2ikNV1wt92sN7cWLXMw+DguyX5dS+wy9yu08XbLoM459RhASycrILmgIcA2dmP2t+
         1VShiWkjnbyXxXGyY21sgB/AeZ78cj/jLfzhXhJBczDVmVEeZEQEklQZRgGpvHJmofyl
         jvG7EJrXpRbznB4/GQmUaZ8W7VkCCblzLIVYRLUMhTZqZQYVeJWE8Le6zdF8wNih4b9I
         zRJg==
X-Gm-Message-State: ANhLgQ1JGlr5JfXhhSxRMQqa3t4eRcH3XmE2jv4gRY8XeDYSLiNfLbsN
        npQ2US5+CdRQEo6QrmNCvLrBUw1c1duBDA==
X-Google-Smtp-Source: ADFU+vsu8q3LnJDjMC9nvyI2lwrBnA+cK6rLxL6tt/tp/blHLWuh14ZHBaUa2BuZxu5PSNnEOvFByw==
X-Received: by 2002:a1c:2e04:: with SMTP id u4mr2352140wmu.185.1585643288992;
        Tue, 31 Mar 2020 01:28:08 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x16sm6172296wrn.71.2020.03.31.01.28.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 01:28:08 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] mesh: Honor provisioner's capabilities
Date:   Tue, 31 Mar 2020 10:28:09 +0200
Message-Id: <20200331082810.10856-6-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331082810.10856-1-michal.lowas-rzechonek@silvair.com>
References: <20200331082810.10856-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch makes the daemon select authentication method based from
capabilities supported by both provisioned node and provisioner
application.
---
 mesh/prov-initiator.c  | 82 ++++++++++++++++++++++++++----------------
 tools/mesh-cfgclient.c |  7 ++++
 2 files changed, 58 insertions(+), 31 deletions(-)

diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index 17bda6521..a36d090f3 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -38,6 +38,8 @@
 #include "mesh/agent.h"
 #include "mesh/error.h"
 
+#define MIN(x, y) ((x) < (y) ? (x) : (y))
+
 /* Quick size sanity check */
 static const uint16_t expected_pdu_size[] = {
 	2,	/* PROV_INVITE */
@@ -587,6 +589,44 @@ failure:
 	int_prov_close(prov, fail_code[1]);
 }
 
+static void int_prov_start_auth(const struct mesh_agent_prov_caps *prov_caps,
+				const struct mesh_net_prov_caps *dev_caps,
+				struct prov_start *start)
+{
+	uint8_t pub_type = prov_caps->pub_type & dev_caps->pub_type;
+	uint8_t static_type = prov_caps->static_type & dev_caps->static_type;
+	uint16_t output_action = prov_caps->output_action &
+							dev_caps->output_action;
+	uint8_t output_size = MIN(prov_caps->output_size,
+							dev_caps->output_size);
+	uint16_t input_action = prov_caps->input_action &
+							dev_caps->input_action;
+	uint8_t input_size = MIN(prov_caps->input_size, dev_caps->input_size);
+
+	if (pub_type)
+		start->pub_key = 0x01;
+
+	/* Parse OOB Options, prefer static, then out, then in */
+	if (static_type) {
+		start->auth_method = 0x01;
+		return;
+	}
+
+	if(output_size && output_action) {
+		start->auth_method = 0x02;
+		start->auth_action = u16_high_bit(L_BE16_TO_CPU(output_action));
+		start->auth_size = MIN(output_size, 8);
+		return;
+	}
+
+	if (input_size && input_action) {
+		start->auth_method = 0x03;
+		start->auth_action = u16_high_bit(L_BE16_TO_CPU(input_action));
+		start->auth_size = MIN(input_size, 8);
+		return;
+	}
+}
+
 static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 {
 	struct mesh_prov_initiator *rx_prov = user_data;
@@ -638,43 +678,23 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 			goto failure;
 		}
 
-		/* If Public Key available Out of Band, use it */
-		if (prov->conf_inputs.caps.pub_type) {
-			prov->conf_inputs.start.pub_key = 0x01;
+		/*
+		 * Select auth mechanism from methods supported by both
+		 * parties.
+		 */
+		int_prov_start_auth(mesh_agent_get_caps(prov->agent),
+						&prov->conf_inputs.caps,
+						&prov->conf_inputs.start);
+
+		if (prov->conf_inputs.start.pub_key == 0x01) {
 			prov->expected = PROV_CONFIRM;
 			/* Prompt Agent for remote Public Key */
 			mesh_agent_request_public_key(prov->agent,
 							pub_key_cb, prov);
-
 			/* Nothing else for us to do now */
 		} else
 			prov->expected = PROV_PUB_KEY;
 
-		/* Parse OOB Options, prefer static, then out, then in */
-		if (prov->conf_inputs.caps.static_type) {
-
-			prov->conf_inputs.start.auth_method = 0x01;
-
-		} else if (prov->conf_inputs.caps.output_size &&
-				prov->conf_inputs.caps.output_action) {
-
-			prov->conf_inputs.start.auth_method = 0x02;
-			prov->conf_inputs.start.auth_action =
-					u16_high_bit(l_get_be16(data + 6));
-			prov->conf_inputs.start.auth_size =
-						(data[5] > 8 ? 8 : data[5]);
-
-		} else if (prov->conf_inputs.caps.input_size &&
-				prov->conf_inputs.caps.input_action) {
-
-			prov->conf_inputs.start.auth_method = 0x03;
-			prov->conf_inputs.start.auth_action =
-					u16_high_bit(l_get_be16(data + 9));
-			prov->conf_inputs.start.auth_size =
-						(data[8] > 8 ? 8 : data[8]);
-
-		}
-
 		out = l_malloc(1 + sizeof(prov->conf_inputs.start));
 		out[0] = PROV_START;
 		memcpy(out + 1, &prov->conf_inputs.start,
@@ -789,7 +809,7 @@ static void int_prov_ack(void *user_data, uint8_t msg_num)
 	switch (prov->state) {
 	case INT_PROV_START_SENT:
 		prov->state = INT_PROV_START_ACKED;
-		if (prov->conf_inputs.caps.pub_type == 0)
+		if (!prov->conf_inputs.start.pub_key)
 			send_pub_key(prov);
 		break;
 
@@ -798,7 +818,7 @@ static void int_prov_ack(void *user_data, uint8_t msg_num)
 		break;
 
 	case INT_PROV_KEY_SENT:
-		if (prov->conf_inputs.caps.pub_type == 1)
+		if (prov->conf_inputs.start.pub_key)
 			int_prov_auth();
 		break;
 
diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index eafabf825..08cae899f 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -617,6 +617,13 @@ static bool register_agent(void)
 		return false;
 	}
 
+	if (!l_dbus_object_add_interface(dbus, app.agent_path,
+					 L_DBUS_INTERFACE_PROPERTIES, NULL)) {
+		l_error("Failed to add interface %s",
+					L_DBUS_INTERFACE_PROPERTIES);
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.20.1

