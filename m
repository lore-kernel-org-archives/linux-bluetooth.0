Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F76C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 11:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F93610FF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 11:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbhIGLWC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Sep 2021 07:22:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:50899 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244382AbhIGLWB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Sep 2021 07:22:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="219856271"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="219856271"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 04:20:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="448960473"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga002.jf.intel.com with ESMTP; 07 Sep 2021 04:20:36 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        tedd.an@intel.com, luiz.von.dentz@intel.com,
        michaelfsun@google.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 2/3] tools/sco-tester: Add a test case for setting offload codec
Date:   Tue,  7 Sep 2021 16:55:55 +0530
Message-Id: <20210907112556.11848-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210907112556.11848-1-kiran.k@intel.com>
References: <20210907112556.11848-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a test case to set codec for HFP offload use case
---

Notes:
    changes in v2:
     - No changes

 tools/sco-tester.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 0c4d9d76e4df..67ea4769ef2b 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -375,6 +375,43 @@ end:
 	close(sk);
 }
 
+static void test_codecs_setsockopt(const void *test_data)
+{
+	int sk, err;
+	char buffer[255];
+	struct bt_codecs *codecs;
+
+	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
+	if (sk < 0) {
+		tester_warn("Can't create socket: %s (%d)", strerror(errno),
+									errno);
+		tester_test_failed();
+		return;
+	}
+
+	memset(buffer, 0, sizeof(buffer));
+
+	codecs = (void *)buffer;
+
+	codecs->codecs[0].id = 0x05;
+	codecs->num_codecs = 1;
+	codecs->codecs[0].data_path_id = 1;
+	codecs->codecs[0].num_caps = 0x00;
+
+	err = setsockopt(sk, SOL_BLUETOOTH, BT_CODEC, codecs, sizeof(buffer));
+	if (err < 0) {
+		tester_warn("Can't set socket option : %s (%d)",
+			    strerror(errno), errno);
+		tester_test_failed();
+		goto end;
+	}
+
+	tester_test_passed();
+
+end:
+	close(sk);
+}
+
 static void test_getsockopt(const void *test_data)
 {
 	int sk, err;
@@ -669,5 +706,8 @@ int main(int argc, char *argv[])
 	test_offload_sco("Basic SCO Get Socket Option - Offload - Success",
 				NULL, setup_powered, test_codecs_getsockopt);
 
+	test_offload_sco("Basic SCO Set Socket Option - Offload - Success",
+				NULL, setup_powered, test_codecs_setsockopt);
+
 	return tester_run();
 }
-- 
2.17.1

