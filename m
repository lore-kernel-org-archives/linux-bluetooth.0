Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC845C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jul 2022 17:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiGERZG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jul 2022 13:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiGERZF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jul 2022 13:25:05 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9EA1C925
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 10:25:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v126so11938927pgv.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Jul 2022 10:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctcnAJL7+WGYl0TtSsvKCpfo0oPIAkNGw9R2E6cLGUM=;
        b=osBSaUn/9hDlK891+XccdhMQ7GCyWnnGE3uBhWRJpfe700PGh/AHnuAQlbWZtV+YoH
         q4vDNkRS2J0c2tPUPXJu1yarqm/fZYtPXTP4B5m90B7HkyG8Cch7XQeKFtpWaAxvPwJO
         55Xyp+h6FrPie7w4BUbfyXHE3xAmBUMO1j5uBKGBHA/D/tXHIb8RxPRFVBrrXNTJcu7l
         ySIJzXj2SKsTfe85DWj9pMCU1yaKVBJlqnlRYDDTnW5CBLvFkV7aJWNMUYE9ozwRFpsV
         izf/XexqrGWxnEhD0teMsJ7E8QJubu3mOPO+nUIazM7oWpHjoLRtpeux8zITiG3frzEI
         3kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctcnAJL7+WGYl0TtSsvKCpfo0oPIAkNGw9R2E6cLGUM=;
        b=JjRIQ0pRIwLwQvYq73df/+HcjKn/5WDuNs5oYpbzBPwDHaLF0+ax3klAKNq+WYOIjb
         zmJnxs3/O1p6wUHm7HwMjMUUJCHiiAKVNzL6Ykr4tPrS7noP64M4m/QfJMyA9MgA9nNt
         SQsd/1QKROlDRTmxe0p/G68RRaTBv6FTHlnxSTrBS4Dws7Y9zaUjDcJDNzwZQrskFsFt
         RKmIr4aZ9Qtzk2XnEB5zPfcuAkcfp1WaMqaS3IhWA+R3ow1+e/Fm+mE8yTODpRY96ytA
         ftX9kiZ1s4108d96gu7DsQx3uEojZvCri9HkvdsM4fjGWEc8v3CHF7KObsrEScobAeaT
         jp5A==
X-Gm-Message-State: AJIora/IXqZmfJ/1mcSn3kTn9YYEmRV559h3MtPuizdoFoTYSDnKncDX
        8NbHe40aBsu9PaddIolkx8G5c0Pyty2Img==
X-Google-Smtp-Source: AGRyM1uAL6tLOPrjjx38VIStJwxCLaFs3aGV/uHuGL1fvCVLWIHGztzhSaSJoYJsU2KAQrH5koP00Q==
X-Received: by 2002:a63:2bd0:0:b0:412:2f70:f0ac with SMTP id r199-20020a632bd0000000b004122f70f0acmr11489572pgr.465.1657041904045;
        Tue, 05 Jul 2022 10:25:04 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b00168f08d0d12sm20856740plb.89.2022.07.05.10.25.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 10:25:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: core: Fix deadlock on hci_power_on_sync.
Date:   Tue,  5 Jul 2022 10:25:01 -0700
Message-Id: <20220705172501.1610923-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>

`cancel_work_sync(&hdev->power_on)` was moved to hci_dev_close_sync in
commit [1] to ensure that power_on work is canceled after HCI interface
down.

But, in certain cases power_on work function may call hci_dev_close_sync
itself: hci_power_on -> hci_dev_do_close -> hci_dev_close_sync ->
cancel_work_sync(&hdev->power_on), causing deadlock. In particular, this
happens when device is rfkilled on boot. To avoid deadlock, move
power_on work canceling out of hci_dev_do_close/hci_dev_close_sync.

Deadlock introduced by commit [1] was reported in [2,3] as broken
suspend. Suspend did not work because `hdev->req_lock` held as result of
`power_on` work deadlock. In fact, other BT features were not working.
It was not observed when testing [1] since it was verified without
rfkill in place.

NOTE: It is not needed to cancel power_on work from other places where
hci_dev_do_close/hci_dev_close_sync is called in case:
* Requests were serialized due to `hdev->req_workqueue`. The power_on
work is first in that workqueue.
* hci_rfkill_set_block which won't close device anyway until HCI_SETUP
is on.
* hci_sock_release which runs after hci_sock_bind which ensures
HCI_SETUP was cleared.

As result, behaviour is the same as in pre-dd06ed7 commit, except
power_on work cancel added to hci_dev_close.

[1]: commit dd06ed7ad057 ("Bluetooth: core: Fix missing power_on work cancel on HCI close")
[2]: https://lore.kernel.org/lkml/20220614181706.26513-1-max.oss.09@gmail.com/
[2]: https://lore.kernel.org/lkml/1236061d-95dd-c3ad-a38f-2dae7aae51ef@o2.pl/

Fixes: ff7f2926114d ("Bluetooth: core: Fix missing power_on work cancel on HCI close")
Signed-off-by: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
Reported-by: Max Krummenacher <max.krummenacher@toradex.com>
Reported-by: Mateusz Jonczyk <mat.jonczyk@o2.pl>
Tested-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 3 +++
 net/bluetooth/hci_sync.c | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 05c13f639b94..27e90eb4bf4c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -571,6 +571,7 @@ int hci_dev_close(__u16 dev)
 		goto done;
 	}
 
+	cancel_work_sync(&hdev->power_on);
 	if (hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF))
 		cancel_delayed_work(&hdev->power_off);
 
@@ -2677,6 +2678,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
 
+	cancel_work_sync(&hdev->power_on);
+
 	hci_cmd_sync_clear(hdev);
 
 	hci_unregister_suspend_notifier(hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 489c420b477c..dcaeb0c18292 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4139,7 +4139,6 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	bt_dev_dbg(hdev, "");
 
-	cancel_work_sync(&hdev->power_on);
 	cancel_delayed_work(&hdev->power_off);
 	cancel_delayed_work(&hdev->ncmd_timer);
 
-- 
2.35.3

