Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471BEEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Jul 2023 20:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjGBU1C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Jul 2023 16:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjGBU1B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Jul 2023 16:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA96DDF
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jul 2023 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688329571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RAuoFBXJGbrEK7r6lFPsWq6Du417iZcQuP9Eu+SLXPs=;
        b=InEQWTYZgY9lpnzPaqFZ5lAGFfTApvFacFK7ZOxKj8Ii4jIHIDPdAn0SQWAlLSsO/PkJJT
        9x694Mi1ZYrW+klia5D+K6xGeW8Ex/94qlqbiokSuR2ezx6NgKBDk/iQ28QO3PSPjPL9DE
        6j+vmMiJbeZqK8QF5imPwANNKVJ5QA0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-lsU50Y8QNGawGFQwoy-xcQ-1; Sun, 02 Jul 2023 16:26:06 -0400
X-MC-Unique: lsU50Y8QNGawGFQwoy-xcQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635e10763f3so25993056d6.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Jul 2023 13:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688329566; x=1690921566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAuoFBXJGbrEK7r6lFPsWq6Du417iZcQuP9Eu+SLXPs=;
        b=WLBvucI+pHm2Eka1QWGY1sGZB7No8WYU+UQ8PusDqHX7RIJFuERtI3hXTCTf54aiHu
         S1PmOEjqVfpcc+276MrtzWE6K/ESUpfU9RdN77nlDLO20akPKNNNwQQOqIyfO9OQkc4p
         jR36UWcw1Ng/pxkNFHNjGQN49ZrdvUbz0sr2MN4uJSrUdyTBHYlUoFAV3fW8cbGkdUmo
         hGVnWW43dZh7sBr3hex5pAUot8fM7gFpY2oCirl2vjziT2MGpOBnG51qBfnH3HnL0g8U
         VJ7SUnUlwwpA0U9/afmfPw2hVPRiL4g5dMwVWcVRRN+2B5O/AbxWG/NgTGG0RiQXSkeN
         Gj0g==
X-Gm-Message-State: ABy/qLa9u2ww/p9lz8XgR01QZuJHHmstrlC6PdNlMI8qnZWw0naXYWjs
        UJt+ePX4VyPTBRSOaV8I0UOqlZjyWRv6kVOeukRQ9v1SHrCu4xCTwDctRn8vkZ+jdm1eS52PDmP
        LZcF3VYpnlAwYhGa0sf9RZxQLJL4Z
X-Received: by 2002:ad4:5fcd:0:b0:635:a1f5:5458 with SMTP id jq13-20020ad45fcd000000b00635a1f55458mr10055511qvb.12.1688329566475;
        Sun, 02 Jul 2023 13:26:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHAdOVmOK/0+cxD45eADjdrnL8vXwAqDR93DNfpbltexe47gg5n3KhEGJTHpGhBn8F7/mMyLw==
X-Received: by 2002:ad4:5fcd:0:b0:635:a1f5:5458 with SMTP id jq13-20020ad45fcd000000b00635a1f55458mr10055495qvb.12.1688329566186;
        Sun, 02 Jul 2023 13:26:06 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g10-20020ad4510a000000b0063623c266easm4430335qvp.3.2023.07.02.13.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 13:26:05 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        jing.cai@mediatek.com, sean.wang@mediatek.com,
        chris.lu@mediatek.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] Bluetooth: btmtk: fix handling of CONFIG_DEV_COREDUMP not being defined
Date:   Sun,  2 Jul 2023 16:26:03 -0400
Message-Id: <20230702202603.3442724-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When CONFIG_DEV_COREDUMP is not defined, there is this error
drivers/bluetooth/btmtk.c: In function ‘btmtk_process_coredump’:
drivers/bluetooth/btmtk.c:386:44: error: ‘struct hci_dev’ has no member named ‘dump’
  386 |                 schedule_delayed_work(&hdev->dump.dump_timeout,
      |                                            ^~

The runtime IS_ENABLED(CONFIG_DEV_COREDUMP) is not enough to
prevent the compiletime error of accessing the dump element of hci_dev.
So switch to #ifdef.

Fixes: 872f8c253cb9 ("Bluetooth: btusb: mediatek: add MediaTek devcoredump support")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/bluetooth/btmtk.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 786f775196ae..12769e95bf55 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -369,11 +369,9 @@ EXPORT_SYMBOL_GPL(btmtk_register_coredump);
 
 int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	int err = 0;
+#ifdef CONFIG_DEV_COREDUMP
 	struct btmediatek_data *data = hci_get_priv(hdev);
-	int err;
-
-	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
-		return 0;
 
 	switch (data->cd_info.state) {
 	case HCI_DEVCOREDUMP_IDLE:
@@ -407,7 +405,7 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (err < 0)
 		kfree_skb(skb);
-
+#endif
 	return err;
 }
 EXPORT_SYMBOL_GPL(btmtk_process_coredump);
-- 
2.27.0

