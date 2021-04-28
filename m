Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB81BC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 13:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2FC461441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 13:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbhD1N6a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Apr 2021 09:58:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:27560 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239283AbhD1N6V (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Apr 2021 09:58:21 -0400
IronPort-SDR: 0wGM5KkgY7pL3PxiHG+oH/P7bweWcbDz8cOqmFrvEQYrzKv0k2B+DnOpnJdBifJfIchNtsuxTb
 obDdG1RtwGcw==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="217462967"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="217462967"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 06:57:35 -0700
IronPort-SDR: Lt88wcvrDQn8s/izBWh+jf3JHArSQbT08eooYHLHMZnS8kKzDOd2UUrFW2s7ZR7FfC6Kd3hu/W
 e1ab9K4zbFuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="423549405"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga008.fm.intel.com with ESMTP; 28 Apr 2021 06:57:33 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
Subject: [PATCH v4 2/2] Bluetooth: Add support for Read Local Supported Codecs V2
Date:   Wed, 28 Apr 2021 19:31:32 +0530
Message-Id: <20210428140132.30316-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210428140132.30316-1-kiran.k@intel.com>
References: <20210428140132.30316-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use V2 version of read local supported command is controller
supports

snoop:
> HCI Event: Command Complete (0x0e) plen 20
      Read Local Supported Codecs V2 (0x04|0x000d) ncmd 1
        Status: Success (0x00)
        Number of supported codecs: 7
          Codec: u-law log (0x00)
          Logical Transport Type: 0x02
            Codec supported over BR/EDR SCO and eSCO
          Codec: A-law log (0x01)
          Logical Transport Type: 0x02
            Codec supported over BR/EDR SCO and eSCO
          Codec: CVSD (0x02)
          Logical Transport Type: 0x02
            Codec supported over BR/EDR SCO and eSCO
          Codec: Transparent (0x03)
          Logical Transport Type: 0x02
            Codec supported over BR/EDR SCO and eSCO
          Codec: Linear PCM (0x04)
          Logical Transport Type: 0x02
            Codec supported over BR/EDR SCO and eSCO
          Codec: Reserved (0x08)
          Logical Transport Type: 0x03
            Codec supported over BR/EDR ACL
            Codec supported over BR/EDR SCO and eSCO
          Codec: mSBC (0x05)
          Logical Transport Type: 0x03
            Codec supported over BR/EDR ACL
            Codec supported over BR/EDR SCO and eSCO
        Number of vendor codecs: 0
......
< HCI Command: Read Local Suppor.. (0x04|0x000e) plen 7
        Codec: mSBC (0x05)
        Logical Transport Type: 0x00
        Direction: Input (Host to Controller) (0x00)
> HCI Event: Command Complete (0x0e) plen 12
      Read Local Supported Codec Capabilities (0x04|0x000e) ncmd 1
        Status: Success (0x00)
        Number of codec capabilities: 1
         Capabilities #0:
        00 00 11 15 02 33

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
* changes in v4:
  converts codec read capabilities calls from async to sync

* changes in v3:
  No changes

* changes in v2:
  add length check for event data before accessing

 include/net/bluetooth/hci.h |  2 +
 net/bluetooth/hci_core.c    | 97 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 2f7f8c6f7d63..38a6eeb5e03a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1314,6 +1314,8 @@ struct hci_rp_read_local_pairing_opts {
 	__u8     max_key_size;
 } __packed;
 
+#define HCI_OP_READ_LOCAL_CODECS_V2	0x100d
+
 #define HCI_OP_READ_LOCAL_CODEC_CAPS	0x100e
 struct hci_op_read_local_codec_caps {
 	__u8	codec_id[5];
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7201967b6e9c..039747b5617a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1003,10 +1003,105 @@ static void hci_read_supported_codecs(struct hci_dev *hdev)
 	kfree_skb(skb);
 }
 
+static void hci_read_supported_codecs_v2(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	__u8 num_codecs;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_CODECS_V2, 0, NULL,
+			     HCI_CMD_TIMEOUT);
+
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Failed to read local supported codecs v2 (%ld)",
+			   PTR_ERR(skb));
+		return;
+	}
+
+	if (skb->len < 1 || skb->data[0])
+		goto error;
+
+	skb_pull(skb, 1);
+
+	if (skb->len < 1)
+		goto error;
+
+	/* enumerate standard codecs */
+	num_codecs = skb->data[0];
+
+	skb_pull(skb, 1);
+
+	if (num_codecs && skb->len  < (num_codecs * 2))
+		goto error;
+
+	while (num_codecs--) {
+		__u8 transport;
+
+		transport = skb->data[1];
+
+		if (transport & LOCAL_CODEC_ACL_MASK)
+			hci_read_codec_capabilities(hdev, skb->data,
+						    LOCAL_CODEC_ACL, false);
+
+		if (transport & LOCAL_CODEC_SCO_MASK)
+			hci_read_codec_capabilities(hdev, skb->data,
+						    LOCAL_CODEC_SCO, false);
+
+		if (transport & LOCAL_CODEC_BIS_MASK)
+			hci_read_codec_capabilities(hdev, skb->data,
+						    LOCAL_CODEC_BIS, false);
+
+		if (transport & LOCAL_CODEC_CIS_MASK)
+			hci_read_codec_capabilities(hdev, skb->data,
+						    LOCAL_CODEC_CIS, false);
+
+		skb_pull(skb, 2);
+	}
+
+	/* enumerate vendor specific codecs */
+	if (skb->len < 1)
+		goto error;
+
+	num_codecs = skb->data[0];
+
+	skb_pull(skb, 1);
+
+	if (num_codecs && skb->len < (num_codecs * 5))
+		goto error;
+
+	while (num_codecs--) {
+		__u8 transport;
+
+		transport = skb->data[4];
+
+		if (transport & LOCAL_CODEC_ACL_MASK)
+			hci_read_codec_capabilities(hdev, skb->data,
+						    LOCAL_CODEC_ACL, true);
+
+		if (transport & LOCAL_CODEC_SCO_MASK)
+			hci_read_codec_capabilities(hdev, skb->data,
+						    LOCAL_CODEC_SCO, true);
+
+		if (transport & LOCAL_CODEC_BIS_MASK)
+			hci_read_codec_capabilities(hdev, skb->data,
+						    LOCAL_CODEC_BIS, true);
+
+		if (transport & LOCAL_CODEC_CIS_MASK)
+			hci_read_codec_capabilities(hdev, skb->data,
+						    LOCAL_CODEC_CIS, true);
+
+		skb_pull(skb, 5);
+	}
+
+error:
+	kfree_skb(skb);
+}
+
 static void hci_init5_req(struct hci_dev *hdev)
 {
 	/* Read local codec list if the HCI command is supported */
-	if (hdev->commands[29] & 0x20)
+	if (hdev->commands[45] & 0x04)
+		hci_read_supported_codecs_v2(hdev);
+	else if (hdev->commands[29] & 0x20)
 		hci_read_supported_codecs(hdev);
 }
 
-- 
2.17.1

