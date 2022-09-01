Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0C9ECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 10:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiIAKny (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 06:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbiIAKnq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 06:43:46 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DD9BB93B
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 03:43:41 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id EAB02240017
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 10:43:39 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 6/6] adapter: Remove experimental flag for PowerState
Date:   Thu,  1 Sep 2022 12:43:31 +0200
Message-Id: <20220901104331.174588-6-hadess@hadess.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901104331.174588-1-hadess@hadess.net>
References: <20220901104331.174588-1-hadess@hadess.net>
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
index dc96b9718..b3d25f4b0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3861,8 +3861,7 @@ static const GDBusPropertyTable adapter_properties[] = {
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

