Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FC1C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 13:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7013207FF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 13:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W/jpatMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390830AbgDCNiU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:38:20 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38885 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgDCNiU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 09:38:20 -0400
Received: by mail-ua1-f66.google.com with SMTP id g10so2719936uae.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nSWbhqvfY+/Us7kVMx2Qrr6gl+oA8LNK2eayGaO0+bs=;
        b=W/jpatMGZE1Al9QN97WIBYl14zACI/s98JBYFNXxEvKL1DGLThQL6pyYafzKyEPQy9
         fHaIn647JGi+QSIxLRZAMLIY2s1/Fp9R7qDaabOdp9YhEVk5qwF706E32TWaCgtYAjw8
         0Tz9tXyaq0njJdeh67bogfHMAy2nqqIaHlsQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nSWbhqvfY+/Us7kVMx2Qrr6gl+oA8LNK2eayGaO0+bs=;
        b=KK6iTEn0iYIoye89Er3/x7IkUgjV8rF/lKSFPRL85W2OblM4aMAj9emAEC3AYzyG3S
         5rNa3vjo2DshMRO7sFS+zsKtoN6aVLfh9IrVF+RR1ZVVSINvC6xX1hnp/SAmnSsQLQ8v
         I8xC4xAsHkPO+LOCQ29PaEzJ3WmF54Nn5ounPCf5ZVkoCjn/QkDBH19oqyp4rQjXJ6Eq
         wYdPuDJ/dzURIM2i66LY4fwmh0S8hQMVd6gQqPztjS+SmcHv1rfk47hKTNmps1pHcpT0
         t4Py1lvokavmRNZ8fmBe7Mh15JB3K9G8vjiLcFMPVqwwPsEOlboK4Ljcj7XkAnncWjl4
         P9bQ==
X-Gm-Message-State: AGi0PubkiSJtNpBjuGMCsiK9PElGStrAW6pKyq82kX7aThcyQCgEqSYq
        Ca+05bPuRBV0AD31olb6A4JgX+2/VAQ=
X-Google-Smtp-Source: APiQypIB++g7YCoYFeIvHYEqP2le8p5bcnkqiG8RhMMLTp0agLy2w1VeSab9XYRgigs8K3dlWxTCCQ==
X-Received: by 2002:ab0:70a1:: with SMTP id q1mr6428691ual.52.1585921097002;
        Fri, 03 Apr 2020 06:38:17 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id t194sm2082580vst.17.2020.04.03.06.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 06:38:16 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v1] bluetooth:Adding driver and quirk defs for multi-role LE
Date:   Fri,  3 Apr 2020 13:38:06 +0000
Message-Id: <20200403133806.246918-1-alainm@chromium.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds the relevant driver and quirk to allow drivers to
report that concurrent roles are well supported by the controller.

This has historically been disabled as controllers did not reliably
support this. In particular, this will be used to relax this condition
for controllers that have been well tested and reliable.

	/* Most controller will fail if we try to create new connections
	 * while we have an existing one in slave role.
	 */
	if (hdev->conn_hash.le_num_slave > 0)
		return NULL;

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 drivers/bluetooth/btusb.c   | 2 ++
 include/net/bluetooth/hci.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3bdec42c9612..22e61a502d40 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -58,6 +58,8 @@ static struct usb_driver btusb_driver;
 #define BTUSB_CW6622		0x100000
 #define BTUSB_MEDIATEK		0x200000
 #define BTUSB_WIDEBAND_SPEECH	0x400000
+#define BTUSB_LE_CONCURRENT_ROLES_SUPPORTED \
+				0x800000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5f60e135aeb6..b2c76cde7cd4 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -214,6 +214,14 @@ enum {
 	 * This quirk must be set before hci_register_dev is called.
 	 */
 	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
+
+	/* When this quirk is set, the controller has validated that
+	 * concurrent LE roles are supported.  This mechanism is necessary
+	 * as many controllers have been seen has having trouble initiating
+	 * a connectable advertisement after at least one connection in
+	 * central had already been established.
+	 */
+	HCI_QUIRK_LE_CONCURRENT_ROLES_SUPPORTED,
 };
 
 /* HCI device flags */
-- 
2.26.0.292.g33ef6b2f38-goog

