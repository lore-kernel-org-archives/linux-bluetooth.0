Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659DAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 13:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E4A60FD8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 13:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhJHNze (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 09:55:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:60434 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239126AbhJHNzb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 09:55:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="213457783"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="213457783"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 06:53:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="624745019"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga001.fm.intel.com with ESMTP; 08 Oct 2021 06:53:33 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 7/7] Bluetooth: Read Output codec capabilities
Date:   Fri,  8 Oct 2021 19:28:53 +0530
Message-Id: <20211008135853.8604-7-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211008135853.8604-1-kiran.k@intel.com>
References: <20211008135853.8604-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When reading codec capabilities, read output (controller to host)
capabilities also along with input (host to controller) capabilities.

Change-Id: I68c9aaca0fb0f57be3cceb33251b39acfae58aaa
---
 net/bluetooth/hci_codec.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
index 6d4e5353f05c..c6bd934dcf36 100644
--- a/net/bluetooth/hci_codec.c
+++ b/net/bluetooth/hci_codec.c
@@ -159,6 +159,9 @@ void hci_read_supported_codecs(struct hci_dev *hdev)
 		caps.id = std_codecs->codec[i];
 		caps.direction = 0x00;
 		hci_read_codec_capabilities(hdev, LOCAL_CODEC_ACL_MASK, &caps);
+
+		caps.direction = 0x01;
+		hci_read_codec_capabilities(hdev, LOCAL_CODEC_ACL_MASK, &caps);
 	}
 
 	skb_pull(skb, flex_array_size(std_codecs, codec, std_codecs->num)
@@ -179,6 +182,9 @@ void hci_read_supported_codecs(struct hci_dev *hdev)
 		caps.vid = vnd_codecs->codec[i].vid;
 		caps.direction = 0x00;
 		hci_read_codec_capabilities(hdev, LOCAL_CODEC_ACL_MASK, &caps);
+
+		caps.direction = 0x01;
+		hci_read_codec_capabilities(hdev, LOCAL_CODEC_ACL_MASK, &caps);
 	}
 
 error:
@@ -224,6 +230,10 @@ void hci_read_supported_codecs_v2(struct hci_dev *hdev)
 
 	for (i = 0; i < std_codecs->num; i++) {
 		caps.id = std_codecs->codec[i].id;
+		caps.direction = 0x00;
+		hci_read_codec_capabilities(hdev, std_codecs->codec[i].transport,
+					    &caps);
+		caps.direction = 0x01;
 		hci_read_codec_capabilities(hdev, std_codecs->codec[i].transport,
 					    &caps);
 	}
@@ -243,6 +253,10 @@ void hci_read_supported_codecs_v2(struct hci_dev *hdev)
 		caps.id = 0xFF;
 		caps.cid = vnd_codecs->codec[i].cid;
 		caps.vid = vnd_codecs->codec[i].vid;
+		caps.direction = 0x00;
+		hci_read_codec_capabilities(hdev, vnd_codecs->codec[i].transport,
+					    &caps);
+		caps.direction = 0x01;
 		hci_read_codec_capabilities(hdev, vnd_codecs->codec[i].transport,
 					    &caps);
 	}
-- 
2.17.1

