Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3F0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2190361179
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhIOIeT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbhIOIeN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 04:34:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07921C061764
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:32:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y134-20020a25dc8c000000b0059f0301df0fso2598483ybe.21
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ncXsIu1QmamRg6s0hXCJsyHRu3fTjFRSiCoJFPhGjFs=;
        b=ozKXcm3bZBfKo1p6BfvFAMauhCuQsmDhAhanbWKT7wkeVtYhMZKvkwgWi0SnfoERNH
         H+fOY1qNAaLts6JG220wDRgmkGf8FFLNvxIxziMEa045a5VoBiEJXQ3eXL2CVggRhdHV
         8Lr9Pl111kQEKrIFA4XYm30gk+h5LnfRvP0ymOMqytiNjoWT4o8lcu9vmiC7simHIil/
         Bt/j2fhzz6vBxiP2luWFvY9fTXbRyb+Y7iDj2vwIj0JTUPy+kt7vhYI5uQw8Pcug7dvh
         ZGutCxlSEAIT9HBFq0K8tLDVrIywXctGzhFSbBD7Z2pt6yFuz5jccQtzTjTDuPcu7bfT
         Ia0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ncXsIu1QmamRg6s0hXCJsyHRu3fTjFRSiCoJFPhGjFs=;
        b=lvhJ9Itbu0bkHgPHDlNiQDoLqWLJ8Z9sVlb6iSzKrzfD32IriZwSRu/W0rWv/vSrqE
         zT8wJCAUmibXrT9gefFXDzK00MnKsJi+TOTUSQ8LaDHIpizZWaTwg4mFZElZtsNcQINx
         PlQS7FPtFHghG01qztmeFGsalRF7V/XVY3lQdSNtwBTEzjhSiVsQJhU2Vj37O/HZN7uC
         SEQLaibS+IWwI5rHtJapLpNLfNOT6i43vukOxkJvTcISbek77HHaNEO70Q/Xmc7rIQfO
         nuU49ZLGxlkee0QhlyW03uCuhcoftCW+2CbLd48knGnZgBAE1aOc1VJAZVjU9fbBh60J
         SfCw==
X-Gm-Message-State: AOAM532FG63YiPD6tEh97jbR2zhhAzOY1JVy3xGEm4eQluZxuEMv2VBc
        XnkLpLyrdciGsRBXcDCE2vvgd8q0oyReokAMmz+H1heeBMw75KYz8xHgBlgwXTMeYGsuyAOxXV/
        f2RxTlHm+qdEtu/CIzPQ0AdCMRb2qg94hPicJBqJ10ZXYPPX7lVFauYJvvveGwOs+oJsR2mcHh/
        MP
X-Google-Smtp-Source: ABdhPJzhSpUG54ZS52u2mE3C/ZQ9ty1RRVSR53HByg38M2bp0RGxTP5M4GqEnqV7xAMnJ3JUr8O0uwEitz3n
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3c6b:8053:7e45:276b])
 (user=apusaka job=sendgmr) by 2002:a25:9a09:: with SMTP id
 x9mr4836847ybn.157.1631694772247; Wed, 15 Sep 2021 01:32:52 -0700 (PDT)
Date:   Wed, 15 Sep 2021 16:31:59 +0800
In-Reply-To: <20210915083207.243957-1-apusaka@google.com>
Message-Id: <20210915162843.Bluez.v5.5.I700d72f935b48346f2e74088152eeef41dc5b938@changeid>
Mime-Version: 1.0
References: <20210915083207.243957-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [Bluez PATCH v5 05/13] tools: Inclusive language changes
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

Changes in v5:
* Support the original term as input parameter for tools
* Split input parameters changes as a separate patch

Changes in v4:
* Aggresively fix line over 80 columns

