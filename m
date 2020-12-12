Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31DEC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 09:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA5C22DFB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 09:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437346AbgLLJ4p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Dec 2020 04:56:45 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:59571 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407336AbgLLJ43 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Dec 2020 04:56:29 -0500
Received: from localhost.localdomain ([93.22.36.60])
        by mwinf5d05 with ME
        id 3Mmz2400z1HrHD103Mn0mg; Sat, 12 Dec 2020 10:47:01 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 12 Dec 2020 10:47:01 +0100
X-ME-IP: 93.22.36.60
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     agross@kernel.org, bjorn.andersson@linaro.org, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] Bluetooth: btqcomsmd: Fix a resource leak in error handling paths in the probe function
Date:   Sat, 12 Dec 2020 10:46:58 +0100
Message-Id: <20201212094658.83861-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some resource should be released in the error handling path of the probe
function, as already done in the remove function.

The remove function was fixed in commit 5052de8deff5 ("soc: qcom: smd:
Transition client drivers from smd to rpmsg")

Fixes: 1511cc750c3d ("Bluetooth: Introduce Qualcomm WCNSS SMD based HCI driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/bluetooth/btqcomsmd.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 98d53764871f..2acb719e596f 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -142,12 +142,16 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 
 	btq->cmd_channel = qcom_wcnss_open_channel(wcnss, "APPS_RIVA_BT_CMD",
 						   btqcomsmd_cmd_callback, btq);
-	if (IS_ERR(btq->cmd_channel))
-		return PTR_ERR(btq->cmd_channel);
+	if (IS_ERR(btq->cmd_channel)) {
+		ret = PTR_ERR(btq->cmd_channel);
+		goto destroy_acl_channel;
+	}
 
 	hdev = hci_alloc_dev();
-	if (!hdev)
-		return -ENOMEM;
+	if (!hdev) {
+		ret = -ENOMEM;
+		goto destroy_cmd_channel;
+	}
 
 	hci_set_drvdata(hdev, btq);
 	btq->hdev = hdev;
@@ -161,14 +165,21 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	hdev->set_bdaddr = qca_set_bdaddr_rome;
 
 	ret = hci_register_dev(hdev);
-	if (ret < 0) {
-		hci_free_dev(hdev);
-		return ret;
-	}
+	if (ret < 0)
+		goto hci_free_dev;
 
 	platform_set_drvdata(pdev, btq);
 
 	return 0;
+
+hci_free_dev:
+	hci_free_dev(hdev);
+destroy_cmd_channel:
+	rpmsg_destroy_ept(btq->cmd_channel);
+destroy_acl_channel:
+	rpmsg_destroy_ept(btq->acl_channel);
+
+	return ret;
 }
 
 static int btqcomsmd_remove(struct platform_device *pdev)
-- 
2.27.0

