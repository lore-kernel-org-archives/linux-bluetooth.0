Return-Path: <SRS0=crNx=RJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F50C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 12:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4162420652
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 12:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhC5EmtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfCFMw3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Mar 2019 07:52:29 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45672 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbfCFMw3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Mar 2019 07:52:29 -0500
Received: by mail-ed1-f68.google.com with SMTP id f19so10222889eds.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Mar 2019 04:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=YnVzSAuHdeaLhvHCBIjpcWEfhgL4GOL2W1gs5mNEmeE=;
        b=dhC5EmtRrhb7+ZjptcemDH76xlZCZNb2bjvVDIEf4QzmltakfNoit9uRzCO2jT3udd
         9dm4DwlQP/AVg+kzrZpYdjvVjhDExZSzlF6Aejnb/QMe8XrzFEWGfQ2BNYf3HxHChdMY
         s/ovvAXZEvJ+oXVwT/7fiV8deop99dStMo2Bsfs9wL7jUTwxzPLEOAIXHSy3wROAwXsT
         kTAXvUszjKW7fsj3t62E+FS/7S1OFW1Zc6sX7wBa4UDocbUqertixuBFWKygOtAhg5sH
         wE/O5dcOOMbMuTc4qg70fOZyJ6i0SEKSuh/cgGbEqncaeWY04KXRB/ua3j7CBJtf7v8x
         xCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=YnVzSAuHdeaLhvHCBIjpcWEfhgL4GOL2W1gs5mNEmeE=;
        b=gdQ7fll0fCjhnm3xAmPaozkSSpROdbcOg49/IbafAuF7jE1X8/LLYuUeQnJIkOS9oI
         NvXiGvyoiqIHR9P3wqy/VDM7Hz6tL+rDc8YX2/bXUSNtwWDrsu+VujzsWGgxeQSXN6uQ
         rn+s4Yo0vbqAybzGPF2yk9Aq2khISsKGIsmYD2XyTM+Efq7b5NRmSGPcamW7phvbinAe
         3BXa1YozQ4xPxqfLvSMmoS7pXD45pRmwft8bAem9CJY0xWO0BgQyHaBYyPJJ19dNVngg
         dICWA8JORQa05DLBhAcYhcRDtamjwahid59+BkFGmqk1X7+OAgzxipu9J6LEBlwrRbTg
         XX3g==
X-Gm-Message-State: APjAAAWgUL2wZvpYbgeLMt57urpJ8DTDSxKh+VdIZKeW+Xa2XLIxVgqL
        PIumkds4On+DH+9j4rIzmHsjI5GokdY=
X-Google-Smtp-Source: APXvYqyIO2wB5AGPoitk+rzUofCNwqQo6cLBjKYBfuAgNqVitNk5EjQJObq9uZrHIFmP0fWFc7iOYw==
X-Received: by 2002:a17:906:7711:: with SMTP id q17mr3884311ejm.174.1551876747047;
        Wed, 06 Mar 2019 04:52:27 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id z39sm426625edc.96.2019.03.06.04.52.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 04:52:26 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] adapter: Fix length calculation of filter UUIDs on big endian
Date:   Wed,  6 Mar 2019 14:52:24 +0200
Message-Id: <20190306125224.14427-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The management interface expect all values to be in little endian
thus the length of uuids needs to be converted on big endian.
---
 src/adapter.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b8a6bb6e2..160a6ca52 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1602,10 +1602,12 @@ static gboolean start_discovery_timeout(gpointer user_data)
 	sd_cp = adapter->current_discovery_filter;
 
 	DBG("sending MGMT_OP_START_SERVICE_DISCOVERY %d, %d, %d",
-				sd_cp->rssi, sd_cp->type, sd_cp->uuid_count);
+				sd_cp->rssi, sd_cp->type,
+				btohs(sd_cp->uuid_count));
 
 	mgmt_send(adapter->mgmt, MGMT_OP_START_SERVICE_DISCOVERY,
-		  adapter->dev_id, sizeof(*sd_cp) + sd_cp->uuid_count * 16,
+		  adapter->dev_id, sizeof(*sd_cp) +
+		  btohs(sd_cp->uuid_count) * 16,
 		  sd_cp, start_discovery_complete, adapter, NULL);
 
 	return FALSE;
@@ -2076,7 +2078,7 @@ static int discovery_filter_to_mgmt_cp(struct btd_adapter *adapter,
 
 	cp->type = discovery_type;
 	cp->rssi = rssi;
-	cp->uuid_count = uuid_count;
+	cp->uuid_count = htobs(uuid_count);
 	populate_mgmt_filter_uuids(cp->uuids, uuids);
 
 	g_slist_free(uuids);
-- 
2.17.2

