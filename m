Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97910C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 09:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241871AbiC3Jti (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 05:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbiC3Jth (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 05:49:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DA3266B49
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 02:47:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: fdanis)
        with ESMTPSA id EDF271F44576
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648633667;
        bh=9wHPtAXUfRoA+BKZLI7PWdiZexsJOtzcFoxk2awKnwI=;
        h=From:To:Subject:Date:From;
        b=j0sxmP7mrZboG4VfBF/AoTGOjVwVKR82+eFbcORyvENQ9PGkA3WtPSbGn7kf8Wqf5
         z+DtTogfvRoopYP3eVOmH9Mvrbe7xcjtNk5i/RZijaEK/EaW8g1REzntrpNehiVo93
         +L51JjvCuLWYi4rT5E0TSp4/vgi4gmB4eY0qqHrt0/L/3j9OhbfkeJwL/XLetGWqU1
         on2HCNtW47LA2jWZ6nJBfjyKNhl9oJ/EL9QAbHjq5wX7a6Aa/OaN+5jXmqrzliTN2t
         I4+Mp0ZCjUaOYdgw7mkkKSemU/hKdPGDBEq+ka0UH8Mv2G0wNmzMEPbVLhRjVLgrPm
         H+NP+uo5iMTww==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] tools: Fix g_dbus_setup_private connection check in mpris-proxy
Date:   Wed, 30 Mar 2022 11:47:40 +0200
Message-Id: <20220330094740.45637-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/mpris-proxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index 91a25501d..3779b6887 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -1978,7 +1978,7 @@ static void register_player(GDBusProxy *proxy)
 
 	player->conn = g_dbus_setup_private(DBUS_BUS_SESSION, player->bus_name,
 									NULL);
-	if (!session) {
+	if (!player->conn) {
 		fprintf(stderr, "Could not register bus name %s",
 							player->bus_name);
 		goto fail;
-- 
2.25.1

