Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD741C433E6
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jan 2021 05:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E5A22241
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jan 2021 05:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbhABF4C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Jan 2021 00:56:02 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:9212 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725208AbhABF4B (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Jan 2021 00:56:01 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Jan 2021 00:56:00 EST
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app2 (Coremail) with SMTP id by_KCgCXz3wMCfBfFuJJAA--.62532S4;
        Sat, 02 Jan 2021 13:47:59 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_qca: Fix memleak in qca_controller_memdump
Date:   Sat,  2 Jan 2021 13:47:55 +0800
Message-Id: <20210102054755.21069-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgCXz3wMCfBfFuJJAA--.62532S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWxZr4rCr1DWryDJrWrXwb_yoWfGFX_C3
        Z3uFy7Ar1UGr1Yy3WjgF45urySyan8ur1vg3Waq34fW39xZa47WryjqF98Gr1fWr1UGrsx
        A3yDCFyrAr1UAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
        aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0IBlZdtRuRfAASsb
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When __le32_to_cpu() fails, qca_memdump should be freed
just like when vmalloc() fails.

Fixes: d841502c79e3f ("Bluetooth: hci_qca: Collect controller memory dump during SSR")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/bluetooth/hci_qca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 4a963682c702..5dbcb7c42b80 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1024,7 +1024,9 @@ static void qca_controller_memdump(struct work_struct *work)
 			dump_size = __le32_to_cpu(dump->dump_size);
 			if (!(dump_size)) {
 				bt_dev_err(hu->hdev, "Rx invalid memdump size");
+				kfree(qca_memdump);
 				kfree_skb(skb);
+				qca->qca_memdump = NULL;
 				mutex_unlock(&qca->hci_memdump_lock);
 				return;
 			}
-- 
2.17.1

