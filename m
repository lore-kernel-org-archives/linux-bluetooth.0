Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6F4C3DA6B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 09:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiHaJUD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 05:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiHaJTg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 05:19:36 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50376CD7BA
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 02:19:15 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id E943C200018
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 09:19:13 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 6/6] adapter: Remove experimental flag for PowerState
Date:   Wed, 31 Aug 2022 11:19:12 +0200
Message-Id: <20220831091912.47894-6-hadess@hadess.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831091912.47894-1-hadess@hadess.net>
References: <20220831091912.47894-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Now that the feature has been tested, that the API is deemed adequate
and the reliability sufficient.
---
 src/adapter.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 11a21ca5c..2a4a0a977 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3808,8 +3808,7 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "Alias", "s", property_get_alias, property_set_alias },
 	{ "Class", "u", property_get_class },
 	{ "Powered", "b", property_get_powered, property_set_powered },
-	{ "PowerState", "s", property_get_power_state, NULL, NULL,
-			     G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "PowerState", "s", property_get_power_state },
 	{ "Discoverable", "b", property_get_discoverable,
 					property_set_discoverable },
 	{ "DiscoverableTimeout", "u", property_get_discoverable_timeout,
-- 
2.37.2

