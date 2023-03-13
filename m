Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59185C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 22:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjCMWwr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 18:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCMWwZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 18:52:25 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A71C89F2E
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 15:51:59 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id s7so133074ilv.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 15:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678747915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XdgRFSjXa7KRG/J3C+fPqpfYBSI858tA40zw81foPy4=;
        b=PtNFsRhI9oi8NkmtZNJ82TqT9dJMrzspGo/JxpHBenJJUU5e04DxeYR2fThSFjAOxW
         hc/vMQRP0gtZcsVExFdZjpE8XO17yzfw2xAjY7JrNXkqeeHEadFvEwJEwO1y2x0rJvV3
         35utswWsfyDxVGa3tID1L/VC/QkWw+O0tsb0vwmfAePUlBHJm8YngrvhekloI3dLm3YO
         lob41y7cchQrYzu7PveaygAPtSCOi2f8Jq2+aOABx63GHSbLfqEBNC8I2cwfCvXcfvAy
         aaxEyFM1+40+rOI4cTs5r7G20XLYXdswGZScYeNwfDzAstA7eiP0iRY8DCV53JiDYKam
         3Lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678747915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdgRFSjXa7KRG/J3C+fPqpfYBSI858tA40zw81foPy4=;
        b=ddCBqrUYonNHSyFE40JUohsAk5F68N5OxwLN5pC5DFbFEkN4rPIAEJenXoCCValZIn
         1jn0SkbIocDImEtTzu0MWDoYAxEqpEFHlr3QOoydlHX3BoetI67W1Aqxe108Fq7kEciz
         XEZCBJUd5sKec+hHEDQpxJepUF6a9KON5rhSDHJQ+kojcIlsu2AasbL3yAjMIMSnhdas
         mB8YLUOcMByo00jau36epznERPNJ40eSLmgYbJWIA108M/ROrYAjr7xf05POSYKJ+G7u
         MURmnsJTUcjAmsyfXrb0GPd+pLxs03G+Lz4TlvBsGriELrhPtZy/KxG8DHh1IcfCgEco
         KYrg==
X-Gm-Message-State: AO0yUKWYQzwVC4PO5ERRHkO5APOXanekhajkh2hJdfsDpqbhKU6DdQSD
        nCWeWUBu4UZT1OfHSCd3g1c40iTrglo=
X-Google-Smtp-Source: AK7set9gXH5EXUtT+qYyXgq1RSzwuZdX8lP8ONLvwvyt9Rz2unmTh4GY0My0lLe7TXmV3w693HEWWQ==
X-Received: by 2002:a05:6e02:551:b0:316:f71f:fa9b with SMTP id i17-20020a056e02055100b00316f71ffa9bmr1029356ils.16.1678747915181;
        Mon, 13 Mar 2023 15:51:55 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id m17-20020a02cdd1000000b003c4d71489aasm278318jap.6.2023.03.13.15.51.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 15:51:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] shared/gatt-client: Introduce bt_gatt_client_ref_safe
Date:   Mon, 13 Mar 2023 15:51:49 -0700
Message-Id: <20230313225150.267896-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313225150.267896-1-luiz.dentz@gmail.com>
References: <20230313225150.267896-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces bt_gatt_client_ref_save which ensures the instaces
which are being destroyed, e.g. ref_count = 0, do not attempt to reach
callbacks.
---
 src/shared/gatt-client.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index f885076913dc..3a29f807fc85 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -173,9 +173,20 @@ static bool idle_notify(const void *data, const void *user_data)
 	return true;
 }
 
+static struct bt_gatt_client *
+bt_gatt_client_ref_safe(struct bt_gatt_client *client)
+{
+	if (!client && !client->ref_count)
+		return NULL;
+
+	return bt_gatt_client_ref(client);
+}
+
 static void notify_client_idle(struct bt_gatt_client *client)
 {
-	bt_gatt_client_ref(client);
+	client = bt_gatt_client_ref_safe(client);
+	if (!client)
+		return;
 
 	queue_remove_all(client->idle_cbs, idle_notify, NULL, idle_destroy);
 
@@ -1360,10 +1371,13 @@ static void notify_client_ready(struct bt_gatt_client *client, bool success,
 {
 	const struct queue_entry *entry;
 
-	if (client->ready)
+	client = bt_gatt_client_ref_safe(client);
+	if (!client)
 		return;
 
-	bt_gatt_client_ref(client);
+	if (client->ready)
+		goto done;
+
 	client->ready = success;
 
 	if (client->parent)
@@ -1386,6 +1400,7 @@ static void notify_client_ready(struct bt_gatt_client *client, bool success,
 		notify_client_ready(clone, success, att_ecode);
 	}
 
+done:
 	bt_gatt_client_unref(client);
 }
 
-- 
2.39.2

