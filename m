Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7527C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Nov 2021 00:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346507AbhKYAT2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Nov 2021 19:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243273AbhKYAT0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Nov 2021 19:19:26 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB54C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Nov 2021 16:16:15 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r138so3535957pgr.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Nov 2021 16:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQJyAGwyV/v3jY2O1ai+JHugeg7GofWRLfzX/lPSn7Y=;
        b=l9THGDvRvo9N2ikmGMLBlz2GsczPbGx3uxQX/znGVlwFuWG0XUBGpNwp//6lMYo2RW
         H4w1GPXqgmCKJUiEKwR7AqdqlIfzrQmKJ1GcZjhL1bt0iHk9MvV+1WRk2MMnP12eZfEE
         xUodrdr7omH4dTxiZur3K4ck8tQ/IbCx6zKV/g4hrTh+MEfJiK6XWXgDS8SznpmZgCc3
         iOhxg29BEPLjOuHQneTsf4G+StmgYqkWsH6zZyRHvEeEzdOXgFwbz+EVnAM2LgCQeKob
         OFoR05jX9hezYZQLcVzu+jAvSJ9QSrPFYV+Cbh2nCMGjBivIyLWli5DtDxsixKNAxHw1
         0rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQJyAGwyV/v3jY2O1ai+JHugeg7GofWRLfzX/lPSn7Y=;
        b=scmc6r5rSEYzDOfBydfObFgRNIUsHuhfWKbRKbbQnk0yPKs/4+nNGZLKooTjJHNDfk
         I6lzpAcohJNjz+cQylvf31wrGGUQDXEP+yGhIXH+ljxJoitzpJCIvyS0S+2sFCGZx79N
         g7A5GWJSgN8RU3vGfuKyGeApZ+Q+1O36A38xQQF4cmn2DbX0cTH92NupjUgTTMZDEX2/
         /8fgO5THdOwq/p4yN+ENJssbPo2Spz/Xxr5nTG5whkRosATperMw2s5ES2F9ahSsVNAX
         dKf2Pl3FKp8JIg37P4/snBdalXNZyFSc21GM3YAKLaf2GUMppawpBYxG9SKSWXSwPx9b
         X7Rw==
X-Gm-Message-State: AOAM53012oUyCdpBl5pTKGQsMW29DAk2PO0xWEPukRGAqY2JdSUyCGJ8
        jtk9psqJX+9HDSkQYHRR2NkJ+dTe1Rk=
X-Google-Smtp-Source: ABdhPJywNGUj77AKG/JH2nnzbS6YfiLRKgkYIsKuOFE3UtR5vBG3JlTz0ZbIjta8ZV92MX2qr50K5w==
X-Received: by 2002:a63:6a41:: with SMTP id f62mr13411229pgc.198.1637799374082;
        Wed, 24 Nov 2021 16:16:14 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z4sm861751pfg.101.2021.11.24.16.16.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 16:16:13 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: HCI: Fix definition of hci_rp_read_stored_link_key
Date:   Wed, 24 Nov 2021 16:16:12 -0800
Message-Id: <20211125001613.3274241-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Both max_num_keys and num_key are 2 octects:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
page 1985:

  Max_Num_Keys:
  Size: 2 octets
  Range: 0x0000 to 0xFFFF

  Num_Keys_Read:
  Size: 2 octets
  Range: 0x0000 to 0xFFFF

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Use __le16 instead of __u16 in hci_rp_read_stored_link_key and update
fields in hci_dev to properly store 2 octects. Also add a patch for
hci_rp_delete_stored_link_key since num_keys is also 2 octecs like
hci_rp_read_stored_link_key.

 include/net/bluetooth/hci.h      | 4 ++--
 include/net/bluetooth/hci_core.h | 4 ++--
 net/bluetooth/hci_event.c        | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 84db6b275231..3c5211c3a790 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1047,8 +1047,8 @@ struct hci_cp_read_stored_link_key {
 } __packed;
 struct hci_rp_read_stored_link_key {
 	__u8     status;
-	__u8     max_keys;
-	__u8     num_keys;
+	__le16    max_keys;
+	__le16    num_keys;
 } __packed;
 
 #define HCI_OP_DELETE_STORED_LINK_KEY	0x0c12
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2560cfe80db8..bb07a6d0d597 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -352,8 +352,8 @@ struct hci_dev {
 	__u16		lmp_subver;
 	__u16		voice_setting;
 	__u8		num_iac;
-	__u8		stored_max_keys;
-	__u8		stored_num_keys;
+	__u16		stored_max_keys;
+	__u16		stored_num_keys;
 	__u8		io_capability;
 	__s8		inq_tx_power;
 	__u8		err_data_reporting;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index efc5458b1345..7452de6895fc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -256,8 +256,8 @@ static void hci_cc_read_stored_link_key(struct hci_dev *hdev,
 		return;
 
 	if (!rp->status && sent->read_all == 0x01) {
-		hdev->stored_max_keys = rp->max_keys;
-		hdev->stored_num_keys = rp->num_keys;
+		hdev->stored_max_keys = le16_to_cpu(rp->max_keys);
+		hdev->stored_num_keys = le16_to_cpu(rp->num_keys);
 	}
 }
 
-- 
2.33.1

