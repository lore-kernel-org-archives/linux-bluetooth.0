Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Don't set LE flags in mgmt_start_discovery()
Date: Tue, 22 Nov 2011 16:51:10 -0300
Message-Id: <1321991470-2201-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since LE based discovery procedures are not yet supported, we should
not set the LE flags in mgmt_start_discovery(). Otherwise, we might
get an error from management interface.
---
 plugins/mgmtops.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index b9e9ad6..d28f89c 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1689,8 +1689,6 @@ static int mgmt_start_discovery(int index)
 	hdr->index = htobs(index);
 
 	hci_set_bit(MGMT_ADDR_BREDR, &cp->type);
-	hci_set_bit(MGMT_ADDR_LE_PUBLIC, &cp->type);
-	hci_set_bit(MGMT_ADDR_LE_RANDOM, &cp->type);
 
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
 		return -errno;
-- 
1.7.7.1

