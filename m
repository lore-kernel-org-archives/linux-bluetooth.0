Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEFAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Oct 2021 17:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18FA61156
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Oct 2021 17:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhJNRbF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Oct 2021 13:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbhJNRbE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Oct 2021 13:31:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD221C061570
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 10:28:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so7486127pjw.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 10:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kjAjz9ScoC55VcdBvcj8FJt5E9hnktxD9DkWra6a05g=;
        b=OpB5YLOXKicb1EUrXCPkC26DuWyPAHKQV61/aVVorXnmE8dRkFfS0mBusVMO6Z8kCq
         x82Fo7mQseZpctX+vZ1JOoa1KW5fmmSDVBCm0vzE3NYaI4zS3DiC5+R3wfc5v87q0Zd4
         0cz9ldvRHydjaGqMSe/+nO5/u/ovlQ+zAmX+YCHLhopm0m9SXz1f4cGuoIuzoZw56a1v
         As8xN+0dAmDKGtdtn6lvp5ziB5k++Hi1dB5zW/yEBaP3+CfJIXVvjZP8Dl73K5NrUuAK
         bZKkw6sNAlwcJfWX9aQNuxBAMUgHFssVfzKNnEqXerbrYZGEIdUMgTS9uhpbqHZddQ8K
         nl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kjAjz9ScoC55VcdBvcj8FJt5E9hnktxD9DkWra6a05g=;
        b=ZmSZ36AjwqXorGTRXgy7AYgudUQWUvqD8ECkWapzjiDWsOhwVS6zNW6ptPQsUPYxFk
         bwJPYilXLWfRvekG9gUAembyPl6gZcF94QkuRkQvov/Mo56dLE7S6ctTHIJjlNt9YzTl
         nq9VJYMrMW/NEUoOnBH1V52KA3nqFAE4EaPi6NVH4eUHHKf+6cQ1UEMCAw++Ft95OWz6
         0DV6C2wb1C2AZ74X2xiQOHJ6iw3qocw5w+KNT1DsYUhTAQXuFg3gnORVzTChcFTrCMdF
         Pv/I9zbOLcfS78iV/gLqVPmuf1EFxBEKtMcE9g7flydkd6scK76gSTCEyaWDItsfQnKr
         3/Og==
X-Gm-Message-State: AOAM530X+QbnqbxkJI9GsfBujqEwPN7UOATie5MTA+iH60HyB59TXEls
        raIrAfd8gOMTGXI53hS9lf9FJgI+v7k=
X-Google-Smtp-Source: ABdhPJw0bv8c4mqqIZ+scJglGkCLB5nbGdgAAXYH/a273QWP7a9gXtxPHKdTmIEjK7xaPK66wOkQBQ==
X-Received: by 2002:a17:902:e5d2:b0:13f:21c1:b44f with SMTP id u18-20020a170902e5d200b0013f21c1b44fmr6253104plf.30.1634232538886;
        Thu, 14 Oct 2021 10:28:58 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w19sm9787017pjy.9.2021.10.14.10.28.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:28:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Add parameter to hci_set_aosp_capable
Date:   Thu, 14 Oct 2021 10:28:55 -0700
Message-Id: <20211014172855.2989669-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it simpler for the driver like vhci that has it own setting
to pass it directly to hci_set_aosp_capable.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btrtl.c        | 2 +-
 drivers/bluetooth/hci_qca.c      | 2 +-
 drivers/bluetooth/hci_vhci.c     | 2 +-
 drivers/bluetooth/virtio_bt.c    | 2 +-
 include/net/bluetooth/hci_core.h | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index c2bdd1e6060e..602a022c3fba 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -751,7 +751,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	case CHIP_ID_8852A:
 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
-		hci_set_aosp_capable(hdev);
+		hci_set_aosp_capable(hdev, true);
 		break;
 	default:
 		rtl_dev_dbg(hdev, "Central-peripheral role not enabled.");
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index dd768a8ed7cb..fc212225fe63 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1730,7 +1730,7 @@ static int qca_setup(struct hci_uart *hu)
 	if (qca_is_wcn399x(soc_type) ||
 	    qca_is_wcn6750(soc_type)) {
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
-		hci_set_aosp_capable(hdev);
+		hci_set_aosp_capable(hdev, true);
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
 		if (ret)
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 74c0eb28c422..9e67517b6cef 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -264,7 +264,7 @@ static int vhci_setup(struct hci_dev *hdev)
 	struct vhci_data *vhci = hci_get_drvdata(hdev);
 
 	hci_set_msft_opcode(hdev, vhci->msft_opcode);
-	hci_set_aosp_capable(hdev);
+	hci_set_aosp_capable(hdev, vhci->aosp_capable);
 
 	return 0;
 }
diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 57908ce4fae8..f5e2003c26e6 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -343,7 +343,7 @@ static int virtbt_probe(struct virtio_device *vdev)
 	}
 
 	if (virtio_has_feature(vdev, VIRTIO_BT_F_AOSP_EXT))
-		hci_set_aosp_capable(hdev);
+		hci_set_aosp_capable(hdev, true);
 
 	if (hci_register_dev(hdev) < 0) {
 		hci_free_dev(hdev);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dd8840e70e25..d007b487d4c1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1279,10 +1279,10 @@ static inline void hci_set_msft_opcode(struct hci_dev *hdev, __u16 opcode)
 #endif
 }
 
-static inline void hci_set_aosp_capable(struct hci_dev *hdev)
+static inline void hci_set_aosp_capable(struct hci_dev *hdev, bool enable)
 {
 #if IS_ENABLED(CONFIG_BT_AOSPEXT)
-	hdev->aosp_capable = true;
+	hdev->aosp_capable = enable;
 #endif
 }
 
-- 
2.31.1

