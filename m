Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C009BC3815B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 08:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995362072D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 08:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="IzhGtzvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437247AbgDNIzw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437242AbgDNIzr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 04:55:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCFFC008769
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 01:55:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x18so9079834wrq.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 01:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1vJvsZdK9Zte0jn8KQyvh97y2PKBP0yP5HpQaCPeJ7g=;
        b=IzhGtzvb+v5xTtbf2GhcWg73YVCvNaiQQJ4rPxfZW+1TMBsNA+casulg/kUJzzqrTi
         aeSdZIjd4gZF59w4R+5gpt5Lc5hDBB7kCfQaU7IF0y1gwyu3PJTrEtKaXAslV1V0NKkz
         /0Sc9APzYgjCKVNQ7j/y5OLlcvuhoCgnkcsjpLPzS645LIwQMyerhyifRDY0l92CB2os
         m4bUTBKm4Vjv++OVfeK37PlLh9k2548huKjJgYY8RL9Jjk7fI8C5prWjE+JWLZJtez6i
         u7sjcCzR4Ou5DYNC9TB1s9o1Z00kzBC6w117GLAHv2HeqCd8Yxcy5rC3lLL/Op4T86fc
         dZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vJvsZdK9Zte0jn8KQyvh97y2PKBP0yP5HpQaCPeJ7g=;
        b=ewpKNUhOGlCibMGesXHJ6aMm1nTx7Ke2zzuU6Ym3//2Y8VylQ585OtD5V4zjW3gzZ4
         l55mgDrJQawWOR7wJ398mpwmBv2YgoSN/Jbd/c/1D6XYllYqazELQe9IBMxeMnBXh5TD
         ZATC+f6ZSnwVJCzG6Q1tXhkMgJ4pHqn+wOnisrEg/YENC6OeSEOLsYDaqOa9Rwpxk9cs
         4k9eGsEeolNLBmOkLOKs9U9k0BgagWoY/Dr4fy+MBK2xhiFirJXwuG2mHZtIdUsviED6
         wGvGFRgrEJE+AzA58wR99G3zK4ksr5nwosO7WDr4MNVbQeWUs6VYu/9ILLFE7srSqisl
         lIlw==
X-Gm-Message-State: AGi0Pua3VnrhZKB4nBApvixwKk7KkTQfc6r5qiE9VxMfUMoAJBawCvS4
        Nl1UY4gfk3VbYPjZ6JrP9aUKJjMeQno=
X-Google-Smtp-Source: APiQypIi/d1Ny+uaF2GVoosCR+5a0xmFlmljyKWuUHetngZzDRNdRMNHEfkcBe9v5l2RofkG+Qo7pQ==
X-Received: by 2002:a05:6000:8f:: with SMTP id m15mr19574914wrx.19.1586854545363;
        Tue, 14 Apr 2020 01:55:45 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id w83sm18361553wmb.37.2020.04.14.01.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 01:55:44 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v5 4/4] mesh: Add Time-outs to critical dbus send-with-replies
Date:   Tue, 14 Apr 2020 10:55:57 +0200
Message-Id: <20200414085557.23464-5-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414085557.23464-1-michal.lowas-rzechonek@silvair.com>
References: <20200414085557.23464-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

JoinComplete() dbus method calls are the only time that node tokens are
delivered to client Applications, so if the call fails for any reason
(including time-outs) the daemon has a way to clean-up the stale unused
node data.
---
 mesh/dbus.c | 40 ++++++++++++++++++++++++++++++++++++++++
 mesh/dbus.h |  6 ++++++
 mesh/mesh.c |  8 ++++----
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/mesh/dbus.c b/mesh/dbus.c
index 6b9694ab7..bf0f73bd9 100644
--- a/mesh/dbus.c
+++ b/mesh/dbus.c
@@ -37,6 +37,14 @@ struct error_entry {
 	const char *default_desc;
 };
 
+struct send_info {
+	struct l_dbus *dbus;
+	struct l_timeout *timeout;
+	l_dbus_message_func_t cb;
+	void *user_data;
+	uint32_t serial;
+};
+
 /*
  * Important: The entries in this table follow the order of
  * enumerated values in mesh_error (file error.h)
@@ -143,3 +151,35 @@ void dbus_append_dict_entry_basic(struct l_dbus_message_builder *builder,
 	l_dbus_message_builder_leave_variant(builder);
 	l_dbus_message_builder_leave_dict(builder);
 }
+
+static void send_reply(struct l_dbus_message *message, void *user_data)
+{
+	struct send_info *info = user_data;
+
+	l_timeout_remove(info->timeout);
+	info->cb(message, info->user_data);
+	l_free(info);
+}
+
+static void send_timeout(struct l_timeout *timeout, void *user_data)
+{
+	struct send_info *info = user_data;
+
+	l_dbus_cancel(info->dbus, info->serial);
+	send_reply(NULL, info);
+}
+
+void dbus_send_with_timeout(struct l_dbus *dbus, struct l_dbus_message *msg,
+						l_dbus_message_func_t cb,
+						void *user_data,
+						unsigned int seconds)
+{
+	struct send_info *info = l_new(struct send_info, 1);
+
+	info->dbus = dbus;
+	info->cb = cb;
+	info->user_data = user_data;
+	info->serial = l_dbus_send_with_reply(dbus, msg, send_reply,
+								info, NULL);
+	info->timeout = l_timeout_create(seconds, send_timeout, info, NULL);
+}
diff --git a/mesh/dbus.h b/mesh/dbus.h
index e7643a59d..aafb85f6b 100644
--- a/mesh/dbus.h
+++ b/mesh/dbus.h
@@ -20,6 +20,8 @@
 #define BLUEZ_MESH_PATH "/org/bluez/mesh"
 #define BLUEZ_MESH_SERVICE "org.bluez.mesh"
 
+#define DEFAULT_DBUS_TIMEOUT	30
+
 bool dbus_init(struct l_dbus *dbus);
 struct l_dbus *dbus_get_bus(void);
 void dbus_append_byte_array(struct l_dbus_message_builder *builder,
@@ -31,3 +33,7 @@ bool dbus_match_interface(struct l_dbus_message_iter *interfaces,
 							const char *match);
 struct l_dbus_message *dbus_error(struct l_dbus_message *msg, int err,
 						const char *description);
+void dbus_send_with_timeout(struct l_dbus *dbus, struct l_dbus_message *msg,
+						l_dbus_message_func_t cb,
+						void *user_data,
+						unsigned int seconds);
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 01e39e916..21e1517db 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -478,8 +478,8 @@ static bool prov_complete_cb(void *user_data, uint8_t status,
 						"JoinComplete");
 
 	l_dbus_message_set_arguments(msg, "t", l_get_be64(token));
-	l_dbus_send_with_reply(dbus, msg,
-				prov_join_complete_reply_cb, NULL, NULL);
+	dbus_send_with_timeout(dbus, msg, prov_join_complete_reply_cb,
+						NULL, DEFAULT_DBUS_TIMEOUT);
 
 	return true;
 }
@@ -725,8 +725,8 @@ static void create_node_ready_cb(void *user_data, int status,
 						"JoinComplete");
 
 	l_dbus_message_set_arguments(msg, "t", l_get_be64(token));
-	l_dbus_send_with_reply(dbus, msg,
-				create_join_complete_reply_cb, node, NULL);
+	dbus_send_with_timeout(dbus, msg, create_join_complete_reply_cb,
+						node, DEFAULT_DBUS_TIMEOUT);
 }
 
 static struct l_dbus_message *create_network_call(struct l_dbus *dbus,
-- 
2.20.1

