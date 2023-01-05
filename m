Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35D5C54EF0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Jan 2023 22:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjAEWKP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Jan 2023 17:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjAEWJw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Jan 2023 17:09:52 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1432967BEA
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jan 2023 14:09:51 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id n4so40802577plp.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jan 2023 14:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gw6itf7AVrCO7LXSXZODgQaXufV/CbE8VRMeicmNgDc=;
        b=TyWwwYCGbAZpp2Qiwlr03WssIfQgQ21+P0AZPHakekrKtRUp/u/YoQ9fx9DbCWACcA
         IbzEQy0xekxmwEJOHXQzromGzkKPnUheWkbAFUGrpl3twIAbSeX81hgN5krj9a3IQ7EF
         vwwskenk7Ns0jB9NEGRHaxmx22Qed6mVMrDi02umU44o8q/TjFIJjRgo9LBHWS560FkN
         EEMjRXmOZ/Cj/6B4nud3fmgHBsPaEhWBL9twEMLqUiUqSLxX05q9KXjDRhq07mBB3dVV
         OaaVjAWEfRx4HhyLgY6rDdH1+mcdguh2DZ8ok20pPoiBY6tilXQxWN+kidRUsoAE0aLz
         dzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gw6itf7AVrCO7LXSXZODgQaXufV/CbE8VRMeicmNgDc=;
        b=Tn/+bMmwHfEcOc1t3Teehz4d/fjXQ6/ujUKtOrwRTg/LnvU0YqFXS75IJhxiK/DL5V
         C+488s5SdFKbIURnmMp9H2hIFDNNxP8i31rZNRvK3pkJn4ceGezcbL8uMkqLx5Oyocxf
         P1j8tN2/SFixFA/qcN3/ZtBmHeWUA5Tiysv/XfHWdJsBx35nawdnYOpn++0vFfQV5JHc
         7+yBBRRML8wTry/7mTmsKMiIhlLSW/PlXrsmmX2FGC4fU4tbc4hCvehlT22isJms05EY
         DKjPnz6L8OvzE9UHllTxbKJecB7Huj42l1/ce1E1ojjts16hXrD9fUT5DA1D3HRmyCCT
         yeIA==
X-Gm-Message-State: AFqh2krJMFTO6xvhf7SdQIUpNgQrZxSOo35x83Hc7lDg2hUXnX+ZlW/6
        nNor4RG1SsIv591q+7SGc36RGK7syN4=
X-Google-Smtp-Source: AMrXdXsLuC1cDYsMsk15nn4cuu3YURR9Qx8FjQK6Se4CmamgruT++5EriN6GVQNzviijVlWsIZHiEw==
X-Received: by 2002:a17:903:3311:b0:189:d696:63e2 with SMTP id jk17-20020a170903331100b00189d69663e2mr58379339plb.39.1672956589964;
        Thu, 05 Jan 2023 14:09:49 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id jg21-20020a17090326d500b001929827731esm16744861plb.201.2023.01.05.14.09.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:09:49 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] attrib: Introduce g_attrib_attach_client
Date:   Thu,  5 Jan 2023 14:09:43 -0800
Message-Id: <20230105220944.2373424-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230105220944.2373424-1-luiz.dentz@gmail.com>
References: <20230105220944.2373424-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces g_attrib_attach_client which can be used to attach a
bt_gatt_client instance to GAttr so it can be used to register
notifications.
---
 Makefile.am      |  6 +++---
 attrib/gattrib.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 attrib/gattrib.h |  2 ++
 3 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index aa3a5e053cd8..0e8cce249c7d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -565,9 +565,9 @@ unit_tests += unit/test-gattrib
 
 unit_test_gattrib_SOURCES = unit/test-gattrib.c attrib/gattrib.c \
 					$(btio_sources) src/log.h src/log.c
