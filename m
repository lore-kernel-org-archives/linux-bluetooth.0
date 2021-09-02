Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C511C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD2860EE6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbhIBEI5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 00:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhIBEIz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 00:08:55 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075A0C061757
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Sep 2021 21:07:58 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id j11-20020a0cf9cb000000b00375f0642d2dso579930qvo.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Sep 2021 21:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t5JRZwZhXgiZ+XY5Wwwsiv8YjU0aIA7Lt8KlbHeeZ5E=;
        b=jTW1B5wmdLIQaLHNYPoPgXJQ2/B1Ntx3ILmdyt4DZvMtcDgnlx+ZJUfeQkvKY3oxWp
         1pmNyhC6AzbADvjZbVt+bWEKtBBiQ7SR/rLPlmPvhiV+teEVNOnbEyUur1MprGQOS595
         1ZU5DhII/QM1tCb0MngiJcGnTKTxr19ev1XtInW9+/mjLyCQqXMrpuRiangVmruwrBiC
         NV4zYDKX7ILA+2LBewzD8RhEtZfaCeBgWyti0DkvQC9ECTAwwAJHgUVfQw6iJIEXrE0+
         Flccrsd2TQ5b2Ff+upLIG5Msz0uWx+rTxbVI9YMMBRfMW2PJPaKk4Mp/Ro8NWqcSQv5W
         SzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t5JRZwZhXgiZ+XY5Wwwsiv8YjU0aIA7Lt8KlbHeeZ5E=;
        b=hJ9x4JsYVfr072lQE5yUmS2abnRGGcoA2ta+lqMop+4lj+Lc1yYCLTp7RH3KrWGS5M
         WCIDBk0EnjKB+4ZB7HgTECkvHANDQqI18PqbsgU/5Pbdp9NbGONEldlACHDQc8YfEKJe
         rLD5Hwi7UnMveQeZX/puFYVoD9/RQsuV8GpWGEWBXKgnVBpeSXRPjpDLkG1qwRLYUdKb
         7tPVQsaWEwhmqeoSCacIZFoonmjCUBBPkdFnX/vfrMLbqgpGDkkA8u7Vska6lbz1U2ZL
         5T6pgpTtwhhvJCcvx9kIUQseV6mUo041EbKdt5ZRFK9Lt2TwvPx5jR220aPBWNfjZ4Np
         lQ0Q==
X-Gm-Message-State: AOAM531msYfcdFtN56kpxL5F6RxMTlNDLcP1RlhobGKAV29T+YfbayLE
        U6CC57JLieeudOrh+/JG8o1d3xDg5sXLcqxlneI6F9cRXSC+hk5NVrfos3rUJ147pUOEDm/gVNg
        eTU3GHqIoy4ZvzF90XhQDI1+NeGXpcokyfg+DqCZivTQL1AwKHLzLi0/g0uJvdlQ9gTUWynBOnM
        F8
X-Google-Smtp-Source: ABdhPJxzllBYKHH2m3rdHtyt3gCV1T81jjzDgQyUnh0CrLp+LTke7OE8DNFTVHMGAl0rM4zNPhh5KHQQP+WU
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a05:6214:7cf:: with SMTP id
 bb15mr1119978qvb.9.1630555677208; Wed, 01 Sep 2021 21:07:57 -0700 (PDT)
Date:   Thu,  2 Sep 2021 12:07:03 +0800
In-Reply-To: <20210902040711.665952-1-apusaka@google.com>
Message-Id: <20210902120509.Bluez.v2.5.I700d72f935b48346f2e74088152eeef41dc5b938@changeid>
Mime-Version: 1.0
References: <20210902040711.665952-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v2 05/13] tools: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

BT core spec 5.3 promotes the usage of inclusive languages.
This CL replaces some terms with the more appropriate counterparts,
such as "central", "peripheral", "accept list", "reject list", and
"temporary link key". Note that some suggestions come from
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf
---

Changes in v2:
* Merging several patches from the same directory into one

 tools/3dsp.c               |  33 +++++-----
 tools/bdaddr.rst           |   2 +-
 tools/btiotest.c           |  22 +++----
 tools/btpclientctl.c       |   2 +-
 tools/hci-tester.c         |  12 ++--
 tools/hciconfig.c          |  26 ++++----
 tools/hciconfig.rst        |  24 ++++----
 tools/hcitool.c            | 102 +++++++++++++++----------------
 tools/hcitool.rst          |  30 +++++-----
 tools/l2cap-tester.c       |  24 ++++----
 tools/l2test.c             |  18 +++---
 tools/mesh-cfgclient.c     |   4 +-
 tools/mesh-gatt/mesh-net.h |   4 +-
 tools/mesh-gatt/net.c      |  60 +++++++++----------
 tools/mesh/mesh-db.c       |  28 ++++-----
 tools/mesh/mesh-db.h       |   4 +-
 tools/mesh/remote.c        |  53 ++++++++--------
 tools/mesh/remote.h        |   5 +-
 tools/meshctl.c            |   6 +-
 tools/mgmt-tester.c        | 120 +++++++++++++++++++------------------
 tools/oobtest.c            |   8 +--
 tools/parser/avdtp.c       |   4 +-
 tools/parser/csr.c         |  17 +++---
 tools/parser/ericsson.c    |   2 +-
 tools/parser/hci.c         |  35 +++++------
 tools/parser/lmp.c         | 112 +++++++++++++++++-----------------
 tools/parser/parser.h      |   2 +-
 tools/parser/smp.c         |  12 ++--
 tools/rctest.c             |  18 +++---
 tools/rctest.rst           |   4 +-
 tools/rfcomm-tester.c      |  14 ++---
 tools/rfcomm.c             |  14 ++---
 tools/rfcomm.rst           |   2 +-
 tools/sco-tester.c         |  10 ++--
 tools/smp-tester.c         |  12 ++--
 35 files changed, 423 insertions(+), 422 deletions(-)

diff --git a/tools/3dsp.c b/tools/3dsp.c
index 5227c30b63..267a39e904 100644
--- a/tools/3dsp.c
+++ b/tools/3dsp.c
@@ -112,10 +112,10 @@ static void start_inquiry(void)
 						inquiry_started, NULL, NULL);
 }
 
-static void set_slave_broadcast_receive(const void *data, uint8_t size,
+static void set_peripheral_broadcast_receive(const void *data, uint8_t size,
 							void *user_data)
 {
-	printf("Slave broadcast receiption enabled\n");
+	printf("Peripheral broadcast reception enabled\n");
 }
 
 static void sync_train_received(const void *data, uint8_t size,
@@ -149,7 +149,7 @@ static void sync_train_received(const void *data, uint8_t size,
 
 	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_RECEIVE,
 				&cmd, sizeof(cmd),
-				set_slave_broadcast_receive, NULL, NULL);
+				set_peripheral_broadcast_receive, NULL, NULL);
 }
 
 static void brcm_sync_train_received(const void *data, uint8_t size,
@@ -183,7 +183,7 @@ static void brcm_sync_train_received(const void *data, uint8_t size,
 
 	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_RECEIVE,
 				&cmd, sizeof(cmd),
-				set_slave_broadcast_receive, NULL, NULL);
+				set_peripheral_broadcast_receive, NULL, NULL);
 }
 
 static void truncated_page_complete(const void *data, uint8_t size,
@@ -209,7 +209,7 @@ static void truncated_page_complete(const void *data, uint8_t size,
 							NULL, NULL, NULL);
 }
 
-static void slave_broadcast_timeout(const void *data, uint8_t size,
+static void peripheral_broadcast_timeout(const void *data, uint8_t size,
 							void *user_data)
 {
 	const struct bt_hci_evt_peripheral_broadcast_timeout *evt = data;
@@ -226,7 +226,7 @@ static void slave_broadcast_timeout(const void *data, uint8_t size,
 							NULL, NULL, NULL);
 }
 
-static void slave_broadcast_receive(const void *data, uint8_t size,
+static void peripheral_broadcast_receive(const void *data, uint8_t size,
 							void *user_data)
 {
 	const struct bt_hci_evt_peripheral_broadcast_receive *evt = data;
@@ -327,9 +327,9 @@ static void start_glasses(void)
 	bt_hci_register(hci_dev, BT_HCI_EVT_TRUNCATED_PAGE_COMPLETE,
 					truncated_page_complete, NULL, NULL);
 	bt_hci_register(hci_dev, BT_HCI_EVT_PERIPHERAL_BROADCAST_TIMEOUT,
-					slave_broadcast_timeout, NULL, NULL);
+				peripheral_broadcast_timeout, NULL, NULL);
 	bt_hci_register(hci_dev, BT_HCI_EVT_PERIPHERAL_BROADCAST_RECEIVE,
-					slave_broadcast_receive, NULL, NULL);
+				peripheral_broadcast_receive, NULL, NULL);
 
 	start_inquiry();
 }
@@ -381,7 +381,7 @@ static void conn_request(const void *data, uint8_t size, void *user_data)
 	start_sync_train();
 }
 
-static void slave_page_response_timeout(const void *data, uint8_t size,
+static void peripheral_page_response_timeout(const void *data, uint8_t size,
 							void *user_data)
 {
 	printf("Incoming truncated page received\n");
@@ -389,8 +389,8 @@ static void slave_page_response_timeout(const void *data, uint8_t size,
 	start_sync_train();
 }
 
-static void slave_broadcast_channel_map_change(const void *data, uint8_t size,
-								void *user_data)
+static void peripheral_broadcast_channel_map_change(const void *data,
+						uint8_t size, void *user_data)
 {
 	printf("Broadcast channel map changed\n");
 
@@ -447,13 +447,14 @@ static void read_clock(const void *data, uint8_t size, void *user_data)
 			bcastdata, sizeof(bcastdata), NULL, NULL, NULL);
 }
 
-static void set_slave_broadcast(const void *data, uint8_t size, void *user_data)
+static void set_peripheral_broadcast(const void *data, uint8_t size,
+								void *user_data)
 {
 	const struct bt_hci_rsp_set_peripheral_broadcast *rsp = data;
 	struct bt_hci_cmd_read_clock cmd;
 
 	if (rsp->status) {
-		printf("Failed to set slave broadcast transmission\n");
+		printf("Failed to set peripheral broadcast transmission\n");
 		shutdown_device();
 		return;
 	}
@@ -493,10 +494,10 @@ static void start_display(void)
 						conn_request, NULL, NULL);
 
 	bt_hci_register(hci_dev, BT_HCI_EVT_PERIPHERAL_PAGE_RESPONSE_TIMEOUT,
-				slave_page_response_timeout, NULL, NULL);
+				peripheral_page_response_timeout, NULL, NULL);
 	bt_hci_register(hci_dev,
 			BT_HCI_EVT_PERIPHERAL_BROADCAST_CHANNEL_MAP_CHANGE,
-			slave_broadcast_channel_map_change, NULL, NULL);
+			peripheral_broadcast_channel_map_change, NULL, NULL);
 	bt_hci_register(hci_dev, BT_HCI_EVT_SYNC_TRAIN_COMPLETE,
 					sync_train_complete, NULL, NULL);
 
@@ -512,7 +513,7 @@ static void start_display(void)
 	cmd.timeout = cpu_to_le16(0xfffe);
 
 	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST, &cmd,
-			sizeof(cmd), set_slave_broadcast, NULL, NULL);
+			sizeof(cmd), set_peripheral_broadcast, NULL, NULL);
 }
 
 static void signal_callback(int signum, void *user_data)
diff --git a/tools/bdaddr.rst b/tools/bdaddr.rst
index 1d21e2ca39..a84950bc35 100644
--- a/tools/bdaddr.rst
+++ b/tools/bdaddr.rst
@@ -61,7 +61,7 @@ FILES
 =====
 
 /usr/share/misc/oui.txt
-    IEEE Organizationally Unique Identifier master file.
+    IEEE Organizationally Unique Identifier consolidated file.
     Manually update from: http://standards.ieee.org/regauth/oui/oui.txt
 
 
