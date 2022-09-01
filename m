Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA91C0502C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 11:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiIALH4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 07:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiIALHb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 07:07:31 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A05135D35
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 04:07:28 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 2EE1C40008
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 11:07:27 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 3/6] client: Print the PowerState property
Date:   Thu,  1 Sep 2022 13:07:16 +0200
Message-Id: <20220901110719.176944-3-hadess@hadess.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901110719.176944-1-hadess@hadess.net>
References: <20220901110719.176944-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 6773d5262..2816e880f 100644
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

