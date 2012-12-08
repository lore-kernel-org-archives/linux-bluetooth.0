Return-Path: <cyrus@holtmann.org>
From: Rami Rosen <ramirose@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	Rami Rosen <ramirose@gmail.com>
Subject: [PATCH ] Bluetooth: Remove unnecessary include l2cap.h.
Date: Sat,  8 Dec 2012 07:08:25 +0200
Message-Id: <1354943305-7069-1-git-send-email-ramirose@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes unnecessary include of <net/bluetooth/l2cap.h>
in bluetooth/bnep/core.c.

Signed-off-by: Rami Rosen <ramirose@gmail.com>
---
 net/bluetooth/bnep/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index a5b6397..e430b1a 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -33,7 +33,6 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
-#include <net/bluetooth/l2cap.h>
 
 #include "bnep.h"
 
-- 
1.7.11.7
