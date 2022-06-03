Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F3DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jun 2022 14:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiFCOzC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jun 2022 10:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiFCOy6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jun 2022 10:54:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E302939140
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jun 2022 07:54:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: fdanis)
        with ESMTPSA id B41D61F45734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654268095;
        bh=yemU3lMc3LYLi4U6FkOON5xHPf49RSlOlszwblj3jhE=;
        h=From:To:Subject:Date:From;
        b=JSqGp3NR2u2eMgTsCjnH0VXHWUc0lySW/QfWzAajd1Ci6D6hdu8CIRCmJw8sy1TiJ
         wZpfEOOlMwI5rC+wd1UiwyW6fmFI4V0BkcqsEE6+x2ibK5NjJYzxrjkXtoK1hkXn+p
         PptwBKs/n/9JiwSH1FSvowtkMWPUA1R9LdPM5yHE4LtUNNQYP/+0dJRP+mtj+ukOyb
         TGLltR2WZ4/lLviJjgDvKk4+hRX+GzIirVJCG4CJ0kpax/jLgdTisD6HArE3OIaqMQ
         LzbgT2hR7wa5ErywnAFZd6cWc6dDbpjpRtxlSuLT02m9NY+PPSn3LoYHdgWv9H5Tc1
         fS3hhywFZiAWQ==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] btproxy: Allow to select multiple BT controllers
Date:   Fri,  3 Jun 2022 16:54:47 +0200
Message-Id: <20220603145447.45655-1-frederic.danis@collabora.com>
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

This patch keeps the old beahvior when used without -i option, in this case
it will try to use the first controller available.
It also allows to select multiple controllers to be used by btproxy.
---
changes since v2:
 - replace get_next_hci_index() by util_get_uid()

 tools/btproxy.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/tools/btproxy.c b/tools/btproxy.c
index 94ca1c7fd..305ef7893 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -48,8 +48,9 @@ struct sockaddr_hci {
 };
 #define HCI_CHANNEL_USER	1
 #define HCI_INDEX_NONE		0xffff
+#define HCI_INDEX_MAX		16
 
-static uint16_t hci_index = HCI_INDEX_NONE;
+static uint64_t hci_index = HCI_INDEX_NONE;
 static bool client_active = false;
 static bool debug_enabled = false;
 static bool emulate_ecc = false;
@@ -533,13 +534,18 @@ static bool setup_proxy(int host_fd, bool host_shutdown,
 	return true;
 }
 
-static int open_channel(uint16_t index)
+static int open_channel(uint64_t hci_index)
 {
 	struct sockaddr_hci addr;
 	int fd, err;
+	uint8_t index;
 
-	if (index == HCI_INDEX_NONE)
-		index = 0;
+	index = util_get_uid(&hci_index, HCI_INDEX_MAX);
+	if (index == 0) {
+		perror("No controller available");
+		return -1;
+	}
+	index--;
 
 	printf("Opening user channel for hci%u\n", index);
 
@@ -558,12 +564,11 @@ static int open_channel(uint16_t index)
 		err = -errno;
 		close(fd);
 
-		/* Open next available controller if no specific index was
-		 * provided and the error indicates that the controller.
+		/* Open next available controller if the error indicates
+		 * that the controller is in use.
 		 */
-		if (hci_index == HCI_INDEX_NONE &&
-				(err == -EBUSY || err == -EUSERS))
-			return open_channel(++index);
+		if (err == -EBUSY || err == -EUSERS)
+			return open_channel(hci_index);
 
 		perror("Failed to bind Bluetooth socket");
 		return -1;
@@ -601,12 +606,6 @@ static void server_callback(int fd, uint32_t events, void *user_data)
 		return;
 	}
 
-	if (client_active && hci_index != HCI_INDEX_NONE) {
-		fprintf(stderr, "Active client already present\n");
-		close(host_fd);
-		return;
-	}
-
 	dev_fd = open_channel(hci_index);
 	if (dev_fd < 0) {
 		close(host_fd);
@@ -800,6 +799,7 @@ int main(int argc, char *argv[])
 
 	for (;;) {
 		int opt;
+		int index;
 
 		opt = getopt_long(argc, argv, "rc:l::u::p:i:aezdvh",
 						main_options, NULL);
@@ -844,7 +844,13 @@ int main(int argc, char *argv[])
 				usage();
 				return EXIT_FAILURE;
 			}
-			hci_index = atoi(str);
+			index = atoi(str) + 1;
+			if (index > HCI_INDEX_MAX) {
+				fprintf(stderr, "Invalid controller index\n");
+				usage();
+				return EXIT_FAILURE;
+			}
+			util_clear_uid(&hci_index, index);
 			break;
 		case 'a':
 			type = HCI_AMP;
@@ -884,6 +890,9 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
+	if (hci_index == HCI_INDEX_NONE)
+		hci_index = 0;
+
 	mainloop_init();
 
 	if (connect_address || use_redirect) {
-- 
2.25.1

