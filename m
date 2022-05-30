Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740ACC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 May 2022 08:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiE3IMa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 May 2022 04:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiE3IM3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 May 2022 04:12:29 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C57753151E
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 01:12:28 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-82c8eLv6MkisC8Hwy_VHcQ-1; Mon, 30 May 2022 04:12:26 -0400
X-MC-Unique: 82c8eLv6MkisC8Hwy_VHcQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3176F3C02185;
        Mon, 30 May 2022 08:12:26 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB8671410F36;
        Mon, 30 May 2022 08:12:23 +0000 (UTC)
From:   Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, gtiwari@redhat.com
Subject: [Bluez 03/13] Fixing memroy leak in jlink.c
Date:   Mon, 30 May 2022 13:41:59 +0530
Message-Id: <20220530081209.560465-4-gopalkrishna.tiwari@gmail.com>
In-Reply-To: <20220530081209.560465-1-gopalkrishna.tiwari@gmail.com>
References: <20220530081209.560465-1-gopalkrishna.tiwari@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Gopal Tiwari <gtiwari@redhat.com>

While performing static tool analysis using coverity found following reports for resouse leak

bluez-5.64/monitor/jlink.c:111: leaked_storage: Variable "so" going out of scope leaks the storage it points to.

bluez-5.64/monitor/jlink.c:113: leaked_storage: Variable "so" going out of scope leaks the storage it points to.

Fixing them.

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 monitor/jlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/monitor/jlink.c b/monitor/jlink.c
index 9aaa4ebd8..672097004 100644
--- a/monitor/jlink.c
+++ b/monitor/jlink.c
@@ -107,9 +107,12 @@ int jlink_init(void)
 			!jlink.tif_select || !jlink.setspeed ||
 			!jlink.connect || !jlink.getsn ||
 			!jlink.emu_getproductname ||
-			!jlink.rtterminal_control || !jlink.rtterminal_read)
+			!jlink.rtterminal_control || !jlink.rtterminal_read) {
+		dlclose(so);
 		return -EIO;
+	}
 
+	dlclose(so)
 	return 0;
 }
 
-- 
2.26.2

