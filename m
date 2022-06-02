Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9341EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 15:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiFBP01 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 11:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiFBP01 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 11:26:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144BA1D5026
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 08:26:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: fdanis)
        with ESMTPSA id 7D7E11F450B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654183584;
        bh=BFxFHUombTlOVN38ZDaHX/rcjZm0FSBIBZ4FgJ2ajAk=;
        h=From:To:Subject:Date:From;
        b=BweyZEnrrCkY7/n4Se3GG6ftpmej2e5TZ8RLEogflu60bOsRuqmOr9Q3UxE2cksr1
         7In+iH0DPghr1Whajc0vnAasWb2ee3SXzgPUKm8TQUaRt8mihsdQfPMw5cZEcddN6X
         XOvytKEJ9HAepMwV3NG5fgnMujp6PeFkTEbUCQ7uQsry+kk9eyB/xs7swHg0ycbARp
         pO0aNd2t5NcbttCkpjadoomOpwCh+/eMQFCGXWT1BMrG9sJov+g0WXYfn7+VdwW3DP
         T9g+vadpzay65jV1jH2KLpnrFts1hTQDJvcgu3HFeRUb34zwVKpPLmgekIGF8dGAk0
         0ExWlzRU7p3BQ==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] btproxy: Allow to select multiple BT controllers
Date:   Thu,  2 Jun 2022 17:26:13 +0200
Message-Id: <20220602152613.79718-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When running on a computer with a real Bluetooth controller (e.g. hci0) and
multiple emulators (e.g. hci1 and hci2) it isn't possible to use the
emulators with 2 test-runner vms.
If btproxy is started without index parameter the first test-runner will
use hci0, and btprox can't be started with multiple index parameters
(e.g. -i1 -i2).

This patch allows to select the controllers to be used by btproxy.
---
 tools/btproxy.c | 48 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/tools/btproxy.c b/tools/btproxy.c
index 94ca1c7fd..c09a504ff 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -48,6 +48,7 @@ struct sockaddr_hci {
 };
 #define HCI_CHANNEL_USER	1
 #define HCI_INDEX_NONE		0xffff
+#define HCI_INDEX_MAX		15
 
 static uint16_t hci_index = HCI_INDEX_NONE;
 static bool client_active = false;
@@ -533,13 +534,28 @@ static bool setup_proxy(int host_fd, bool host_shutdown,
 	return true;
 }
 
-static int open_channel(uint16_t index)
+static int get_next_hci_index(int index)
+{
+	while (++index <= HCI_INDEX_MAX) {
+		if (hci_index & (1 << index))
+			return index;
+	}
+
+	return -1;
+}
+
+static int open_channel(int index)
 {
 	struct sockaddr_hci addr;
 	int fd, err;
 
-	if (index == HCI_INDEX_NONE)
-		index = 0;
+	if (index == HCI_INDEX_NONE) {
+		index = get_next_hci_index(-1);
+		if (index < 0) {
+			perror("No controller available");
+			return -1;
+		}
+	}
 
 	printf("Opening user channel for hci%u\n", index);
 
@@ -561,9 +577,10 @@ static int open_channel(uint16_t index)
 		/* Open next available controller if no specific index was
 		 * provided and the error indicates that the controller.
 		 */
-		if (hci_index == HCI_INDEX_NONE &&
+		index = get_next_hci_index(index);
+		if (index >=0 &&
 				(err == -EBUSY || err == -EUSERS))
-			return open_channel(++index);
+			return open_channel(index);
 
 		perror("Failed to bind Bluetooth socket");
 		return -1;
@@ -601,13 +618,7 @@ static void server_callback(int fd, uint32_t events, void *user_data)
 		return;
 	}
 
-	if (client_active && hci_index != HCI_INDEX_NONE) {
-		fprintf(stderr, "Active client already present\n");
-		close(host_fd);
-		return;
-	}
-
-	dev_fd = open_channel(hci_index);
+	dev_fd = open_channel(HCI_INDEX_NONE);
 	if (dev_fd < 0) {
 		close(host_fd);
 		return;
@@ -800,6 +811,7 @@ int main(int argc, char *argv[])
 
 	for (;;) {
 		int opt;
+		int index;
 
 		opt = getopt_long(argc, argv, "rc:l::u::p:i:aezdvh",
 						main_options, NULL);
@@ -844,7 +856,15 @@ int main(int argc, char *argv[])
 				usage();
 				return EXIT_FAILURE;
 			}
-			hci_index = atoi(str);
+			index = atoi(str);
+			if (index > HCI_INDEX_MAX) {
+				fprintf(stderr, "Invalid controller index\n");
+				usage();
+				return EXIT_FAILURE;
+			}
+			if (hci_index == HCI_INDEX_NONE)
+				hci_index = 0;
+			hci_index |= 1 << index;
 			break;
 		case 'a':
 			type = HCI_AMP;
@@ -892,7 +912,7 @@ int main(int argc, char *argv[])
 		if (use_redirect) {
 			printf("Creating local redirect\n");
 
-			dev_fd = open_channel(hci_index);
+			dev_fd = open_channel(HCI_INDEX_NONE);
 		} else {
 			printf("Connecting to %s:%u\n", connect_address,
 								tcp_port);
-- 
2.25.1

