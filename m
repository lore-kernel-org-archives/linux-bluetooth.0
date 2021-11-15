Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88EFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 06:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0AB663218
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 06:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhKOGq4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 01:46:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:7180 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230336AbhKOGqt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 01:46:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="220598238"
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="220598238"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 22:43:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="453725972"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2021 22:43:50 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 07/13] Bluetooth: Read Output codec capabilities
Date:   Mon, 15 Nov 2021 12:19:08 +0530
Message-Id: <20211115064914.2345-7-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211115064914.2345-1-kiran.k@intel.com>
References: <20211115064914.2345-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When reading codec capabilities, read output (controller to host)
capabilities also along with input (host to controller) capabilities.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
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

