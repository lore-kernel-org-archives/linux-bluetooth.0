Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EFBC43464
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 21:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C747020870
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 21:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XwGwXUur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIQV0f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 17:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgIQV0f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 17:26:35 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2DEC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 14:26:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id k15so2023515pfc.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 14:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UgExmGJD0WUGNTW5ZOzNd/c9xQ0pED0xft63St+aD78=;
        b=XwGwXUurEuP3Z4rlHd7dzhsmZuFfRMguRDIbEJ0WJsHC4zm6hwdcJRtlpIhV8Y4EHa
         Yvy/QrPfk7uZVM9OsiDdzPWymls1oscmzxQ28ETLB0287DRevRWIwsJJ2Ev1jbIm2+Lj
         iNw4ICaiKtzC1aP/tddDo3S5JHiW0tbU6oCo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UgExmGJD0WUGNTW5ZOzNd/c9xQ0pED0xft63St+aD78=;
        b=P6FbZryxnE+kzYMqH4hiW2/yZTf4x9avn7GS/oESmqG1VgRVBONgMQMyA1JA2f0dD1
         Cz288ewyEhSKDYsFuOdsV7heanDllExW0238dR31xCUMvinUK7c260zrvp20F0vva4cY
         5yUOb1x8k3++TrDppVxMBWem8rNg+N2aDemePRs5rznK9o/KOIsZs0rVmcq3VU3LNZ6s
         o6K3sCH/rK53lFQkJgBC0AUlM1ykI0dyDRcvMDHho19p7/Q5vJ8LeLMbZLm/ytINhhvD
         yXK3wSKWYHWIWkJo07c71oF4oZ5PbZmzzSsHB/Fq89jMANlb3+zdiRSuoxA11ye70Sa2
         a9JQ==
X-Gm-Message-State: AOAM533Ym0t4idzRGgfxPSDV2/AiB+H9K8PCqO/Qg64+JB9yPia+8CvI
        heRl0zFumM++COH3yFugSuyoOsddpFUqZg==
X-Google-Smtp-Source: ABdhPJw6uiQ06WD3ARuZ6UuW7wd1Swz7N47s1WH28eqFreipOw6K1518HVMrkbJGraw1rE8rfw1xxQ==
X-Received: by 2002:a63:725d:: with SMTP id c29mr1318380pgn.234.1600377994450;
        Thu, 17 Sep 2020 14:26:34 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id y3sm645308pfb.18.2020.09.17.14.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 14:26:33 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v4 4/8] adv_monitor: Implement unit tests for content filter
Date:   Thu, 17 Sep 2020 14:25:35 -0700
Message-Id: <20200917142456.BlueZ.v4.4.I7f88b6e4c63c14d77974438eb2f07326aedbfd9b@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917142456.BlueZ.v4.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200917142456.BlueZ.v4.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements the unit tests for verifying the correctness of
advertisement data fields matching against a pattern.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v3)

Changes in v3:
- Fix mixed declarations and assignments

Changes in v2:
- Cast test data to void *

 doc/test-coverage.txt   |   4 +-
 unit/test-adv-monitor.c | 144 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+), 2 deletions(-)

diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
index 5296983e6..e15474a44 100644
--- a/doc/test-coverage.txt
+++ b/doc/test-coverage.txt
@@ -30,9 +30,9 @@ test-gobex-transfer	  36	OBEX transfer handling
 test-gdbus-client	  13	D-Bus client handling
 test-gatt		 180	GATT qualification test cases
 test-hog		   6	HID Over GATT qualification test cases
-test-adv-monitor	   5	Advertisement Monitor test cases
+test-adv-monitor	   9	Advertisement Monitor test cases
 			-----
-			 766
+			 770
 
 
 Automated end-to-end testing
diff --git a/unit/test-adv-monitor.c b/unit/test-adv-monitor.c
index 970be84b0..a19a3092b 100644
--- a/unit/test-adv-monitor.c
+++ b/unit/test-adv-monitor.c
@@ -40,6 +40,8 @@
 		if (type == TEST_RSSI_FILTER) {				\
 			test.rssi_filter_test_data = (void *)&data;	\
 			test.rssi_filter_test_data->test_info = &test;	\
+		} else if (type == TEST_CONTENT_FILTER) {		\
+			test.content_filter_test_data = (void *)&data;	\
 		}							\
 		tester_add(name, &test, setup_fn, test_fn, teardown_fn);\
 	} while (0)