-unit_test_gattrib_LDADD = lib/libbluetooth-internal.la \
-			src/libshared-glib.la \
-			$(GLIB_LIBS) $(DBUS_LIBS) -ldl -lrt
+unit_test_gattrib_LDADD = src/libshared-glib.la \
+				lib/libbluetooth-internal.la \
+				$(GLIB_LIBS) $(DBUS_LIBS) -ldl -lrt
 
 unit_tests += unit/test-bap
 
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 041b9d289c64..997af3699c51 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -21,17 +21,23 @@
 #include <glib.h>
 
 #include "lib/bluetooth.h"
+#include "lib/uuid.h"
 
 #include "btio/btio.h"
 #include "src/log.h"
 #include "src/shared/util.h"
 #include "src/shared/att.h"
+#include "src/shared/gatt-helpers.h"
 #include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
+#include "attrib/att.h"
 #include "attrib/gattrib.h"
 
 struct _GAttrib {
 	int ref_count;
 	struct bt_att *att;
+	struct bt_gatt_client *client;
 	GIOChannel *io;
 	GDestroyNotify destroy;
 	gpointer destroy_user_data;
@@ -145,6 +151,7 @@ void g_attrib_unref(GAttrib *attrib)
 	if (attrib->destroy)
 		attrib->destroy(attrib->destroy_user_data);
 
+	bt_gatt_client_unref(attrib->client);
 	bt_att_unref(attrib->att);
 
 	queue_destroy(attrib->callbacks, attrib_callbacks_destroy);
@@ -338,6 +345,20 @@ gboolean g_attrib_cancel_all(GAttrib *attrib)
 	return TRUE;
 }
 
+static void client_notify_cb(uint16_t value_handle, const uint8_t *value,
+				uint16_t length, void *user_data)
+{
+	uint8_t *buf = newa(uint8_t, length + 2);
+
+	put_le16(value_handle, buf);
+
+	if (length)
+		memcpy(buf + 2, value, length);
+
+	attrib_callback_notify(NULL, ATT_OP_HANDLE_NOTIFY, buf, length + 2,
+							user_data);
+}
+
 guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
 				GAttribNotifyFunc func, gpointer user_data,
 				GDestroyNotify notify)
@@ -359,6 +380,16 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
 		queue_push_head(attrib->callbacks, cb);
 	}
 
+	if (opcode == ATT_OP_HANDLE_NOTIFY && attrib->client) {
+		unsigned int id;
+
+		id = bt_gatt_client_register_notify(attrib->client, handle,
+						NULL, client_notify_cb, cb,
+						attrib_callbacks_remove);
+		if (id)
+			return id;
+	}
+
 	if (opcode == GATTRIB_ALL_REQS)
 		opcode = BT_ATT_ALL_REQUESTS;
 
@@ -410,6 +441,21 @@ gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
 	return bt_att_set_mtu(attrib->att, mtu);
 }
 
+gboolean g_attrib_attach_client(GAttrib *attrib, struct bt_gatt_client *client)
+{
+	if (!attrib || !client)
+		return FALSE;
+
+	if (attrib->client)
+		bt_gatt_client_unref(attrib->client);
+
+	attrib->client = bt_gatt_client_clone(client);
+	if (!attrib->client)
+		return FALSE;
+
+	return TRUE;
+}
+
 gboolean g_attrib_unregister(GAttrib *attrib, guint id)
 {
 	if (!attrib)
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index c2877d757342..0111bfc3f2fa 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -19,6 +19,7 @@ extern "C" {
 #define GATTRIB_ALL_HANDLES 0x0000
 
 struct bt_att;  /* Forward declaration for compatibility */
+struct bt_gatt_client;  /* Forward declaration for compatibility */
 struct _GAttrib;
 typedef struct _GAttrib GAttrib;
 
@@ -53,6 +54,7 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
 
 uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len);
 gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu);
+gboolean g_attrib_attach_client(GAttrib *attrib, struct bt_gatt_client *client);
 
 gboolean g_attrib_unregister(GAttrib *attrib, guint id);
 gboolean g_attrib_unregister_all(GAttrib *attrib);
-- 
2.37.3

