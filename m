Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CE3C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 04:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FE02075E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 04:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a3Rqeux0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgIQEaX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 00:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQEaW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 00:30:22 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F79C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 21:30:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z18so429105pfg.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 21:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvB+lIaE0kyS699vcytQm7GY0BeMARJCH099CoEsjEE=;
        b=a3Rqeux033TBeasa3hhzqcjCNTQUbpIJuFdaCYxgpl4khhXi6lvp1XJSR204KQOxmk
         OSS4VDOiW5fH4IbpmnEtkXmiu5zk0/1KwceoptWkxt7NB1tSJbcxC6EvWnsxKyGUif0l
         HnFPO1NpeT72ms6foatrIUd4p8AjXc0RI8PGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvB+lIaE0kyS699vcytQm7GY0BeMARJCH099CoEsjEE=;
        b=o6MK9PgT+mYZG3JEhAMAYI0R+gHz2RPWDxj/0MGP3n2dFxeYtkMjs6GJr1HyILwrQH
         KjCd4S8n2Rd0Gs/0Jq82OUTA7W99uQyl5Cx4nx2stKIlsXaHQ+SQ6Rao9Svi3eWttxHo
         bGPxg60MyjI/0Tf+k0FYkN5d9/mJzuD0faJ0oco57Vs8B4hogVHZBuohzqCMIMKzco/y
         7gwWdV71+2CjMjK2Uh/Q8uPayCFlaDrnPaC1YWHsZGRfcsv9w/x+MpBqhN1uBtIn4pCA
         U+g8SXO1/5zpxzM4DUDbkvQ2pqUZddg6IdGVuZpFNrnsVVNl6sWfHfpgc7GaV1IREux7
         qitg==
X-Gm-Message-State: AOAM530XKLY7P6pyx6rmUH8TASpYGVakUP7o1Qap2/NEu29rdKmIwCHo
        lvACeSiC+fes1b7pczAdPpfjMSzdHdIUAw==
X-Google-Smtp-Source: ABdhPJxwEKqSORsR0MNUrLepJRmSjdc9TMWq3pyjP/03TB3pcwNy1kdPE2NWI3KRRukcQCrBJNQJdA==
X-Received: by 2002:a05:6a00:7ce:b029:142:2501:35ea with SMTP id n14-20020a056a0007ceb0290142250135eamr9693939pfu.74.1600317021032;
        Wed, 16 Sep 2020 21:30:21 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id 99sm4169562pjo.40.2020.09.16.21.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 21:30:20 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v1 2/8] adv_monitor: Implement unit tests for RSSI Filter
Date:   Wed, 16 Sep 2020 21:29:47 -0700
Message-Id: <20200916212926.BlueZ.v1.2.I5ae05701b2b792a3ea2ca98f4a5d977645b1afc2@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916212926.BlueZ.v1.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200916212926.BlueZ.v1.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Manish Mandlik <mmandlik@google.com>

This patch implements unit tests for the background scanning RSSI
Filtering logic.

Verified all tests PASS by running tests in unit/test-adv-monitor.c

     USE="-bluez-next bluez-upstream" FEATURES=test emerge-hatch bluez

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 Makefile.am             |   9 +
 doc/test-coverage.txt   |   3 +-
 src/adv_monitor.c       |  79 ++++++++
 src/adv_monitor.h       |  10 +
 unit/test-adv-monitor.c | 391 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 491 insertions(+), 1 deletion(-)
 create mode 100644 unit/test-adv-monitor.c

diff --git a/Makefile.am b/Makefile.am
index 22b4fa30c..6918f02b0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -527,6 +527,15 @@ unit_test_gattrib_LDADD = lib/libbluetooth-internal.la \
 			src/libshared-glib.la \
 			$(GLIB_LIBS) $(DBUS_LIBS) -ldl -lrt
 
