Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06838C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Dec 2021 22:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242399AbhLGW7n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 17:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbhLGW7m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 17:59:42 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754B4C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 14:56:11 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z5so1949485edd.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 14:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yHTPc3cESSW0P5EddWkkzAEgsNh8NzxLBf/zHbglCUY=;
        b=AoTvx1ObzSjrsmidfnGGNw5DMfgftd3ifJC+568GwpV4N42oUUryqUsRMPy6Ju9Xmq
         yeSg8iot1ehMF5WAitCZqdV8aVVsUVkRXHqCCn+1zuEFDpv7lr+86yd6nOy7iB4wrwX/
         QlEOa4L/i0+ndanpVwkN2LobnWdkjijmvLe9lV7y5Pofua7X8+2NSRXZOtxiQWHh9d/p
         178HDouRDNB8bznOF43D/ONlCzE3zePNTveI1exWd0r0bODWCVRwCmvu6Hnac8FFfGvU
         AtsVJWEhJNgqZS0sZml7y0NNx4FVbxApYvXknUE6iKlico3dybiL6N7agNfdbb4B24zE
         x4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHTPc3cESSW0P5EddWkkzAEgsNh8NzxLBf/zHbglCUY=;
        b=MrL3tod3QTr2c9PelqSgfAowBmVdOOQF3tFhyZkDnz0aFXrtfzm3wZk1mJB0kP9znd
         dLDUqFvsL61xBJ+I1yzzj6nViuOdULH6YJpy3j22q3wC6QjKXNX0Fy3V7mChtMOfGIj5
         DSWiduNPKy0VQLCUVcWE9ersqs6vpN46VtIvJgSupN4G894RiF1qJ/S2dbAptn0Fo8rN
         RPUPVvJjcaYADT6CL7BHSTmBuq56s/JOiHv5xKsy7CYlKhvxtfTruBWFTlvyQ32zOkDQ
         pdO5EkVRwmjweDH/TZBw/gq2Mj1aqfinLwPgLO1L/+iDt+NxD5jT/2T6tUhqzsOatvy8
         p4UA==
X-Gm-Message-State: AOAM530wU6qaNzczZh75Np5s4Sub2nopzcz2E5dQpK1lj2KCVCRI3vPL
        yBYBX/Ks/rUybPDcwFDdGiFsqtFYPKE=
X-Google-Smtp-Source: ABdhPJxElm/bZNV6AV3XaFxMwrLlkwxkSwE18+hpmv5KB0jhl8MNLj4Tuap+ZsYaD8LHuDdd9XlmUA==
X-Received: by 2002:a50:e0c9:: with SMTP id j9mr13604127edl.336.1638917770044;
        Tue, 07 Dec 2021 14:56:10 -0800 (PST)
Received: from aspire.cbl.vpn (net-188-217-49-100.cust.vodafonedsl.it. [188.217.49.100])
        by smtp.gmail.com with ESMTPSA id ho30sm489468ejc.30.2021.12.07.14.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 14:56:09 -0800 (PST)
From:   Daniele Biagetti <dbiagio79@gmail.com>
X-Google-Original-From: Daniele Biagetti <daniele.biagetti@cblelectronics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniele Biagetti <daniele.biagetti@cblelectronics.com>
Subject: [PATCH BlueZ 2/6] tools/mesh-gatt: Fix status messages processing
Date:   Tue,  7 Dec 2021 23:56:00 +0100
Message-Id: <20211207225604.35156-3-daniele.biagetti@cblelectronics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207225604.35156-1-daniele.biagetti@cblelectronics.com>
References: <20211207225604.35156-1-daniele.biagetti@cblelectronics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The status messages was processed and displayed even if they do
not belong to the present model. This fix ensure that the status
messages are processed only if they have the correct opcode.
---
 tools/mesh-gatt/node.c        | 11 +++++++++++
 tools/mesh-gatt/onoff-model.c | 23 ++++++++++++-----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/mesh-gatt/node.c b/tools/mesh-gatt/node.c
index 356e1cd1a..4d0cc21e9 100644
--- a/tools/mesh-gatt/node.c
+++ b/tools/mesh-gatt/node.c
@@ -470,6 +470,8 @@ static bool deliver_model_data(struct mesh_element* element, uint16_t src,
 				uint16_t app_idx, uint8_t *data, uint16_t len)
 {
 	GList *l;
+	uint32_t opcode;
+	int n;
 
 	for(l = element->models; l; l = l->next) {
 		struct mesh_model *model = l->data;
@@ -482,6 +484,15 @@ static bool deliver_model_data(struct mesh_element* element, uint16_t src,
 			return true;
 	}
 
+	if (mesh_opcode_get(data, len, &opcode, &n)) {
+		len -= n;
+		data += n;
+	} else
+		return false;
+	bt_shell_printf("Unknown Model Message received (%d) opcode %x\n",
+						len, opcode);
+	print_byte_array("\t",data, len);
+
 	return false;
 }
 
diff --git a/tools/mesh-gatt/onoff-model.c b/tools/mesh-gatt/onoff-model.c
index 13ff4bbe3..1c9676e03 100644
--- a/tools/mesh-gatt/onoff-model.c
+++ b/tools/mesh-gatt/onoff-model.c
@@ -99,6 +99,7 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 {
 	uint32_t opcode;
 	int n;
+	char s[128];
 
 	if (mesh_opcode_get(data, len, &opcode, &n)) {
 		len -= n;
@@ -106,27 +107,27 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 	} else
 		return false;
 
-	bt_shell_printf("On Off Model Message received (%d) opcode %x\n",
-								len, opcode);
-	print_byte_array("\t",data, len);
-
 	switch (opcode) {
 	default:
 		return false;
 
 	case OP_GENERIC_ONOFF_STATUS:
+		bt_shell_printf("On Off Model Message received (%d) opcode %x\n",
+			len, opcode);
+		print_byte_array("\t",data, len);
 		if (len != 1 && len != 3)
 			break;
 
-		bt_shell_printf("Node %4.4x: Off Status present = %s",
-						src, data[0] ? "ON" : "OFF");
-
+		snprintf(s, sizeof(s), "Node %4.4x: On Off Status present = %s",
+			src, data[0] ? "ON" : "OFF");
 		if (len == 3) {
-			bt_shell_printf(", target = %s",
-					data[1] ? "ON" : "OFF");
+			snprintf(s + strlen(s), sizeof(s), ", target = %s",
+				data[1] ? "ON" : "OFF");
+			bt_shell_printf("%s\n", s);
 			print_remaining_time(data[2]);
-		} else
-			bt_shell_printf("\n");
+		}else
+			bt_shell_printf("%s\n", s);
+
 		break;
 	}
 
-- 
2.25.1

