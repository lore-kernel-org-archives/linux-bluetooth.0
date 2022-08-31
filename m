Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E85C6FA81
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 09:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiHaJUF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 05:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiHaJTp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 05:19:45 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7C1CE308
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 02:19:19 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id B0EED200014
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 09:19:13 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 5/6] adapter: Fix typo in function name
Date:   Wed, 31 Aug 2022 11:19:11 +0200
Message-Id: <20220831091912.47894-5-hadess@hadess.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831091912.47894-1-hadess@hadess.net>
References: <20220831091912.47894-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 src/adapter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index e295ef247..11a21ca5c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3455,7 +3455,7 @@ static gboolean property_get_experimental(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean property_experimental_exits(const GDBusPropertyTable *property,
+static gboolean property_experimental_exists(const GDBusPropertyTable *property,
 								void *data)
 {
 	struct btd_adapter *adapter = data;
@@ -3823,7 +3823,7 @@ static const GDBusPropertyTable adapter_properties[] = {
 					property_exists_modalias },
 	{ "Roles", "as", property_get_roles },
 	{ "ExperimentalFeatures", "as", property_get_experimental, NULL,
-					property_experimental_exits },
+					property_experimental_exists },
 	{ }
 };
 
-- 
2.37.2

