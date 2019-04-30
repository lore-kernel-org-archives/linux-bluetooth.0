Return-Path: <SRS0=EsMn=TA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BF0C43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 11:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624B221670
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 11:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aatffQrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbfD3Ly3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:54:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40753 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729937AbfD3Ly2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Apr 2019 07:54:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id e56so5732432ede.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2019 04:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ccEdINQbaFyLbFPiM63GQN8ZYKGq4oiVZmtnTU+ixnM=;
        b=aatffQrXv7To0jyot/zrb6nKPX+K3FWqRxXJrDaoqlTR6UNCg7tmQ9K4HJPc5oLoM6
         JfqOMHslYwtA2/2KgZfZItqf1a5uXmuHTLn30FNzMr4QYxVQgs1FCx05dPRkLcehA53p
         tu4QYByHnfBiqmLogsW1THiJ4bSyVkeey2FATvdXfPUwqM1zJEe1BUe8aZJoQ5huzaiI
         rhO0Xmo0jn+kHCQ/PUeM4h2mNRUT6qrNMc77f9QhEH/nsaRuKHywESQYUAfCzk4Js3RR
         39pJBVZvN5htFX9DpTxdWc0zoF+D4aNnGTGNHtLrT+G3JksPLXGdugK9sRI2NC28x3VC
         6Bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ccEdINQbaFyLbFPiM63GQN8ZYKGq4oiVZmtnTU+ixnM=;
        b=OY7PlAKebZlOWZSTvAqdR4JnyBZyPmUShEUbvD+cK2NGGLfzsb9XXdqe9sBb9q1b3A
         7MzQmswYNAibdUA62k7hO8GMi1RjmXHayeCyo87dA6ib6B+6yiCnPDQ+kmsReppzgC15
         T9kvpi+vB/d3M3zWeQMZpLrTD2X7AOHo/87AZAcOmVKz7YySRXA7r7DMnZ74UMt8MnN4
         OGMFPvYjOm5s03vvIuP82qKPcUl1ZJr661V6z1XJinVOJlPSVlcTtNVHElDZH8JrgIjM
         C3ovQRPY41LLekxFEoEM3UBmhV0fZ74GRuT4YnwOpy/x06sZZecw8RZnpXfztt5YBwku
         y8tg==
X-Gm-Message-State: APjAAAWnRqbGI1APT2dfsRRvpw09ZYSi4Ih17YpksIKW2teapIc08P10
        0dzV/8jD2HDf0pKe4pSuKVOV5UlPfzM=
X-Google-Smtp-Source: APXvYqzx1nCsqhsY4D2iqU6g17P47YPycLohAOvchev7DUqIO8sZxSOkmh+jnQjWTRMYZZ3pc0CLnA==
X-Received: by 2002:a17:906:9c9:: with SMTP id r9mr11547079eje.197.1556625266226;
        Tue, 30 Apr 2019 04:54:26 -0700 (PDT)
Received: from bksv-VirtualBox.bkogc.com ([152.115.31.4])
        by smtp.gmail.com with ESMTPSA id n7sm1214629ejk.72.2019.04.30.04.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 04:54:25 -0700 (PDT)
From:   Troels Dalsgaard Hoffmeyer <troels.d.hoffmeyer@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Troels Dalsgaard Hoffmeyer <troels.d.hoffmeyer@gmail.com>
Subject: [PATCH Bluez 1/1] advertising: Timeout of 0 should not fire a callback
Date:   Tue, 30 Apr 2019 13:51:47 +0200
Message-Id: <20190430115147.14631-2-troels.d.hoffmeyer@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190430115147.14631-1-troels.d.hoffmeyer@gmail.com>
References: <20190429111441.20481-1-troels.d.hoffmeyer@gmail.com>
 <20190430115147.14631-1-troels.d.hoffmeyer@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Setting a timeout of 0 on an advertisement should let the
advertisement run forever. The client was released
immediately after, although the advertisement was still in the air.
---
 src/advertising.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 2f187edcf..890acd542 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -587,8 +587,10 @@ static bool parse_timeout(DBusMessageIter *iter,
 	if (client->to_id)
 		g_source_remove(client->to_id);
 
-	client->to_id = g_timeout_add_seconds(client->timeout, client_timeout,
-								client);
+	if (client->timeout > 0) {
+		client->to_id = g_timeout_add_seconds(client->timeout, client_timeout,
+																		client);
+	}
 
 	return true;
 }
-- 
2.17.1

