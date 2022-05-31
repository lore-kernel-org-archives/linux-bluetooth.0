Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA300C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 07:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244566AbiEaHlm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 03:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244565AbiEaHll (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 03:41:41 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A89C025D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 00:41:40 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-ifshmUf9PeitAYIII_8KzQ-1; Tue, 31 May 2022 03:41:37 -0400
X-MC-Unique: ifshmUf9PeitAYIII_8KzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 660F1185A79C;
        Tue, 31 May 2022 07:41:37 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D698140EBD5;
        Tue, 31 May 2022 07:41:34 +0000 (UTC)
From:   Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, gtiwari@redhat.com
Subject: [Bluez V2 04/13] Fixing memory leak in sixaxis.c
Date:   Tue, 31 May 2022 13:11:08 +0530
Message-Id: <20220531074117.610321-5-gopalkrishna.tiwari@gmail.com>
In-Reply-To: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com>
References: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Gopal Tiwari <gtiwari@redhat.com>

While performing static tool analysis using coverity
found following reports for resouse leak

bluez-5.64/plugins/sixaxis.c:425: alloc_arg:
"get_pairing_type_for_device" allocates memory that is 
stored into "sysfs_path".

bluez-5.64/plugins/sixaxis.c:428: leaked_storage: Variable "sysfs_path"
going out of scope leaks the storage it points to.

Fixing them.

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 plugins/sixaxis.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index ddecbcccb..10cf15948 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -424,10 +424,15 @@ static void device_added(struct udev_device *udevice)
 
 	cp = get_pairing_type_for_device(udevice, &bus, &sysfs_path);
 	if (!cp || (cp->type != CABLE_PAIRING_SIXAXIS &&
-				cp->type != CABLE_PAIRING_DS4))
+				cp->type != CABLE_PAIRING_DS4)) {
+		g_free(sysfs_path);
 		return;
-	if (bus != BUS_USB)
+	}
+
+	if (bus != BUS_USB) {
+		g_free(sysfs_path);
 		return;
+	}
 
 	info("sixaxis: compatible device connected: %s (%04X:%04X %s)",
 				cp->name, cp->vid, cp->pid, sysfs_path);
-- 
2.26.2

