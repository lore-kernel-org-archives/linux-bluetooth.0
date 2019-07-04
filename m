Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77BDC0651C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 12:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6ED2082E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 12:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="g15GhW3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfGDMds (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:33:48 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:42512 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfGDMdr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jul 2019 08:33:47 -0400
Received: by mail-lj1-f178.google.com with SMTP id t28so5988658lje.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2019 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zlw8L5+yskUSC4tHVm2lBZcPGopq19rqAKLUeoXmxvo=;
        b=g15GhW3xaff0syWftJzjBVevBcvoL4e+AHWLhKjL7BWV+hQewrQYW48TzhLVToSpZn
         Z5BBZYzlmdfXSU4akXbtLMjRhdZ1r5oZFQ1V0r5i7Es2raVGHcXNGaIbYQHaBBxNxcxo
         MJEE4B0aQgGbeJs/nTwO3PAjFwBencb+tNWXq1uTXbQ35QbA0iXvRdfgRo/ZWhuH4rNf
         At9hBpEPtva1K8eFHJyxjaFdKddXD8UxqvL8CmjjL4N0Dgt58rMFDcbW6Tu54KbGc6Lq
         TC/H47me+UkW2BOXe6R+/mcNAQ9vInhW0eiIa6ptDhlkK+An0CqX163YGdRUtRverLzF
         XM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zlw8L5+yskUSC4tHVm2lBZcPGopq19rqAKLUeoXmxvo=;
        b=BPGVdTGkJszP1sj1x6WdOwe5MrOJB+Y5yfUzD+jmfhjlXa44b+VfMGCTuu+uyw6LZR
         g9FRnFSbHHyN4LmYHdbmIWC9DpTmT0KwsEkzfz7cqVf8kHpzwMPF1IgddOLAr7QNSUTT
         Y7lGKeg1AMP7x7btqTnoCMCcNhoFAcSy/4p+EwUo5ba7MrmN2zioLyeBFJS1UxfFJhqS
         RKmkIaXZ6PQDCc6ttFOdCNMkP526vSrFkRN7juGcZ+rDxAsEH2zwB1lp4+YDKNzI95NX
         NyjgYIDcuBEjbPlw1cFJu7YB5LvUkqD2AzpwV9tqcR/DovCnOFtMXP6jP9lD9MdDERcG
         wWHA==
X-Gm-Message-State: APjAAAWFrT7dzkeRzewwQSQTHTSO3TXsaKHuN9SP7x1ctzwkvIqPrPvX
        SuGPbryNvpl521KVx7U31DoaImkVkuk=
X-Google-Smtp-Source: APXvYqwMcMlUXfOhYf2CIMaKYMSQqNAgkA6T3Su+3+tvJFPa0phIwN1d1puQ+PhIf4SowrTCLfZ9EQ==
X-Received: by 2002:a2e:298a:: with SMTP id p10mr24159244ljp.74.1562243625490;
        Thu, 04 Jul 2019 05:33:45 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id g68sm1126151ljg.47.2019.07.04.05.33.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 05:33:44 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v5 2/5] mesh: Cleanup D-Bus method returns with empty result
Date:   Thu,  4 Jul 2019 14:33:35 +0200
Message-Id: <20190704123338.5988-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190704123338.5988-1-michal.lowas-rzechonek@silvair.com>
References: <20190704123338.5988-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/node.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 1dcb74b4f..53876ef5a 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1949,7 +1949,6 @@ static struct l_dbus_message *send_call(struct l_dbus *dbus,
 	uint16_t dst, app_idx, src;
 	uint8_t *data;
 	uint32_t len;
-	struct l_dbus_message *reply;
 
 	l_debug("Send");
 
@@ -1978,10 +1977,7 @@ static struct l_dbus_message *send_call(struct l_dbus *dbus,
 				mesh_net_get_default_ttl(node->net), data, len))
 		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
 
-	reply = l_dbus_message_new_method_return(msg);
-	l_dbus_message_set_arguments(reply, "");
-
-	return reply;
+	return l_dbus_message_new_method_return(msg);
 }
 
 static struct l_dbus_message *publish_call(struct l_dbus *dbus,
@@ -1995,7 +1991,6 @@ static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 	struct node_element *ele;
 	uint8_t *data;
 	uint32_t len;
-	struct l_dbus_message *reply;
 	int result;
 
 	l_debug("Publish");
@@ -2027,10 +2022,7 @@ static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 	if (result != MESH_ERROR_NONE)
 		return dbus_error(msg, result, NULL);
 
-	reply = l_dbus_message_new_method_return(msg);
-	l_dbus_message_set_arguments(reply, "");
-
-	return reply;
+	return l_dbus_message_new_method_return(msg);
 }
 
 static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
@@ -2046,7 +2038,6 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 	struct node_element *ele;
 	uint8_t *data = NULL;
 	uint32_t len;
-	struct l_dbus_message *reply;
 	int result;
 
 	l_debug("Publish");
@@ -2079,10 +2070,7 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 	if (result != MESH_ERROR_NONE)
 		return dbus_error(msg, result, NULL);
 
-	reply = l_dbus_message_new_method_return(msg);
-	l_dbus_message_set_arguments(reply, "");
-
-	return reply;
+	return  l_dbus_message_new_method_return(msg);
 }
 
 static void setup_node_interface(struct l_dbus_interface *iface)
-- 
2.19.1

