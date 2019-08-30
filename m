Return-Path: <SRS0=Lvhs=W2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E186C3A59B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 17:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBB123426
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 17:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfH3RjL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:39:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:12030 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfH3RjL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Aug 2019 13:39:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 10:39:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="381192674"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.35.27])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2019 10:39:10 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com, marcel@holtmann.org
Subject: [PATCH BlueZ] mesh: test AEAD at startup to check kernel support
Date:   Fri, 30 Aug 2019 10:39:02 -0700
Message-Id: <20190830173902.19953-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

One time test at startup to ensure either kernel version v4.9 or later,
*or* that required AES-CCM support has been back-ported. If support not
there, daemon will run without providing D-Bus service or attaching to
controllers (prevents systemd thrashing).
---
 mesh/crypto.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/crypto.h |  1 +
 mesh/main.c   |  7 +++++++
 3 files changed, 59 insertions(+)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index a6dc7ffe2..27d1a16cc 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -1130,3 +1130,54 @@ bool mesh_crypto_check_fcs(const uint8_t *packet, uint8_t packet_len,
 
 	return fcs == 0xcf;
 }
+
+/* This function performs a quick-check of ELL and Kernel AEAD encryption.
+ * Some kernel versions before v4.9 have a known AEAD bug. If the system
+ * running this test is using a v4.8 or earlier kernel, a failure here is
+ * likely unless AEAD encryption has been backported.
+ */
+static const uint8_t crypto_test_result[] = {
+	0x75, 0x03, 0x7e, 0xe2, 0x89, 0x81, 0xbe, 0x59,
+	0xbc, 0xe6, 0xdd, 0x23, 0x63, 0x5b, 0x16, 0x61,
+	0xb7, 0x23, 0x92, 0xd4, 0x86, 0xee, 0x84, 0x29,
+	0x9a, 0x2a, 0xbf, 0x96
+};
+bool mesh_crypto_check_avail()
+{
+	void *cipher;
+	bool result;
+	uint8_t i;
+	union {
+		struct {
+			uint8_t key[16];
+			uint8_t aad[16];
+			uint8_t nonce[13];
+			uint8_t data[20];
+			uint8_t mic[8];
+		} crypto;
+		uint8_t bytes[0];
+	} u;
+	uint8_t out_msg[sizeof(u.crypto.data) + sizeof(u.crypto.mic)];
+
+
+	l_debug("Testing Crypto");
+	for (i = 0; i < sizeof(u); i++) {
+		u.bytes[i] = 0x60 + i;
+	}
+
+	cipher = l_aead_cipher_new(L_AEAD_CIPHER_AES_CCM, u.crypto.key,
+				sizeof(u.crypto.key), sizeof(u.crypto.mic));
+
+	result = l_aead_cipher_encrypt(cipher,
+				u.crypto.data, sizeof(u.crypto.data),
+				u.crypto.aad, sizeof(u.crypto.aad),
+				u.crypto.nonce, sizeof(u.crypto.nonce),
+				out_msg, sizeof(out_msg));
+
+	if (result)
+		result = !memcmp(out_msg, crypto_test_result, sizeof(out_msg));
+
+	l_aead_cipher_free(cipher);
+
+	return result;
+}
diff --git a/mesh/crypto.h b/mesh/crypto.h
index 1a73bcaa3..e5ce840b4 100644
--- a/mesh/crypto.h
+++ b/mesh/crypto.h
@@ -161,3 +161,4 @@ bool mesh_crypto_check_fcs(const uint8_t *packet, uint8_t packet_len,
 							uint8_t received_fcs);
 bool mesh_crypto_aes_cmac(const uint8_t key[16], const uint8_t *msg,
 					size_t msg_len, uint8_t res[16]);
+bool mesh_crypto_check_avail(void);
diff --git a/mesh/main.c b/mesh/main.c
index 262e3da48..273651f97 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -34,6 +34,7 @@
 #include "lib/mgmt.h"
 
 #include "mesh/mesh.h"
+#include "mesh/crypto.h"
 #include "mesh/dbus.h"
 #include "mesh/mesh-io.h"
 
@@ -121,6 +122,12 @@ int main(int argc, char *argv[])
 
 	l_log_set_stderr();
 
+	if (!mesh_crypto_check_avail()) {
+		l_error("Mesh Crypto functions unavailable");
+		status = l_main_run_with_signal(signal_handler, NULL);
+		goto done;
+	}
+
 	for (;;) {
 		int opt;
 		const char *str;
-- 
2.21.0