diff --git a/tools/btiotest.c b/tools/btiotest.c
index 3f4900a5a5..1da8c20caf 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -310,7 +310,7 @@ static void l2cap_connect(const char *src, const char *dst, uint8_t addr_type,
 static void l2cap_listen(const char *src, uint8_t addr_type, uint16_t psm,
 				uint16_t cid, int defer, int reject,
 				int disconn, int accept, int sec,
-				gboolean master)
+				gboolean central)
 {
 	struct io_data *data;
 	BtIOConnect conn;
@@ -343,7 +343,7 @@ static void l2cap_listen(const char *src, uint8_t addr_type, uint16_t psm,
 					BT_IO_OPT_PSM, psm,
 					BT_IO_OPT_CID, cid,
 					BT_IO_OPT_SEC_LEVEL, sec,
-					BT_IO_OPT_CENTRAL, master,
+					BT_IO_OPT_CENTRAL, central,
 					BT_IO_OPT_INVALID);
 	else
 		l2_srv = bt_io_listen(conn, cfm, data,
@@ -353,7 +353,7 @@ static void l2cap_listen(const char *src, uint8_t addr_type, uint16_t psm,
 					BT_IO_OPT_PSM, psm,
 					BT_IO_OPT_CID, cid,
 					BT_IO_OPT_SEC_LEVEL, sec,
-					BT_IO_OPT_CENTRAL, master,
+					BT_IO_OPT_CENTRAL, central,
 					BT_IO_OPT_INVALID);
 
 	if (!l2_srv) {
@@ -402,7 +402,7 @@ static void rfcomm_connect(const char *src, const char *dst, uint8_t ch,
 
 static void rfcomm_listen(const char *src, uint8_t ch, gboolean defer,
 				int reject, int disconn, int accept,
-				int sec, gboolean master)
+				int sec, gboolean central)
 {
 	struct io_data *data;
 	BtIOConnect conn;
@@ -427,7 +427,7 @@ static void rfcomm_listen(const char *src, uint8_t ch, gboolean defer,
 					BT_IO_OPT_SOURCE, src,
 					BT_IO_OPT_CHANNEL, ch,
 					BT_IO_OPT_SEC_LEVEL, sec,
-					BT_IO_OPT_CENTRAL, master,
+					BT_IO_OPT_CENTRAL, central,
 					BT_IO_OPT_INVALID);
 	else
 		rc_srv = bt_io_listen(conn, cfm,
@@ -435,7 +435,7 @@ static void rfcomm_listen(const char *src, uint8_t ch, gboolean defer,
 					&err,
 					BT_IO_OPT_CHANNEL, ch,
 					BT_IO_OPT_SEC_LEVEL, sec,
-					BT_IO_OPT_CENTRAL, master,
+					BT_IO_OPT_CENTRAL, central,
 					BT_IO_OPT_INVALID);
 
 	if (!rc_srv) {
@@ -540,7 +540,7 @@ static int opt_reject = -1;
 static int opt_disconn = -1;
 static int opt_accept = DEFAULT_ACCEPT_TIMEOUT;
 static int opt_sec = 0;
-static gboolean opt_master = FALSE;
+static gboolean opt_central = FALSE;
 static int opt_priority = 0;
 static int opt_cid = 0;
 static guint8 opt_addr_type = 0;
@@ -576,8 +576,8 @@ static GOptionEntry options[] = {
 				"Disconnect connection after N seconds" },
 	{ "accept", 'a', 0, G_OPTION_ARG_INT, &opt_accept,
 				"Accept connection after N seconds" },
-	{ "master", 'm', 0, G_OPTION_ARG_NONE, &opt_master,
-				"Master role switch (incoming connections)" },
+	{ "central", 'C', 0, G_OPTION_ARG_NONE, &opt_central,
+				"Central role switch (incoming connections)" },
 	{ "priority", 'P', 0, G_OPTION_ARG_INT, &opt_priority,
 				"Transmission priority: Setting a priority "
 				"outside the range 0 to 6 requires the"
@@ -614,7 +614,7 @@ int main(int argc, char *argv[])
 		else
 			l2cap_listen(opt_dev, opt_addr_type, opt_psm, opt_cid,
 					opt_defer, opt_reject, opt_disconn,
-					opt_accept, opt_sec, opt_master);
+					opt_accept, opt_sec, opt_central);
 	}
 
 	if (opt_channel != -1) {
@@ -624,7 +624,7 @@ int main(int argc, char *argv[])
 		else
 			rfcomm_listen(opt_dev, opt_channel, opt_defer,
 					opt_reject, opt_disconn, opt_accept,
-					opt_sec, opt_master);
+					opt_sec, opt_central);
 	}
 
 	if (opt_sco) {
diff --git a/tools/btpclientctl.c b/tools/btpclientctl.c
index 6553f2f3a7..c30d5bd4e7 100644
--- a/tools/btpclientctl.c
+++ b/tools/btpclientctl.c
@@ -676,7 +676,7 @@ const struct indexstr_data ad_type_table[] = {
 	{ 0x10, "BT_AD_DEVICE_ID" },
 	{ 0x10, "BT_AD_SMP_TK" },
 	{ 0x11, "BT_AD_SMP_OOB_FLAGS" },
-	{ 0x12, "BT_AD_SLAVE_CONN_INTERVAL" },
+	{ 0x12, "BT_AD_PERIPHERAL_CONN_INTERVAL" },
 	{ 0x14, "BT_AD_SOLICIT16" },
 	{ 0x15, "BT_AD_SOLICIT128" },
 	{ 0x16, "BT_AD_SERVICE_DATA16" },
diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index 645d89e721..79193220fe 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -335,12 +335,12 @@ static void test_read_local_supported_codecs(const void *test_data)
 	test_command(BT_HCI_CMD_READ_LOCAL_CODECS);
 }
 
-static void test_le_read_white_list_size(const void *test_data)
+static void test_le_read_accept_list_size(const void *test_data)
 {
 	test_command(BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE);
 }
 
-static void test_le_clear_white_list(const void *test_data)
+static void test_le_clear_accept_list(const void *test_data)
 {
 	test_command(BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST);
 }
@@ -944,10 +944,10 @@ int main(int argc, char *argv[])
 	test_hci_local("Read Local Supported Codecs", NULL, NULL,
 				test_read_local_supported_codecs);
 
-	test_hci_local("LE Read White List Size", NULL, NULL,
-				test_le_read_white_list_size);
-	test_hci_local("LE Clear White List", NULL, NULL,
-				test_le_clear_white_list);
+	test_hci_local("LE Read Accept List Size", NULL, NULL,
+				test_le_read_accept_list_size);
+	test_hci_local("LE Clear Accept List", NULL, NULL,
+				test_le_clear_accept_list);
 	test_hci_local("LE Encrypt", NULL, NULL,
 				test_le_encrypt);
 	test_hci_local("LE Rand", NULL, NULL,
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 491f216135..2bc9fe84c3 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -116,8 +116,8 @@ static void print_le_states(uint64_t states)
 		"Directed Advertising State",
 		"Passive Scanning State",
 		"Active Scanning State",
-		"Initiating State/Connection State in Master Role",
-		"Connection State in the Slave Role",
+		"Initiating State/Connection State in Central Role",
+		"Connection State in the Peripheral Role",
 		"Non-connectable Advertising State and Passive Scanning State combination",
 		"Scannable Advertising State and Passive Scanning State combination",
 		"Connectable Advertising State and Passive Scanning State combination",
@@ -128,17 +128,17 @@ static void print_le_states(uint64_t states)
 		"Directed Advertising State and Active Scanning State combination",
 		"Non-connectable Advertising State and Initiating State combination",
 		"Scannable Advertising State and Initiating State combination",
-		"Non-connectable Advertising State and Master Role combination",
-		"Scannable Advertising State and Master Role combination",
-		"Non-connectable Advertising State and Slave Role combination",
-		"Scannable Advertising State and Slave Role combination",
+		"Non-connectable Advertising State and Central Role combination",
+		"Scannable Advertising State and Central Role combination",
+		"Non-connectable Advertising State and Peripheral Role combination",
+		"Scannable Advertising State and Peripheral Role combination",
 		"Passive Scanning State and Initiating State combination",
 		"Active Scanning State and Initiating State combination",
-		"Passive Scanning State and Master Role combination",
-		"Active Scanning State and Master Role combination",
-		"Passive Scanning State and Slave Role combination",
-		"Active Scanning State and Slave Role combination",
-		"Initiating State and Master Role combination/Master Role and Master Role combination",
+		"Passive Scanning State and Central Role combination",
+		"Active Scanning State and Central Role combination",
+		"Passive Scanning State and Peripheral Role combination",
+		"Active Scanning State and Peripheral Role combination",
+		"Initiating State and Central Role combination/Central Role and Central Role combination",
 		NULL
 	};
 
@@ -1922,8 +1922,8 @@ static struct {
 	{ "features",	cmd_features,	0,		"Display device features" },
 	{ "version",	cmd_version,	0,		"Display version information" },
 	{ "revision",	cmd_revision,	0,		"Display revision information" },
-	{ "block",	cmd_block,	"<bdaddr>",	"Add a device to the blacklist" },
-	{ "unblock",	cmd_unblock,	"<bdaddr>",	"Remove a device from the blacklist" },
+	{ "block",	cmd_block,	"<bdaddr>",	"Add a device to the reject list" },
+	{ "unblock",	cmd_unblock,	"<bdaddr>",	"Remove a device from the reject list" },
 	{ "lerandaddr", cmd_le_addr,	"<bdaddr>",	"Set LE Random Address" },
 	{ "leadv",	cmd_le_adv,	"[type]",	"Enable LE advertising"
 		"\n\t\t\t0 - Connectable undirected advertising (default)"
diff --git a/tools/hciconfig.rst b/tools/hciconfig.rst
index 7d59b4046e..2d56eeb413 100644
--- a/tools/hciconfig.rst
+++ b/tools/hciconfig.rst
@@ -216,24 +216,24 @@ revision
     Display revision information.
 
 lm [*mode*]
-    With no *mode*, prints link mode. **MASTER** or **SLAVE** mean,
-    respectively, to ask to become master or to remain slave when a connection
-    request comes in. The additional keyword **ACCEPT** means that baseband
-    connections will be accepted even if there are no listening *AF_BLUETOOTH*
-    sockets. *mode* is **NONE** or a comma-separated list of keywords, where
-    possible keywords are **MASTER** and **ACCEPT**. **NONE** sets link policy
-    to the default behaviour of remaining slave and not accepting baseband
-    connections when there are no listening *AF_BLUETOOTH* sockets.  If
-    **MASTER** is  present, the device will ask to become master if a
-    connection request comes in. If **ACCEPT** is present, the device will
+    With no *mode*, prints link mode. **CENTRAL** or **PERIPHERAL** mean,
+    respectively, to ask to become central or to remain peripheral when a
+    connection request comes in. The additional keyword **ACCEPT** means that
+    baseband connections will be accepted even if there are no listening
+    *AF_BLUETOOTH* sockets. *mode* is **NONE** or a comma-separated list of
+    keywords, where possible keywords are **CENTRAL** and **ACCEPT**. **NONE**
+    sets link policy to the default behaviour of remaining peripheral and not
+    accepting baseband connections when there are no listening *AF_BLUETOOTH*
+    sockets.  If **CENTRAL** is  present, the device will ask to become central
+    if a connection request comes in. If **ACCEPT** is present, the device will
     accept baseband connections even when there are no listening *AF_BLUETOOTH*
     sockets.
 
 block <*bdaddr*>
-    Add a device to the blacklist
+    Add a device to the reject list
 
 unblock <*bdaddr*>
-    Remove a device from the blacklist
+    Remove a device from the reject list
 
 lerandaddr <*bdaddr*>
     Set LE Random Address
diff --git a/tools/hcitool.c b/tools/hcitool.c
index f7fca5216c..082895bce4 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -1210,10 +1210,10 @@ static struct option cc_options[] = {
 
 static const char *cc_help =
 	"Usage:\n"
-	"\tcc [--role=m|s] [--ptype=pkt_types] <bdaddr>\n"
+	"\tcc [--role=c|p] [--ptype=pkt_types] <bdaddr>\n"
 	"Example:\n"
 	"\tcc --ptype=dm1,dh3,dh5 01:02:03:04:05:06\n"
-	"\tcc --role=m 01:02:03:04:05:06\n";
+	"\tcc --role=c 01:02:03:04:05:06\n";
 
 static void cmd_cc(int dev_id, int argc, char **argv)
 {
@@ -1360,10 +1360,10 @@ static void cmd_sr(int dev_id, int argc, char **argv)
 
 	str2ba(argv[0], &bdaddr);
 	switch (argv[1][0]) {
-	case 'm':
+	case 'c':
 		role = 0;
 		break;
-	case 's':
+	case 'p':
 		role = 1;
 		break;
 	default:
@@ -2474,7 +2474,7 @@ static struct option lescan_options[] = {
 	{ "static",	0, 0, 's' },
 	{ "privacy",	0, 0, 'p' },
 	{ "passive",	0, 0, 'P' },
-	{ "whitelist",	0, 0, 'w' },
+	{ "acceptlist",	0, 0, 'a' },
 	{ "discovery",	1, 0, 'd' },
 	{ "duplicates",	0, 0, 'D' },
 	{ 0, 0, 0, 0 }
@@ -2484,7 +2484,7 @@ static const char *lescan_help =
 	"Usage:\n"
 	"\tlescan [--privacy] enable privacy\n"
 	"\tlescan [--passive] set scan type passive (default active)\n"
-	"\tlescan [--whitelist] scan for address in the whitelist only\n"
+	"\tlescan [--acceptlist] scan for address in the accept list only\n"
 	"\tlescan [--discovery=g|l] enable general or limited discovery"
 		"procedure\n"
 	"\tlescan [--duplicates] don't filter duplicates\n";
@@ -2511,8 +2511,8 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 		case 'P':
 			scan_type = 0x00; /* Passive */
 			break;
-		case 'w':
-			filter_policy = 0x01; /* Whitelist */
+		case 'a':
+			filter_policy = 0x01; /* Accept list */
 			break;
 		case 'd':
 			filter_type = optarg[0];
@@ -2678,14 +2678,14 @@ static struct option lecc_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "static",	0, 0, 's' },
 	{ "random",	0, 0, 'r' },
-	{ "whitelist",	0, 0, 'w' },
+	{ "acceptlist",	0, 0, 'a' },
 	{ 0, 0, 0, 0 }
 };
 
 static const char *lecc_help =
 	"Usage:\n"
 	"\tlecc [--static] [--random] <bdaddr>\n"
-	"\tlecc --whitelist\n";
+	"\tlecc --acceptlist\n";
 
 static void cmd_lecc(int dev_id, int argc, char **argv)
 {
@@ -2707,8 +2707,8 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 		case 'r':
 			peer_bdaddr_type = LE_RANDOM_ADDRESS;
 			break;
-		case 'w':
-			initiator_filter = 0x01; /* Use white list */
+		case 'a':
+			initiator_filter = 0x01; /* Use accept list */
 			break;
 		default:
 			printf("%s", lecc_help);
@@ -2753,34 +2753,34 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 	hci_close_dev(dd);
 }
 
-static struct option lewladd_options[] = {
+static struct option lealall_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "random",	0, 0, 'r' },
 	{ 0, 0, 0, 0 }
 };
 
-static const char *lewladd_help =
+static const char *lealall_help =
 	"Usage:\n"
-	"\tlewladd [--random] <bdaddr>\n";
+	"\tlealall [--random] <bdaddr>\n";
 
-static void cmd_lewladd(int dev_id, int argc, char **argv)
+static void cmd_lealall(int dev_id, int argc, char **argv)
 {
 	int err, opt, dd;
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type = LE_PUBLIC_ADDRESS;
 
-	for_each_opt(opt, lewladd_options, NULL) {
+	for_each_opt(opt, lealall_options, NULL) {
 		switch (opt) {
 		case 'r':
 			bdaddr_type = LE_RANDOM_ADDRESS;
 			break;
 		default:
-			printf("%s", lewladd_help);
+			printf("%s", lealall_help);
 			return;
 		}
 	}
 
-	helper_arg(1, 1, &argc, &argv, lewladd_help);
+	helper_arg(1, 1, &argc, &argv, lealall_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -2798,35 +2798,35 @@ static void cmd_lewladd(int dev_id, int argc, char **argv)
 
 	if (err < 0) {
 		err = -errno;
-		fprintf(stderr, "Can't add to white list: %s(%d)\n",
+		fprintf(stderr, "Can't add to accept list: %s(%d)\n",
 							strerror(-err), -err);
 		exit(1);
 	}
 }
 
-static struct option lewlrm_options[] = {
+static struct option lealrm_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
 };
 
-static const char *lewlrm_help =
+static const char *lealrm_help =
 	"Usage:\n"
-	"\tlewlrm <bdaddr>\n";
+	"\tlealrm <bdaddr>\n";
 
-static void cmd_lewlrm(int dev_id, int argc, char **argv)
+static void cmd_lealrm(int dev_id, int argc, char **argv)
 {
 	int err, opt, dd;
 	bdaddr_t bdaddr;
 
-	for_each_opt(opt, lewlrm_options, NULL) {
+	for_each_opt(opt, lealrm_options, NULL) {
 		switch (opt) {
 		default:
-			printf("%s", lewlrm_help);
+			printf("%s", lealrm_help);
 			return;
 		}
 	}
 
-	helper_arg(1, 1, &argc, &argv, lewlrm_help);
+	helper_arg(1, 1, &argc, &argv, lealrm_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -2844,35 +2844,35 @@ static void cmd_lewlrm(int dev_id, int argc, char **argv)
 
 	if (err < 0) {
 		err = errno;
-		fprintf(stderr, "Can't remove from white list: %s(%d)\n",
+		fprintf(stderr, "Can't remove from accept list: %s(%d)\n",
 							strerror(err), err);
 		exit(1);
 	}
 }
 
-static struct option lewlsz_options[] = {
+static struct option lealsz_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
 };
 
-static const char *lewlsz_help =
+static const char *lealsz_help =
 	"Usage:\n"
-	"\tlewlsz\n";
+	"\tlealsz\n";
 
-static void cmd_lewlsz(int dev_id, int argc, char **argv)
+static void cmd_lealsz(int dev_id, int argc, char **argv)
 {
 	int err, dd, opt;
 	uint8_t size;
 
-	for_each_opt(opt, lewlsz_options, NULL) {
+	for_each_opt(opt, lealsz_options, NULL) {
 		switch (opt) {
 		default:
-			printf("%s", lewlsz_help);
+			printf("%s", lealsz_help);
 			return;
 		}
 	}
 
-	helper_arg(0, 0, &argc, &argv, lewlsz_help);
+	helper_arg(0, 0, &argc, &argv, lealsz_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -2888,36 +2888,36 @@ static void cmd_lewlsz(int dev_id, int argc, char **argv)
 
 	if (err < 0) {
 		err = -errno;
-		fprintf(stderr, "Can't read white list size: %s(%d)\n",
+		fprintf(stderr, "Can't read accept list size: %s(%d)\n",
 							strerror(-err), -err);
 		exit(1);
 	}
 
-	printf("White list size: %d\n", size);
+	printf("Accept list size: %d\n", size);
 }
 
-static struct option lewlclr_options[] = {
+static struct option lealclr_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
 };
 
-static const char *lewlclr_help =
+static const char *lealclr_help =
 	"Usage:\n"
-	"\tlewlclr\n";
+	"\tlealclr\n";
 
-static void cmd_lewlclr(int dev_id, int argc, char **argv)
+static void cmd_lealclr(int dev_id, int argc, char **argv)
 {
 	int err, dd, opt;
 
-	for_each_opt(opt, lewlclr_options, NULL) {
+	for_each_opt(opt, lealclr_options, NULL) {
 		switch (opt) {
 		default:
-			printf("%s", lewlclr_help);
+			printf("%s", lealclr_help);
 			return;
 		}
 	}
 
-	helper_arg(0, 0, &argc, &argv, lewlclr_help);
+	helper_arg(0, 0, &argc, &argv, lealclr_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -2933,7 +2933,7 @@ static void cmd_lewlclr(int dev_id, int argc, char **argv)
 
 	if (err < 0) {
 		err = -errno;
-		fprintf(stderr, "Can't clear white list: %s(%d)\n",
+		fprintf(stderr, "Can't clear accept list: %s(%d)\n",
 							strerror(-err), -err);
 		exit(1);
 	}
@@ -3287,7 +3287,7 @@ static const char *lecup_help =
 	"\t    --handle=<0xXXXX>  LE connection handle\n"
 	"\t    --min=<interval>   Range: 0x0006 to 0x0C80\n"
 	"\t    --max=<interval>   Range: 0x0006 to 0x0C80\n"
-	"\t    --latency=<range>  Slave latency. Range: 0x0000 to 0x03E8\n"
+	"\t    --latency=<range>  Peripheral latency. Range: 0x0000 to 0x03E8\n"
 	"\t    --timeout=<time>   N * 10ms. Range: 0x000A to 0x0C80\n"
 	"\n\t min/max range: 7.5ms to 4s. Multiply factor: 1.25ms"
 	"\n\t timeout range: 100ms to 32.0s. Larger than max interval\n";
@@ -3379,7 +3379,7 @@ static struct {
 	{ "con",      cmd_con,     "Display active connections"           },
 	{ "cc",       cmd_cc,      "Create connection to remote device"   },
 	{ "dc",       cmd_dc,      "Disconnect from remote device"        },
-	{ "sr",       cmd_sr,      "Switch master/slave role"             },
+	{ "sr",       cmd_sr,      "Switch central/peripheral role"       },
 	{ "cpt",      cmd_cpt,     "Change connection packet type"        },
 	{ "rssi",     cmd_rssi,    "Display connection RSSI"              },
 	{ "lq",       cmd_lq,      "Display link quality"                 },
@@ -3394,10 +3394,10 @@ static struct {
 	{ "clock",    cmd_clock,   "Read local or remote clock"           },
 	{ "lescan",   cmd_lescan,  "Start LE scan"                        },
 	{ "leinfo",   cmd_leinfo,  "Get LE remote information"            },
-	{ "lewladd",  cmd_lewladd, "Add device to LE White List"          },
-	{ "lewlrm",   cmd_lewlrm,  "Remove device from LE White List"     },
-	{ "lewlsz",   cmd_lewlsz,  "Read size of LE White List"           },
-	{ "lewlclr",  cmd_lewlclr, "Clear LE White List"                  },
+	{ "lealall",  cmd_lealall, "Add device to LE Accept List"         },
+	{ "lealrm",   cmd_lealrm,  "Remove device from LE Accept List"    },
+	{ "lealsz",   cmd_lealsz,  "Read size of LE Accept List"          },
+	{ "lealclr",  cmd_lealclr, "Clear LE Accept List"                 },
 	{ "lerladd",  cmd_lerladd, "Add device to LE Resolving List"      },
 	{ "lerlrm",   cmd_lerlrm,  "Remove device from LE Resolving List" },
 	{ "lerlclr",  cmd_lerlclr, "Clear LE Resolving List"              },
diff --git a/tools/hcitool.rst b/tools/hcitool.rst
index f59d694078..36cf4fd66b 100644
--- a/tools/hcitool.rst
+++ b/tools/hcitool.rst
@@ -74,7 +74,7 @@ cmd <*ogf*> <*ocf*> [*parameters*]
 con
     Display active baseband connections
 
-cc [--*role*\=m|s] [--*pkt-type*\=<*ptype*>] <*bdaddr*>
+cc [--*role*\=c|p] [--*pkt-type*\=<*ptype*>] <*bdaddr*>
     Create baseband connection to remote device with Bluetooth address *bdaddr*.
 
     Option **--pkt-type** specifies a list  of  allowed packet types.
@@ -82,9 +82,9 @@ cc [--*role*\=m|s] [--*pkt-type*\=<*ptype*>] <*bdaddr*>
     packet types are **DM1**, **DM3**, **DM5**, **DH1**, **DH3**, **DH5**,
     **HV1**, **HV2**, **HV3**. Default is to allow all packet types.
 
-    Option  **--role** can have value **m** (do not allow role switch, stay
-    master) or **s** (allow role switch, become slave if the peer asks to become
-    master). Default is **m**.
+    Option  **--role** can have value **c** (do not allow role switch, stay
+    central) or **p** (allow role switch, become peripheral if the peer asks to
+    become central). Default is **c**.
 
 dc <*bdaddr*> [*reason*]
     Delete baseband connection from remote device with Bluetooth address
@@ -96,7 +96,7 @@ dc <*bdaddr*> [*reason*]
 
 sr <*bdaddr*> <*role*>
     Switch role for the baseband connection from the remote device to
-    **master** or **slave**.
+    **central** or **peripheral**.
 
 cpt <*bdaddr*> <*ptypes*>
     Change packet types for baseband connection to device with Bluetooth
@@ -157,23 +157,23 @@ clock [*bdaddr*] [*clock*]
     The *clock* can be **0** for the local clock or **1** for the piconet
     clock (which is default).
 
-lescan [--*privacy*] [--*passive*] [--*whitelist*] [--*discovery*\=g|l] [--*duplicates*]
+lescan [--*privacy*] [--*passive*] [--*acceptlist*] [--*discovery*\=g|l] [--*duplicates*]
     Start LE scan
 
 leinfo [--*static*] [--*random*] <*bdaddr*>
     Get LE remote information
 
-lewladd [--*random*] <*bdaddr*>
-    Add device to LE White List
+lealall [--*random*] <*bdaddr*>
+    Add device to LE Accept List
 
-lewlrm <*bdaddr*>
-    Remove device from LE White List
+lealrm <*bdaddr*>
+    Remove device from LE Accept List
 
-lewlsz
-    Read size of LE White List
+lealsz
+    Read size of LE Accept List
 
-lewlclr
-    Clear LE White List
+lealclr
+    Clear LE Accept List
 
 lerladd [--*local_irk*] [--*peer_irk*] [--*random*] <*bdaddr*>
     Add device to LE Resolving List
@@ -193,7 +193,7 @@ lerlon
 lerloff
     Disable LE Address Resolution
 
-lecc [--*static*] [--*random*] <*bdaddr*> | [--*whitelist*]
+lecc [--*static*] [--*random*] <*bdaddr*> | [--*acceptlist*]
     Create a LE Connection
 
 ledc <*handle*> [*reason*]
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 169a989f54..d78b1e29cc 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -1103,7 +1103,7 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 				uint16_t cid, int sec_level, uint8_t mode)
 {
 	const struct l2cap_data *l2data = data->test_data;
-	const uint8_t *master_bdaddr;
+	const uint8_t *central_bdaddr;
 	struct sockaddr_l2 addr;
 	int sk, err;
 
@@ -1116,9 +1116,9 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 		return err;
 	}
 
-	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
-	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
+	central_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+	if (!central_bdaddr) {
+		tester_warn("No central bdaddr");
 		close(sk);
 		return -ENODEV;
 	}
@@ -1127,7 +1127,7 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 	addr.l2_family = AF_BLUETOOTH;
 	addr.l2_psm = htobs(psm);
 	addr.l2_cid = htobs(cid);
-	bacpy(&addr.l2_bdaddr, (void *) master_bdaddr);
+	bacpy(&addr.l2_bdaddr, (void *) central_bdaddr);
 
 	if (l2data && l2data->addr_type_avail)
 		addr.l2_bdaddr_type = l2data->addr_type;
@@ -1437,7 +1437,7 @@ static gboolean test_close_socket_1_part_2(gpointer args)
 	tester_print("Will close socket during scan phase...");
 
 	/* We tried to conect to LE device that is not advertising. It
-	 * was added to kernel whitelist, and scan was started. We
+	 * was added to kernel accept list, and scan was started. We
 	 * should be still scanning.
 	 */
 	if (!hciemu_get_central_le_scan_enable(data->hciemu)) {
@@ -1446,7 +1446,7 @@ static gboolean test_close_socket_1_part_2(gpointer args)
 		return FALSE;
 	}
 
-	/* Calling close() should remove device from  whitelist, and stop
+	/* Calling close() should remove device from  accept list, and stop
 	 * the scan.
 	 */
 	if (close(sk) < 0) {
@@ -1836,7 +1836,7 @@ static void test_server(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
-	const uint8_t *master_bdaddr;
+	const uint8_t *central_bdaddr;
 	uint8_t addr_type;
 	struct bthost *bthost;
 	GIOChannel *io;
@@ -1869,9 +1869,9 @@ static void test_server(const void *test_data)
 		tester_print("Listening for connections");
 	}
 
-	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
-	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
+	central_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+	if (!central_bdaddr) {
+		tester_warn("No central bdaddr");
 		tester_test_failed();
 		return;
 	}
@@ -1884,7 +1884,7 @@ static void test_server(const void *test_data)
 	else
 		addr_type = BDADDR_LE_PUBLIC;
 
-	bthost_hci_connect(bthost, master_bdaddr, addr_type);
+	bthost_hci_connect(bthost, central_bdaddr, addr_type);
 }
 
 static void test_getpeername_not_connected(const void *test_data)
diff --git a/tools/l2test.c b/tools/l2test.c
index 822cdc8cc9..ca58a6549b 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -110,7 +110,7 @@ static int seq_start = 0;
 static const char *filename = NULL;
 
 static int rfcmode = 0;
-static int master = 0;
+static int central = 0;
 static int auth = 0;
 static int encr = 0;
 static int secure = 0;
@@ -483,7 +483,7 @@ static int do_connect(char *svr)
 	opt = 0;
 	if (reliable)
 		opt |= L2CAP_LM_RELIABLE;
-	if (master)
+	if (central)
 		opt |= L2CAP_LM_CENTRAL;
 	if (auth)
 		opt |= L2CAP_LM_AUTH;
@@ -586,7 +586,7 @@ static void do_listen(void (*handler)(int sk))
 	opt = 0;
 	if (reliable)
 		opt |= L2CAP_LM_RELIABLE;
-	if (master)
+	if (central)
 		opt |= L2CAP_LM_CENTRAL;
 	if (auth)
 		opt |= L2CAP_LM_AUTH;
@@ -1306,7 +1306,7 @@ static void usage(void)
 		"\t[-W seconds] enable deferred setup\n"
 		"\t[-B filename] use data packets from file\n"
 		"\t[-N num] send num frames (default = infinite)\n"
-		"\t[-C num] send num frames before delay (default = 1)\n"
+		"\t[-M num] send num frames before delay (default = 1)\n"
 		"\t[-D milliseconds] delay after sending num frames (default = 0)\n"
 		"\t[-K milliseconds] delay before receiving (default = 0)\n"
 		"\t[-g milliseconds] delay before disconnecting (default = 0)\n"
@@ -1323,7 +1323,7 @@ static void usage(void)
 		"\t[-A] request authentication\n"
 		"\t[-E] request encryption\n"
 		"\t[-S] secure connection\n"
-		"\t[-M] become master\n"
+		"\t[-C] become central\n"
 		"\t[-T] enable timestamps\n"
 		"\t[-V type] address type (help for list, default = bredr)\n"
 		"\t[-e seq] initial sequence value (default = 0)\n");
@@ -1337,7 +1337,7 @@ int main(int argc, char *argv[])
 	bacpy(&bdaddr, BDADDR_ANY);
 
 	while ((opt = getopt(argc, argv, "a:b:cde:g:i:mnpqrstuwxyz"
-		"AB:C:D:EF:GH:I:J:K:L:MN:O:P:Q:RSTUV:W:X:Y:Z:")) != EOF) {
+		"AB:CD:EF:GH:I:J:K:L:M:N:O:P:Q:RSTUV:W:X:Y:Z:")) != EOF) {
 		switch (opt) {
 		case 'r':
 			mode = RECV;
@@ -1442,7 +1442,7 @@ int main(int argc, char *argv[])
 			num_frames = atoi(optarg);
 			break;
 
-		case 'C':
+		case 'M':
 			count = atoi(optarg);
 			break;
 
@@ -1488,8 +1488,8 @@ int main(int argc, char *argv[])
 			reliable = 1;
 			break;
 
-		case 'M':
-			master = 1;
+		case 'C':
+			central = 1;
 			break;
 
 		case 'A':
diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index a4a6f21ab8..70553c95c8 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -720,7 +720,7 @@ static void attach_node_reply(struct l_dbus_proxy *proxy,
 							ivi != iv_index) {
 		iv_index = ivi;
 		mesh_db_set_iv_index(ivi);
-		remote_clear_blacklisted_addresses(ivi);
+		remote_clear_rejected_addresses(ivi);
 	}
 
 	return;
@@ -1858,7 +1858,7 @@ static void property_changed(struct l_dbus_proxy *proxy, const char *name,
 
 			iv_index = ivi;
 			mesh_db_set_iv_index(ivi);
-			remote_clear_blacklisted_addresses(ivi);
+			remote_clear_rejected_addresses(ivi);
 		}
 	}
 }
diff --git a/tools/mesh-gatt/mesh-net.h b/tools/mesh-gatt/mesh-net.h
index 29c8de06cf..95a1346e75 100644
--- a/tools/mesh-gatt/mesh-net.h
+++ b/tools/mesh-gatt/mesh-net.h
@@ -97,8 +97,8 @@
 #define PROXY_OP_FILTER_STATUS		0x03
 
 /* Proxy Filter Defines */
-#define PROXY_FILTER_WHITELIST		0x00
-#define PROXY_FILTER_BLACKLIST		0x01
+#define PROXY_FILTER_ACCEPT_LIST	0x00
+#define PROXY_FILTER_REJECT_LIST	0x01
 
 /* Network Tranport Opcodes */
 #define NET_OP_SEG_ACKNOWLEDGE		0x00
diff --git a/tools/mesh-gatt/net.c b/tools/mesh-gatt/net.c
index 2fdd0d4bef..47afedf34d 100644
--- a/tools/mesh-gatt/net.c
+++ b/tools/mesh-gatt/net.c
@@ -47,11 +47,11 @@ struct mesh_net {
 	uint8_t default_ttl;
 	bool iv_update;
 	bool provisioner;
-	bool blacklist;
+	bool reject_list;
 	guint iv_update_timeout;
 	GDBusProxy *proxy_in;
 	GList *address_pool;
-	GList *dest;	/* List of valid local destinations for Whitelist */
+	GList *dest;	/* List of valid local destinations for Accept List */
 	GList *sar_in;	/* Incoming segmented messages in progress */
 	GList *msg_out;	/* Pre-Network encoded, might be multi-segment */
 	GList *pkt_out; /* Fully encoded packets awaiting Tx in order */
@@ -200,8 +200,8 @@ struct mesh_destination {
 #define FILTER_STATUS		0x03
 
 /* Proxy Filter Types */
-#define WHITELIST_FILTER	0x00
-#define BLACKLIST_FILTER	0x01
+#define ACCEPT_LIST_FILTER	0x00
+#define REJECT_LIST_FILTER	0x01
 
 /* IV Updating states for timing enforcement */
 #define IV_UPD_INIT 		0
@@ -919,45 +919,45 @@ void net_dest_unref(uint16_t dst)
 	}
 }
 
-struct build_whitelist {
+struct build_accept_list {
 	uint8_t len;
 	uint8_t data[12];
 };
 
-static void whitefilter_add(gpointer data, gpointer user_data)
+static void accept_filter_add(gpointer data, gpointer user_data)
 {
 	struct mesh_destination	*dest = data;
-	struct build_whitelist *white = user_data;
+	struct build_accept_list *accept = user_data;
 
-	if (white->len == 0)
-		white->data[white->len++] = FILTER_ADD;
+	if (accept->len == 0)
+		accept->data[accept->len++] = FILTER_ADD;
 
-	put_be16(dest->dst, white->data + white->len);
-	white->len += 2;
+	put_be16(dest->dst, accept->data + accept->len);
+	accept->len += 2;
 
-	if (white->len > (sizeof(white->data) - sizeof(uint16_t))) {
-		net_ctl_msg_send(0, 0, 0, white->data, white->len);
-		white->len = 0;
+	if (accept->len > (sizeof(accept->data) - sizeof(uint16_t))) {
+		net_ctl_msg_send(0, 0, 0, accept->data, accept->len);
+		accept->len = 0;
 	}
 }
 
-static void setup_whitelist()
+static void setup_accept_list()
 {
-	struct build_whitelist white;
+	struct build_accept_list accept;
 
-	white.len = 0;
+	accept.len = 0;
 
-	/* Enable (and Clear) Proxy Whitelist */
-	white.data[white.len++] = FILTER_SETUP;
-	white.data[white.len++] = WHITELIST_FILTER;
+	/* Enable (and Clear) Proxy Accept List */
+	accept.data[accept.len++] = FILTER_SETUP;
+	accept.data[accept.len++] = ACCEPT_LIST_FILTER;
 
-	net_ctl_msg_send(0, 0, 0, white.data, white.len);
+	net_ctl_msg_send(0, 0, 0, accept.data, accept.len);
 
-	white.len = 0;
-	g_list_foreach(net.dest, whitefilter_add, &white);
+	accept.len = 0;
+	g_list_foreach(net.dest, accept_filter_add, &accept);
 
-	if (white.len)
-		net_ctl_msg_send(0, 0, 0, white.data, white.len);
+	if (accept.len)
+		net_ctl_msg_send(0, 0, 0, accept.data, accept.len);
 }
 
 static void beacon_update(bool first, bool iv_update, uint32_t iv_index)
@@ -1009,7 +1009,7 @@ static void beacon_update(bool first, bool iv_update, uint32_t iv_index)
 
 	if (first) {
 		/* Must be done once per Proxy Connection after Beacon RXed */
-		setup_whitelist();
+		setup_accept_list();
 		if (net.open_cb)
 			net.open_cb(0);
 	}
@@ -1388,9 +1388,9 @@ static bool proxy_ctl_rxed(uint16_t net_idx, uint32_t iv_index,
 			if (len != 4)
 				return false;
 
-			net.blacklist = !!(trans[1] == BLACKLIST_FILTER);
-			bt_shell_printf("Proxy %slist filter length: %d\n",
-					net.blacklist ? "Black" : "White",
+			net.reject_list = !!(trans[1] == REJECT_LIST_FILTER);
+			bt_shell_printf("Proxy %s list filter length: %d\n",
+					net.reject_list ? "Reject" : "Accept",
 					get_be16(trans + 2));
 
 			return true;
@@ -1950,7 +1950,7 @@ bool net_session_open(GDBusProxy *data_in, bool provisioner,
 
 	net.proxy_in = data_in;
 	net.iv_upd_state = IV_UPD_INIT;
-	net.blacklist = false;
+	net.reject_list = false;
 	net.provisioner = provisioner;
 	net.open_cb = cb;
 	flush_pkt_list(&net.pkt_out);
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 46f0c60751..6779bb8403 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -1246,7 +1246,7 @@ bool mesh_db_set_iv_index(uint32_t ivi)
 	return save_config();
 }
 
-static int get_blacklisted_by_iv_index(json_object *jarray, uint32_t iv_index)
+static int get_rejected_by_iv_index(json_object *jarray, uint32_t iv_index)
 {
 	int i, cnt;
 
@@ -1268,12 +1268,12 @@ static int get_blacklisted_by_iv_index(json_object *jarray, uint32_t iv_index)
 	return -1;
 }
 
-static bool load_blacklisted(json_object *jobj)
+static bool load_rejected_addresses(json_object *jobj)
 {
 	json_object *jarray;
 	int i, cnt;
 
-	json_object_object_get_ex(jobj, "blacklistedAddresses", &jarray);
+	json_object_object_get_ex(jobj, "rejectedAddresses", &jarray);
 	if (!jarray || json_object_get_type(jarray) != json_type_array)
 		return true;
 
@@ -1304,15 +1304,14 @@ static bool load_blacklisted(json_object *jobj)
 			if (sscanf(str, "%04hx", &unicast) != 1)
 				return false;
 
-			remote_add_blacklisted_address(unicast, iv_index,
-								false);
+			remote_add_rejected_address(unicast, iv_index, false);
 		}
 	}
 
 	return true;
 }
 
-bool mesh_db_add_blacklisted_addr(uint16_t unicast, uint32_t iv_index)
+bool mesh_db_add_rejected_addr(uint16_t unicast, uint32_t iv_index)
 {
 	json_object *jarray, *jobj, *jaddrs, *jstring;
 	int idx;
@@ -1321,14 +1320,13 @@ bool mesh_db_add_blacklisted_addr(uint16_t unicast, uint32_t iv_index)
 	if (!cfg || !cfg->jcfg)
 		return false;
 
-	json_object_object_get_ex(cfg->jcfg, "blacklistedAddresses", &jarray);
+	json_object_object_get_ex(cfg->jcfg, "rejectedAddresses", &jarray);
 	if (!jarray) {
 		jarray = json_object_new_array();
-		json_object_object_add(cfg->jcfg, "blacklistedAddresses",
-									jarray);
+		json_object_object_add(cfg->jcfg, "rejectedAddresses", jarray);
 	}
 
-	idx = get_blacklisted_by_iv_index(jarray, iv_index);
+	idx = get_rejected_by_iv_index(jarray, iv_index);
 
 	if (idx < 0) {
 		jobj = json_object_new_object();
@@ -1362,7 +1360,7 @@ fail:
 	return false;
 }
 
-bool mesh_db_clear_blacklisted(uint32_t iv_index)
+bool mesh_db_clear_rejected(uint32_t iv_index)
 {
 	json_object *jarray;
 	int idx;
@@ -1370,11 +1368,11 @@ bool mesh_db_clear_blacklisted(uint32_t iv_index)
 	if (!cfg || !cfg->jcfg)
 		return false;
 
-	json_object_object_get_ex(cfg->jcfg, "blacklistedAddresses", &jarray);
+	json_object_object_get_ex(cfg->jcfg, "rejectedAddresses", &jarray);
 	if (!jarray || json_object_get_type(jarray) != json_type_array)
 		return false;
 
-	idx = get_blacklisted_by_iv_index(jarray, iv_index);
+	idx = get_rejected_by_iv_index(jarray, iv_index);
 	if (idx < 0)
 		return true;
 
@@ -1437,7 +1435,7 @@ bool mesh_db_create(const char *fname, const uint8_t token[8],
 	if (!jarray)
 		goto fail;
 
-	json_object_object_add(jcfg, "blacklistedAddresses", jarray);
+	json_object_object_add(jcfg, "rejectedAddresses", jarray);
 
 	write_int(jcfg, "ivIndex", 0);
 
@@ -1504,7 +1502,7 @@ bool mesh_db_load(const char *fname)
 
 	load_remotes(jcfg);
 
-	load_blacklisted(jcfg);
+	load_rejected_addresses(jcfg);
 
 	return true;
 fail:
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index d1d734bf3e..22518c6189 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -49,5 +49,5 @@ bool mesh_db_node_model_binding_del(uint16_t unicast, uint8_t ele, bool vendor,
 					uint32_t mod_id, uint16_t app_idx);
 struct l_queue *mesh_db_load_groups(void);
 bool mesh_db_add_group(struct mesh_group *grp);
-bool mesh_db_add_blacklisted_addr(uint16_t unicast, uint32_t iv_index);
-bool mesh_db_clear_blacklisted(uint32_t iv_index);
+bool mesh_db_add_rejected_addr(uint16_t unicast, uint32_t iv_index);
+bool mesh_db_clear_rejected(uint32_t iv_index);
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index 9b265bee49..e60a3681d0 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -34,13 +34,13 @@ struct remote_node {
 	uint8_t num_ele;
 };
 
-struct blacklisted_addr {
+struct rejected_addr {
 	uint32_t iv_index;
 	uint16_t unicast;
 };
 
 static struct l_queue *nodes;
-static struct l_queue *blacklisted;
+static struct l_queue *reject_list;
 
 static bool key_present(struct l_queue *keys, uint16_t app_idx)
 {
@@ -124,7 +124,7 @@ uint8_t remote_del_node(uint16_t unicast)
 
 	for (i = 0; i < num_ele; ++i) {
 		l_queue_destroy(rmt->els[i], NULL);
-		remote_add_blacklisted_address(unicast + i, iv_index, true);
+		remote_add_rejected_address(unicast + i, iv_index, true);
 	}
 
 	l_free(rmt->els);
@@ -333,9 +333,9 @@ static void print_node(void *rmt, void *user_data)
 		print_element(node->els[i], i);
 }
 
-static bool match_black_addr(const void *a, const void *b)
+static bool match_rejected_addr(const void *a, const void *b)
 {
-	const struct blacklisted_addr *addr = a;
+	const struct rejected_addr *addr = a;
 	uint16_t unicast = L_PTR_TO_UINT(b);
 
 	return addr->unicast == unicast;
@@ -348,11 +348,11 @@ static uint16_t get_next_addr(uint16_t high, uint16_t addr,
 		int i = 0;
 
 		for (i = 0; i < ele_cnt; i++) {
-			struct blacklisted_addr *black;
+			struct rejected_addr *reject;
 
-			black = l_queue_find(blacklisted, match_black_addr,
+			reject = l_queue_find(reject_list, match_rejected_addr,
 						L_UINT_TO_PTR(addr + i));
-			if (!black)
+			if (!reject)
 				break;
 		}
 
@@ -367,10 +367,10 @@ static uint16_t get_next_addr(uint16_t high, uint16_t addr,
 
 static bool check_iv_index(const void *a, const void *b)
 {
-	const struct blacklisted_addr *black_addr = a;
+	const struct rejected_addr *reject = a;
 	uint32_t iv_index = L_PTR_TO_UINT(b);
 
-	return (abs_diff(iv_index, black_addr->iv_index) > 2);
+	return (abs_diff(iv_index, reject->iv_index) > 2);
 }
 
 void remote_print_node(uint16_t addr)
@@ -435,36 +435,35 @@ uint16_t remote_get_next_unicast(uint16_t low, uint16_t high, uint8_t ele_cnt)
 	return addr;
 }
 
-void remote_add_blacklisted_address(uint16_t addr, uint32_t iv_index,
-								bool save)
+void remote_add_rejected_address(uint16_t addr, uint32_t iv_index, bool save)
 {
-	struct blacklisted_addr *black_addr;
+	struct rejected_addr *reject;
 
-	if (!blacklisted)
-		blacklisted = l_queue_new();
+	if (!reject_list)
+		reject_list = l_queue_new();
 
-	black_addr = l_new(struct blacklisted_addr, 1);
-	black_addr->unicast = addr;
-	black_addr->iv_index = iv_index;
+	reject = l_new(struct rejected_addr, 1);
+	reject->unicast = addr;
+	reject->iv_index = iv_index;
 
-	l_queue_push_tail(blacklisted, black_addr);
+	l_queue_push_tail(reject_list, reject);
 
 	if (save)
-		mesh_db_add_blacklisted_addr(addr, iv_index);
+		mesh_db_add_rejected_addr(addr, iv_index);
 }
 
-void remote_clear_blacklisted_addresses(uint32_t iv_index)
+void remote_clear_rejected_addresses(uint32_t iv_index)
 {
-	struct blacklisted_addr *black_addr;
+	struct rejected_addr *reject;
 
-	black_addr = l_queue_remove_if(blacklisted, check_iv_index,
+	reject = l_queue_remove_if(reject_list, check_iv_index,
 						L_UINT_TO_PTR(iv_index));
 
-	while (black_addr) {
-		l_free(black_addr);
-		black_addr = l_queue_remove_if(blacklisted, check_iv_index,
+	while (reject) {
+		l_free(reject);
+		reject = l_queue_remove_if(reject_list, check_iv_index,
 						L_UINT_TO_PTR(iv_index));
 	}
 
-	mesh_db_clear_blacklisted(iv_index);
+	mesh_db_clear_rejected(iv_index);
 }
diff --git a/tools/mesh/remote.h b/tools/mesh/remote.h
index bb4fb11917..8ecb097ae4 100644
--- a/tools/mesh/remote.h
+++ b/tools/mesh/remote.h
@@ -13,9 +13,8 @@ bool remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 uint8_t remote_del_node(uint16_t unicast);
 bool remote_set_model(uint16_t unicast, uint8_t ele_idx, uint32_t mod_id,
 								bool vendor);
-void remote_add_blacklisted_address(uint16_t addr, uint32_t iv_index,
-								bool save);
-void remote_clear_blacklisted_addresses(uint32_t iv_index);
+void remote_add_rejected_address(uint16_t addr, uint32_t iv_index, bool save);
+void remote_clear_rejected_addresses(uint32_t iv_index);
 uint16_t remote_get_next_unicast(uint16_t low, uint16_t high, uint8_t ele_cnt);
 bool remote_add_net_key(uint16_t addr, uint16_t net_idx);
 bool remote_del_net_key(uint16_t addr, uint16_t net_idx);
diff --git a/tools/meshctl.c b/tools/meshctl.c
index 9d7df2ccdc..18e20c40d2 100644
--- a/tools/meshctl.c
+++ b/tools/meshctl.c
@@ -541,19 +541,19 @@ static void print_uuids(GDBusProxy *proxy)
 	}
 }
 
-static gboolean device_is_child(GDBusProxy *device, GDBusProxy *master)
+static gboolean device_is_child(GDBusProxy *device, GDBusProxy *parent)
 {
 	DBusMessageIter iter;
 	const char *adapter, *path;
 
-	if (!master)
+	if (!parent)
 		return FALSE;
 
 	if (g_dbus_proxy_get_property(device, "Adapter", &iter) == FALSE)
 		return FALSE;
 
 	dbus_message_iter_get_basic(&iter, &adapter);
-	path = g_dbus_proxy_get_path(master);
+	path = g_dbus_proxy_get_path(parent);
 
 	if (!strcmp(path, adapter))
 		return TRUE;
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index dc53faf3af..65507952b1 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2698,20 +2698,20 @@ static const char load_ltks_invalid_param_2[] = {
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
 	0x00,						/* addr type */
 	0x00,						/* authenticated */
-	0x00,						/* master */
+	0x00,						/* central */
 	0x00,						/* encryption size */
 	0x00, 0x00,					/* diversifier */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
 };
-/* Invalid master value */
+/* Invalid central value */
 static const char load_ltks_invalid_param_3[] = {
 	0x01, 0x00,					/* count */
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
 	0x01,						/* addr type */
 	0x00,						/* authenticated */
-	0x02,						/* master */
+	0x02,						/* central */
 	0x00,						/* encryption size */
 	0x00, 0x00,					/* diversifier */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
@@ -4233,7 +4233,7 @@ static const uint8_t add_device_success_param_6[] = {
 					0x02,
 };
 
-static const uint8_t le_add_to_white_list_param[] = {
+static const uint8_t le_add_to_accept_list_param[] = {
 	0x00,					/* Type */
 	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
 };
@@ -4249,8 +4249,8 @@ static const struct generic_data add_device_success_6 = {
 	.expect_alt_ev_param = add_device_success_param_6,
 	.expect_alt_ev_len = sizeof(add_device_success_param_6),
 	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
-	.expect_hci_param = le_add_to_white_list_param,
-	.expect_hci_len = sizeof(le_add_to_white_list_param),
+	.expect_hci_param = le_add_to_accept_list_param,
+	.expect_hci_len = sizeof(le_add_to_accept_list_param),
 };
 
 static const uint8_t le_add_to_resolv_list_param[] = {
@@ -4419,8 +4419,8 @@ static const struct generic_data remove_device_success_7 = {
 	.expect_len = sizeof(remove_device_param_2),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST,
-	.expect_hci_param = le_add_to_white_list_param,
-	.expect_hci_len = sizeof(le_add_to_white_list_param),
+	.expect_hci_param = le_add_to_accept_list_param,
+	.expect_hci_len = sizeof(le_add_to_accept_list_param),
 	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
 	.expect_alt_ev_param = remove_device_param_2,
 	.expect_alt_ev_len = sizeof(remove_device_param_2),
@@ -4434,8 +4434,8 @@ static const struct generic_data remove_device_success_8 = {
 	.expect_len = sizeof(remove_device_param_2),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
-	.expect_hci_param = le_add_to_white_list_param,
-	.expect_hci_len = sizeof(le_add_to_white_list_param),
+	.expect_hci_param = le_add_to_accept_list_param,
+	.expect_hci_len = sizeof(le_add_to_accept_list_param),
 	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
 	.expect_alt_ev_param = remove_device_param_2,
 	.expect_alt_ev_len = sizeof(remove_device_param_2),
@@ -5374,40 +5374,40 @@ static const struct generic_data read_local_oob_ext_success_sc_test = {
 	.expect_hci_command = BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA,
 };
 
-static const uint8_t le_states_conn_slave_adv_connectable[] = {
+static const uint8_t le_states_conn_peripheral_adv_connectable[] = {
 			0x00, 0x00, 0x20, 0x00, 0x40, 0x00, 0x00, 0x00};
-static const uint8_t le_states_conn_slave_adv_non_connectable[] = {
+static const uint8_t le_states_conn_peripheral_adv_non_connectable[] = {
 			0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00};
-static const uint8_t le_states_conn_master_adv_connectable[] = {
+static const uint8_t le_states_conn_central_adv_connectable[] = {
 			0x00, 0x00, 0x08, 0x00, 0x08, 0x00, 0x00, 0x00};
-static const uint8_t le_states_conn_master_adv_non_connectable[] = {
+static const uint8_t le_states_conn_central_adv_non_connectable[] = {
 			0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00};
 
-static const struct generic_data conn_slave_adv_conneactable_test = {
+static const struct generic_data conn_peripheral_adv_connectable_test = {
 	.setup_le_states = true,
-	.le_states = le_states_conn_slave_adv_connectable,
+	.le_states = le_states_conn_peripheral_adv_connectable,
 	.setup_settings = settings_powered_le,
 	.client_enable_le = true
 };
 
-static const struct generic_data conn_slave_adv_non_conneactable_test = {
+static const struct generic_data conn_peripheral_adv_non_connectable_test = {
 	.setup_le_states = true,
-	.le_states = le_states_conn_slave_adv_non_connectable,
+	.le_states = le_states_conn_peripheral_adv_non_connectable,
 	.setup_settings = settings_powered_le,
 	.client_enable_le = true
 };
 
-static const struct generic_data conn_master_adv_conneactable_test = {
+static const struct generic_data conn_central_adv_connectable_test = {
 	.setup_le_states = true,
-	.le_states = le_states_conn_master_adv_connectable,
+	.le_states = le_states_conn_central_adv_connectable,
 	.setup_settings = settings_powered_le,
 	.client_enable_le = true,
 	.client_enable_adv = 1
 };
 
-static const struct generic_data conn_master_adv_non_conneactable_test = {
+static const struct generic_data conn_central_adv_non_connectable_test = {
 	.setup_le_states = true,
-	.le_states = le_states_conn_master_adv_non_connectable,
+	.le_states = le_states_conn_central_adv_non_connectable,
 	.setup_settings = settings_powered_le,
 	.client_enable_le = true,
 	.client_enable_adv = 1
@@ -9801,7 +9801,7 @@ static void test_pairing_acceptor(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
-	const uint8_t *master_bdaddr;
+	const uint8_t *central_bdaddr;
 	struct bthost *bthost;
 	uint8_t addr_type;
 
@@ -9817,9 +9817,9 @@ static void test_pairing_acceptor(const void *test_data)
 		test_add_condition(data);
 	}
 
-	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
-	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
+	central_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+	if (!central_bdaddr) {
+		tester_warn("No central bdaddr");
 		tester_test_failed();
 		return;
 	}
@@ -9832,7 +9832,7 @@ static void test_pairing_acceptor(const void *test_data)
 	else
 		addr_type = BDADDR_LE_PUBLIC;
 
-	bthost_hci_connect(bthost, master_bdaddr, addr_type);
+	bthost_hci_connect(bthost, central_bdaddr, addr_type);
 }
 
 static void connected_event(uint16_t index, uint16_t length, const void *param,
@@ -9870,7 +9870,7 @@ static void test_command_generic_connect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	unsigned int id;
-	const uint8_t *master_bdaddr;
+	const uint8_t *central_bdaddr;
 	uint8_t addr_type;
 	struct bthost *bthost;
 
@@ -9882,9 +9882,9 @@ static void test_command_generic_connect(const void *test_data)
 	data->mgmt_alt_ev_id = id;
 	test_add_condition(data);
 
-	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
-	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
+	central_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+	if (!central_bdaddr) {
+		tester_warn("No central bdaddr");
 		tester_test_failed();
 		return;
 	}
@@ -9893,7 +9893,7 @@ static void test_command_generic_connect(const void *test_data)
 							BDADDR_LE_PUBLIC;
 	tester_print("ADDR TYPE: %d", addr_type);
 	bthost = hciemu_client_get_host(data->hciemu);
-	bthost_hci_connect(bthost, master_bdaddr, addr_type);
+	bthost_hci_connect(bthost, central_bdaddr, addr_type);
 }
 
 static bool test_adv_enable_hook(const void *data, uint16_t len,
@@ -9946,7 +9946,7 @@ static void add_device_callback(uint8_t status, uint16_t len, const void *param,
 	struct test_data *data = user_data;
 	const struct generic_data *test = data->test_data;
 	struct bthost *bthost;
-	const uint8_t *master_bdaddr;
+	const uint8_t *central_bdaddr;
 
 	if (status != 0) {
 		tester_test_failed();
@@ -9961,18 +9961,19 @@ static void add_device_callback(uint8_t status, uint16_t len, const void *param,
 	if (test->client_enable_adv)
 		return;
 
-	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
-	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
+	central_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+	if (!central_bdaddr) {
+		tester_warn("No central bdaddr");
 		tester_test_failed();
 		return;
 	}
 
 	bthost = hciemu_client_get_host(data->hciemu);
 	if (data->hciemu_type >= HCIEMU_TYPE_BREDRLE50)
-		bthost_hci_ext_connect(bthost, master_bdaddr, BDADDR_LE_PUBLIC);
+		bthost_hci_ext_connect(bthost, central_bdaddr,
+		BDADDR_LE_PUBLIC);
 	else
-		bthost_hci_connect(bthost, master_bdaddr, BDADDR_LE_PUBLIC);
+		bthost_hci_connect(bthost, central_bdaddr, BDADDR_LE_PUBLIC);
 }
 
 static void test_connected_and_advertising(const void *test_data)
@@ -10915,9 +10916,9 @@ int main(int argc, char *argv[])
 				&add_device_success_5,
 				NULL, test_command_generic);
 	/* MGMT_OP_ADD_DEVICE
-	 * Add device and check the device is added to the whitelist
+	 * Add device and check the device is added to the accept list
 	 */
-	test_bredrle50("Add Device - Success 6 - Add to whitelist",
+	test_bredrle50("Add Device - Success 6 - Add to accept list",
 				&add_device_success_6,
 				NULL, test_command_generic);
 	/* MGMT_OP_ADD_DEVICE
@@ -10969,7 +10970,7 @@ int main(int argc, char *argv[])
 	 * Remove the device and check the device is removed from the whilte
 	 * list as well.
 	 */
-	test_bredrle50("Remove Device - Success 7 - Remove from whitelist",
+	test_bredrle50("Remove Device - Success 7 - Remove from accept list",
 				&remove_device_success_7,
 				setup_ll_privacy_device2, test_command_generic);
 	/* MGMT_OP_REMOVE_DEVICE
@@ -11176,23 +11177,24 @@ int main(int argc, char *argv[])
 					 &add_advertising_name_data_appear,
 					 setup_command_generic,
 					 test_command_generic);
-	test_le_full("Adv. connectable & connected (slave) - Success",
-					&conn_slave_adv_conneactable_test,
-					setup_advertise_while_connected,
-					test_connected_and_advertising, 10);
 
-	test_le_full("Adv. non-connectable & connected (slave) - Success",
-					&conn_slave_adv_non_conneactable_test,
+	test_le_full("Adv. connectable & connected (peripheral) - Success",
+					&conn_peripheral_adv_connectable_test,
 					setup_advertise_while_connected,
 					test_connected_and_advertising, 10);
 
-	test_le_full("Adv. connectable & connected (master) - Success",
-					&conn_master_adv_conneactable_test,
+	test_le_full("Adv. non-connectable & connected (peripheral) - Success",
+				&conn_peripheral_adv_non_connectable_test,
+				setup_advertise_while_connected,
+				test_connected_and_advertising, 10);
+
+	test_le_full("Adv. connectable & connected (central) - Success",
+					&conn_central_adv_connectable_test,
 					setup_advertise_while_connected,
 					test_connected_and_advertising, 10);
 
-	test_le_full("Adv. non-connectable & connected (master) - Success",
-					&conn_master_adv_non_conneactable_test,
+	test_le_full("Adv. non-connectable & connected (central) - Success",
+					&conn_central_adv_non_connectable_test,
 					setup_advertise_while_connected,
 					test_connected_and_advertising, 10);
 
@@ -11600,23 +11602,23 @@ int main(int argc, char *argv[])
 				&device_found_invalid_field,
 				NULL, test_device_found);
 
-	test_bredrle50_full("Ext Adv. connectable & connected (slave) - Success",
-				&conn_slave_adv_conneactable_test,
+	test_bredrle50_full("Ext Adv. connectable & connected (peripheral) - Success",
+				&conn_peripheral_adv_connectable_test,
 				setup_advertise_while_connected,
 				test_connected_and_advertising, 10);
 
-	test_bredrle50_full("Ext Adv. non-connectable & connected (slave) - Success",
-				&conn_slave_adv_non_conneactable_test,
+	test_bredrle50_full("Ext Adv. non-connectable & connected (peripheral) - Success",
+				&conn_peripheral_adv_non_connectable_test,
 				setup_advertise_while_connected,
 				test_connected_and_advertising, 10);
 
-	test_bredrle50_full("Ext Adv. connectable & connected (master) - Success",
-				&conn_master_adv_conneactable_test,
+	test_bredrle50_full("Ext Adv. connectable & connected (central) - Success",
+				&conn_central_adv_connectable_test,
 				setup_advertise_while_connected,
 				test_connected_and_advertising, 10);
 
-	test_bredrle50_full("Ext Adv. non-connectable & connected (master) - Success",
-				&conn_master_adv_non_conneactable_test,
+	test_bredrle50_full("Ext Adv. non-connectable & connected (central) - Success",
+				&conn_central_adv_non_connectable_test,
 				setup_advertise_while_connected,
 				test_connected_and_advertising, 10);
 
diff --git a/tools/oobtest.c b/tools/oobtest.c
index 0368bc3865..eed765af02 100644
--- a/tools/oobtest.c
+++ b/tools/oobtest.c
@@ -134,15 +134,15 @@ static void new_long_term_key_event(uint16_t index, uint16_t len,
 	switch (ev->key.type) {
 	case 0x00:
 		if (ev->key.central)
-			type = "Unauthenticated, Master";
+			type = "Unauthenticated, Central";
 		else
-			type = "Unauthenticated, Slave";
+			type = "Unauthenticated, Peripheral";
 		break;
 	case 0x01:
 		if (ev->key.central)
-			type = "Authenticated, Master";
+			type = "Authenticated, Central";
 		else
-			type = "Authenticated, Slave";
+			type = "Authenticated, Peripheral";
 		break;
 	case 0x02:
 		type = "Unauthenticated, P-256";
diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
index bb7bbadaba..68a5b370c5 100644
--- a/tools/parser/avdtp.c
+++ b/tools/parser/avdtp.c
@@ -605,7 +605,7 @@ void avdtp_dump(int level, struct frame *frm)
 		nsp = (hdr & 0x0c) == 0x04 ? p_get_u8(frm) : 0;
 		sid = hdr & 0x08 ? 0x00 : p_get_u8(frm);
 
-		printf("AVDTP(s): %s %s: transaction %d nsp 0x%02x\n",
+		printf("AVDTP(p): %s %s: transaction %d nsp 0x%02x\n",
 			hdr & 0x08 ? pt2str(hdr) : si2str(sid),
 			mt2str(hdr), hdr >> 4, nsp);
 
@@ -659,7 +659,7 @@ void avdtp_dump(int level, struct frame *frm)
 		time = p_get_u32(frm);
 		ssrc = p_get_u32(frm);
 
-		printf("AVDTP(m): ver %d %s%scc %d %spt %d seqn %d time %d ssrc %d\n",
+		printf("AVDTP(c): ver %d %s%scc %d %spt %d seqn %d time %d ssrc %d\n",
 			hdr >> 6, hdr & 0x20 ? "pad " : "", hdr & 0x10 ? "ext " : "",
 			hdr & 0xf, type & 0x80 ? "mark " : "", type & 0x7f, seqn, time, ssrc);
 		break;
diff --git a/tools/parser/csr.c b/tools/parser/csr.c
index c112e138b1..bd50b1c760 100644
--- a/tools/parser/csr.c
+++ b/tools/parser/csr.c
@@ -257,7 +257,7 @@ static inline void pskey_dump(int level, struct frame *frm)
 		uint16_dump(level + 1, "MAX_SCOS", frm);
 		break;
 	case 0x000f:
-		uint16_dump(level + 1, "MAX_REMOTE_MASTERS", frm);
+		uint16_dump(level + 1, "MAX_REMOTE_CENTRALS", frm);
 		break;
 	case 0x00da:
 		uint16_dump(level + 1, "ENC_KEY_LMIN", frm);
@@ -546,7 +546,7 @@ static char *frag2str(uint8_t frag)
 void csr_dump(int level, struct frame *frm)
 {
 	uint8_t desc, cid, type;
-	uint16_t handle, master, addr;
+	uint16_t handle, central, addr;
 
 	desc = CSR_U8(frm);
 
@@ -564,24 +564,25 @@ void csr_dump(int level, struct frame *frm)
 			switch (type) {
 			case 0x0f:
 				frm->handle =  ((uint8_t *) frm->ptr)[17];
-				frm->master = 0;
+				frm->central = 0;
 				frm->len--;
 				lmp_dump(level, frm);
 				return;
 			case 0x10:
 				frm->handle = ((uint8_t *) frm->ptr)[17];
-				frm->master = 1;
+				frm->central = 1;
 				frm->len--;
 				lmp_dump(level, frm);
 				return;
 			case 0x12:
 				handle = CSR_U16(frm);
-				master = CSR_U16(frm);
+				central = CSR_U16(frm);
 				addr = CSR_U16(frm);
 				p_indent(level, frm);
-				printf("FHS: handle %d addr %d (%s)\n", handle,
-					addr, master ? "master" : "slave");
-				if (!master) {
+				printf("FHS: handle %d addr %d (%s)\n",
+					handle, addr,
+					central ? "central" : "peripheral");
+				if (!central) {
 					char addr[18];
 					p_ba2str((bdaddr_t *) frm->ptr, addr);
 					p_indent(level + 1, frm);
diff --git a/tools/parser/ericsson.c b/tools/parser/ericsson.c
index 09b7cec68f..b2807eca59 100644
--- a/tools/parser/ericsson.c
+++ b/tools/parser/ericsson.c
@@ -29,7 +29,7 @@ void ericsson_dump(int level, struct frame *frm)
 		raw_dump(level, frm);
 	}
 
-	frm->master = !(buf[0] & 0x01);
+	frm->central = !(buf[0] & 0x01);
 	frm->handle = buf[1] | (buf[2] << 8);
 
 	buf[5] = (buf[5] << 1) | (buf[3] & 0x01);
diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index 02ebcfc442..7b3ffa6cb9 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -45,7 +45,7 @@ static char *event_str[EVENT_NUM + 1] = {
 	"Remote Name Req Complete",
 	"Encrypt Change",
 	"Change Connection Link Key Complete",
-	"Master Link Key Complete",
+	"Temporary Link Key Complete",
 	"Read Remote Supported Features",
 	"Read Remote Ver Info Complete",
 	"QoS Setup Complete",
@@ -150,7 +150,7 @@ static char *cmd_linkctl_str[CMD_LINKCTL_NUM + 1] = {
 	"Unknown",
 	"Change Connection Link Key",
 	"Unknown",
-	"Master Link Key",
+	"Temporary Link Key",
 	"Unknown",
 	"Remote Name Request",
 	"Remote Name Request Cancel",
@@ -383,10 +383,10 @@ static char *cmd_le_str[CMD_LE_NUM + 1] = {
 	"LE Set Scan Enable",
 	"LE Create Connection",
 	"LE Create Connection Cancel",
-	"LE Read White List Size",
-	"LE Clear White List",
-	"LE Add Device To White List",
-	"LE Remove Device From White List",
+	"LE Read Accept List Size",
+	"LE Clear Accept List",
+	"LE Add Device To Accept List",
+	"LE Remove Device From Accept List",
 	"LE Connection Update",
 	"LE Set Host Channel Classification",
 	"LE Read Channel Map",
@@ -568,9 +568,9 @@ static char *role2str(uint8_t role)
 {
 	switch (role) {
 	case 0x00:
-		return "Master";
+		return "Central";
 	case 0x01:
-		return "Slave";
+		return "Peripheral";
 	default:
 		return "Unknown";
 	}
@@ -739,11 +739,11 @@ static char *filterpolicy2str(uint8_t policy)
 	case 0x00:
 		return "Allow scan from any, connection from any";
 	case 0x01:
-		return "Allow scan from white list, connection from any";
+		return "Allow scan from accept list, connection from any";
 	case 0x02:
-		return "Allow scan from any, connection from white list";
+		return "Allow scan from any, connection from accept list";
 	case 0x03:
-		return "Allow scan and connection from white list";
+		return "Allow scan and connection from accept list";
 	default:
 		return "Reserved";
 	}
@@ -1082,7 +1082,7 @@ static inline void remote_name_req_dump(int level, struct frame *frm)
 		clkoffset & 0x7fff, clkoffset & 0x8000 ? " (valid)" : "");
 }
 
-static inline void master_link_key_dump(int level, struct frame *frm)
+static inline void temporary_link_key_dump(int level, struct frame *frm)
 {
 	central_link_key_cp *cp = frm->ptr;
 
@@ -1640,7 +1640,7 @@ static inline void le_set_scan_parameters_dump(int level, struct frame *frm)
 	printf("own address: 0x%02x (%s) policy: %s\n", cp->own_bdaddr_type,
 			bdaddrtype2str(cp->own_bdaddr_type),
 		(cp->filter == 0x00 ? "All" :
-			(cp->filter == 0x01 ? "white list only" : "reserved")));
+			(cp->filter == 0x01 ? "accept list only" : "reserved")));
 }
 
 static inline void le_set_scan_enable_dump(int level, struct frame *frm)
@@ -1772,7 +1772,7 @@ static inline void command_dump(int level, struct frame *frm)
 			generic_command_dump(level + 1, frm);
 			return;
 		case OCF_CENTRAL_LINK_KEY:
-			master_link_key_dump(level + 1, frm);
+			temporary_link_key_dump(level + 1, frm);
 			return;
 		case OCF_READ_REMOTE_EXT_FEATURES:
 			read_remote_ext_features_dump(level + 1, frm);
@@ -3114,7 +3114,8 @@ static inline void remote_name_req_complete_dump(int level, struct frame *frm)
 	}
 }
 
-static inline void master_link_key_complete_dump(int level, struct frame *frm)
+static inline void temporary_link_key_complete_dump(int level,
+							struct frame *frm)
 {
 	evt_central_link_key_complete *evt = frm->ptr;
 
@@ -3565,7 +3566,7 @@ static inline void evt_le_conn_complete_dump(int level, struct frame *frm)
 	p_indent(level, frm);
 	printf("status 0x%2.2x handle %d, role %s\n",
 					evt->status, btohs(evt->handle),
-					evt->role ? "slave" : "master");
+					evt->role ? "peripheral" : "central");
 
 	p_indent(level, frm);
 	p_ba2str(&evt->peer_bdaddr, addr);
@@ -3875,7 +3876,7 @@ static inline void event_dump(int level, struct frame *frm)
 		generic_response_dump(level + 1, frm);
 		break;
 	case EVT_CENTRAL_LINK_KEY_COMPLETE:
-		master_link_key_complete_dump(level + 1, frm);
+		temporary_link_key_complete_dump(level + 1, frm);
 		break;
 	case EVT_REMOTE_NAME_REQ_COMPLETE:
 		remote_name_req_complete_dump(level + 1, frm);
diff --git a/tools/parser/lmp.c b/tools/parser/lmp.c
index e99902b0e6..94b6428967 100644
--- a/tools/parser/lmp.c
+++ b/tools/parser/lmp.c
@@ -28,22 +28,22 @@
 
 static enum {
 	IN_RAND,
-	COMB_KEY_M,
-	COMB_KEY_S,
-	AU_RAND_M,
-	AU_RAND_S,
-	SRES_M,
-	SRES_S,
+	COMB_KEY_C,
+	COMB_KEY_P,
+	AU_RAND_C,
+	AU_RAND_P,
+	SRES_C,
+	SRES_P,
 } pairing_state = IN_RAND;
 
 static struct {
 	uint8_t in_rand[16];
-	uint8_t comb_key_m[16];
-	uint8_t comb_key_s[16];
-	uint8_t au_rand_m[16];
-	uint8_t au_rand_s[16];
-	uint8_t sres_m[4];
-	uint8_t sres_s[4];
+	uint8_t comb_key_c[16];
+	uint8_t comb_key_p[16];
+	uint8_t au_rand_c[16];
+	uint8_t au_rand_p[16];
+	uint8_t sres_c[4];
+	uint8_t sres_p[4];
 } pairing_data;
 
 static inline void pairing_data_dump(void)
@@ -59,31 +59,31 @@ static inline void pairing_data_dump(void)
 	p_indent(6, NULL);
 	printf("COMB_KEY ");
 	for (i = 0; i < 16; i++)
-		printf("%2.2x", pairing_data.comb_key_m[i]);
+		printf("%2.2x", pairing_data.comb_key_c[i]);
 	printf(" (M)\n");
 
 	p_indent(6, NULL);
 	printf("COMB_KEY ");
 	for (i = 0; i < 16; i++)
-		printf("%2.2x", pairing_data.comb_key_s[i]);
+		printf("%2.2x", pairing_data.comb_key_p[i]);
 	printf(" (S)\n");
 
 	p_indent(6, NULL);
 	printf("AU_RAND  ");
 	for (i = 0; i < 16; i++)
-		printf("%2.2x", pairing_data.au_rand_m[i]);
+		printf("%2.2x", pairing_data.au_rand_c[i]);
 	printf(" SRES ");
 	for (i = 0; i < 4; i++)
-		printf("%2.2x", pairing_data.sres_m[i]);
+		printf("%2.2x", pairing_data.sres_c[i]);
 	printf(" (M)\n");
 
 	p_indent(6, NULL);
 	printf("AU_RAND  ");
 	for (i = 0; i < 16; i++)
-		printf("%2.2x", pairing_data.au_rand_s[i]);
+		printf("%2.2x", pairing_data.au_rand_p[i]);
 	printf(" SRES ");
 	for (i = 0; i < 4; i++)
-		printf("%2.2x", pairing_data.sres_s[i]);
+		printf("%2.2x", pairing_data.sres_p[i]);
 	printf(" (S)\n");
 }
 
@@ -92,7 +92,7 @@ static inline void in_rand(struct frame *frm)
 	uint8_t *val = frm->ptr;
 
 	memcpy(pairing_data.in_rand, val, 16);
-	pairing_state = COMB_KEY_M;
+	pairing_state = COMB_KEY_C;
 }
 
 static inline void comb_key(struct frame *frm)
@@ -100,19 +100,19 @@ static inline void comb_key(struct frame *frm)
 	uint8_t *val = frm->ptr;
 
 	switch (pairing_state) {
-	case COMB_KEY_M:
-		memcpy(pairing_data.comb_key_m, val, 16);
-		pairing_state = COMB_KEY_S;
+	case COMB_KEY_C:
+		memcpy(pairing_data.comb_key_c, val, 16);
+		pairing_state = COMB_KEY_P;
 		break;
-	case COMB_KEY_S:
-		memcpy(pairing_data.comb_key_s, val, 16);
-		pairing_state = AU_RAND_M;
+	case COMB_KEY_P:
+		memcpy(pairing_data.comb_key_p, val, 16);
+		pairing_state = AU_RAND_C;
 		break;
 	case IN_RAND:
-	case AU_RAND_M:
-	case AU_RAND_S:
-	case SRES_M:
-	case SRES_S:
+	case AU_RAND_C:
+	case AU_RAND_P:
+	case SRES_C:
+	case SRES_P:
 	default:
 		pairing_state = IN_RAND;
 		break;
@@ -124,19 +124,19 @@ static inline void au_rand(struct frame *frm)
 	uint8_t *val = frm->ptr;
 
 	switch (pairing_state) {
-	case AU_RAND_M:
-		memcpy(pairing_data.au_rand_m, val, 16);
-		pairing_state = SRES_M;
+	case AU_RAND_C:
+		memcpy(pairing_data.au_rand_c, val, 16);
+		pairing_state = SRES_C;
 		break;
-	case AU_RAND_S:
-		memcpy(pairing_data.au_rand_s, val, 16);
-		pairing_state = SRES_S;
+	case AU_RAND_P:
+		memcpy(pairing_data.au_rand_p, val, 16);
+		pairing_state = SRES_P;
 		break;
-	case COMB_KEY_M:
-	case COMB_KEY_S:
+	case COMB_KEY_C:
+	case COMB_KEY_P:
 	case IN_RAND:
-	case SRES_M:
-	case SRES_S:
+	case SRES_C:
+	case SRES_P:
 	default:
 		pairing_state = IN_RAND;
 		break;
@@ -148,20 +148,20 @@ static inline void sres(struct frame *frm)
 	uint8_t *val = frm->ptr;
 
 	switch (pairing_state) {
-	case SRES_M:
-		memcpy(pairing_data.sres_m, val, 4);
-		pairing_state = AU_RAND_S;
+	case SRES_C:
+		memcpy(pairing_data.sres_c, val, 4);
+		pairing_state = AU_RAND_P;
 		break;
-	case SRES_S:
-		memcpy(pairing_data.sres_s, val, 4);
+	case SRES_P:
+		memcpy(pairing_data.sres_p, val, 4);
 		pairing_state = IN_RAND;
 		pairing_data_dump();
 		break;
-	case COMB_KEY_M:
-	case COMB_KEY_S:
+	case COMB_KEY_C:
+	case COMB_KEY_P:
 	case IN_RAND:
-	case AU_RAND_M:
-	case AU_RAND_S:
+	case AU_RAND_C:
+	case AU_RAND_P:
 	default:
 		pairing_state = IN_RAND;
 		break;
@@ -1016,10 +1016,10 @@ static inline void esco_link_req_dump(int level, struct frame *frm)
 	uint8_t desco = LMP_U8(frm);
 	uint8_t tesco = LMP_U8(frm);
 	uint8_t wesco = LMP_U8(frm);
-	uint8_t mspkt = LMP_U8(frm);
-	uint8_t smpkt = LMP_U8(frm);
-	uint16_t mslen = LMP_U16(frm);
-	uint16_t smlen = LMP_U16(frm);
+	uint8_t cppkt = LMP_U8(frm);
+	uint8_t pcpkt = LMP_U8(frm);
+	uint16_t cplen = LMP_U16(frm);
+	uint16_t pclen = LMP_U16(frm);
 	uint8_t airmode = LMP_U8(frm);
 	uint8_t negstate = LMP_U8(frm);
 
@@ -1036,10 +1036,10 @@ static inline void esco_link_req_dump(int level, struct frame *frm)
 	printf("D_eSCO %d T_eSCO %d W_eSCO %d\n", desco, tesco, wesco);
 
 	p_indent(level, frm);
-	printf("eSCO M->S packet type 0x%2.2x length %d\n", mspkt, mslen);
+	printf("eSCO C->P packet type 0x%2.2x length %d\n", cppkt, cplen);
 
 	p_indent(level, frm);
-	printf("eSCO S->M packet type 0x%2.2x length %d\n", smpkt, smlen);
+	printf("eSCO P->C packet type 0x%2.2x length %d\n", pcpkt, pclen);
 
 	p_indent(level, frm);
 	printf("air mode 0x%2.2x\n", airmode);
@@ -1141,8 +1141,8 @@ void lmp_dump(int level, struct frame *frm)
 		opcode += tmp << 7;
 	}
 
-	printf("LMP(%c): %s(%c): ", frm->master ? 's' : 'r',
-				opcode2str(opcode), tid ? 's' : 'm');
+	printf("LMP(%c): %s(%c): ", frm->central ? 's' : 'r',
+				opcode2str(opcode), tid ? 'p' : 'c');
 
 	if (opcode > 123)
 		printf("op code %d/%d", opcode & 0x7f, opcode >> 7);
diff --git a/tools/parser/parser.h b/tools/parser/parser.h
index c5d9cf9a6d..5f65f16894 100644
--- a/tools/parser/parser.h
+++ b/tools/parser/parser.h
@@ -26,7 +26,7 @@ struct frame {
 	uint32_t	len;
 	uint16_t	dev_id;
 	uint8_t		in;
-	uint8_t		master;
+	uint8_t		central;
 	uint16_t	handle;
 	uint16_t	cid;
 	uint16_t	num;
diff --git a/tools/parser/smp.c b/tools/parser/smp.c
index a372e5e5ff..733795ac68 100644
--- a/tools/parser/smp.c
+++ b/tools/parser/smp.c
@@ -28,7 +28,7 @@
 #define SMP_CMD_PAIRING_RANDOM	0x04
 #define SMP_CMD_PAIRING_FAILED	0x05
 #define SMP_CMD_ENCRYPT_INFO	0x06
-#define SMP_CMD_MASTER_IDENT	0x07
+#define SMP_CMD_CENTRAL_IDENT	0x07
 #define SMP_CMD_IDENT_INFO	0X08
 #define SMP_CMD_IDENT_ADDR_INFO	0x09
 #define SMP_CMD_SIGN_INFO	0x0a
@@ -78,8 +78,8 @@ static const char *smpcmd2str(uint8_t cmd)
 		return "Pairing Failed";
 	case SMP_CMD_ENCRYPT_INFO:
 		return "Encryption Information";
-	case SMP_CMD_MASTER_IDENT:
-		return "Master Identification";
+	case SMP_CMD_CENTRAL_IDENT:
+		return "Central Identification";
 	case SMP_CMD_IDENT_INFO:
 		return "Identity Information";
 	case SMP_CMD_IDENT_ADDR_INFO:
@@ -221,7 +221,7 @@ static void smp_cmd_encrypt_info_dump(int level, struct frame *frm)
 	printf("\n");
 }
 
-static void smp_cmd_master_ident_dump(int level, struct frame *frm)
+static void smp_cmd_central_ident_dump(int level, struct frame *frm)
 {
 	uint16_t ediv = btohs(htons(p_get_u16(frm)));
 	int i;
@@ -303,8 +303,8 @@ void smp_dump(int level, struct frame *frm)
 	case SMP_CMD_ENCRYPT_INFO:
 		smp_cmd_encrypt_info_dump(level + 1, frm);
 		break;
-	case SMP_CMD_MASTER_IDENT:
-		smp_cmd_master_ident_dump(level + 1, frm);
+	case SMP_CMD_CENTRAL_IDENT:
+		smp_cmd_central_ident_dump(level + 1, frm);
 		break;
 	case SMP_CMD_IDENT_INFO:
 		smp_cmd_ident_info_dump(level + 1, frm);
diff --git a/tools/rctest.c b/tools/rctest.c
index 034ae167b2..7fd6c355de 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -76,7 +76,7 @@ static const char *filename = NULL;
 static const char *savefile = NULL;
 static int save_fd = -1;
 
-static int master = 0;
+static int central = 0;
 static int auth = 0;
 static int encr = 0;
 static int secure = 0;
@@ -202,7 +202,7 @@ static int do_connect(const char *svr)
 
 	/* Set link mode */
 	opt = 0;
-	if (master)
+	if (central)
 		opt |= RFCOMM_LM_CENTRAL;
 	if (auth)
 		opt |= RFCOMM_LM_AUTH;
@@ -293,7 +293,7 @@ static void do_listen(void (*handler)(int sk))
 
 	/* Set link mode */
 	opt = 0;
-	if (master)
+	if (central)
 		opt |= RFCOMM_LM_CENTRAL;
 	if (auth)
 		opt |= RFCOMM_LM_AUTH;
@@ -679,13 +679,13 @@ static void usage(void)
 		"\t[-B filename] use data packets from file\n"
 		"\t[-O filename] save received data to file\n"
 		"\t[-N num] number of frames to send\n"
-		"\t[-C num] send num frames before delay (default = 1)\n"
+		"\t[-M num] send num frames before delay (default = 1)\n"
 		"\t[-D milliseconds] delay after sending num frames (default = 0)\n"
 		"\t[-Y priority] socket priority\n"
 		"\t[-A] request authentication\n"
 		"\t[-E] request encryption\n"
 		"\t[-S] secure connection\n"
-		"\t[-M] become master\n"
+		"\t[-C] become central\n"
 		"\t[-T] enable timestamps\n");
 }
 
@@ -697,7 +697,7 @@ int main(int argc, char *argv[])
 	bacpy(&bdaddr, BDADDR_ANY);
 	bacpy(&auto_bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmna:b:i:P:U:B:O:N:MAESL:W:C:D:Y:T")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmna:b:i:P:U:B:O:N:CAESL:W:M:D:Y:T")) != EOF) {
 		switch (opt) {
 		case 'r':
 			mode = RECV;
@@ -769,8 +769,8 @@ int main(int argc, char *argv[])
 				uuid = atoi(optarg);
 			break;
 
-		case 'M':
-			master = 1;
+		case 'C':
+			central = 1;
 			break;
 
 		case 'A':
@@ -805,7 +805,7 @@ int main(int argc, char *argv[])
 			num_frames = atoi(optarg);
 			break;
 
-		case 'C':
+		case 'M':
 			count = atoi(optarg);
 			break;
 
diff --git a/tools/rctest.rst b/tools/rctest.rst
index 23595112d7..e0982adc3f 100644
--- a/tools/rctest.rst
+++ b/tools/rctest.rst
@@ -56,7 +56,7 @@ OPTIONS
 
 -N num          send num frames
 
--C num          send num frames before delay (default: 1)
+-M num          send num frames before delay (default: 1)
 
 -D milliseconds     delay milliseconds after sending num frames (default: 0)
 
@@ -66,7 +66,7 @@ OPTIONS
 
 -S              secure connection
 
--M              become master
+-C              become central
 
 -T              enable timestamps
 
diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 78b08663bd..ef47904de0 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -534,7 +534,7 @@ static void test_connect(const void *test_data)
 	struct test_data *data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 	const struct rfcomm_client_data *cli = data->test_data;
-	const uint8_t *client_addr, *master_addr;
+	const uint8_t *client_addr, *central_addr;
 	GIOChannel *io;
 	int sk;
 
@@ -542,10 +542,10 @@ static void test_connect(const void *test_data)
 	bthost_add_rfcomm_server(bthost, cli->server_channel,
 						rfcomm_connect_cb, NULL);
 
-	master_addr = hciemu_get_central_bdaddr(data->hciemu);
+	central_addr = hciemu_get_central_bdaddr(data->hciemu);
 	client_addr = hciemu_get_client_bdaddr(data->hciemu);
 
-	sk = create_rfcomm_sock((bdaddr_t *) master_addr, 0);
+	sk = create_rfcomm_sock((bdaddr_t *) central_addr, 0);
 
 	if (connect_rfcomm_sock(sk, (const bdaddr_t *) client_addr,
 					cli->client_channel) < 0) {
@@ -675,14 +675,14 @@ static void test_server(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct rfcomm_server_data *srv = data->test_data;
-	const uint8_t *master_addr;
+	const uint8_t *central_addr;
 	struct bthost *bthost;
 	GIOChannel *io;
 	int sk;
 
-	master_addr = hciemu_get_central_bdaddr(data->hciemu);
+	central_addr = hciemu_get_central_bdaddr(data->hciemu);
 
-	sk = create_rfcomm_sock((bdaddr_t *) master_addr, srv->server_channel);
+	sk = create_rfcomm_sock((bdaddr_t *) central_addr, srv->server_channel);
 	if (sk < 0) {
 		tester_test_failed();
 		return;
@@ -707,7 +707,7 @@ static void test_server(const void *test_data)
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_connect_cb(bthost, client_new_conn, data);
 
-	bthost_hci_connect(bthost, master_addr, BDADDR_BREDR);
+	bthost_hci_connect(bthost, central_addr, BDADDR_BREDR);
 }
 
 #define test_rfcomm(name, data, setup, func) \
diff --git a/tools/rfcomm.c b/tools/rfcomm.c
index 7ad7ca5ad6..51b397b6ef 100644
--- a/tools/rfcomm.c
+++ b/tools/rfcomm.c
@@ -37,7 +37,7 @@ static int rfcomm_raw_tty = 0;
 static int auth = 0;
 static int encryption = 0;
 static int secure = 0;
-static int master = 0;
+static int central = 0;
 static int linger = 0;
 
 static char *rfcomm_state[] = {
@@ -434,7 +434,7 @@ static void cmd_listen(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv
 	}
 
 	lm = 0;
-	if (master)
+	if (central)
 		lm |= RFCOMM_LM_CENTRAL;
 	if (auth)
 		lm |= RFCOMM_LM_AUTH;
@@ -646,7 +646,7 @@ static void usage(void)
 		"\t-A, --auth                     Enable authentication\n"
 		"\t-E, --encrypt                  Enable encryption\n"
 		"\t-S, --secure                   Secure connection\n"
-		"\t-M, --master                   Become the master of a piconet\n"
+		"\t-C, --central                  Become the central of a piconet\n"
 		"\t-L, --linger [seconds]         Set linger timeout\n"
 		"\t-a                             Show all devices (default)\n"
 		"\n");
@@ -668,7 +668,7 @@ static struct option main_options[] = {
 	{ "auth",	0, 0, 'A' },
 	{ "encrypt",	0, 0, 'E' },
 	{ "secure",	0, 0, 'S' },
-	{ "master",	0, 0, 'M' },
+	{ "central",	0, 0, 'C' },
 	{ "linger",	1, 0, 'L' },
 	{ 0, 0, 0, 0 }
 };
@@ -680,7 +680,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt = getopt_long(argc, argv, "+i:rahAESML:", main_options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "+i:rahAESCL:", main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'i':
 			if (strncmp(optarg, "hci", 3) == 0)
@@ -713,8 +713,8 @@ int main(int argc, char *argv[])
 			secure = 1;
 			break;
 
-		case 'M':
-			master = 1;
+		case 'C':
+			central = 1;
 			break;
 
 		case 'L':
diff --git a/tools/rfcomm.rst b/tools/rfcomm.rst
index 3c1b8cd682..cd5daa674d 100644
--- a/tools/rfcomm.rst
+++ b/tools/rfcomm.rst
@@ -47,7 +47,7 @@ OPTIONS
 
 -S     Secure connection
 
--M     Become the master of a piconet
+-C     Become the central of a piconet
 
 -L <seconds>    Set linger timeout
 
diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 7c83aee195..3e7bfc5e3a 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -413,7 +413,7 @@ end:
 
 static int create_sco_sock(struct test_data *data)
 {
-	const uint8_t *master_bdaddr;
+	const uint8_t *central_bdaddr;
 	struct sockaddr_sco addr;
 	int sk, err;
 
@@ -426,15 +426,15 @@ static int create_sco_sock(struct test_data *data)
 		return err;
 	}
 
-	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
-	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
+	central_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+	if (!central_bdaddr) {
+		tester_warn("No central bdaddr");
 		return -ENODEV;
 	}
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sco_family = AF_BLUETOOTH;
-	bacpy(&addr.sco_bdaddr, (void *) master_bdaddr);
+	bacpy(&addr.sco_bdaddr, (void *) central_bdaddr);
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		err = -errno;
diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index b075c5df8a..16fe0dfd7a 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -765,11 +765,11 @@ static void smp_new_conn(uint16_t handle, void *user_data)
 
 static void init_bdaddr(struct test_data *data)
 {
-	const uint8_t *master_bdaddr, *client_bdaddr;
+	const uint8_t *central_bdaddr, *client_bdaddr;
 
-	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
-	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
+	central_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+	if (!central_bdaddr) {
+		tester_warn("No central bdaddr");
 		tester_test_failed();
 		return;
 	}
@@ -786,9 +786,9 @@ static void init_bdaddr(struct test_data *data)
 
 	if (data->out) {
 		memcpy(data->ia, client_bdaddr, sizeof(data->ia));
-		memcpy(data->ra, master_bdaddr, sizeof(data->ra));
+		memcpy(data->ra, central_bdaddr, sizeof(data->ra));
 	} else {
-		memcpy(data->ia, master_bdaddr, sizeof(data->ia));
+		memcpy(data->ia, central_bdaddr, sizeof(data->ia));
 		memcpy(data->ra, client_bdaddr, sizeof(data->ra));
 	}
 }
-- 
2.33.0.259.gc128427fd7-goog

