Return-Path: <SRS0=SB5R=BN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F47C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 14:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73E2206DA
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 14:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mnmoran.org header.i=@mnmoran.org header.b="QPKZ1H1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgHCOH4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:07:56 -0400
Received: from hoster906.com ([192.252.156.27]:49224 "EHLO hoster906.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgHCOHz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Aug 2020 10:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=mnmoran.org; h=from
        :subject:to:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=dkim; bh=L7wJiaPTNNBoh2x4608zvE36N
        HtHcq2BA+rXIDzW5B8=; b=QPKZ1H1NrJUWVgSQuQiOUspLEfdOsPk1KKrj7lfFj
        3NwQE+y8gfbSQT8kF7BGq80t6pmOuOA0Zs/J5v1S5989uc4CQqZry9TJtXZWQHSl
        Yl18UIygQLaIGqRZiT9uIYIrJ4hlUKOxkRAoLcGpSOLdyNVKJNVU7cVtLDlP/iKy
        b4=
Received: (qmail 1103 invoked by uid 503); 3 Aug 2020 14:07:54 -0000
Received: from unknown (HELO ?192.168.254.79?) (pop-before-smtp@162.39.210.203)
  by hoster906.com with ESMTPA; 3 Aug 2020 14:07:54 -0000
From:   "Michael N. Moran" <mike@mnmoran.org>
Subject: [PATCH BlueZ v2 1/1] mesh: Add strings for SIG Model IDs
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-ID: <84fb4cad-5402-6d6b-b72e-a03a1c5d187a@mnmoran.org>
Date:   Mon, 3 Aug 2020 10:07:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
  tools/mesh/cfgcli.c |  3 ++-
  tools/mesh/remote.c |  5 ++--
  tools/mesh/util.c   | 64 
+++++++++++++++++++++++++++++++++++++++++++++
  tools/mesh/util.h   |  1 +
  4 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index e36c8dca5..351f40ad0 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -263,7 +263,8 @@ static uint32_t print_mod_id(uint8_t 
*data, bool vendor, const char *offset)
   	if (!vendor) {
  		mod_id = get_le16(data);
-		bt_shell_printf("%sModel ID\t%4.4x\n", offset, mod_id);
+		bt_shell_printf("%sModel ID\t%4.4x \"%s\"\n",
+							offset, mod_id, sig_model_string(mod_id));
  		mod_id = VENDOR_ID_MASK | mod_id;
  	} else {
  		mod_id = get_le16(data + 2);
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index c74f0bec1..206885c07 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -30,6 +30,7 @@
  #include "tools/mesh/keys.h"
  #include "tools/mesh/mesh-db.h"
  #include "tools/mesh/remote.h"
+#include "tools/mesh/util.h"
   #define abs_diff(a, b) ((a) > (b) ? (a) - (b) : (b) - (a))
  @@ -293,8 +294,8 @@ static void print_model(void *model, 
void *user_data)
   	if (mod_id >= VENDOR_ID_MASK) {
  		mod_id &= ~VENDOR_ID_MASK;
-		bt_shell_printf("\t\t\t" COLOR_GREEN "SIG model: %4.4x\n"
-							COLOR_OFF, mod_id);
+		bt_shell_printf("\t\t\t" COLOR_GREEN "SIG model: %4.4x 
\"%s\"\n"
+							COLOR_OFF, mod_id, sig_model_string(mod_id));
  		return;
  	}
  diff --git a/tools/mesh/util.c b/tools/mesh/util.c
index 7176cc562..82e4c9ad2 100644
--- a/tools/mesh/util.c
+++ b/tools/mesh/util.c
@@ -138,3 +138,67 @@ void swap_u256_bytes(uint8_t *u256)
  		u256[i] ^= u256[31 - i];
  	}
  }
+
+const char	*sig_model_string(uint16_t sig_model_id)
+{
+	switch (sig_model_id) {
+	case 0x0000: return "Configuration Server";
+	case 0x0001: return "Configuration Client";
+	case 0x0002: return "Health Server";
+	case 0x0003: return "Health Client";
+	case 0x1000: return "Generic OnOff Server";
+	case 0x1001: return "Generic OnOff Client";
+	case 0x1002: return "Generic Level Server";
+	case 0x1003: return "Generic Level Client";
+	case 0x1004: return "Generic Default Transition Time Server";
+	case 0x1005: return "Generic Default Transition Time Client";
+	case 0x1006: return "Generic Power OnOff Server";
+	case 0x1007: return "Generic Power OnOff Setup Server";
+	case 0x1008: return "Generic Power OnOff Client";
+	case 0x1009: return "Generic Power Level Server";
+	case 0x100A: return "Generic Power Level Setup Server";
+	case 0x100B: return "Generic Power Level Client";
+	case 0x100C: return "Generic Battery Server";
+	case 0x100D: return "Generic Battery Client";
+	case 0x100E: return "Generic Location Server";
+	case 0x100F: return "Generic Location Setup Server";
+	case 0x1010: return "Generic Location Client";
+	case 0x1011: return "Generic Admin Property Server";
+	case 0x1012: return "Generic Manufacturer Property Server";
+	case 0x1013: return "Generic User Property Server";
+	case 0x1014: return "Generic Client Property Server";
+	case 0x1015: return "Generic Property Client";
+	case 0x1100: return "Sensor Server";
+	case 0x1101: return "Sensor Setup Server";
+	case 0x1102: return "Sensor Client";
+	case 0x1200: return "Time Server";
+	case 0x1201: return "Time Setup Server";
+	case 0x1202: return "Time Client";
+	case 0x1203: return "Scene Server";
+	case 0x1204: return "Scene Setup Server";
+	case 0x1205: return "Scene Client";
+	case 0x1206: return "Scheduler Server";
+	case 0x1207: return "Scheduler Setup Server";
+	case 0x1208: return "Scheduler Client";
+	case 0x1300: return "Light Lightness Server";
+	case 0x1301: return "Light Lightness Setup Server";
+	case 0x1302: return "Light Lightness Client";
+	case 0x1303: return "Light CTL Server";
+	case 0x1304: return "Light CTL Setup Server";
+	case 0x1305: return "Light CTL Client";
+	case 0x1306: return "Light CTL Temperature Server";
+	case 0x1307: return "Light HSL Server";
+	case 0x1308: return "Light HSL Setup Server";
+	case 0x1309: return "Light HSL Client";
+	case 0x130A: return "Light HSL Hue Server";
+	case 0x130B: return "Light HSL Saturation Server";
+	case 0x130C: return "Light xyL Server";
+	case 0x130D: return "Light xyL Setup Server";
+	case 0x130E: return "Light xyL Client";
+	case 0x130F: return "Light LC Server";
+	case 0x1310: return "Light LC Setup Server";
+	case 0x1311: return "Light LC Client";
+
+	default: return "Unknown";
+	}
+}
diff --git a/tools/mesh/util.h b/tools/mesh/util.h
index cca07cf96..2b9b926b1 100644
--- a/tools/mesh/util.h
+++ b/tools/mesh/util.h
@@ -27,3 +27,4 @@ uint16_t mesh_opcode_set(uint32_t opcode, 
uint8_t *buf);
  bool mesh_opcode_get(const uint8_t *buf, uint16_t sz, 
uint32_t *opcode, int *n);
  const char *mesh_status_str(uint8_t status);
  void swap_u256_bytes(uint8_t *u256);
+const char	*sig_model_string(uint16_t sig_model_id);
-- 
2.26.2

