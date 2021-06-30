Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ED8C11F68
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jun 2021 08:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853FE61D07
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jun 2021 08:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhF3IGZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jun 2021 04:06:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:5410 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232966AbhF3IGY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jun 2021 04:06:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="272164632"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="272164632"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 01:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="643997937"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2021 01:03:54 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
Subject: [PATCH v10 02/10] Bluetooth: Add support for Read Local Supported Codecs V2
Date:   Wed, 30 Jun 2021 13:37:59 +0530
Message-Id: <20210630080807.12600-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210630080807.12600-1-kiran.k@intel.com>
References: <20210630080807.12600-1-kiran.k@intel.com>
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
* changes in v10:
  no changes

* changes in v9:
  use vnd as shortcut name for vendor instead of ven

* changes in v8:
  no changes

* changes in v7:
  call codec enumeration code in hci_init instead of having it in a separate
  function

* changes in v6
  no changes

* changes in v5:
  fix review comments

* changes in v4:
  converts codec read capabilities calls from async to sync

* changes in v3:
  No changes

* changes in v2:
  add length check for event data before accessing

 include/net/bluetooth/hci.h | 29 ++++++++++++++
 net/bluetooth/hci_core.c    | 78 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index f76849c8eafd..b4e35cf5f4b1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1337,6 +1337,35 @@ struct hci_rp_read_local_pairing_opts {
 	__u8     max_key_size;
 } __packed;
 
+#define HCI_OP_READ_LOCAL_CODECS_V2	0x100d
+struct hci_std_codec_v2 {
+	__u8	id;
+	__u8	transport;
+} __packed;
+
+struct hci_std_codecs_v2 {
+	__u8	num;
+	struct hci_std_codec_v2 codec[];
+} __packed;
+
+struct hci_vnd_codec_v2 {
+	__u8	id;
+	__le16	cid;
+	__le16	vid;
+	__u8	transport;
+} __packed;
+
+struct hci_vnd_codecs_v2 {
+	__u8	num;
+	struct hci_vnd_codec_v2 codec[];
+} __packed;
+
+struct hci_rp_read_local_supported_codecs_v2 {
+	__u8	status;
+	struct hci_std_codecs_v2 std_codecs;
+	struct hci_vnd_codecs_v2 vendor_codecs;
+} __packed;
+
 #define HCI_OP_READ_LOCAL_CODEC_CAPS	0x100e
 struct hci_op_read_local_codec_caps {
 	__u8	id;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2657d84e8240..4bd411d32468 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1039,6 +1039,28 @@ static void hci_codec_list_parse(struct hci_dev *hdev, __u8 num_codecs,
 	}
 }
 
+static void hci_codec_list_parse_v2(struct hci_dev *hdev, __u8 num_codecs,
+				    void *codec_list, bool is_vnd_codec)
+{
+	__u8 i;
+
+	for (i = 0; i < num_codecs; i++) {
+		if (!is_vnd_codec) {
+			struct hci_std_codecs_v2 *codecs = codec_list;
+
+			hci_read_codec_capabilities(hdev, &codecs->codec[i],
+						    codecs->codec[i].transport,
+						    is_vnd_codec);
+		} else {
+			struct hci_vnd_codecs_v2 *codecs = codec_list;
+
+			hci_read_codec_capabilities(hdev, &codecs->codec[i],
+						    codecs->codec[i].transport,
+						    is_vnd_codec);
+		}
+	}
+}
+
 static void hci_read_supported_codecs(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -1089,6 +1111,58 @@ static void hci_read_supported_codecs(struct hci_dev *hdev)
 	/* enumerate vendor codec capabilities */
 	hci_codec_list_parse(hdev, vnd_codecs->num, vnd_codecs, true);
 
+error:
+	kfree_skb(skb);
+}
+
+static void hci_read_supported_codecs_v2(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	struct hci_rp_read_local_supported_codecs_v2 *rp;
+	struct hci_std_codecs_v2 *std_codecs;
+	struct hci_vnd_codecs_v2 *vnd_codecs;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_CODECS_V2, 0, NULL,
+			     HCI_CMD_TIMEOUT);
+
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Failed to read local supported codecs (%ld)",
+			   PTR_ERR(skb));
+		return;
+	}
+
+	if (skb->len < sizeof(*rp))
+		goto error;
+
+	rp = (void *)skb->data;
+
+	if (rp->status)
+		goto error;
+
+	skb_pull(skb, sizeof(rp->status));
+
+	std_codecs = (void *)skb->data;
+
+	/* check for payload data length before accessing */
+	if (skb->len < flex_array_size(std_codecs, codec, std_codecs->num)
+	    + sizeof(std_codecs->num))
+		goto error;
+
+	hci_codec_list_parse_v2(hdev, std_codecs->num, std_codecs, false);
+
+	skb_pull(skb, flex_array_size(std_codecs, codec, std_codecs->num)
+		 + sizeof(std_codecs->num));
+
+	vnd_codecs = (void *)skb->data;
+
+	/* check for payload data length before accessing */
+	if (skb->len <
+	    flex_array_size(vnd_codecs, codec, vnd_codecs->num)
+	    + sizeof(vnd_codecs->num))
+		goto error;
+
+	hci_codec_list_parse_v2(hdev, vnd_codecs->num, vnd_codecs, true);
+
 error:
 	kfree_skb(skb);
 }
@@ -1126,7 +1200,9 @@ static int __hci_init(struct hci_dev *hdev)
 
 #if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
 	/* Read local codec list if the HCI command is supported */
-	if (hdev->commands[29] & 0x20)
+	if (hdev->commands[45] & 0x04)
+		hci_read_supported_codecs_v2(hdev);
+	else if (hdev->commands[29] & 0x20)
 		hci_read_supported_codecs(hdev);
 #endif
 
-- 
2.17.1

