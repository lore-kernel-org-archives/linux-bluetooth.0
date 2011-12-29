Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] Fix strict-aliasing rules handling for hciemu and IP ports
Date: Thu, 29 Dec 2011 14:41:08 -0400
Message-Id: <1325184068-30979-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix is based on commit 97046eaf3fc44b4451157b1a1bbc166ab0f4dda8.
---

Due to some recent change, gcc 4.4.3 (from Ubuntu 10.04) started complaining
about this code:

test/hciemu.c: In function ‘hci_host_control’:
test/hciemu.c:431: error: dereferencing pointer ‘({anonymous})’ does break
strict-aliasing rules
test/hciemu.c:431: note: initialized from here


 test/hciemu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/hciemu.c b/test/hciemu.c
index ccd6cc3..7eb8814 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -428,7 +428,7 @@ static int scan_enable(uint8_t *data)
 	baswap(&ba, &vdev.bdaddr);
 	sa.sin_family = AF_INET;
 	memcpy(&sa.sin_addr.s_addr, &ba, sizeof(sa.sin_addr.s_addr));
-	sa.sin_port = *(uint16_t *) &ba.b[4];
+	memcpy(&sa.sin_port, &ba.b[4], sizeof(sa.sin_port));
 	if (bind(sk, (struct sockaddr *) &sa, sizeof(sa))) {
 		syslog(LOG_ERR, "Can't bind socket: %s (%d)",
 						strerror(errno), errno);
@@ -541,7 +541,7 @@ do_connect:
 	baswap(&ba, &cp->bdaddr);
 	sa.sin_family = AF_INET;
 	memcpy(&sa.sin_addr.s_addr, &ba, sizeof(sa.sin_addr.s_addr));
-	sa.sin_port = *(uint16_t *) &ba.b[4];
+	memcpy(&sa.sin_port, &ba.b[4], sizeof(sa.sin_port));
 	if (connect(sk, (struct sockaddr *) &sa, sizeof(sa)) < 0) {
 		syslog(LOG_ERR, "Can't connect: %s (%d)",
 						strerror(errno), errno);
-- 
1.7.0.4

