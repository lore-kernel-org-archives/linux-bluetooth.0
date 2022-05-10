Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B32FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 May 2022 01:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbiEJBbs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 May 2022 21:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiEJBbr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 May 2022 21:31:47 -0400
Received: from smtpproxy21.qq.com (smtpbg704.qq.com [203.205.195.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4549D1F0DE3
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 18:27:50 -0700 (PDT)
X-QQ-mid: bizesmtp76t1652146064t83f7f86
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 10 May 2022 09:27:38 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000B00A0000000
X-QQ-FEAT: qfvbM89F700eyl2J/3OYA54UGqiawKMQ7Mn2PjbZg2BA7qG/UVdJXt5kA0J3e
        n1up7jB9ozlg3WfPtDmHxtnyYs/bVJ29PN3hasRNcDUgyzc8yEku4rQojfBedEQwsWDG2Ek
        ZFqwyFSdpQ56iSLenjv3DnIumBGWfgYd5SPlemklV+puF/jNE0aF08mEx6a5gaN30KzBEIG
        3qOKxGkhVHA+nF74aZ2RgZSUDcJtrTiqnaiFqmGaErqmw/i6QRQVwCMpL+YpfZJlPI1LhIJ
        TfNBYG6lZWn2eb65MfaiCjOiiR3jCg7rj7aeZE3BSGsk+hWz+nsAGgT5dC0Giud8LlDg==
X-QQ-GoodBg: 2
From:   wangyouwan <wangyouwan@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     wangyouwan <wangyouwan@uniontech.com>
Subject: [PATCH] device: Fix pairing has failed due to the error of Already Paired (0x13)
Date:   Tue, 10 May 2022 09:27:35 +0800
Message-Id: <20220510012735.1698-1-wangyouwan@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign9
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

After connect the Bluetooth mouse, open two Bluetoothctl at the same time,
when remove the mouse, quickly go to power off,
try to paired the mouse again when I was power on,
found that the error 0x13 was always reported.
try to connect directly,can connect successfully.
but use the info command to query the information of the mouse
and find that the pairing status of the mouse is No.
so I try to delete the paired information in the kernel
through the "* cancel_pairing()" interface.

Signed-off-by: wangyouwan <wangyouwan@uniontech.com>
---
 src/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 6da5c380b..f3ce55eff 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3106,8 +3106,11 @@ static DBusMessage *cancel_pairing(DBusConnection *conn, DBusMessage *msg,
 
 	DBG("");
 
-	if (!req)
+	if (!req) {
+		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
+						device->bdaddr_type);
 		return btd_error_does_not_exist(msg);
+	}
 
 	device_cancel_bonding(device, MGMT_STATUS_CANCELLED);
 
-- 
2.20.1



