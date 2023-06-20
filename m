Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2D3EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 23:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjFTXlg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 19:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTXlf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 19:41:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AD51710
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 16:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687304494; x=1718840494;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RiCnlnhf4wLnmauT0y5tHCtmegZ48eaHagptOAjGTwQ=;
  b=WFWOsWOMnMNplu96FNs7W+x3Iphh967fwO5YQF7giY+SR9YZy2WayoQX
   EIiWy7RCC6tzkQ3+3sllFcWOGcvH5KxNMrtv/ow8MO3Vnv8K5rCc2CbO+
   eqd9QU2Cz5aE9NJIuxbOaE+YM1kwVl/fwbC98S9y/ryXQJ7EAHzQCat0J
   TJwwcmWCFVEYh8uRKxNooGB1OyKyL3ZMPmTrbMukoGgwJTzQqtDEh6VEm
   hZP3Gvs5MgQ5YrE1xZ92FjDaCuDKJ79RzDw58TIfMvU3hM76DLfHKqD7y
   tXKsQqCjdiZTDrA4fwk5BicDdehBajEWhoVDq1dq+8ZMiau1YjjTCS58i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="340353547"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="340353547"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 16:41:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888429692"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="888429692"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 20 Jun 2023 16:41:31 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        pmenzel@molgen.mpg.de, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/2] Bluetooth: btintel: print friendly error message for acpi errors
Date:   Wed, 21 Jun 2023 05:22:32 +0530
Message-Id: <20230620235233.1845036-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Print user friendly error messages for errors returned by ACPI
methods.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index dd1e48808ee2..1110289ccd02 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2463,28 +2463,29 @@ static int btintel_acpi_reset_method(struct hci_dev *hdev)
 
 	status = acpi_evaluate_object(ACPI_HANDLE(GET_HCIDEV_DEV(hdev)), "_PRR", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		bt_dev_err(hdev, "Failed to run _PRR method");
+		bt_dev_err(hdev, "Failed to run _PRR method: %s", acpi_format_exception(status));
 		ret = -ENODEV;
 		return ret;
 	}
 	p = buffer.pointer;
 
 	if (p->package.count != 1 || p->type != ACPI_TYPE_PACKAGE) {
-		bt_dev_err(hdev, "Invalid arguments");
+		bt_dev_err(hdev, "Invalid arguments: count: %u type: 0x%x", p->package.count,
+			   p->type);
 		ret = -EINVAL;
 		goto exit_on_error;
 	}
 
 	ref = &p->package.elements[0];
 	if (ref->type != ACPI_TYPE_LOCAL_REFERENCE) {
-		bt_dev_err(hdev, "Invalid object type: 0x%x", ref->type);
+		bt_dev_err(hdev, "Object type is not ACPI_TYPE_LOCAL_REFERENCE: 0x%x", ref->type);
 		ret = -EINVAL;
 		goto exit_on_error;
 	}
 
 	status = acpi_evaluate_object(ref->reference.handle, "_RST", NULL, NULL);
 	if (ACPI_FAILURE(status)) {
-		bt_dev_err(hdev, "Failed to run_RST method");
+		bt_dev_err(hdev, "Failed to run_RST method: %s", acpi_format_exception(status));
 		ret = -ENODEV;
 		goto exit_on_error;
 	}
-- 
2.25.1

