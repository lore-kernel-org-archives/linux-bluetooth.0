Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB81C169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93ADC2147A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i07AhvaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfA2N0r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:26:47 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45805 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfA2N0q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 08:26:46 -0500
Received: by mail-ed1-f41.google.com with SMTP id d39so15919795edb.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 05:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Pz9Dhtpz4I1WYBYMM6DmEskTDCJCMLzjR64XJGfYlpg=;
        b=i07AhvaALhI4dRYRYOXb2jhPUkGWDOmj99HRVbZdhjXySchfPba+PlU/977t5HxC+h
         +BWn4p8vG9NCABjuuivUHNnRIrh5ND9KfbEgef0E6mn/jpl41L7ZDXW8q0sOYS8PKG4E
         Fdh/e25TK7+Cb48m1l7lpxUVVCQ3Zqa9dJuWO332qZlVvnQD4bd5m8YHNOrKb+lo5/18
         dVeSJ4DoaNqovjWCUmEJzUAgmNVsKZpha1GkXHz5qAygQI1qRNY2Mald/Gf0L4ksQ1T+
         jpaUvvQds+KkOrToIkQRI0avvxS6kGkdZB8PEM4bQlowQ0EUchdTX7io2OR3SsA60tPx
         sVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Pz9Dhtpz4I1WYBYMM6DmEskTDCJCMLzjR64XJGfYlpg=;
        b=W5imb7JMj9mi1JxVmWvUWnF7KJvm6i29fJzWEn7Vmccxh1LtErCVlzaMbdkKTIPG4Y
         Bkpohoy8FzblGO9SWBntEVO89kc4qfXkcq9np77dlgAWG7iJR04v5wOuQSAY7wPB0kE0
         N6nMMHqqOSI+NsJqvFXMstZXA+8Sb2q6HBJS/zFc+637NWwdi0Ia8zTLMB1bsVrGY0xO
         wcyfEJn77yw9EXvNpSmknTAE1xhcR3752/ZaMIV8PaO1QhxqmMqGHkXEuxsBuzn53Zjc
         ZszBaz27ArTYxI/YZLqJiUZBkXaizu4yHVwx8JMlIl1X9SNfi6tfGMrPi3MjGgGPQj1y
         z6mQ==
X-Gm-Message-State: AJcUukcQdTRfJzJU6CqC1BSeW0YgDLXPc/Xn03HsUe+eF8CE0CZIhvKd
        McewWVjFJZQdD2LPw/JBWPQk+7Ou
X-Google-Smtp-Source: ALg8bN7zaKF9+1RjfsGnM/IzdSBVA/Zx6AxovaIupy4HoTrsQdHCFxuWy6AiWsQdfOeJanodMYiAjw==
X-Received: by 2002:a17:906:364f:: with SMTP id r15mr7388246ejb.70.1548768404407;
        Tue, 29 Jan 2019 05:26:44 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id i14-v6sm8179964ejy.40.2019.01.29.05.26.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:26:43 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/15] monitor: Decode GATT Caching errors
Date:   Tue, 29 Jan 2019 15:26:25 +0200
Message-Id: <20190129132634.28786-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129132634.28786-1-luiz.dentz@gmail.com>
References: <20190129132634.28786-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables decoding of Database Out of Sync and Value Not Allowed
ATT errors introduced with GATT Caching improvements.
---
 monitor/l2cap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 1e6ca3492..26719ac5e 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -2132,6 +2132,12 @@ static void att_error_response(const struct l2cap_frame *frame)
 	case 0x11:
 		str = "Insufficient Resources";
 		break;
+	case 0x12:
+		str = "Database Out of Sync";
+		break;
+	case 0x13:
+		str = "Value Not Allowed";
+		break;
 	case 0xfd:
 		str = "CCC Improperly Configured";
 		break;
-- 
2.17.2