Changes in v2:
* Merging several patches from the same directory into one

 tools/3dsp.c               |  33 +++++----
 tools/bdaddr.rst           |   2 +-
 tools/btiotest.c           |  20 ++---
 tools/btpclientctl.c       |   2 +-
 tools/hci-tester.c         |  12 +--
 tools/hciconfig.c          | 148 ++++++++++++++++++++++++-------------
 tools/hciconfig.rst        |  24 +++---
 tools/hcitool.c            |  16 ++--
 tools/l2cap-tester.c       |  24 +++---
 tools/l2test.c             |  10 +--
 tools/mesh-cfgclient.c     |   4 +-
 tools/mesh-gatt/mesh-net.h |   4 +-
 tools/mesh-gatt/net.c      |  60 +++++++--------
 tools/mesh/mesh-db.c       |  17 ++---
 tools/mesh/mesh-db.h       |   4 +-
 tools/mesh/remote.c        |  53 +++++++------
 tools/mesh/remote.h        |   5 +-
 tools/meshctl.c            |   6 +-
 tools/mgmt-tester.c        | 120 +++++++++++++++---------------
 tools/oobtest.c            |   8 +-
 tools/parser/avdtp.c       |  11 ++-
 tools/parser/csr.c         |  17 +++--
 tools/parser/ericsson.c    |   2 +-
 tools/parser/hci.c         |  38 +++++-----
 tools/parser/lmp.c         | 112 ++++++++++++++--------------
 tools/parser/parser.h      |   2 +-
 tools/parser/smp.c         |  12 +--
 tools/rctest.c             |  13 ++--
 tools/rctest.rst           |   2 +-
 tools/rfcomm-tester.c      |  14 ++--
 tools/rfcomm.c             |   9 ++-
 tools/rfcomm.rst           |   2 +-
 tools/sco-tester.c         |  10 +--
 tools/smp-tester.c         |  12 +--
 34 files changed, 439 insertions(+), 389 deletions(-)

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
index 3f4900a5a5..4bbe088bc3 100644
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
@@ -576,7 +576,7 @@ static GOptionEntry options[] = {
 				"Disconnect connection after N seconds" },
 	{ "accept", 'a', 0, G_OPTION_ARG_INT, &opt_accept,
 				"Accept connection after N seconds" },
