Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB99AC83F01
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Aug 2023 08:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjHZI2u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Aug 2023 04:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjHZI2d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Aug 2023 04:28:33 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Aug 2023 01:28:30 PDT
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C13FB8
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Aug 2023 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=StY62
        IqFVfGM+O5VlHm07FT85M7pR6U2XLjz/OquzDc=; b=eRymzZaCKyczp/b5Dv6oS
        y4ItEkjKERMAu5yX/ffgeS06PO0hIDKOLu/VGLJRFNwHCsP3BFhbntqHYXJOKZ3W
        x+RefZWlZGsHcgqO9wYbsSLlbxSx5+jZLg68ob2bjbpnfbXUZREwDzk+gjqFzoRr
        6mKF1jNFI/+Krmuu0Df2os=
Received: from localhost.localdomain (unknown [103.29.142.67])
        by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wA3jqIbtOlk5bZsAA--.17442S2;
        Sat, 26 Aug 2023 16:13:16 +0800 (CST)
From:   xkq <xiaokeqinhealth@126.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Yao Xiao <xiaoyao@rock-chips.com>
Subject: [PATCH 1/1] Bluetooth: Delete unused hci_req_prepare_suspend() declaration
Date:   Sat, 26 Aug 2023 16:13:13 +0800
Message-Id: <20230826081313.3431523-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3jqIbtOlk5bZsAA--.17442S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWUAFW5Xr45XFyrKryUZFb_yoWDXFbEg3
        s0krnrG3y8trWUtrsFkr43uws5Wa1fWFn7WrnFqF9rK3s7GanFyr17Xr98try3Wws8CFyf
        Awn8tFyrAFnYyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU138n7UUUUU==
X-Originating-IP: [103.29.142.67]
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbi7x7X1V-1WCXUOAAAsI
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yao Xiao <xiaoyao@rock-chips.com>

hci_req_prepare_suspend() has been deprecated in favor of
hci_suspend_sync().

Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
Signed-off-by: Yao Xiao <xiaoyao@rock-chips.com>
---
 net/bluetooth/hci_request.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index b9c5a9823837..0be75cf0efed 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -71,7 +71,5 @@ struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn);
 void hci_req_add_le_passive_scan(struct hci_request *req);
 
-void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next);
-
 void hci_request_setup(struct hci_dev *hdev);
 void hci_request_cancel_all(struct hci_dev *hdev);
-- 
2.34.1

