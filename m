Return-Path: <SRS0=4ALD=QH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188F9C169C4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 22:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BD520B1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 22:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfAaWK7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:10:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44118 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbfAaWKj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Jan 2019 17:10:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so2106674pfh.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jan 2019 14:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lTG4LqWhzedutRFZB8ceBB4jwcNpwwb+uZupnthHOUM=;
        b=QfUgC+aZyiyYCp9qG0VN6mewofWDlCNXKr+uKzJfU0uFVcTBEsJxFFTR9p7eMaLZUx
         aEYWFHizT1WtNSDklTP5sPKMfdBIKH23JKgIJeoLdJvfVCBdwNgNr28jpUqqZr+/aBkY
         w/pXNvmsxVxfCQvwiwRqi3+xpFfCakQUBAU108bZt5LmvRZxmtvQWRnvk0N1shOAHEDv
         kHBkQnbZH4BrIIfWuSHu+ZUi+IrNSAoLkHGfkXLQlwEigU+VM5wKKGQIRGbs9RoNdUGY
         nq2MkKWKgq2l+2R5XOTwhCI2YBHXhMx0vDxViaIEBG/Lrissuqv5dyJY2YVc3jTh3XpV
         26OA==
X-Gm-Message-State: AJcUukf3XvV7TAdCfQIAORIqiaqhhbGoR8rChOM9jRiNFdMoxCwLlZAw
        sx2o/rFV0SXSp944SBAzNiPoKw==
X-Google-Smtp-Source: ALg8bN53pf4XquSibA3VcFqlqpNYa1npTrsVqJWpC2yuFBV22HfR8GnfbH5EV/jzSLyPRSQw3AH/cA==
X-Received: by 2002:a63:3287:: with SMTP id y129mr33252332pgy.337.1548972638132;
        Thu, 31 Jan 2019 14:10:38 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r80sm10279879pfa.111.2019.01.31.14.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 14:10:37 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH RESEND 1/3] Bluetooth: Add quirk for reading BD_ADDR from fwnode property
Date:   Thu, 31 Jan 2019 14:10:19 -0800
Message-Id: <20190131221021.176809-2-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131221021.176809-1-mka@chromium.org>
References: <20190131221021.176809-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add HCI_QUIRK_USE_BDADDR_PROPERTY to allow controllers to retrieve
the public Bluetooth address from the firmware node property
'local-bd-address'. If quirk is set and the property does not exist
or is invalid the controller is marked as unconfigured.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Tested-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v3:
- return no value from hci_dev_get_bd_addr_from_property() since
  currently nobody uses it anyway
- use bacpy() in hci_dev_get_bd_addr_from_property()
- return -EADDRNOTAVAIL if no BD_ADDR is configured or if the driver
  has no ->set_bdaddr

Changes in v2:
- added check for return value of ->setup()
- only read BD_ADDR from the property if it isn't assigned yet. This
  is needed to support configuration from user space
- refactored the branch of the new quirk to get rid of 'bd_addr_set'
- added 'Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>' tag
---
 include/net/bluetooth/hci.h | 12 +++++++++++
 net/bluetooth/hci_core.c    | 43 +++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c        |  6 ++++--
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c36dc1e20556a..fbba43e9bef5b 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -158,6 +158,18 @@ enum {
 	 */
 	HCI_QUIRK_INVALID_BDADDR,
 
+	/* When this quirk is set, the public Bluetooth address
+	 * initially reported by HCI Read BD Address command
+	 * is considered invalid. The public BD Address can be
+	 * specified in the fwnode property 'local-bd-address'.
+	 * If this property does not exist or is invalid controller
+	 * configuration is required before this device can be used.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_USE_BDADDR_PROPERTY,
+
 	/* When this quirk is set, the duplicate filtering during
 	 * scanning is based on Bluetooth devices addresses. To allow
 	 * RSSI based updates, restart scanning if needed.
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7352fe85674be..3ccfa351b87bb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -30,6 +30,7 @@
 #include <linux/rfkill.h>
 #include <linux/debugfs.h>
 #include <linux/crypto.h>
+#include <linux/property.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -1355,6 +1356,32 @@ int hci_inquiry(void __user *arg)
 	return err;
 }
 
+/**
+ * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device Address
+ *				       (BD_ADDR) for a HCI device from
+ *				       a firmware node property.
+ * @hdev:	The HCI device
+ *
+ * Search the firmware node for 'local-bd-address'.
+ *
+ * All-zero BD addresses are rejected, because those could be properties
+ * that exist in the firmware tables, but were not updated by the firmware. For
+ * example, the DTS could define 'local-bd-address', with zero BD addresses.
+ */
+static void hci_dev_get_bd_addr_from_property(struct hci_dev *hdev)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(hdev->dev.parent);
+	bdaddr_t ba;
+	int ret;
+
+	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
+					    (u8 *)&ba, sizeof(ba));
+	if (ret < 0 || !bacmp(&ba, BDADDR_ANY))
+		return;
+
+	bacpy(&hdev->public_addr, &ba);
+}
+
 static int hci_dev_do_open(struct hci_dev *hdev)
 {
 	int ret = 0;
@@ -1422,6 +1449,22 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		if (hdev->setup)
 			ret = hdev->setup(hdev);
 
+		if (ret)
+			goto setup_failed;
+
+		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
+			if (!bacmp(&hdev->public_addr, BDADDR_ANY))
+				hci_dev_get_bd_addr_from_property(hdev);
+
+			if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
+			    hdev->set_bdaddr)
+				ret = hdev->set_bdaddr(hdev,
+						       &hdev->public_addr);
+			else
+				ret = -EADDRNOTAVAIL;
+		}
+
+setup_failed:
 		/* The transport driver can set these quirks before
 		 * creating the HCI device or in its setup callback.
 		 *
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ccce954f81468..fae84353d030f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -551,7 +551,8 @@ static bool is_configured(struct hci_dev *hdev)
 	    !hci_dev_test_flag(hdev, HCI_EXT_CONFIGURED))
 		return false;
 
-	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
+	if ((test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) ||
+	     test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) &&
 	    !bacmp(&hdev->public_addr, BDADDR_ANY))
 		return false;
 
@@ -566,7 +567,8 @@ static __le32 get_missing_options(struct hci_dev *hdev)
 	    !hci_dev_test_flag(hdev, HCI_EXT_CONFIGURED))
 		options |= MGMT_OPTION_EXTERNAL_CONFIG;
 
-	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
+	if ((test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) ||
+	     test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) &&
 	    !bacmp(&hdev->public_addr, BDADDR_ANY))
 		options |= MGMT_OPTION_PUBLIC_ADDRESS;
 
-- 
2.20.1.495.gaa96b0ce6b-goog

