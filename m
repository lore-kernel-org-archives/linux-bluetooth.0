Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB10C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 18:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiJGSea (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 14:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJGSe3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 14:34:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59773BC59
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 11:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665167668; x=1696703668;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tKlm9F7hAK5IstbcuPpLC0qmukg7SZj7Q/CjhkYE0ek=;
  b=fyOuqPoV/XS15huyg7WaVtlFdhEINhFNz9zwuCSw4Zp1AQ02YETUK45J
   iumpQ+zAHzQiimEtkQLS5WvkWIlzfvUZgKkw+CpKp9LL/OawSkUcELttY
   tcDbScLJc9i8pxL7ut3fOltZqC8yqMccDP6FFMQcJJjBSBjxGwj73eObQ
   D9WI+bzbUYPHTP6vvbVVjiLC4ZtcmDokP9HwQWb+6OU1cztROjPflrO/u
   RNpjfe1I/Tnv/QLqMyLHOF4yR3g4xKWb0vkPsnIRuz3cr7C0x6pxcVorH
   veC+90PzmN0xr5SgfXe2Wq6uL/n8tMozaCzZ7wJVw1a6T9te8bZT1LqY0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="390099865"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="390099865"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 11:34:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="627542683"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="627542683"
Received: from msislam-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.13.154])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 11:34:28 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v2] Bluetooth: Call HCI cmd to set random addr during MGMT call
Date:   Fri,  7 Oct 2022 11:34:20 -0700
Message-Id: <20221007183420.797070-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The call to MGMT_OP_SET_STATIC_ADDRESS saved the requested address in
the hdev structure, but never wrote that address out to the controller.
This adds call to hci_set_random_addr_sync() after it has been
validated.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_sync.c         |  2 +-
 net/bluetooth/mgmt.c             | 35 ++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 17f5a4c32f36..24864672d12c 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -90,6 +90,7 @@ int hci_read_clock_sync(struct hci_dev *hdev, struct hci_cp_read_clock *cp);
 int hci_write_fast_connectable_sync(struct hci_dev *hdev, bool enable);
 int hci_update_scan_sync(struct hci_dev *hdev);
 int hci_update_scan(struct hci_dev *hdev);
+int hci_set_random_addr_sync(struct hci_dev *hdev, bdaddr_t *rpa);
 
 int hci_write_le_host_supported_sync(struct hci_dev *hdev, u8 le, u8 simul);
 int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 76c3107c9f91..e1e3658a6e19 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -839,7 +839,7 @@ static bool adv_use_rpa(struct hci_dev *hdev, uint32_t flags)
 	return true;
 }
 
-static int hci_set_random_addr_sync(struct hci_dev *hdev, bdaddr_t *rpa)
+int hci_set_random_addr_sync(struct hci_dev *hdev, bdaddr_t *rpa)
 {
 	/* If we're advertising or initiating an LE connection we can't
 	 * go ahead and change the random address at this time. This is
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a92e7e485feb..990ab0f6414a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6501,10 +6501,28 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static int set_addr_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_set_static_address *cp = cmd->param;
+
+	return hci_set_random_addr_sync(hdev, &cp->bdaddr);
+}
+
+static void set_addr_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct mgmt_pending_cmd *cmd = data;
+
+	mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_STATIC_ADDRESS,
+			mgmt_status(err));
+	mgmt_pending_free(cmd);
+}
+
 static int set_static_address(struct sock *sk, struct hci_dev *hdev,
 			      void *data, u16 len)
 {
 	struct mgmt_cp_set_static_address *cp = data;
+	struct mgmt_pending_cmd *cmd = data;
 	int err;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -6534,6 +6552,23 @@ static int set_static_address(struct sock *sk, struct hci_dev *hdev,
 
 	bacpy(&hdev->static_addr, &cp->bdaddr);
 
+	cmd = mgmt_pending_new(sk, MGMT_OP_SET_STATIC_ADDRESS, hdev, data, len);
+	if (!cmd)
+		err = -ENOMEM;
+	else
+		err = hci_cmd_sync_queue(hdev, set_addr_sync, cmd,
+					 set_addr_complete);
+
+	if (err < 0) {
+		if (cmd)
+			mgmt_pending_free(cmd);
+
+		mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_STATIC_ADDRESS,
+				mgmt_status(err));
+
+		goto unlock;
+	}
+
 	err = send_settings_rsp(sk, MGMT_OP_SET_STATIC_ADDRESS, hdev);
 	if (err < 0)
 		goto unlock;
-- 
2.37.3

