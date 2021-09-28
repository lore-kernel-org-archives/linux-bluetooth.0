Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76E9C43217
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 23:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3B261157
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 23:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243455AbhI1X4t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243386AbhI1X4c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 19:56:32 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF39C061745
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 16:54:52 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k24so758271pgh.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 16:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AFFUjaeFnLQaYqJNy3oN5/VyuAh8ZFLxv9VhQZ/SAow=;
        b=QC7MQmjiY6mxmWZqR1FYy2cxr92pfv+unfneV8IeRXAjmkdpa6JbxUTwO0mrhGEeg6
         Zq02qLxjep4W8YzBoT61XMfrC1mA04ImWlzLMgtx7fvp3/Rec8F74+5LUCNrTXzMg+FV
         86Y0aS8HBk2XF8qWftel66ZRt+DRaqKoRnCDawlKkKIg8WrzQwerUqXRdg/xUQmKyRwU
         F5+PlCsRTQavmG7ugtnzoYUpkrZMsgqlSlekRxeaIjVAcM7IOs8HDiUV3QHLzjz/O2OC
         04G9nqdWt+Xw414LuI6WGsFer4DKloCVIo8qX+2jLrsWtXUVGGi49IusLStNCF3kcLi4
         T7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AFFUjaeFnLQaYqJNy3oN5/VyuAh8ZFLxv9VhQZ/SAow=;
        b=wPwO4sfCurdmGhYaOOM+oBR3a/17sENVYy27KxE8rvKt2uEoG2oQf8Qm9HuzTnl8qK
         rtyXrbfdAsOTJxtq/jnPxAlA9ZUGFPuEEhRvJHXgtpsbCn5JSAzDQ5jkgWZpxrDPmzdZ
         JSSQLpzyUTLRcIo0fgkGJXvMMR6e3XC8JNfOdYA8TwU2eTp9oBKbm1YtCwvD1JtiENgu
         D2vt1+RcQI5hnLUTYDvElSqezTRF4qwhFFDVqoVwN11zEjDhVPav+1aRNsIeZnEu+jtf
         DexTroauezhVzYVdKGQjGytVy8TbYEzcM0x8wAKda/P216gOdR9rXOCrMgnU3AaYy8lv
         OXIQ==
X-Gm-Message-State: AOAM532hRPpikP7dY5Zx8y3LLh88/MBoDA+tZ/JYxy8XEjDB97/b8/VQ
        QBggzH3ixDA+GNdfu9cWpgNRBMSWzvQ=
X-Google-Smtp-Source: ABdhPJy6CZZB3CAgZSrEDZ++U6o1pdXuMsJ5rfRVx0eCww4MuIziDdS6kHYA6t0gShkk2gWd6LUNkQ==
X-Received: by 2002:a63:cc08:: with SMTP id x8mr5652099pgf.166.1632873291418;
        Tue, 28 Sep 2021 16:54:51 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o2sm3553139pja.7.2021.09.28.16.54.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:54:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] gatt: Emit PropertiesChanged("MTU") when MTU is exchanged
Date:   Tue, 28 Sep 2021 16:54:46 -0700
Message-Id: <20210928235447.3077055-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928235447.3077055-1-luiz.dentz@gmail.com>
References: <20210928235447.3077055-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This notifies client when the ATT MTU changes.
---
 src/gatt-client.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 5b10cbfa0..de18bea97 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -104,6 +104,7 @@ struct characteristic {
 	char *path;
 
 	unsigned int ready_id;
+	unsigned int exchange_id;
 	struct sock_io *write_io;
 	struct sock_io *notify_io;
 
@@ -1707,6 +1708,8 @@ static void remove_client(void *data)
 static void characteristic_free(void *data)
 {
 	struct characteristic *chrc = data;
+	struct bt_gatt_client *gatt = chrc->service->client->gatt;
+	struct bt_att *att;
 
 	/* List should be empty here */
 	queue_destroy(chrc->descs, NULL);
@@ -1723,15 +1726,29 @@ static void characteristic_free(void *data)
 
 	queue_destroy(chrc->notify_clients, remove_client);
 
+	att = bt_gatt_client_get_att(gatt);
+	if (att)
+		bt_att_unregister_exchange(att, chrc->exchange_id);
+
 	g_free(chrc->path);
 	free(chrc);
 }
 
+static void att_exchange(uint16_t mtu, void *user_data)
+{
+	struct characteristic *chrc = user_data;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), chrc->path,
+					GATT_CHARACTERISTIC_IFACE, "MTU");
+}
+
 static struct characteristic *characteristic_create(
 						struct gatt_db_attribute *attr,
 						struct service *service)
 {
 	struct characteristic *chrc;
+	struct bt_gatt_client *gatt = service->client->gatt;
+	struct bt_att *att;
 	bt_uuid_t uuid;
 
 	chrc = new0(struct characteristic, 1);
@@ -1770,6 +1787,11 @@ static struct characteristic *characteristic_create(
 		return NULL;
 	}
 
+	att = bt_gatt_client_get_att(gatt);
+	if (att)
+		chrc->exchange_id = bt_att_register_exchange(att, att_exchange,
+								chrc, NULL);
+
 	DBG("Exported GATT characteristic: %s", chrc->path);
 
 	return chrc;
-- 
2.31.1

