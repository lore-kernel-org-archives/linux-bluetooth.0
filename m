Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D641C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 10:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679C3610FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 10:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243644AbhIGKLR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:11:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:1875 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244974AbhIGKLQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Sep 2021 06:11:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="200363856"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="200363856"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 03:10:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="478618578"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2021 03:10:09 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, michaelfsun@google.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 3/3] tools/sco-tester: add a test case for offload SCO connect
Date:   Tue,  7 Sep 2021 15:45:20 +0530
Message-Id: <20210907101520.8473-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210907101520.8473-1-kiran.k@intel.com>
References: <20210907101520.8473-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a test case for offload SCO connect with codec type set to mSBC
---
 tools/sco-tester.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index e412111ffd42..06d3700f009c 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -678,6 +678,52 @@ end:
 	close(sk);
 }
 
+static void test_connect_offload_msbc(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct sco_client_data *scodata = data->test_data;
+	int sk, err;
+	int len;
+	char buffer[255];
+	struct bt_codecs *codecs;
+
+	sk = create_sco_sock(data);
+	if (sk < 0) {
+		tester_test_failed();
+		return;
+	}
+
+	len = sizeof(buffer);
+	memset(buffer, 0, len);
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
+	err = connect_sco_sock(data, sk);
+
+	tester_warn("Connect returned %s (%d), expected %s (%d)",
+			strerror(-err), -err,
+			strerror(scodata->expect_err), scodata->expect_err);
+
+	if (-err != scodata->expect_err)
+		tester_test_failed();
+	else
+		tester_test_passed();
+
+end:
+	close(sk);
+}
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -712,5 +758,8 @@ int main(int argc, char *argv[])
 	test_offload_sco("Basic SCO Set Socket Option - Offload - Success",
 				NULL, setup_powered, test_codecs_setsockopt);
 
+	test_offload_sco("eSCO mSBC - Offload - Success",
+		&connect_success, setup_powered, test_connect_offload_msbc);
+
 	return tester_run();
 }
-- 
2.17.1

