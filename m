Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AADC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 13:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349502AbiFUNsq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351453AbiFUNsp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 09:48:45 -0400
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7510963CB
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 06:48:43 -0700 (PDT)
X-QQ-mid: bizesmtp74t1655819312ti55rqcd
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 21:48:22 +0800 (CST)
X-QQ-SSF: 00400000002000C0D000B00A0000000
X-QQ-FEAT: Oygdsb2PWc44IuOgY+h9uwUMDsF/xM7B03uo2HjN7A3LdzT7IZAR/lTR4e+1k
        FKQ6oxExjdO8VJreG1AtTVi+v2hOGWZkyZXsglcD3XxxHOuNS+xI+fsLk5Ueeu21UVmIN1B
        5PtptYJkAcErLZMmKJpyBaK/YewlWiM66QF7hgEteF2LxOE17rEE2x6Ff1clbbPxhTlR5e4
        JuXd3KixeCOBKe65x0rLScgUqN2i9nW5Er3SMmUk6/pO6R6xVUzJtPTBa2krBlvDYXUu/N3
        zRGi4VTsGuMjPX4s9bo5f+ppAqZ7cf1QyNfP4YfwLNMtXYeipjsC+CHVoj8wCttS9cLdbCS
        b+npsjOrBFiOrAnisU=
X-QQ-GoodBg: 2
From:   Youwan Wang <wangyouwan@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Youwan Wang <wangyouwan@uniontech.com>
Subject: [PATCH] device: Fix timeout=1 to remove the device immediately
Date:   Tue, 21 Jun 2022 21:48:18 +0800
Message-Id: <20220621134818.11515-1-wangyouwan@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

　When I use bluetoothctl to remove a device,
　I find that the device has not been deleted.

　static void set_temporary_timer(device, 0)
　{
     ......
	if (!timeout)
		return;
　　 ......
　 }
 　
　　Now I want to delete the connected device
    when call remove.
　　I don't know whether this modification is
    feasible, please give me some suggestions.
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 7b451e458..d38ad74fc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3159,7 +3159,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 						DEVICE_INTERFACE, "Connected");
 
 	if (remove_device)
-		set_temporary_timer(device, 0);
+		set_temporary_timer(device, 1);
 }
 
 guint device_add_disconnect_watch(struct btd_device *device,
-- 
2.20.1



