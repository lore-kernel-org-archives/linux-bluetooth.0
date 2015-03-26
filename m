Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 3/3] tools/btmgmt: Prettify supported flags in advinfo
Date: Wed, 25 Mar 2015 20:07:12 -0700
Message-Id: <1427339232-27053-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1427339232-27053-1-git-send-email-armansito@chromium.org>
References: <1427339232-27053-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes advinfo print human readable strings for the supported
flags field of Read Advertising Features response for the advinfo
command.
---
 tools/btmgmt.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 7ec2b23..3649a86 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3616,6 +3616,34 @@ static void cmd_le_oob(struct mgmt *mgmt, uint16_t index,
 	}
 }
 
+static const char *adv_flags_str[] = {
+				"connectable",
+				"general-discoverable",
+				"limited-discoverable",
+				"managed-flags",
+				"tx-power",
+				"scan-rsp-appearance",
+				"scan-rsp-local-name",
+};
+
+static const char *adv_flags2str(uint32_t flags)
+{
+	static char str[256];
+	unsigned i;
+	int off;
+
+	off = 0;
+	str[0] = '\0';
+
+	for (i = 0; i < NELEM(adv_flags_str); i++) {
+		if ((flags & (1 << i)) != 0)
+			off += snprintf(str + off, sizeof(str) - off, "%s ",
+							adv_flags_str[i]);
+	}
+
+	return str;
+}
+
 static void adv_features_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -3640,7 +3668,7 @@ static void adv_features_rsp(uint8_t status, uint16_t len, const void *param,
 	}
 
 	supported_flags = le32_to_cpu(rp->supported_flags);
-	print("Supported flags: 0x%04x", supported_flags);
+	print("Supported flags: %s", adv_flags2str(supported_flags));
 	print("Max advertising data len: %u", rp->max_adv_data_len);
 	print("Max scan response data len: %u", rp->max_scan_rsp_len);
 	print("Max instances: %u", rp->max_instances);
-- 
2.2.0.rc0.207.ga3a616c

