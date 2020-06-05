Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23979C433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 06:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082992089D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 06:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgFEGKV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 02:10:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:34047 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgFEGKU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 02:10:20 -0400
IronPort-SDR: ClV50fY0lIUadDab7BtOIr/eMEJzJFcOrUg6yihMtWvakVdjJR7yIpzYtrqR3ZTh1x8w65jN4K
 lhtJDTMUSzyw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 23:10:20 -0700
IronPort-SDR: fm9KQtPDgQjtSHi060dA6d2EH2VrZag0wmL7xlU0Q7BlllWSdEmLOnLq3QXuHn3aoLawflF3Nk
 69rbe9cPpcEg==
X-IronPort-AV: E=Sophos;i="5.73,475,1583222400"; 
   d="scan'208";a="257942459"
Received: from mdhakni-mobl.amr.corp.intel.com (HELO han1-mobl3.jf.intel.com) ([10.254.69.252])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 23:10:19 -0700
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH V2 2/2] tools/btpclient: Use mgmt api for limited discovery
Date:   Thu,  4 Jun 2020 23:10:03 -0700
Message-Id: <20200605061003.14634-2-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200605061003.14634-1-tedd.an@linux.intel.com>
References: <20200605061003.14634-1-tedd.an@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

There are a few test cases for limited discovery in GAP qualification
test suite. But the d-bus API doesn't support it and the only way to
start the limited discovery is using the management API.

This patch adds support for limited discovery by using management API.
---
 tools/btpclient.c | 194 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 187 insertions(+), 7 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index f9c693056..46f866117 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -36,6 +36,10 @@
 #include "lib/bluetooth.h"
 #include "src/shared/btp.h"
 
+/* For BT_MGMT API */
+#include "lib/mgmt.h"
+#include "src/shared/mgmt.h"
+
 #define AD_PATH "/org/bluez/advertising"
 #define AG_PATH "/org/bluez/agent"
 #define AD_IFACE "org.bluez.LEAdvertisement1"
@@ -77,6 +81,14 @@ static struct btp *btp;
 
 static bool gap_service_registered;
 
+/* For BT_MGMT API */
+static struct mgmt *mgmt;
+static uint16_t mgmt_index;
+
+static uint32_t mgmt_flags;
+
+#define MGMT_OPS_DISCOVERY	0x01
+
 struct ad_data {
 	uint8_t data[25];
 	uint8_t len;
@@ -1403,6 +1415,88 @@ static void set_discovery_filter_reply(struct l_dbus_proxy *proxy,
 					start_discovery_reply, NULL, NULL);
 }
 
