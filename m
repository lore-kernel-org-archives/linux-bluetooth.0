Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B405C169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE432147A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbzKq9oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfA2N0m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:26:42 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45797 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbfA2N0m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 08:26:42 -0500
Received: by mail-ed1-f41.google.com with SMTP id d39so15919608edb.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 05:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=/7G+6AaPjBNNYsahqqqpTw5dwK7692a4bGPdpJ35QkM=;
        b=WbzKq9oesIJ0+Bga4vvJmNn3o6z3cq0t7rUqe1UnMajfxtjWRCEIhD+qZoGHwGxPDm
         RfDnu3NJ/8BtRtvI9zZPoVw/wT9IuVCeZyZseuJFn+SLeQKncZh1YC4ZJ+/5MQfxWXfg
         EsoBd6E+pRYn4Thvx5KS4v0VU7u6VTO0C9kR1Gslb6HrpMO+cZV7/eUHO/E736gs7w0O
         ytrdd0xT06SverIxCJkAHO3yDwo1UaPYlcMq7pfJunz5yIDB7aXlsxlWcpA4MofvC2IC
         qe5dBJvcjx7AbdAXZs6DJVahQ8SF7bUEEbL2kWPTia1P8J/7qZw27l/miEmSgbSjMS0K
         x3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=/7G+6AaPjBNNYsahqqqpTw5dwK7692a4bGPdpJ35QkM=;
        b=M0HL1ypX4NRvLVw7BOsSpCZGLn8FlAvAQWv0OygU44JLChoNEQvz991Zdb4inO5gfW
         3K69cu0meGuDBOsAJfU5oyu3DAPTBIDyqiF5+iRvBp5sv+9RBO1GJT9DwWG6oMbXAAG3
         AgwS0ZG8Ohve4EfkwvWU2qcmzG0UvdvC2GajkaFyl5yfPgDSpIRBnJNzV19IeBsvCGuf
         h3OrTInHOn/fH7/13njrcfLqYi5aAduw/WR+lwtKMUJl2J9epvf0vnYtXiIuvge/KZ9Y
         e+jcR1Dz3JUVqT1aI0u3hsmeBjFIuBwgu/J0fZhiMb/tTIZOYz2OQXWijcyBPzpuUKWj
         4npw==
X-Gm-Message-State: AJcUukeJhPkBapy/6tPR0EY+i80kVHQuI3EANzD1LQBXbVzfpmsFM1gY
        TdEyKwDhYQCuj1xvavsaZqBz8vJV
X-Google-Smtp-Source: ALg8bN4E4YGTQ6IrxdptzxDbrc236hB0JV3Nmghsg0gkjJE2zwT74g8gK000WwE67CqTE8kl/LlJXA==
X-Received: by 2002:a17:906:2f88:: with SMTP id w8-v6mr22230229eji.114.1548768400449;
        Tue, 29 Jan 2019 05:26:40 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id i14-v6sm8179964ejy.40.2019.01.29.05.26.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:26:39 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/15] lib/uuid: Introduce definition for GATT caching attributes
Date:   Tue, 29 Jan 2019 15:26:22 +0200
Message-Id: <20190129132634.28786-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129132634.28786-1-luiz.dentz@gmail.com>
References: <20190129132634.28786-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces UUIDs for Client Features and Database Hash
characteristics.
---
 lib/uuid.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 7e13e0fda..fbc08f51e 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -150,6 +150,10 @@ extern "C" {
 #define MESH_PROXY_DATA_IN				0x2ADD
 #define MESH_PROXY_DATA_OUT				0x2ADE
 
+/* GATT Caching attributes */
+#define GATT_CHARAC_CLI_FEAT				0x2B29
+#define GATT_CHARAC_DB_HASH				0x2B2A
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
2.17.2