+unit_tests += unit/test-adv-monitor
+
+unit_test_adv_monitor_SOURCES = unit/test-adv-monitor.c \
+				src/adv_monitor.h src/adv_monitor.c \
+				src/device.h src/device.c \
+				src/log.h src/log.c
+unit_test_adv_monitor_LDADD = gdbus/libgdbus-internal.la \
+				src/libshared-glib.la $(GLIB_LIBS) $(DBUS_LIBS)
+
 if MIDI
 unit_tests += unit/test-midi
 unit_test_midi_CPPFLAGS = $(AM_CPPFLAGS) $(ALSA_CFLAGS) -DMIDI_TEST
diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
index 741492a3e..5296983e6 100644
--- a/doc/test-coverage.txt
+++ b/doc/test-coverage.txt
@@ -30,8 +30,9 @@ test-gobex-transfer	  36	OBEX transfer handling
 test-gdbus-client	  13	D-Bus client handling
 test-gatt		 180	GATT qualification test cases
 test-hog		   6	HID Over GATT qualification test cases
+test-adv-monitor	   5	Advertisement Monitor test cases
 			-----
-			 761
+			 766
 
 
 Automated end-to-end testing
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 7baa5317f..046f5953f 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -1210,3 +1210,82 @@ static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
 					      handle_device_lost_timeout, dev);
 	}
 }
+
+/* Creates the dummy adv_monitor object for unit tests */
+void *btd_adv_monitor_rssi_test_setup(int8_t high_rssi, uint16_t high_timeout,
+				      int8_t low_rssi, uint16_t low_timeout)
+{
+	struct adv_monitor *test_monitor = NULL;
+
+	test_monitor = g_new0(struct adv_monitor, 1);
+	if (!test_monitor)
+		return NULL;
+
+	test_monitor->app = g_new0(struct adv_monitor_app, 1);
+	if (!test_monitor->app)
+		goto app_failed;
+
+	test_monitor->app->manager = g_new0(struct btd_adv_monitor_manager, 1);
+	if (!test_monitor->app->manager)
+		goto manager_failed;
+
+	test_monitor->high_rssi = high_rssi;
+	test_monitor->high_rssi_timeout = high_timeout;
+	test_monitor->low_rssi = low_rssi;
+	test_monitor->low_rssi_timeout = low_timeout;
+	test_monitor->devices = queue_new();
+
+	return test_monitor;
+
+manager_failed:
+	g_free(test_monitor->app);
+
+app_failed:
+	g_free(test_monitor);
+
+	return NULL;
+}
+
+/* Cleanup after unit test is done */
+void btd_adv_monitor_rssi_test_teardown(void *monitor_obj)
+{
+	struct adv_monitor *monitor = monitor_obj;
+
+	if (!monitor)
+		return;
+
+	queue_destroy(monitor->devices, monitor_device_free);
+	g_free(monitor);
+}
+
+/* Returns the current state of device - found/lost, used in unit tests */
+bool btd_adv_monitor_test_device_state(void *monitor_obj, void *device_obj)
+{
+	struct adv_monitor *monitor = monitor_obj;
+	struct btd_device *device = device_obj;
+	struct adv_monitor_device *dev = NULL;
+
+	if (!monitor || !device)
+		return false;
+
+	dev = queue_find(monitor->devices, monitor_device_match, device);
+	if (!dev)
+		return false;
+
+	return dev->device_found;
+}
+
+/* Helper function for the RSSI Filter unit tests */
+bool btd_adv_monitor_test_rssi(void *monitor_obj, void *device_obj,
+			       int8_t adv_rssi)
+{
+	struct adv_monitor *monitor = monitor_obj;
+	struct btd_device *device = device_obj;
+
+	if (!monitor || !device)
+		return false;
+
+	adv_monitor_filter_rssi(monitor, device, adv_rssi);
+
+	return btd_adv_monitor_test_device_state(monitor, device);
+}
diff --git a/src/adv_monitor.h b/src/adv_monitor.h
index 14508e7d1..351e7f9aa 100644
--- a/src/adv_monitor.h
+++ b/src/adv_monitor.h
@@ -33,4 +33,14 @@ void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager);
 void btd_adv_monitor_device_remove(struct btd_adv_monitor_manager *manager,
 				   struct btd_device *device);
 
