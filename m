Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AECEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Feb 2022 10:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiBZKmV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Feb 2022 05:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiBZKmV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Feb 2022 05:42:21 -0500
X-Greylist: delayed 1977 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Feb 2022 02:41:46 PST
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F4C290E53
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 02:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3EqbRWxbzPf36Pvq3MgmlhdSEMELrRjn+dZL2V3FbT8=; b=GDXWKkZqVT9uQphiZpoxS0RYor
        nRjjreNYhn1EddvU8HRQMrtD/E7lDWEZYNfp5PVJuXG4azeK49m+JReVt2GhnrgrmQimtnmDi26Y+
        iZMypl5mhEKAaBS87Up39ArBwkEa2kkwJZAEcCJZYSXbNEbXyQf4SwMNuWCAy09TgHf8=;
Received: from p200300ccff34d3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff34:d300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1nNu0M-0000Yj-T7; Sat, 26 Feb 2022 11:08:47 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1nNu0M-006SjS-AE; Sat, 26 Feb 2022 11:08:46 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH BlueZ] gatt: sanitize input at profile registration
Date:   Sat, 26 Feb 2022 11:08:36 +0100
Message-Id: <20220226100836.1540367-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Check whether type of UUIDs property of GattProfile1 object
is correct.
---
 src/gatt-database.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 481222d44..485af04ea 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -3423,6 +3423,11 @@ static struct external_profile *create_profile(struct gatt_app *app,
 		goto fail;
 	}
 
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
+		DBG("UUIDs wrongly formatted");
+		goto fail;
+	}
+
 	dbus_message_iter_recurse(&iter, &array);
 
 	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRING) {
-- 
2.30.2

