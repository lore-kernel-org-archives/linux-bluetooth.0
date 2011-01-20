Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Fix uninitialized struct sockaddr_hci memory passed to bind()
Date: Thu, 20 Jan 2011 17:02:48 -0400
Message-Id: <1295557368-9737-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The bind() call in open_socket() was passing a struct sockaddr_hci to
bind() with two uninitialized bytes. This caused "Invalid argument" errors
on kernels which do strict checks of struct sockaddr_hci fields.
---
 src/hcidump.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/hcidump.c b/src/hcidump.c
index b8eb1e4..97aae5d 100644
--- a/src/hcidump.c
+++ b/src/hcidump.c
@@ -603,6 +603,7 @@ static int open_socket(int dev, unsigned long flags)
 	}
 
 	/* Bind socket to the HCI device */
+	memset(&addr, 0, sizeof(addr));
 	addr.hci_family = AF_BLUETOOTH;
 	addr.hci_dev = dev;
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-- 
1.7.0.4