@@ -94,6 +96,22 @@ struct rssi_filter_test {
 	} test_steps[];
 };
 
+struct content_filter_test {
+	void *advmon_pattern;		/* btd_adv_monitor_pattern */
+
+	bool expected_match;
+
+	const struct {
+		uint8_t ad_type;
+		uint8_t offset;
+		uint8_t length;
+		uint8_t value[BT_AD_MAX_DATA_LEN];
+	} pattern;
+
+	uint8_t eir_len;
+	uint8_t eir[];
+};
+
 /* Parent data structure to hold the test data and information,
  * used by tester_* functions and callbacks.
  */
@@ -103,6 +121,7 @@ struct test_data {
 
 	union {
 		struct rssi_filter_test *rssi_filter_test_data;
+		struct content_filter_test *content_filter_test_data;
 	};
 };
 
@@ -211,6 +230,62 @@ static struct rssi_filter_test rssi_data_5 = {
 	},
 };
 
+/* Content Filter Test 1:
+ * The valid EIR data contains the given pattern whose content is a UUID16 AD
+ * data.
+ */
+static struct content_filter_test content_data_1 = {
+	.expected_match = true,
+	.pattern = {0x03, 0x02, 0x02, {0x09, 0x18} },
+	.eir_len = 20,
+	.eir = {0x02, 0x01, 0x02,				// flags
+		0x06, 0xff, 0x96, 0xfd, 0xab, 0xcd, 0xef,	// Mfr. Data
+		0x05, 0x03, 0x0d, 0x18, 0x09, 0x18,		// 16-bit UUIDs
+		0x05, 0x16, 0x0d, 0x18, 0x12, 0x34},		// Service Data
+};
+
+/* Content Filter Test 2:
+ * The valid EIR data does not match the given pattern whose content is a UUID16
+ * AD data.
+ */
+static struct content_filter_test content_data_2 = {
+	.expected_match = false,
+	.pattern = {0x03, 0x02, 0x02, {0x0d, 0x18} },
+	.eir_len = 20,
+	.eir = {0x02, 0x01, 0x02,				// flags
+		0x06, 0xff, 0x96, 0xfd, 0xab, 0xcd, 0xef,	// Mfr. Data
+		0x05, 0x03, 0x0d, 0x18, 0x09, 0x18,		// 16-bit UUIDs
+		0x05, 0x16, 0x0d, 0x18, 0x12, 0x34},		// Service Data
+};
+
+/* Content Filter Test 3:
+ * The valid EIR data does not have the given pattern whose content is a UUID32
+ * AD data.
+ */
+static struct content_filter_test content_data_3 = {
+	.expected_match = false,
+	.pattern = {0x05, 0x00, 0x04, {0x09, 0x18, 0x00, 0x00} },
+	.eir_len = 20,
+	.eir = {0x02, 0x01, 0x02,				// flags
+		0x06, 0xff, 0x96, 0xfd, 0xab, 0xcd, 0xef,	// Mfr. Data
+		0x05, 0x03, 0x0d, 0x18, 0x09, 0x18,		// 16-bit UUIDs
+		0x05, 0x16, 0x0d, 0x18, 0x12, 0x34},		// Service Data
+};
+
+/* Content Filter Test 4:
+ * The valid EIR data does not match the given pattern whose content is a
+ * UUID16 AD data due to invalid starting position of matching.
+ */
+static struct content_filter_test content_data_4 = {
+	.expected_match = false,
+	.pattern = {0x03, 0x02, 0x02, {0x09, 0x18} },
+	.eir_len = 20,
+	.eir = {0x02, 0x01, 0x02,				// flags
+		0x06, 0xff, 0x96, 0xfd, 0xab, 0xcd, 0xef,	// Mfr. Data
+		0x03, 0x03, 0x09, 0x18,				// 16-bit UUIDs
+		0x05, 0x16, 0x0d, 0x18, 0x12, 0x34},		// Service Data
+};
+
 /* Initialize the data required for RSSI Filter test */
 static void setup_rssi_filter_test(gpointer data)
 {
@@ -343,6 +418,60 @@ static gboolean test_rssi_filter(gpointer data)
 	return FALSE;
 }
 
