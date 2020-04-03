Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A177C2D0E8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 07:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DA32080C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 07:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DZd7UtYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390361AbgDCHkA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:40:00 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:42920 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390372AbgDCHkA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 03:40:00 -0400
Received: by mail-wr1-f42.google.com with SMTP id h15so7270547wrx.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 00:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VDZIxY8yOjZpWbJOay59avVDj9oEMEVs5GjYQo2E16M=;
        b=DZd7UtYA4YNbp1QTYbbcua65VH8sBt7Jsw/RZBlkLqqha2rpaUxY1qIKf3uKrYLmxC
         sH+gm2du2sNhI2cETsoI1a4z/CuCxjT/C1qV1T4+m7/3q58rXX2CxZlLzTUSYXmyEJY/
         y8sF7bWW2MlDeXZTuTlGHKof04uJCOlbODW8kDOZDs8YYnQMrjj8XXgZjr4FHhuEMCOZ
         4dI/R7NOYtumvLNYyLJ/QpIpbh0416wfkr0IZ4xkNdX7e7GOUMVz+8F9hX4r9Z00DC3g
         ANsliWWNT/H5QFJw6drd5j8251yuTxrY8+xQsJklOhYbBnAQbiC64NMIYt7KAWGJm0MF
         sphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VDZIxY8yOjZpWbJOay59avVDj9oEMEVs5GjYQo2E16M=;
        b=bHu3SSrL+l2j/3ofewOTTHvJ0lewHh8bk8xaAp6T3afRJKOXW4a4K0pTJny2kJS4eI
         NR+xCAnXLvPwRMLvA7RO0Q8wOnU+yVz1UwrgiKdM+msDQkxI5Sl9R3P1I/p4k5PxBNRB
         0ULuRdEaX9lELcduSbuaAo2Vt+zQu0dMVuoCVllfloSEVh9ssnH5DltUewstShdUK12t
         887N50XY5OlYT5UlUUaDR5F212jeAdY2Sd95LGIa7ekZ/jTKAZItcrub9nHG750Pq8dc
         u2F1lvgm703qqaCn4ZjiSGseyLldRdM/PGkKHk+c3xfM/1q37OFIfJnnPEAYysnZEjGn
         L/sw==
X-Gm-Message-State: AGi0PuaOOWPWfab1x9eoaQJAzIjRTSYht1gqT2ucsC2IoOB8fPTPgRh4
        2JFZ028gQtD/jNpvWkgBr9ZRKJ49
X-Google-Smtp-Source: APiQypLn8Bo/364AN7GkKboY8lqbgAYGOpGFvDvntBETm4+NvsGIfEa2ySTkI4TGkAxOq7cwjo2tyw==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr7359576wrp.420.1585899598581;
        Fri, 03 Apr 2020 00:39:58 -0700 (PDT)
Received: from RBGWVBL000659.fritz.box (p5B26793F.dip0.t-ipconnect.de. [91.38.121.63])
        by smtp.gmail.com with ESMTPSA id 98sm11283261wrk.52.2020.04.03.00.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2020 00:39:58 -0700 (PDT)
From:   "Klein, Thorsten (BSH)" <kleinkastel@googlemail.com>
X-Google-Original-From: "Klein, Thorsten (BSH)" <thorsten.klein@bshg.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     "Schachschal, Maximilian (BSH)" <maximilian.schachschal@bshg.com>
Subject: [PATCH BlueZ] ManufacturerData field added to ScanResponse
Date:   Fri,  3 Apr 2020 09:39:51 +0200
Message-Id: <1585899591-14623-2-git-send-email-thorsten.klein@bshg.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585899591-14623-1-git-send-email-thorsten.klein@bshg.com>
References: <1585899591-14623-1-git-send-email-thorsten.klein@bshg.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "Schachschal, Maximilian (BSH)" <maximilian.schachschal@bshg.com>

Keys are the Manufacturer ID to associate with the data.
---
 doc/advertising-api.txt |  6 ++++++
 src/advertising.c       | 25 +++++++++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index b0565ea..14ccae2 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -51,6 +51,12 @@ Properties	string Type
 			the Advertising Data.  Keys are the Manufacturer ID
 			to associate with the data.
 
+		dict ManufacturerDataScanResponse [Experimental]
+
+			Manufactuer Data fields to include in
+			the Scan Response.  Keys are the Manufacturer ID
+			to associate with the data.
+
 		array{string} SolicitUUIDs
 
 			Array of UUIDs to include in "Service Solicitation"
diff --git a/src/advertising.c b/src/advertising.c
index 45ff19f..0e1a3f1 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -328,12 +328,12 @@ fail:
 }
 
 static bool parse_manufacturer_data(DBusMessageIter *iter,
-					struct btd_adv_client *client)
+					struct btd_ad *ad)
 {
 	DBusMessageIter entries;
 
 	if (!iter) {
-		bt_ad_clear_manufacturer_data(client->data);
+		bt_ad_clear_manufacturer_data(ad);
 		return true;
 	}
 
@@ -342,7 +342,7 @@ static bool parse_manufacturer_data(DBusMessageIter *iter,
 
 	dbus_message_iter_recurse(iter, &entries);
 
-	bt_ad_clear_manufacturer_data(client->data);
+	bt_ad_clear_manufacturer_data(ad);
 
 	while (dbus_message_iter_get_arg_type(&entries)
 						== DBUS_TYPE_DICT_ENTRY) {
@@ -373,7 +373,7 @@ static bool parse_manufacturer_data(DBusMessageIter *iter,
 
 		DBG("Adding ManufacturerData for %04x", manuf_id);
 
-		if (!bt_ad_add_manufacturer_data(client->data, manuf_id,
+		if (!bt_ad_add_manufacturer_data(ad, manuf_id,
 							manuf_data, len))
 			goto fail;
 
@@ -383,10 +383,22 @@ static bool parse_manufacturer_data(DBusMessageIter *iter,
 	return true;
 
 fail:
-	bt_ad_clear_manufacturer_data(client->data);
+	bt_ad_clear_manufacturer_data(ad);
 	return false;
 }
 
+static bool parse_manufacturer_data_adv(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	return parse_manufacturer_data(iter, client->data);
+}
+
+static bool parse_manufacturer_data_scan(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	return parse_manufacturer_data(iter, client->scan);
+}
+
 static bool parse_service_data(DBusMessageIter *iter,
 					struct btd_adv_client *client)
 {
@@ -941,7 +953,8 @@ static struct adv_parser {
 	{ "Type", parse_type },
 	{ "ServiceUUIDs", parse_service_uuids },
 	{ "SolicitUUIDs", parse_solicit_uuids },
-	{ "ManufacturerData", parse_manufacturer_data },
+	{ "ManufacturerData", parse_manufacturer_data_adv },
+	{ "ManufacturerDataScanResponse", parse_manufacturer_data_scan },
 	{ "ServiceData", parse_service_data },
 	{ "Includes", parse_includes },
 	{ "LocalName", parse_local_name },
-- 
2.7.4

