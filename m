Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C39C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 19:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D82610E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 19:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242579AbhI1T7I convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 15:59:08 -0400
Received: from mail.shanghaitech.edu.cn ([119.78.254.11]:11895 "EHLO
        mail.shanghaitech.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242525AbhI1T7H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 15:59:07 -0400
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 15:59:07 EDT
Received: from [10.15.44.215] by mail.shanghaitech.edu.cn with MESSAGESEC ESMTP id 480409496331105;
        Wed, 29 Sep 2021 03:57:08 +0800 (CST)
Received: from DESKTOP-FOJ6ELG.localdomain (10.15.44.220) by
 smtp.shanghaitech.edu.cn (10.15.44.215) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Wed, 29 Sep 2021 03:57:08 +0800
From:   Mianhan Liu <liumh1@shanghaitech.edu.cn>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mianhan Liu <liumh1@shanghaitech.edu.cn>
Subject: [PATCH] ./drivers/bluetooth/btqcomsmd.c: remove superfluous header files from btqcomsmd.c
Date:   Wed, 29 Sep 2021 03:56:59 +0800
Message-ID: <20210928195659.18645-1-liumh1@shanghaitech.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.15.44.220]
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

btqcomsmd.c hasn't use any macro or function declared in btqca.h,
linux/of.h and linux/slab.h.
Thus, these files can be removed from btqcomsmd.c safely without
affecting the compilation of the ./drivers/bluetooth module
---
 drivers/bluetooth/btqcomsmd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 2acb719e5..0fcb423c4 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -5,9 +5,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/slab.h>
 #include <linux/rpmsg.h>
-#include <linux/of.h>
 
 #include <linux/soc/qcom/wcnss_ctrl.h>
 #include <linux/platform_device.h>
@@ -15,7 +13,6 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#include "btqca.h"
 
 struct btqcomsmd {
 	struct hci_dev *hdev;
-- 
2.25.1


