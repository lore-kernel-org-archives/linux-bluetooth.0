Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DD0C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 20:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbhLUUu0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Dec 2021 15:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbhLUUu0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Dec 2021 15:50:26 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C0BC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 12:50:26 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p14so191620plf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 12:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9ihzvmfL1JKR63zuErQK+qR+qt0qyup6+/MlQjMaiNo=;
        b=WvASFp0ky7hePV+IeIuCjEqhfIhfX+8O4J6sP3YLk7cB66u0opDoQkdfX5062wKG2S
         58jS0ppoNOxYWQFN5xOhf82+WxjaycumPCyrH4WkYxC8f5JRHIuf/OzoRgNYqVy8nL3O
         wQS4FpKzLKEpGCzV5B+pjDjg5ax2ca+ZJSh2iUN2goxa4yW3EXPGnmj51lXr27qRa/yX
         yarRrxBweA8ycKuaDQw6f1L1oS8QaKoMi4ZRQNDjdGgITQmpNGZc1oSnfnUdlxWZ9bHu
         zC5XQ6mu3iWk9USAUG6csQIbNE0E7xFjaTNkmxbs5H6kVLcsQTDaMWLkAITtmHukQr7G
         TkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ihzvmfL1JKR63zuErQK+qR+qt0qyup6+/MlQjMaiNo=;
        b=DVoSTT4Q7RrPlCq6gxFG+rpTjU4irOCRJMCrjB1Nvv9ocQ9xlL6FpyvqvGWhkeOL8f
         Q222HVguQLR3/v6Z4zAhNgGlaOiV+apRJXIDogsU0olGbrbgwjFF2FaFteswtyJZ+Swo
         FDJRWbDRioPlx3bGjGX46NXwnRW0YCdG9vTgRKPHJmIE6UPJrKnlzPNtJh+4GOqZXWwy
         fS3rt91yoo4Q4gEMuUYdq4BDUPrUuXqsC/NbDOs9T0DM6GLGaHhSvp2Ihp0txTq4vHYb
         KZVGAqwLfwIFwJ3Tq636/8eFaR4FGnNiowPghBRqEX9CufCZnSEbdxDvarLmtgwiKIqH
         GVJA==
X-Gm-Message-State: AOAM533EY+5g3KtxN0CB8iNc/Njm/nuxr8XhYfmmjTHWNbgpE5ePLNmV
        zaDNel325e+wkMacE+WijOXnT3S6vBQ=
X-Google-Smtp-Source: ABdhPJwL8Sr9tsAqA7gDE9Bqjv5pIey88E/9vLiVwvFWJmrCUaU9optkjHQ1ysJxrPIgpMMvF7vvkg==
X-Received: by 2002:a17:90a:f001:: with SMTP id bt1mr265727pjb.60.1640119824888;
        Tue, 21 Dec 2021 12:50:24 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 72sm3973pfu.70.2021.12.21.12.50.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 12:50:24 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/4] gattrib: Fix passing NULL to memcpy
Date:   Tue, 21 Dec 2021 12:50:19 -0800
Message-Id: <20211221205019.654432-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211221205019.654432-1-luiz.dentz@gmail.com>
References: <20211221205019.654432-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following runtime error:

  attrib/gattrib.c:198:2: runtime error: null pointer passed as
  argument 2, which is declared to never be null
---
 attrib/gattrib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 270a37ebe..041b9d289 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -195,7 +195,9 @@ static uint8_t *construct_full_pdu(uint8_t opcode, const void *pdu,
 		return NULL;
 
 	buf[0] = opcode;
-	memcpy(buf + 1, pdu, length);
+
+	if (pdu && length)
+		memcpy(buf + 1, pdu, length);
 
 	return buf;
 }
-- 
2.33.1