+/* Initialize the data required for Content Filter test */
+static void setup_content_filter_test(gpointer data)
+{
+	struct content_filter_test *test = data;
+	struct btd_adv_monitor_pattern *pattern = NULL;
+
+	pattern = btd_adv_monitor_test_pattern_create(test->pattern.ad_type,
+							test->pattern.offset,
+							test->pattern.length,
+							test->pattern.value);
+	if (!pattern) {
+		tester_setup_failed();
+		return;
+	}
+
+	test->advmon_pattern = pattern;
+	tester_setup_complete();
+}
+
+/* Cleanup after the Content Filter test is done */
+static void teardown_content_filter_test(gpointer data)
+{
+	struct content_filter_test *test = data;
+
+	if (!test)
+		tester_teardown_complete();
+
+	btd_adv_monitor_test_pattern_destroy(test->advmon_pattern);
+	test->advmon_pattern = NULL;
+
+	tester_teardown_complete();
+}
+
+/* Execute the sub-steps of Content Filter test */
+static void test_content_filter(gpointer data)
+{
+	struct content_filter_test *test = data;
+	struct btd_adv_monitor_pattern *pattern = test->advmon_pattern;
+
+	if (!pattern) {
+		tester_test_abort();
+		return;
+	}
+
+	if (btd_adv_monitor_pattern_match(test->eir, test->eir_len,
+						test->advmon_pattern) ==
+		test->expected_match) {
+		tester_test_passed();
+		return;
+	}
+
+	tester_test_failed();
+}
+
 /* Handler function to prepare for a test */
 static void setup_handler(gconstpointer data)
 {
@@ -350,6 +479,8 @@ static void setup_handler(gconstpointer data)
 
 	if (test->test_type == TEST_RSSI_FILTER)
 		setup_rssi_filter_test(test->rssi_filter_test_data);
+	else if (test->test_type == TEST_CONTENT_FILTER)
+		setup_content_filter_test(test->content_filter_test_data);
 }
 
 /* Handler function to cleanup after the test is done */
@@ -359,6 +490,8 @@ static void teardown_handler(gconstpointer data)
 
 	if (test->test_type == TEST_RSSI_FILTER)
 		teardown_rssi_filter_test(test->rssi_filter_test_data);
+	else if (test->test_type == TEST_CONTENT_FILTER)
+		teardown_content_filter_test(test->content_filter_test_data);
 }
 
 /* Handler function to execute a test with the given data set */
@@ -368,6 +501,8 @@ static void test_handler(gconstpointer data)
 
 	if (test->test_type == TEST_RSSI_FILTER)
 		test_rssi_filter(test->rssi_filter_test_data);
+	else if (test->test_type == TEST_CONTENT_FILTER)
+		test_content_filter(test->content_filter_test_data);
 }
 
 int main(int argc, char *argv[])
@@ -387,5 +522,14 @@ int main(int argc, char *argv[])
 	define_test("/advmon/rssi/5", TEST_RSSI_FILTER, rssi_data_5,
 		    setup_handler, test_handler, teardown_handler);
 
+	define_test("/advmon/content/1", TEST_CONTENT_FILTER, content_data_1,
+		    setup_handler, test_handler, teardown_handler);
+	define_test("/advmon/content/2", TEST_CONTENT_FILTER, content_data_2,
+		    setup_handler, test_handler, teardown_handler);
+	define_test("/advmon/content/3", TEST_CONTENT_FILTER, content_data_3,
+		    setup_handler, test_handler, teardown_handler);
+	define_test("/advmon/content/4", TEST_CONTENT_FILTER, content_data_4,
+		    setup_handler, test_handler, teardown_handler);
+
 	return tester_run();
 }
-- 
2.26.2

