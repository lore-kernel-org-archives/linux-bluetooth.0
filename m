Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 2/5] Bluetooth: update L2CAP version
Date: Tue, 13 Jul 2010 11:57:12 -0300
Message-Id: <1279033035-24708-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1279033035-24708-1-git-send-email-gustavo@padovan.org>
References: <1279033035-24708-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

We did some changes on the L2CAP configuration process and its behaviour
is bit different now. That justifies a updated on the L2CAP version.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 67a6f59..cdd608d 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -54,7 +54,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 
-#define VERSION "2.14"
+#define VERSION "2.15"
 
 static int enable_ertm = 0;
 
-- 
1.7.1