+/* Following functions are the helper functions used for RSSI Filter unit tests
+ * defined in unit/test-adv-monitor.c
+ */
+void *btd_adv_monitor_rssi_test_setup(int8_t high_rssi, uint16_t high_timeout,
+				      int8_t low_rssi, uint16_t low_timeout);
+void btd_adv_monitor_rssi_test_teardown(void *monitor_obj);
+bool btd_adv_monitor_test_device_state(void *monitor_obj, void *device_obj);
+bool btd_adv_monitor_test_rssi(void *monitor_obj, void *device_obj,
+			       int8_t adv_rssi);
+
 #endif /* __ADV_MONITOR_H */
diff --git a/unit/test-adv-monitor.c b/unit/test-adv-monitor.c
new file mode 100644
index 000000000..c9aab2bee
--- /dev/null
+++ b/unit/test-adv-monitor.c
@@ -0,0 +1,391 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020 Google LLC
+ *
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <glib.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <unistd.h>
+
+#include "src/log.h"
+#include "src/shared/tester.h"
+
+#include "src/adv_monitor.h"
+
+#define define_test(name, type, data, setup_fn, test_fn, teardown_fn)	\
+	do {								\
+		static struct test_data test;				\
+		test.test_type = type;					\
+		test.test_name = g_strdup(name);			\
+		if (type == TEST_RSSI_FILTER) {				\
+			test.rssi_filter_test_data = &data;		\
+			test.rssi_filter_test_data->test_info = &test;	\
+		}							\
+		tester_add(name, &test, setup_fn, test_fn, teardown_fn);\
+	} while (0)
+
+#define ADV_INTERVAL		1	/* Advertisement interval in seconds */
+#define OUT_OF_RANGE		-128
+#define END_OF_RSSI_TEST	{0}
+
+#define RSSI_TEST_DONE(test_step)	\
+	(!test_step.adv_rssi && !test_step.duration && !test_step.result)
+
+#define DUMMY_BTD_DEVICE_OBJ	((void *) 0xF00)
+
+enum test_type {
+	TEST_RSSI_FILTER = 0,
+	TEST_CONTENT_FILTER,
+};
+
+enum result {
+	RESULT_DEVICE_NOT_FOUND = false,	/* Initial state of a device */
+	RESULT_DEVICE_FOUND = true,		/* Device state when the
+						 * Content/RSSI Filter match
+						 */
+	RESULT_DEVICE_LOST = false,		/* Device state when the Low
+						 * RSSI Filter match or if it
+						 * goes offline/out-of-range
+						 */
+};
+
+struct rssi_filter_test {
+	void *adv_monitor_obj;			/* struct adv_monitor object */
+	void *btd_device_obj;			/* struct btd_device object */
+	struct test_data *test_info;
+
+	const struct {
+		int8_t high_rssi_threshold;	/* High RSSI threshold */
+		uint16_t high_rssi_timeout;	/* High RSSI threshold timeout*/
+		int8_t low_rssi_threshold;	/* Low RSSI threshold */
+		uint16_t low_rssi_timeout;	/* Low RSSI threshold timeout */
+	} rssi_filter;
+
+	time_t start_time;		/* Start time of the test */
+	uint16_t resume_step;		/* Store the current sub-step of the
+					 * test before suspending that test
+					 */
+	guint out_of_range_timer;	/* Timer to simulate device offline */
+
+	const struct {
+		int8_t adv_rssi;	/* Advertisement RSSI */
+		uint16_t duration;	/* Advertisement duration in seconds */
+		enum result result;	/* Device state after every step */
+	} test_steps[];
+};
+
+/* Parent data structure to hold the test data and information,
+ * used by tester_* functions and callbacks.
+ */
+struct test_data {
+	enum test_type test_type;
+	char *test_name;
+
+	union {
+		struct rssi_filter_test *rssi_filter_test_data;
+	};
+};
+
+/* RSSI Filter Test 1:
+ * - The Device Lost event should NOT get triggered even if the Adv RSSI is
+ *   lower than LowRSSIThresh for more than LowRSSITimeout before finding
+ *   the device first.
+ * - Similarly, the Device Found event should NOT get triggered if the Adv RSSI
+ *   is greater than LowRSSIThresh but lower than HighRSSIThresh.
+ */
+static struct rssi_filter_test rssi_data_1 = {
+	.rssi_filter = {-40, 5, -60, 5},
+	.test_steps = {
+		{-70, 6, RESULT_DEVICE_NOT_FOUND},
+		{-50, 6, RESULT_DEVICE_NOT_FOUND},
+		END_OF_RSSI_TEST,
+	},
+};
+
+/* RSSI Filter Test 2:
+ * - The Device Found event should get triggered when the Adv RSSI is higher
+ *   than HighRSSIThresh for more than HighRSSITimeout.
+ * - Once the device is found, the Device Lost event should NOT get triggered
+ *   if the Adv RSSI drops below HighRSSIThresh but it is not lower than
+ *   LowRSSIThresh.
+ * - When the Adv RSSI drops below LowRSSIThresh for more than LowRSSITimeout,
+ *   the Device Lost event should get triggered.
+ */
+static struct rssi_filter_test rssi_data_2 = {
+	.rssi_filter = {-40, 5, -60, 5},
+	.test_steps = {
+		{-30, 6, RESULT_DEVICE_FOUND},
+		{-50, 6, RESULT_DEVICE_FOUND},
+		{-70, 6, RESULT_DEVICE_LOST},
+		END_OF_RSSI_TEST,
+	},
+};
+
+/* RSSI Filter Test 3:
+ * - The Device Found event should get triggered only when the Adv RSSI is
+ *   higher than HighRSSIThresh for more than HighRSSITimeout.
+ * - If the Adv RSSI drops below HighRSSIThresh, timer should reset and start
+ *   counting once the Adv RSSI is above HighRSSIThresh.
+ * - Similarly, when tracking the Low RSSI, timer should reset when the Adv RSSI
+ *   goes above LowRSSIThresh. The Device Lost event should get triggered only
+ *   when the Adv RSSI is lower than LowRSSIThresh for more than LowRSSITimeout.
+ */
+static struct rssi_filter_test rssi_data_3 = {
+	.rssi_filter = {-40, 5, -60, 5},
+	.test_steps = {
+		{-30, 2, RESULT_DEVICE_NOT_FOUND},
+		{-50, 6, RESULT_DEVICE_NOT_FOUND},
+		{-30, 4, RESULT_DEVICE_NOT_FOUND},
+		{-30, 2, RESULT_DEVICE_FOUND},
+		{-70, 2, RESULT_DEVICE_FOUND},
+		{-50, 6, RESULT_DEVICE_FOUND},
+		{-70, 4, RESULT_DEVICE_FOUND},
+		{-70, 2, RESULT_DEVICE_LOST},
+		END_OF_RSSI_TEST,
+	},
+};
+
+/* RSSI Filter Test 4:
+ * - While tracking the High RSSI, timer should reset if the device goes
+ *   offline/out-of-range for more than HighRSSITimeout.
+ * - Once the device is found, if the device goes offline/out-of-range for
+ *   more than LowRSSITimeout, the Device Lost event should get triggered.
+ */
+static struct rssi_filter_test rssi_data_4 = {
+	.rssi_filter = {-40, 5, -60, 5},
+	.test_steps = {
+		{         -30, 2, RESULT_DEVICE_NOT_FOUND},
+		{OUT_OF_RANGE, 6, RESULT_DEVICE_NOT_FOUND},
+		{         -30, 4, RESULT_DEVICE_NOT_FOUND},
+		{         -30, 2, RESULT_DEVICE_FOUND},
+		{         -70, 2, RESULT_DEVICE_FOUND},
+		{OUT_OF_RANGE, 6, RESULT_DEVICE_LOST},
+		END_OF_RSSI_TEST,
+	},
+};
+
+/* RSSI Filter Test 5:
+ * - The Device Found event should get triggered only once even if the Adv RSSI
+ *   stays higher than HighRSSIThresh for a longer period of time.
+ * - Once the device is found, while tracking the Low RSSI, timer should reset
+ *   when the Adv RSSI goes above LowRSSIThresh.
+ * - The timer should NOT reset if the device goes offline/out-of-range for
+ *   a very short period of time and comes back online/in-range before
+ *   the timeouts.
+ */
+static struct rssi_filter_test rssi_data_5 = {
+	.rssi_filter = {-40, 5, -60, 5},
+	.test_steps = {
+		{         -30, 2, RESULT_DEVICE_NOT_FOUND},
+		{OUT_OF_RANGE, 2, RESULT_DEVICE_NOT_FOUND},
+		{         -30, 2, RESULT_DEVICE_FOUND},
+		{         -30, 3, RESULT_DEVICE_FOUND},
+		{         -30, 3, RESULT_DEVICE_FOUND},
+		{         -70, 2, RESULT_DEVICE_FOUND},
+		{OUT_OF_RANGE, 2, RESULT_DEVICE_FOUND},
+		{         -50, 6, RESULT_DEVICE_FOUND},
+		{         -70, 2, RESULT_DEVICE_FOUND},
+		{OUT_OF_RANGE, 2, RESULT_DEVICE_FOUND},
+		{         -70, 2, RESULT_DEVICE_LOST},
+		END_OF_RSSI_TEST,
+	},
+};
+
+/* Initialize the data required for RSSI Filter test */
+static void setup_rssi_filter_test(gpointer data)
+{
+	struct rssi_filter_test *test = data;
+
+	test->adv_monitor_obj = btd_adv_monitor_rssi_test_setup(
+					test->rssi_filter.high_rssi_threshold,
+					test->rssi_filter.high_rssi_timeout,
+					test->rssi_filter.low_rssi_threshold,
+					test->rssi_filter.low_rssi_timeout);
+
+	/* The RSSI Filter logic uses btd_device object only as a key in the
+	 * adv_monitor->devices list, it is never dereferenced nor used to
+	 * perform any operations related to btd_device. So we can use any
+	 * dummy address for unit testing.
+	 */
+	test->btd_device_obj = DUMMY_BTD_DEVICE_OBJ;
+
+	tester_setup_complete();
+}
+
+/* Cleanup after the RSSI Filter test is done */
+static void teardown_rssi_filter_test(gpointer data)
+{
+	struct rssi_filter_test *test = data;
+
+	btd_adv_monitor_rssi_test_teardown(test->adv_monitor_obj);
+
+	tester_teardown_complete();
+}
+
+/* Execute the sub-steps of RSSI Filter test */
+static gboolean test_rssi_filter(gpointer data)
+{
+	struct rssi_filter_test *test = data;
+	time_t start_time = time(NULL);
+	bool ret = false;
+
+	uint16_t i = 0;
+	uint16_t j = 0;
+
+	/* If this is not the beginning of test, return to the sub-step
+	 * before that test was suspended
+	 */
+	if (test->resume_step) {
+		start_time = test->start_time;
+		i = test->resume_step;
+
+		/* Clear the test resume timer */
+		g_source_remove(test->out_of_range_timer);
+		test->out_of_range_timer = 0;
+
+		/* Check state of the device - found/lost, while device was
+		 * offline/out-of-range
+		 */
+		ret = btd_adv_monitor_test_device_state(test->adv_monitor_obj,
+							test->btd_device_obj);
+		tester_debug("%s: [t=%.0lf, step=%d] Test resume, "
+			     "device_found = %s",
+			     test->test_info->test_name,
+			     difftime(time(NULL), start_time), i,
+			     ret ? "true" : "false");
+		g_assert(ret == test->test_steps[i].result);
+
+		i++;
+	}
+
+	while (!RSSI_TEST_DONE(test->test_steps[i])) {
+		if (test->test_steps[i].adv_rssi == OUT_OF_RANGE) {
+			/* Simulate device offline/out-of-range by suspending
+			 * the test.
+			 *
+			 * Note: All tester_* functions run sequentially by
+			 * adding a next function to the main loop using
+			 * g_idle_add(). If a timeout function is added using
+			 * g_timeout_add_*(), it doesn't really get invoked as
+			 * soon as the timer expires. Instead, it is invoked
+			 * once the current function returns and the timer has
+			 * expired. So, to give handle_device_lost_timeout()
+			 * function a chance to run at the correct time, we
+			 * must save the current state and exit from this
+			 * function while we simulate the device offline. We can
+			 * come back later to continue with the remaining steps.
+			 */
+			test->resume_step = i;
+			test->start_time = start_time;
+			test->out_of_range_timer = g_timeout_add_seconds(
+						   test->test_steps[i].duration,
+						   test_rssi_filter, data);
+
+			/* Check the device state before suspending the test */
+			ret = btd_adv_monitor_test_device_state(
+							test->adv_monitor_obj,
+							test->btd_device_obj);
+			tester_debug("%s: [t=%.0lf, step=%d] Test suspend, "
+				     "device_found = %s",
+				     test->test_info->test_name,
+				     difftime(time(NULL), start_time), i,
+				     ret ? "true" : "false");
+			return FALSE;
+		}
+
+		for (j = 0; j < test->test_steps[i].duration; j++) {
+			ret = btd_adv_monitor_test_rssi(
+						test->adv_monitor_obj,
+						test->btd_device_obj,
+						test->test_steps[i].adv_rssi);
+			tester_debug("%s: [t=%.0lf, step=%d] Test "
+				     "advertisement RSSI %d, device_found = %s",
+				     test->test_info->test_name,
+				     difftime(time(NULL), start_time), i,
+				     test->test_steps[i].adv_rssi,
+				     ret ? "true" : "false");
+
+			/* Sleep for a second to simulate receiving
+			 * advertisement once every second
+			 */
+			sleep(ADV_INTERVAL);
+		}
+		g_assert(ret == test->test_steps[i].result);
+
+		i++;
+	}
+
+	tester_debug("%s: [t=%.0lf] Test done", test->test_info->test_name,
+		     difftime(time(NULL), start_time));
+
+	tester_test_passed();
+
+	return FALSE;
+}
+
+/* Handler function to prepare for a test */
+static void setup_handler(gconstpointer data)
+{
+	const struct test_data *test = data;
+
+	if (test->test_type == TEST_RSSI_FILTER)
+		setup_rssi_filter_test(test->rssi_filter_test_data);
+}
+
+/* Handler function to cleanup after the test is done */
+static void teardown_handler(gconstpointer data)
+{
+	const struct test_data *test = data;
+
+	if (test->test_type == TEST_RSSI_FILTER)
+		teardown_rssi_filter_test(test->rssi_filter_test_data);
+}
+
+/* Handler function to execute a test with the given data set */
+static void test_handler(gconstpointer data)
+{
+	const struct test_data *test = data;
+
+	if (test->test_type == TEST_RSSI_FILTER)
+		test_rssi_filter(test->rssi_filter_test_data);
+}
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	__btd_log_init("*", 0);
+
+	define_test("/advmon/rssi/1", TEST_RSSI_FILTER, rssi_data_1,
+		    setup_handler, test_handler, teardown_handler);
+	define_test("/advmon/rssi/2", TEST_RSSI_FILTER, rssi_data_2,
+		    setup_handler, test_handler, teardown_handler);
+	define_test("/advmon/rssi/3", TEST_RSSI_FILTER, rssi_data_3,
+		    setup_handler, test_handler, teardown_handler);
+	define_test("/advmon/rssi/4", TEST_RSSI_FILTER, rssi_data_4,
+		    setup_handler, test_handler, teardown_handler);
+	define_test("/advmon/rssi/5", TEST_RSSI_FILTER, rssi_data_5,
+		    setup_handler, test_handler, teardown_handler);
+
+	return tester_run();
+}
-- 
2.26.2