+#define SCAN_TYPE_BREDR (1 << BDADDR_BREDR)
+#define SCAN_TYPE_LE ((1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM))
+#define SCAN_TYPE_DUAL (SCAN_TYPE_BREDR | SCAN_TYPE_LE)
+
+struct discovery_flags {
+	uint8_t flags;
+};
+
+static int btp_mgmt_start_limited_discovery(uint8_t flags)
+{
+	struct mgmt_cp_start_discovery cp;
+	uint8_t type = SCAN_TYPE_DUAL;
+
+	memset(&cp, 0, sizeof(cp));
+
+	if (flags & (BTP_GAP_DISCOVERY_FLAG_LE |
+		     BTP_GAP_DISCOVERY_FLAG_BREDR)) {
+		type = SCAN_TYPE_DUAL;
+	} else if (flags & BTP_GAP_DISCOVERY_FLAG_LE) {
+		type &= ~SCAN_TYPE_BREDR;
+		type |= SCAN_TYPE_LE;
+	} else if (flags & BTP_GAP_DISCOVERY_FLAG_BREDR) {
+		type |= SCAN_TYPE_BREDR;
+		type &= ~SCAN_TYPE_LE;
+	}
+	cp.type = type;
+
+	return mgmt_send(mgmt, MGMT_OP_START_LIMITED_DISCOVERY, mgmt_index,
+			 sizeof(cp), &cp, NULL, NULL, NULL);
+}
+
+static void btp_mgmt_discovering_destroy(void *user_data)
+{
+	l_free(user_data);
+}
+
+static void btp_mgmt_discovering_cb(uint16_t index, uint16_t len,
+				    const void *param, void *user_data)
+{
+	const struct mgmt_ev_discovering *ev = param;
+	struct discovery_flags *df = user_data;
+
+	if (len < sizeof(*ev)) {
+		l_error("Too short (%u bytes) discovering event", len);
+		return;
+	}
+
+	l_info("MGMT: discovering %s", ev->discovering ? "on" : "off");
+
+	/* Start new discovery */
+	if (ev->discovering == 0 && (mgmt_flags & MGMT_OPS_DISCOVERY))
+		btp_mgmt_start_limited_discovery(df->flags);
+}
+
+static void btp_mgmt_setup_limited_discovery(uint8_t index, uint8_t flags)
+{
+	int ret;
+	struct discovery_flags *df;
+
+	/* Saves the flags so it can be used to start new discovery */
+	df = l_new(struct discovery_flags, 1);
+	df->flags = flags;
+
+	/* Register event for discovering */
+	mgmt_register(mgmt, MGMT_EV_DISCOVERING, mgmt_index,
+		      btp_mgmt_discovering_cb, df,
+		      btp_mgmt_discovering_destroy);
+
+	ret = btp_mgmt_start_limited_discovery(flags);
+	if (ret == 0) {
+		l_error("Unable to send start_discovery cmd");
+		btp_send_error(btp, BTP_GAP_SERVICE, index, BTP_ERROR_FAIL);
+		return;
+	}
+
+	/* Set flag that mgmt interface is used for scanning */
+	mgmt_flags |= MGMT_OPS_DISCOVERY;
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_START_DISCOVERY,
+		 index, 0, NULL);
+}
+
 static void btp_gap_start_discovery(uint8_t index, const void *param,
 					uint16_t length, void *user_data)
 {
@@ -1423,10 +1517,17 @@ static void btp_gap_start_discovery(uint8_t index, const void *param,
 		return;
 	}
 
-	l_dbus_proxy_method_call(adapter->proxy, "SetDiscoveryFilter",
-						set_discovery_filter_setup,
-						set_discovery_filter_reply,
-						L_UINT_TO_PTR(cp->flags), NULL);
+	/* Use BT MGMT interface to start limited discovery procedure since
+	 * it is not supported by D-BUS API
+	 */
+	if (cp->flags & BTP_GAP_DISCOVERY_FLAG_LIMITED)
+		btp_mgmt_setup_limited_discovery(index, cp->flags);
+	else {
+		l_dbus_proxy_method_call(adapter->proxy, "SetDiscoveryFilter",
+					 set_discovery_filter_setup,
+					 set_discovery_filter_reply,
+					 L_UINT_TO_PTR(cp->flags), NULL);
+	}
 }
 
 static void clear_discovery_filter_setup(struct l_dbus_message *message,
@@ -1501,6 +1602,29 @@ static void stop_discovery_reply(struct l_dbus_proxy *proxy,
 						NULL, NULL);
 }
 
