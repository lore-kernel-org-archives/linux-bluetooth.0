Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A8EC0502C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 11:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiIALH7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 07:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiIALHb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 07:07:31 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E87138CA7
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 04:07:28 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 6D6F740010
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 11:07:27 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 4/6] adapter-api: Add PowerState property documentation
Date:   Thu,  1 Sep 2022 13:07:17 +0200
Message-Id: <20220901110719.176944-4-hadess@hadess.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901110719.176944-1-hadess@hadess.net>
References: <20220901110719.176944-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/adapter-api.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 48466ab75..9b2721c1b 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -269,6 +269,21 @@ Properties	string Address [readonly]
 			restart or unplugging of the adapter it will reset
 			back to false.
 
+		string PowerState [readonly, experimental]
+
+			The power state of an adapter.
+
+			The power state will show whether the adapter is
+			turning off, or turning on, as well as being on
+			or off.
+
+			Possible values:
+				"on" - powered on
+				"off" - powered off
+				"off-enabling" - transitioning from "off" to "on"
+				"on-disabling" - transitioning from "on" to "off"
+				"off-blocked" - blocked by rfkill
+
 		boolean Discoverable [readwrite]
 
 			Switch an adapter to discoverable or non-discoverable
-- 
2.37.2