-	{ "master", 'm', 0, G_OPTION_ARG_NONE, &opt_master,
+	{ "master", 'm', 0, G_OPTION_ARG_NONE, &opt_central,
 				"Master role switch (incoming connections)" },
 	{ "priority", 'P', 0, G_OPTION_ARG_INT, &opt_priority,
 				"Transmission priority: Setting a priority "
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
index 491f216135..e4d5215833 100644
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
 
@@ -1886,50 +1886,92 @@ static struct {
 	char *opt;
 	char *doc;
 } command[] = {
-	{ "up",		cmd_up,		0,		"Open and initialize HCI device" },
-	{ "down",	cmd_down,	0,		"Close HCI device" },
-	{ "reset",	cmd_reset,	0,		"Reset HCI device" },
-	{ "rstat",	cmd_rstat,	0,		"Reset statistic counters" },
-	{ "auth",	cmd_auth,	0,		"Enable Authentication" },
-	{ "noauth",	cmd_auth,	0,		"Disable Authentication" },
-	{ "encrypt",	cmd_encrypt,	0,		"Enable Encryption" },
-	{ "noencrypt",	cmd_encrypt,	0,		"Disable Encryption" },
-	{ "piscan",	cmd_scan,	0,		"Enable Page and Inquiry scan" },
-	{ "noscan",	cmd_scan,	0,		"Disable scan" },
-	{ "iscan",	cmd_scan,	0,		"Enable Inquiry scan" },
-	{ "pscan",	cmd_scan,	0,		"Enable Page scan" },
-	{ "ptype",	cmd_ptype,	"[type]",	"Get/Set default packet type" },
-	{ "lm",		cmd_lm,		"[mode]",	"Get/Set default link mode"   },
-	{ "lp",		cmd_lp,		"[policy]",	"Get/Set default link policy" },
-	{ "name",	cmd_name,	"[name]",	"Get/Set local name" },
-	{ "class",	cmd_class,	"[class]",	"Get/Set class of device" },
-	{ "voice",	cmd_voice,	"[voice]",	"Get/Set voice setting" },
-	{ "iac",	cmd_iac,	"[iac]",	"Get/Set inquiry access code" },
-	{ "inqtpl",	cmd_inq_tpl,	"[level]",	"Get/Set inquiry transmit power level" },
-	{ "inqmode",	cmd_inq_mode,	"[mode]",	"Get/Set inquiry mode" },
-	{ "inqdata",	cmd_inq_data,	"[data]",	"Get/Set inquiry data" },
-	{ "inqtype",	cmd_inq_type,	"[type]",	"Get/Set inquiry scan type" },
-	{ "inqparms",	cmd_inq_parms,	"[win:int]",	"Get/Set inquiry scan window and interval" },
-	{ "pageparms",	cmd_page_parms,	"[win:int]",	"Get/Set page scan window and interval" },
-	{ "pageto",	cmd_page_to,	"[to]",		"Get/Set page timeout" },
-	{ "afhmode",	cmd_afh_mode,	"[mode]",	"Get/Set AFH mode" },
-	{ "sspmode",	cmd_ssp_mode,	"[mode]",	"Get/Set Simple Pairing Mode" },
-	{ "aclmtu",	cmd_aclmtu,	"<mtu:pkt>",	"Set ACL MTU and number of packets" },
-	{ "scomtu",	cmd_scomtu,	"<mtu:pkt>",	"Set SCO MTU and number of packets" },
-	{ "delkey",	cmd_delkey,	"<bdaddr>",	"Delete link key from the device" },
-	{ "oobdata",	cmd_oob_data,	0,		"Get local OOB data" },
-	{ "commands",	cmd_commands,	0,		"Display supported commands" },
-	{ "features",	cmd_features,	0,		"Display device features" },
-	{ "version",	cmd_version,	0,		"Display version information" },
-	{ "revision",	cmd_revision,	0,		"Display revision information" },
-	{ "block",	cmd_block,	"<bdaddr>",	"Add a device to the blacklist" },
-	{ "unblock",	cmd_unblock,	"<bdaddr>",	"Remove a device from the blacklist" },
-	{ "lerandaddr", cmd_le_addr,	"<bdaddr>",	"Set LE Random Address" },
-	{ "leadv",	cmd_le_adv,	"[type]",	"Enable LE advertising"
+	{ "up",		cmd_up,		0,
+		"Open and initialize HCI device" },
+	{ "down",	cmd_down,	0,
+		"Close HCI device" },
+	{ "reset",	cmd_reset,	0,
+		"Reset HCI device" },
+	{ "rstat",	cmd_rstat,	0,
+		"Reset statistic counters" },
+	{ "auth",	cmd_auth,	0,
+		"Enable Authentication" },
+	{ "noauth",	cmd_auth,	0,
+		"Disable Authentication" },
+	{ "encrypt",	cmd_encrypt,	0,
+		"Enable Encryption" },
+	{ "noencrypt",	cmd_encrypt,	0,
+		"Disable Encryption" },
+	{ "piscan",	cmd_scan,	0,
+		"Enable Page and Inquiry scan" },
+	{ "noscan",	cmd_scan,	0,
+		"Disable scan" },
+	{ "iscan",	cmd_scan,	0,
+		"Enable Inquiry scan" },
+	{ "pscan",	cmd_scan,	0,
+		"Enable Page scan" },
+	{ "ptype",	cmd_ptype,	"[type]",
+		"Get/Set default packet type" },
+	{ "lm",		cmd_lm,		"[mode]",
+		"Get/Set default link mode"   },
+	{ "lp",		cmd_lp,		"[policy]",
+		"Get/Set default link policy" },
+	{ "name",	cmd_name,	"[name]",
+		"Get/Set local name" },
+	{ "class",	cmd_class,	"[class]",
+		"Get/Set class of device" },
+	{ "voice",	cmd_voice,	"[voice]",
+		"Get/Set voice setting" },
+	{ "iac",	cmd_iac,	"[iac]",
+		"Get/Set inquiry access code" },
+	{ "inqtpl",	cmd_inq_tpl,	"[level]",
+		"Get/Set inquiry transmit power level" },
+	{ "inqmode",	cmd_inq_mode,	"[mode]",
+		"Get/Set inquiry mode" },
+	{ "inqdata",	cmd_inq_data,	"[data]",
+		"Get/Set inquiry data" },
+	{ "inqtype",	cmd_inq_type,	"[type]",
+		"Get/Set inquiry scan type" },
+	{ "inqparms",	cmd_inq_parms,	"[win:int]",
+		"Get/Set inquiry scan window and interval" },
+	{ "pageparms",	cmd_page_parms,	"[win:int]",
+		"Get/Set page scan window and interval" },
+	{ "pageto",	cmd_page_to,	"[to]",
+		"Get/Set page timeout" },
+	{ "afhmode",	cmd_afh_mode,	"[mode]",
+		"Get/Set AFH mode" },
+	{ "sspmode",	cmd_ssp_mode,	"[mode]",
+		"Get/Set Simple Pairing Mode" },
+	{ "aclmtu",	cmd_aclmtu,	"<mtu:pkt>",
+		"Set ACL MTU and number of packets" },
+	{ "scomtu",	cmd_scomtu,	"<mtu:pkt>",
+		"Set SCO MTU and number of packets" },
+	{ "delkey",	cmd_delkey,	"<bdaddr>",
+		"Delete link key from the device" },
+	{ "oobdata",	cmd_oob_data,	0,
+		"Get local OOB data" },
+	{ "commands",	cmd_commands,	0,
+		"Display supported commands" },
+	{ "features",	cmd_features,	0,
+		"Display device features" },
+	{ "version",	cmd_version,	0,
+		"Display version information" },
+	{ "revision",	cmd_revision,	0,
+		"Display revision information" },
+	{ "block",	cmd_block,	"<bdaddr>",
+		"Add a device to the reject list" },
+	{ "unblock",	cmd_unblock,	"<bdaddr>",
+		"Remove a device from the reject list" },
+	{ "lerandaddr", cmd_le_addr,	"<bdaddr>",
+		"Set LE Random Address" },
+	{ "leadv",	cmd_le_adv,	"[type]",
+		"Enable LE advertising"
 		"\n\t\t\t0 - Connectable undirected advertising (default)"
 		"\n\t\t\t3 - Non connectable undirected advertising"},
-	{ "noleadv",	cmd_no_le_adv,	0,		"Disable LE advertising" },
-	{ "lestates",	cmd_le_states,	0,		"Display the supported LE states" },
+	{ "noleadv",	cmd_no_le_adv,	0,
+			"Disable LE advertising" },
+	{ "lestates",	cmd_le_states,	0,
+			"Display the supported LE states" },
 	{ NULL, NULL, 0 }
 };
 
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
index c6a9093733..ab8246e13c 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2512,7 +2512,7 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 			scan_type = 0x00; /* Passive */
 			break;
 		case 'w':
-			filter_policy = 0x01; /* Whitelist */
+			filter_policy = 0x01; /* Accept list */
 			break;
 		case 'd':
 			filter_type = optarg[0];
@@ -2708,7 +2708,7 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 			peer_bdaddr_type = LE_RANDOM_ADDRESS;
 			break;
 		case 'w':
-			initiator_filter = 0x01; /* Use white list */
+			initiator_filter = 0x01; /* Use accept list */
 			break;
 		default:
 			printf("%s", lecc_help);
@@ -2798,7 +2798,7 @@ static void cmd_lewladd(int dev_id, int argc, char **argv)
 
 	if (err < 0) {
 		err = -errno;
-		fprintf(stderr, "Can't add to white list: %s(%d)\n",
+		fprintf(stderr, "Can't add to accept list: %s(%d)\n",
 							strerror(-err), -err);
 		exit(1);
 	}
@@ -2844,7 +2844,7 @@ static void cmd_lewlrm(int dev_id, int argc, char **argv)
 
 	if (err < 0) {
 		err = errno;
-		fprintf(stderr, "Can't remove from white list: %s(%d)\n",
+		fprintf(stderr, "Can't remove from accept list: %s(%d)\n",
 							strerror(err), err);
 		exit(1);
 	}
@@ -2888,12 +2888,12 @@ static void cmd_lewlsz(int dev_id, int argc, char **argv)
 
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
 
 static struct option lewlclr_options[] = {
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
index 6e07f7b842..fbaca747ea 100644
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
 		opt |= L2CAP_LM_MASTER;
 	if (auth)
 		opt |= L2CAP_LM_AUTH;
@@ -586,7 +586,7 @@ static void do_listen(void (*handler)(int sk))
 	opt = 0;
 	if (reliable)
 		opt |= L2CAP_LM_RELIABLE;
-	if (master)
+	if (central)
 		opt |= L2CAP_LM_MASTER;
 	if (auth)
 		opt |= L2CAP_LM_AUTH;
@@ -1323,7 +1323,7 @@ static void usage(void)
 		"\t[-A] request authentication\n"
 		"\t[-E] request encryption\n"
 		"\t[-S] secure connection\n"
-		"\t[-M] become master\n"
+		"\t[-M] become central\n"
 		"\t[-T] enable timestamps\n"
 		"\t[-V type] address type (help for list, default = bredr)\n"
 		"\t[-e seq] initial sequence value (default = 0)\n");
@@ -1489,7 +1489,7 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'M':
-			master = 1;
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
index 2fdd0d4bef..e165c65ce6 100644
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
+static void setup_accept_list(void)
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
index 46f0c60751..034d7be2b5 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -1246,7 +1246,7 @@ bool mesh_db_set_iv_index(uint32_t ivi)
 	return save_config();
 }
 
-static int get_blacklisted_by_iv_index(json_object *jarray, uint32_t iv_index)
+static int get_rejected_by_iv_index(json_object *jarray, uint32_t iv_index)
 {
 	int i, cnt;
 
@@ -1268,7 +1268,7 @@ static int get_blacklisted_by_iv_index(json_object *jarray, uint32_t iv_index)
 	return -1;
 }
 
-static bool load_blacklisted(json_object *jobj)
+static bool load_rejected_addresses(json_object *jobj)
 {
 	json_object *jarray;
 	int i, cnt;
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
@@ -1328,7 +1327,7 @@ bool mesh_db_add_blacklisted_addr(uint16_t unicast, uint32_t iv_index)
 									jarray);
 	}
 
-	idx = get_blacklisted_by_iv_index(jarray, iv_index);
+	idx = get_rejected_by_iv_index(jarray, iv_index);
 
 	if (idx < 0) {
 		jobj = json_object_new_object();
@@ -1362,7 +1361,7 @@ fail:
 	return false;
 }
 
-bool mesh_db_clear_blacklisted(uint32_t iv_index)
+bool mesh_db_clear_rejected(uint32_t iv_index)
 {
 	json_object *jarray;
 	int idx;
@@ -1374,7 +1373,7 @@ bool mesh_db_clear_blacklisted(uint32_t iv_index)
 	if (!jarray || json_object_get_type(jarray) != json_type_array)
 		return false;
 
-	idx = get_blacklisted_by_iv_index(jarray, iv_index);
+	idx = get_rejected_by_iv_index(jarray, iv_index);
 	if (idx < 0)
 		return true;
 
@@ -1504,7 +1503,7 @@ bool mesh_db_load(const char *fname)
 
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
index dc53faf3af..8afd58344c 100644
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
+	test_bredrle50_full("Ext Adv. connectable & connected (peripheral)",
+				&conn_peripheral_adv_connectable_test,
 				setup_advertise_while_connected,
 				test_connected_and_advertising, 10);
 
-	test_bredrle50_full("Ext Adv. non-connectable & connected (slave) - Success",
-				&conn_slave_adv_non_conneactable_test,
+	test_bredrle50_full("Ext Adv. non-connectable & connected (peripheral)",
+				&conn_peripheral_adv_non_connectable_test,
 				setup_advertise_while_connected,
 				test_connected_and_advertising, 10);
 
-	test_bredrle50_full("Ext Adv. connectable & connected (master) - Success",
-				&conn_master_adv_conneactable_test,
+	test_bredrle50_full("Ext Adv. connectable & connected (central)",
+				&conn_central_adv_connectable_test,
 				setup_advertise_while_connected,
 				test_connected_and_advertising, 10);
 
-	test_bredrle50_full("Ext Adv. non-connectable & connected (master) - Success",
-				&conn_master_adv_non_conneactable_test,
+	test_bredrle50_full("Ext Adv. non-connectable & connected (central)",
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
index bb7bbadaba..e78cbd75ba 100644
--- a/tools/parser/avdtp.c
+++ b/tools/parser/avdtp.c
@@ -605,7 +605,7 @@ void avdtp_dump(int level, struct frame *frm)
 		nsp = (hdr & 0x0c) == 0x04 ? p_get_u8(frm) : 0;
 		sid = hdr & 0x08 ? 0x00 : p_get_u8(frm);
 
-		printf("AVDTP(s): %s %s: transaction %d nsp 0x%02x\n",
+		printf("AVDTP(p): %s %s: transaction %d nsp 0x%02x\n",
 			hdr & 0x08 ? pt2str(hdr) : si2str(sid),
 			mt2str(hdr), hdr >> 4, nsp);
 
@@ -659,9 +659,12 @@ void avdtp_dump(int level, struct frame *frm)
 		time = p_get_u32(frm);
 		ssrc = p_get_u32(frm);
 
-		printf("AVDTP(m): ver %d %s%scc %d %spt %d seqn %d time %d ssrc %d\n",
-			hdr >> 6, hdr & 0x20 ? "pad " : "", hdr & 0x10 ? "ext " : "",
-			hdr & 0xf, type & 0x80 ? "mark " : "", type & 0x7f, seqn, time, ssrc);
+		printf("AVDTP(c): ver %d %s%scc"
+			" %d %spt %d seqn %d time %d ssrc %d\n",
+			hdr >> 6, hdr & 0x20 ? "pad " : "",
+			hdr & 0x10 ? "ext " : "", hdr & 0xf,
+			type & 0x80 ? "mark " : "", type & 0x7f,
+			seqn, time, ssrc);
 		break;
 	}
 
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
index d395e37f54..db7d32c011 100644
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
 	master_link_key_cp *cp = frm->ptr;
 
@@ -1638,9 +1638,10 @@ static inline void le_set_scan_parameters_dump(int level, struct frame *frm)
 
 	p_indent(level, frm);
 	printf("own address: 0x%02x (%s) policy: %s\n", cp->own_bdaddr_type,
-			bdaddrtype2str(cp->own_bdaddr_type),
+		bdaddrtype2str(cp->own_bdaddr_type),
 		(cp->filter == 0x00 ? "All" :
-			(cp->filter == 0x01 ? "white list only" : "reserved")));
+			(cp->filter == 0x01 ? "accept list only" :
+			"reserved")));
 }
 
 static inline void le_set_scan_enable_dump(int level, struct frame *frm)
@@ -1772,7 +1773,7 @@ static inline void command_dump(int level, struct frame *frm)
 			generic_command_dump(level + 1, frm);
 			return;
 		case OCF_MASTER_LINK_KEY:
-			master_link_key_dump(level + 1, frm);
+			temporary_link_key_dump(level + 1, frm);
 			return;
 		case OCF_READ_REMOTE_EXT_FEATURES:
 			read_remote_ext_features_dump(level + 1, frm);
@@ -3114,7 +3115,8 @@ static inline void remote_name_req_complete_dump(int level, struct frame *frm)
 	}
 }
 
-static inline void master_link_key_complete_dump(int level, struct frame *frm)
+static inline void temporary_link_key_complete_dump(int level,
+							struct frame *frm)
 {
 	evt_master_link_key_complete *evt = frm->ptr;
 
@@ -3565,7 +3567,7 @@ static inline void evt_le_conn_complete_dump(int level, struct frame *frm)
 	p_indent(level, frm);
 	printf("status 0x%2.2x handle %d, role %s\n",
 					evt->status, btohs(evt->handle),
-					evt->role ? "slave" : "master");
+					evt->role ? "peripheral" : "central");
 
 	p_indent(level, frm);
 	p_ba2str(&evt->peer_bdaddr, addr);
@@ -3875,7 +3877,7 @@ static inline void event_dump(int level, struct frame *frm)
 		generic_response_dump(level + 1, frm);
 		break;
 	case EVT_MASTER_LINK_KEY_COMPLETE:
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
index 7d688691c4..9eb8210d6e 100644
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
 		opt |= RFCOMM_LM_MASTER;
 	if (auth)
 		opt |= RFCOMM_LM_AUTH;
@@ -293,7 +293,7 @@ static void do_listen(void (*handler)(int sk))
 
 	/* Set link mode */
 	opt = 0;
-	if (master)
+	if (central)
 		opt |= RFCOMM_LM_MASTER;
 	if (auth)
 		opt |= RFCOMM_LM_AUTH;
@@ -685,7 +685,7 @@ static void usage(void)
 		"\t[-A] request authentication\n"
 		"\t[-E] request encryption\n"
 		"\t[-S] secure connection\n"
-		"\t[-M] become master\n"
+		"\t[-M] become central\n"
 		"\t[-T] enable timestamps\n");
 }
 
@@ -697,7 +697,8 @@ int main(int argc, char *argv[])
 	bacpy(&bdaddr, BDADDR_ANY);
 	bacpy(&auto_bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmna:b:i:P:U:B:O:N:MAESL:W:C:D:Y:T")) != EOF) {
+	while ((opt = getopt(argc, argv,
+			"rdscuwmna:b:i:P:U:B:O:N:MAESL:W:C:D:Y:T")) != EOF) {
 		switch (opt) {
 		case 'r':
 			mode = RECV;
@@ -770,7 +771,7 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'M':
-			master = 1;
+			central = 1;
 			break;
 
 		case 'A':
diff --git a/tools/rctest.rst b/tools/rctest.rst
index 23595112d7..0e78e09af6 100644
--- a/tools/rctest.rst
+++ b/tools/rctest.rst
@@ -66,7 +66,7 @@ OPTIONS
 
 -S              secure connection
 
--M              become master
+-M              become central
 
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
index 8e1db8ebaa..d7d9713271 100644
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
 		lm |= RFCOMM_LM_MASTER;
 	if (auth)
 		lm |= RFCOMM_LM_AUTH;
@@ -680,7 +680,8 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt = getopt_long(argc, argv, "+i:rahAESML:", main_options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "+i:rahAESML:", main_options,
+								NULL)) != -1) {
 		switch(opt) {
 		case 'i':
 			if (strncmp(optarg, "hci", 3) == 0)
@@ -714,7 +715,7 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'M':
-			master = 1;
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
index 6e7cf6843f..8a40cd2736 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -517,7 +517,7 @@ end:
 
 static int create_sco_sock(struct test_data *data)
 {
-	const uint8_t *master_bdaddr;
+	const uint8_t *central_bdaddr;
 	struct sockaddr_sco addr;
 	int sk, err;
 
@@ -530,15 +530,15 @@ static int create_sco_sock(struct test_data *data)
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
2.33.0.464.g1972c5931b-goog

