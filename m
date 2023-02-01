Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A681C636D4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 19:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjBATvz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Feb 2023 14:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjBATvy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Feb 2023 14:51:54 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547B23AA2
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 11:51:53 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id EA73B2407A2
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 20:51:51 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4P6XcR3Lp1z6tm6;
        Wed,  1 Feb 2023 20:51:51 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2] media: set default value for BAP endpoint Vendor field
Date:   Wed,  1 Feb 2023 19:51:47 +0000
Message-Id: <26d36cc8d645773b6795a18355631134bf2bd074.1675281104.git.pav@iki.fi>
In-Reply-To: <d23190507e9c7131481648848d0afd62448226d3.1675276185.git.pav@iki.fi>
References: <20230127205205.20235-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The "Vendor" field is optional, and should have an initialized valid
default value.

It has the default values in register_endpoint, but not in
app_register_endpoint, so make the latter match the former.
---

Notes:
    v2: Let's not use C99 initializers.
    
    The uninitialized values cause Pipewire media endpoint registrations to
    fail, and this makes it work again. Its BAP media endpoints do not have
    the Vendor field, given that they use LC3, so the struct in
    app_register_endpoint ends up containing random garbage.  The resulting
    invalid codec/cid/vid value combination is rejected by
    bt_bap_add_vendor_pac.

 profiles/audio/media.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index d96367454..8a2afd04c 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -2583,6 +2583,8 @@ static void app_register_endpoint(void *data, void *user_data)
 
 	dbus_message_iter_get_basic(&iter, &codec);
 
+	memset(&vendor, 0, sizeof(vendor));
+
 	if (g_dbus_proxy_get_property(proxy, "Vendor", &iter)) {
 		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT32)
 			goto fail;
-- 
2.39.1

