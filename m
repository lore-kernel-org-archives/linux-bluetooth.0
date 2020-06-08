Return-Path: <SRS0=ITyu=7V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986E8C433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 22:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C172076A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 22:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5Ow6BFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgFHWB7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgFHWB6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 18:01:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E665FC08C5C4
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2020 15:01:57 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d10so9372403pgn.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2020 15:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aCeukELY0ktEDa4JcWYXXOlSHj1N5l5OhM42CLYrj2I=;
        b=H5Ow6BFAmQ/m0mqI67xkgyLBWRlq5f+PtfHeGgJMZdtnOzSRarfqXFbqs7EVd64igw
         0Sl5x3S8khCxTtgasSg4BVtKc6JUKT9M4+gaRdmAGTQWEj1TaEAXqDSOAR4HQ+pt6yCa
         DFXYTg1Grp/earOjmEdAZyCToWZDJX4TvE57d0JXFEIVS6ki7tePN1QlNtR5GlR6kEks
         nT5UoPdQnNiGF4naf9gM79RdZ1Is0ZYQuwjjC/2onZcWMaMJW2aOp7HlBzcZN7EpLBKP
         z++Y7/F5+9TxcZWmraWVbZPvgAv0sLIrUXgWftrxDuza3hD3H+56ncDl7CltaLjFM6MC
         pRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCeukELY0ktEDa4JcWYXXOlSHj1N5l5OhM42CLYrj2I=;
        b=iAJ7N5qugsEqjUjtV5NnXMBB9JGYotvR4aOHWwqb3h6mGW1CIgqG3Ro2+B4fcbVXj7
         u5yof34PzwpNs0FCfXKVUhbo7lIvBVT/ZHVqlRh5494sybO+V9teoiU3Avljw1LASZS4
         1TwAoWfevfZ7y/dd6OXrUAV0PICYQQvU9O6tBvF0xbo/GBct4NpIKI4OWRnzA1TgHskK
         pcmpw1jfsC6j9OSfQspm07KQ473srRMA5XOQzjxSAitQxHxAaadk7u1dVklHAYrobpTK
         9lXM0IDH2Nrwfy9ZGN5p8GQ4tJekRo+/I9NTxsevGYD2mPN7N4MKr/f5itQQZ5n4e5eJ
         3m7Q==
X-Gm-Message-State: AOAM530T9iD5rlP6B+vAqfwKedav/fqZ3SfrQSODI6/7fc7eMZN25nFy
        9Mb5t16L0MGOsh5B9AbxIW6UwlzD
X-Google-Smtp-Source: ABdhPJyWenKks0tAY0mPFxkOVr9iKDuwtLrpOjX1HXtVv6jnLaBagC/mChCRkNycvvyq9ZRyoCXMDg==
X-Received: by 2002:a05:6a00:1510:: with SMTP id q16mr21895979pfu.164.1591653717085;
        Mon, 08 Jun 2020 15:01:57 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b140sm7870172pfb.119.2020.06.08.15.01.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 15:01:56 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] adapter: Fix possible crash when stopping discovery
Date:   Mon,  8 Jun 2020 15:01:53 -0700
Message-Id: <20200608220153.880790-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200608220153.880790-1-luiz.dentz@gmail.com>
References: <20200608220153.880790-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the client disconnect/crash while MGMT_OP_STOP_DISCOVERY was pending
it would possibly cause a crash as the client pointer is passed to
mgmt_send and accessed in the callback after being freed.

To fix this the adapter itself is now passed to the callback so the
client is not accessed directly, instead the code now checks if
discovery_list has not been cleared in the meantime and only then
proceed to access the client pointer which is how
MGMT_OP_START_DISCOVERY is handled.
---
 src/adapter.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c23c84175..64815ecd2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1926,11 +1926,19 @@ static bool set_discovery_discoverable(struct btd_adapter *adapter, bool enable)
 static void stop_discovery_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct watch_client *client = user_data;
-	struct btd_adapter *adapter = client->adapter;
+	struct btd_adapter *adapter = user_data;
+	struct watch_client *client;
 
 	DBG("status 0x%02x", status);
 
+	/* Is there are no clients the discovery must have been stopped while
+	 * discovery command was pending.
+	 */
+	if (!adapter->discovery_list)
+		return;
+
+	client = adapter->discovery_list->data;
+
 	discovery_reply(client, status);
 
 	if (status != MGMT_STATUS_SUCCESS)
-- 
2.25.3

