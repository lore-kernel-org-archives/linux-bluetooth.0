Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E29ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 11:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiHaLgw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 07:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHaLgv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 07:36:51 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC63A9C0B
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 04:36:50 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 019C71C0013
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 11:36:48 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 3/6] client: Print the PowerState property
Date:   Wed, 31 Aug 2022 13:36:44 +0200
Message-Id: <20220831113647.85110-3-hadess@hadess.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831113647.85110-1-hadess@hadess.net>
References: <20220831113647.85110-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 19139d15b..ddd97c23c 100644
--- a/client/main.c
+++ b/client/main.c
@@ -981,6 +981,7 @@ static void cmd_show(int argc, char *argv[])
 	print_property(adapter->proxy, "Alias");
 	print_property(adapter->proxy, "Class");
 	print_property(adapter->proxy, "Powered");
+	print_property(adapter->proxy, "PowerState");
 	print_property(adapter->proxy, "Discoverable");
 	print_property(adapter->proxy, "DiscoverableTimeout");
 	print_property(adapter->proxy, "Pairable");
-- 
2.37.2

