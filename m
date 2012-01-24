Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v2 1/6] lib: Add Key Size information to the security information
Date: Mon, 23 Jan 2012 21:27:00 -0300
Message-Id: <1327364825-7285-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since some time the kernel has the capability to return the length of
the key that was used to encrypt the link.

This patch exposes that field to userspace so more applications can take
decisions based on this information.
---
 lib/bluetooth.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 5bd4f03..1dee6df 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -63,6 +63,7 @@ extern "C" {
 #define BT_SECURITY	4
 struct bt_security {
 	uint8_t level;
+	uint8_t key_size;
 };
 #define BT_SECURITY_SDP		0
 #define BT_SECURITY_LOW		1
-- 
1.7.8.1

