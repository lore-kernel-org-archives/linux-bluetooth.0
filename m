Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E63C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jul 2022 08:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiGYIGQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jul 2022 04:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiGYIGO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jul 2022 04:06:14 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FB213CE9
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jul 2022 01:06:13 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id b21so5185790ljk.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jul 2022 01:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BSrJKs2yxcA/69MpwmakRS6MH+omcc1kXy+iChz5vks=;
        b=CT+/iMby01vcJ3DENSfXbSg6SjhyF6a6ZNlzen9gJ72V5mnxscs8DuBC5E3XsJD6Zx
         Eoc3jwmJQ+CwYEfH/P7WyTkB39jjad+1sLfVj6DPaBK74wW0FOAPXOEjxr1VEQFanCGv
         OeIoguHe7wKIkTv1S/+I8HgrGHQVK26eDysJdtw1TWShXXlqz/wFlQ6Jex3rrhZIjV9k
         k68R5ju4IeqKopJGmvcGCsQ8mY0b3me4F8F1FDL+Egi2mggDx3Y6oeJ0f1aEThorZq91
         qaHIzgfDNtUMCn/AX2Qmcgxx3gr7OLtNM1CN3VkAdf2xtGSM3sRs74KHswQBlaGJeJ8r
         4zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BSrJKs2yxcA/69MpwmakRS6MH+omcc1kXy+iChz5vks=;
        b=asDeN3bvsS2DHOPcP9c5h8g+ImDLKpcfKfFWHN4Vxcc7Z8bM2bZOeDv7vvcVAbW3qr
         FLjy3vMRIlppHmlPG/7tiegFbVH39TL4e4MHjBr52AtbRgftXbnM87Pb19HUxh9lWNxb
         velAFjGN20lWl0/F6LtdFjUEmw0+r8lhStw9a6Xo9kJaL9p2fuX3eTn1TJ30utUs5/K7
         QYSuzsAGjLi9HmU1plEMZBVDp+EnMnJOtPxeM3durFc8oOtHpsg927o/pPSAQYG65dDT
         pxXNViXlFE8R1NgRqE1edkw4qT2PiDSCHA7n8945+jZCJC+U4VAQ6IQ+AYoL95CZM/+7
         +DEw==
X-Gm-Message-State: AJIora91bvDHiDVc8YAMMudU6dSPt71l070NC6FxLixQtLjEpY84z3s1
        /jLINKZkXtydwO0+2wOl2fScK0bk1X1YlQ==
X-Google-Smtp-Source: AGRyM1v9Xp17/b3XkvX8py+B4BJ6T/WlBZHLoxUm6NXlqs8se7kb84uvutX7OKNrFbwuKe9zxg/K6w==
X-Received: by 2002:a05:651c:a12:b0:25d:9ab3:4b38 with SMTP id k18-20020a05651c0a1200b0025d9ab34b38mr3962006ljq.409.1658736371746;
        Mon, 25 Jul 2022 01:06:11 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id h1-20020a05651c124100b0025df2654179sm1730402ljh.36.2022.07.25.01.06.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 01:06:11 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] mesh: Set global bus earlier
Date:   Mon, 25 Jul 2022 10:05:49 +0200
Message-Id: <20220725080549.4163484-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some io implementations might want to either make calls to other D-Bus
services, or provide additional objects/interfaces that allow
applications to fine-tune their operation, so allow them to use the bus
even before initializing mesh D-Bus interfaces.
---
 mesh/dbus.c | 8 ++++++++
 mesh/dbus.h | 1 +
 mesh/main.c | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/mesh/dbus.c b/mesh/dbus.c
index a7abdc428..6e62abd27 100644
--- a/mesh/dbus.c
+++ b/mesh/dbus.c
@@ -75,6 +75,11 @@ struct l_dbus_message *dbus_error(struct l_dbus_message *msg, int err,
 				"%s", error_table[err].default_desc);
 }
 
+void dbus_set_bus(struct l_dbus *bus)
+{
+	dbus = bus;
+}
+
 struct l_dbus *dbus_get_bus(void)
 {
 	return dbus;
@@ -82,6 +87,9 @@ struct l_dbus *dbus_get_bus(void)
 
 bool dbus_init(struct l_dbus *bus)
 {
+	if (dbus != bus)
+		return false;
+
 	/* Network interface */
 	if (!mesh_dbus_init(bus))
 		return false;
diff --git a/mesh/dbus.h b/mesh/dbus.h
index 8f00434d6..ab8b0a2cc 100644
--- a/mesh/dbus.h
+++ b/mesh/dbus.h
@@ -14,6 +14,7 @@
 #define DEFAULT_DBUS_TIMEOUT	30
 
 bool dbus_init(struct l_dbus *dbus);
+void dbus_set_bus(struct l_dbus *bus);
 struct l_dbus *dbus_get_bus(void);
 void dbus_append_byte_array(struct l_dbus_message_builder *builder,
 						const uint8_t *data, int len);
diff --git a/mesh/main.c b/mesh/main.c
index dd99c3085..0180c3768 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -278,6 +278,8 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
+	dbus_set_bus(dbus);
+
 	if (dbus_debug)
 		l_dbus_set_debug(dbus, do_debug, "[DBUS] ", NULL);
 	l_dbus_set_ready_handler(dbus, ready_callback, dbus, NULL);
-- 
2.25.1