+static void btp_mgmt_stop_discovery(uint8_t index)
+{
+	struct mgmt_cp_stop_discovery cp;
+	int ret;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.type = SCAN_TYPE_DUAL;
+
+	ret = mgmt_send(mgmt, MGMT_OP_STOP_DISCOVERY, mgmt_index, sizeof(cp),
+			&cp, NULL, NULL, NULL);
+	if (ret == 0) {
+		l_error("Unable to send stop_discovery cmd");
+		btp_send_error(btp, BTP_GAP_SERVICE, index, BTP_ERROR_FAIL);
+		return;
+	}
+
+	/* Clear flag that mgmt interface is used for scanning */
+	mgmt_flags &= ~MGMT_OPS_DISCOVERY;
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_STOP_DISCOVERY,
+		 index, 0, NULL);
+}
+
 static void btp_gap_stop_discovery(uint8_t index, const void *param,
 					uint16_t length, void *user_data)
 {
@@ -1520,8 +1644,14 @@ static void btp_gap_stop_discovery(uint8_t index, const void *param,
 		return;
 	}
 
-	l_dbus_proxy_method_call(adapter->proxy, "StopDiscovery", NULL,
-					stop_discovery_reply, NULL, NULL);
+	/* If the discovery procedure is started by BT MGMT API for limited
+	 * discovering, it should be stopped by mgmt API.
+	 */
+	if (mgmt_flags & MGMT_OPS_DISCOVERY)
+		btp_mgmt_stop_discovery(index);
+	else
+		l_dbus_proxy_method_call(adapter->proxy, "StopDiscovery", NULL,
+					 stop_discovery_reply, NULL, NULL);
 }
 
 static void connect_reply(struct l_dbus_proxy *proxy,
@@ -3140,6 +3270,7 @@ static void usage(void)
 	l_info("\tbtpclient [options]");
 	l_info("options:\n"
 	"\t-s, --socket <socket>  Socket to use for BTP\n"
+	"\t-i, --index <id>       Specify the adapter index\n"
 	"\t-q, --quiet            Don't emit any logs\n"
 	"\t-v, --version          Show version\n"
 	"\t-h, --help             Show help options");
@@ -3147,12 +3278,52 @@ static void usage(void)
 
 static const struct option options[] = {
 	{ "socket",	1, 0, 's' },
+	{ "index",	1, 0, 'i' },
 	{ "quiet",	0, 0, 'q' },
 	{ "version",	0, 0, 'v' },
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
 };
 
+static void set_index(const char *arg)
+{
+	/* Use default index 0 */
+	if (!arg || !strcmp(arg, "none") || !strcmp(arg, "any") ||
+						!strcmp(arg, "all"))
+		mgmt_index = MGMT_INDEX_NONE;
+	else if (strlen(arg) > 3 && !strncasecmp(arg, "hci", 3))
+		mgmt_index = atoi(&arg[3]);
+	else
+		mgmt_index = atoi(arg);
+}
+
+static int btp_mgmt_init(const char *index_opt)
+{
+	mgmt = mgmt_new_default();
+	if (!mgmt) {
+		l_info("Unable to open mgmt_socket\n");
+		return EXIT_FAILURE;
+	}
+
+	if (index_opt)
+		set_index(index_opt);
+
+	if (mgmt_index == MGMT_INDEX_NONE)
+		mgmt_index = 0;
+
+	return EXIT_SUCCESS;
+}
+
+static void btp_mgmt_release(void)
+{
+	l_error("MGMT: Release all management resources");
+	mgmt_cancel_all(mgmt);
+	mgmt_unregister_all(mgmt);
+	mgmt_unref(mgmt);
+}
+
+static const char *index_opt;
+
 int main(int argc, char *argv[])
 {
 	struct l_dbus_client *client;
@@ -3160,7 +3331,8 @@ int main(int argc, char *argv[])
 
 	l_log_set_stderr();
 
-	while ((opt = getopt_long(argc, argv, "+hs:vq", options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "+hs:vqi:", options,
+								NULL)) != -1) {
 		switch (opt) {
 		case 's':
 			socket_path = l_strdup(optarg);
@@ -3173,6 +3345,9 @@ int main(int argc, char *argv[])
 		case 'v':
 			l_info("%s", VERSION);
 			return EXIT_SUCCESS;
+		case 'i':
+			index_opt = l_strdup(optarg);
+			break;
 		case 'h':
 		default:
 			usage();
@@ -3189,6 +3364,10 @@ int main(int argc, char *argv[])
 	if (!l_main_init())
 		return EXIT_FAILURE;
 
+	if (btp_mgmt_init(index_opt)) {
+		l_error("Unable to initialize the management interface");
+		return EXIT_FAILURE;
+	}
 
 	adapters = l_queue_new();
 
@@ -3210,6 +3389,7 @@ int main(int argc, char *argv[])
 	l_dbus_client_destroy(client);
 	l_dbus_destroy(dbus);
 	btp_cleanup(btp);
+	btp_mgmt_release();
 
 	l_queue_destroy(adapters, (l_queue_destroy_func_t)btp_adapter_free);
 
-- 
2.25.4

