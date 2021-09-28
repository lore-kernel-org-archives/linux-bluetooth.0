Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A732C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 23:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB6F60C41
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 23:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243407AbhI1X4f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243374AbhI1X4a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 19:56:30 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CA4C061749
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 16:54:50 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 75so782896pga.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 16:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cIWX3GVqCks5D8CirVP04qH6BoEaZjhhHgSKRL5/GXw=;
        b=T7AC8Umi4iKqvpxAbbUuHlOHSUb2z73OAtR873OSso1tpzBoZuuNwJwgGBY84LCmDW
         6+6H6qt5nPG5xmWAzRK/wyTJXl4jEmpk3Mp7Xgus1xIQWfYZ7Jgt2YrTBLMzJb7k5BAm
         rMHX/nkvFc+7Gykqr/Cbaww0sPHhh/NivuANj2baaAd34qKx00gD6NvqcRFO5cl2ngAM
         FbB+gtaCCJBp5fewcAUvJo5DpWqD5nCYX0fjzYpghkRUdC4oyLwB5oVUeie2cmKl8Z3l
         m/I7ZTZQjTr3rgLNAMXYbRFmF4o7lB+Vy+gCl8aOb9AVV8JTqibz2VFOV3gkBdftvy3C
         VJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cIWX3GVqCks5D8CirVP04qH6BoEaZjhhHgSKRL5/GXw=;
        b=QtOh2CSiEV2yzO2VsBWIVjkFwhM3qlAXJr1hpJDqtPoUVjGfvmpgooeJsLbqvU7W4J
         U6AfFfbI53o84QQ3BUTxIUjpwC+0n9ZeUgPOSiqwsRujg0pwOYjjoQGa+/PFkHQEY7vu
         Bp/P157THZ/Ho+5KxzzpdjFPG5LJbB5dPt7awv++DuWchqfLOZdwetoe5eNqzolSjWNf
         Q/uyMXd304Oq7HRJoIwHy6s2q483WETwD8lEyhYR0UVB0GASD7snGO7rUgNN/mmxo8VX
         SNAJG6sUed/BAJ9xFw7qnJt+1F1iFXAwA+FXjtN6fqkJUUW7x9d97pcOtt2pFTgdXH+u
         4NRQ==
X-Gm-Message-State: AOAM5323HX9IpnqGKDyS1+Go5a3WVa1fW59lT5MLbr0ucdkLpFU3Q5to
        mgu2T/1Pf/o80NVgC7+MgRjITxjxmnw=
X-Google-Smtp-Source: ABdhPJyFtEXWXHnG1MDdiD75M5c36EyNqHflbsX5sBIasM7kOE8ym68uFhHlUozb0oGWroW692pmuQ==
X-Received: by 2002:a62:6c5:0:b0:447:6093:2c34 with SMTP id 188-20020a6206c5000000b0044760932c34mr452538pfg.80.1632873289357;
        Tue, 28 Sep 2021 16:54:49 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o2sm3553139pja.7.2021.09.28.16.54.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:54:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] gatt: Add implementation of GattCharacteristic1.MTU
Date:   Tue, 28 Sep 2021 16:54:44 -0700
Message-Id: <20210928235447.3077055-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928235447.3077055-1-luiz.dentz@gmail.com>
References: <20210928235447.3077055-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements MTU property in GattCharacteristic1 interface.
---
 src/gatt-client.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 6bed77793..5b10cbfa0 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -873,6 +873,25 @@ characteristic_notify_acquired_exists(const GDBusPropertyTable *property,
 	return (chrc->props & BT_GATT_CHRC_PROP_NOTIFY);
 }
 
+static gboolean characteristic_get_mtu(const GDBusPropertyTable *property,
+				       DBusMessageIter *iter, void *data)
+{
+	struct characteristic *chrc = data;
+	struct bt_gatt_client *gatt = chrc->service->client->gatt;
+	struct bt_att *att;
+	uint16_t mtu;
+
+	att = bt_gatt_client_get_att(gatt);
+	if (!att)
+		return FALSE;
+
+	mtu = bt_att_get_mtu(att);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &mtu);
+
+	return TRUE;
+}
+
 static void write_characteristic_cb(struct gatt_db_attribute *attr, int err,
 								void *user_data)
 {
@@ -1646,6 +1665,7 @@ static const GDBusPropertyTable characteristic_properties[] = {
 				characteristic_write_acquired_exists },
 	{ "NotifyAcquired", "b", characteristic_get_notify_acquired, NULL,
 				characteristic_notify_acquired_exists },
+	{ "MTU", "q", characteristic_get_mtu, NULL, NULL },
 	{ }
 };
 
-- 
2.31.1

