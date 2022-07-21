Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0B8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 08:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiGUIDj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 04:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiGUIDi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 04:03:38 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340C8419B9
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 01:03:37 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u13so1550515lfn.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 01:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i/DnF7MUWhbOLzn6vhF+yvwlh0zjMoWv+hBYMOZWr2c=;
        b=b185S0pwCbreq2bqtrR05nLFTD80QOcHDYEYtRKWxlRuaXgh9mwu7HiFJklKvCiaeX
         s9gvw26+Wo+4KVAKxcWR19GRhQeg7vMbHnpSLiWnLXI57UTey4GyCMH80MoSqBz235QA
         M7eFguoiQDC/cSLfjrqYA7g8jZ4hVvRSPxk2iNOmeCKIWlB6fEGmyw/yS4tGTUwkyuBU
         FTTTOWDs8/biKfU8ch67yb8miRMz1aDd8CYcgcIE6UaRgCemczpL/Qii03tZhk6pTb0A
         r7vNHSeA+5GIAaH40h96oFZsrQWnSJOi5cHfSNIYdyGigr3AWIcZH7XVPkX2l5/3r3cR
         8DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i/DnF7MUWhbOLzn6vhF+yvwlh0zjMoWv+hBYMOZWr2c=;
        b=JfQZkKZ/MhE1PoThzPQJ8GSMN+0xLGExNe5bQPFQrWfdp2NLCRZl99F/UAFA1Aij5D
         +LMBtZOhRGdOWmQmE6bC/z3oXkJZCg8TmRYC+b5KxIrudVzjBf5pOtRwShc7a2RQ3ZBB
         JxVyCjWw9qxbtAieiS+rYkAmiUhzzUF6KYsvHOJLr4Z4qEkqBdIdlvIfRtD7eO9/Dn3m
         okgkh12k+SMSxj+YkUfzdTqzk+ozs6V/gZYx8iLlJetHaNwNv8qKbaYolw1XL6Hu3GZK
         OoClNf52JUS+2mT7UB//TJe4ylo4q1E2ketkQY9o7+fBWbXRfu4n/TkaO3jqa07a5shO
         0jFA==
X-Gm-Message-State: AJIora+AUpcB5ag7HXFC6J9Xt1HvAGmFnFbkG0JpnM4zjUPA8+sYRmLM
        e9v5DYQmpn58rUmYJoy+Dq8fahGGp+I5IA==
X-Google-Smtp-Source: AGRyM1soLLnweYK7DFAUsiDi5BkMel1MlEFBrsZi7aoVBmUGtDkYsSqdBS8qBRdkXf62iXAUFW+abw==
X-Received: by 2002:a05:6512:3a92:b0:48a:7201:3969 with SMTP id q18-20020a0565123a9200b0048a72013969mr296957lfu.412.1658390615549;
        Thu, 21 Jul 2022 01:03:35 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id d11-20020a194f0b000000b00489ec9e377fsm283423lfb.120.2022.07.21.01.03.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 01:03:35 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Set global bus earlier
Date:   Thu, 21 Jul 2022 10:03:31 +0200
Message-Id: <20220721080331.790277-1-michal.lowas-rzechonek@silvair.com>
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
 mesh/dbus.c | 10 +++++++++-
 mesh/dbus.h |  1 +
 mesh/main.c |  2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/mesh/dbus.c b/mesh/dbus.c
index a7abdc428..4ed477256 100644
--- a/mesh/dbus.c
+++ b/mesh/dbus.c
@@ -21,7 +21,7 @@
 #include "mesh/error.h"
 #include "mesh/dbus.h"
 
-static struct l_dbus *dbus;
+static struct l_dbus *dbus = NULL;
 
 struct error_entry {
 	const char *dbus_err;
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

