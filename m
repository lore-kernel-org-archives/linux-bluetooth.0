Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 hcidump 2/3] add fixed channel definitions
Date: Wed, 12 Oct 2011 11:31:35 +0300
Message-Id: <1318408296-28840-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318408296-28840-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318408296-28840-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 lib/l2cap.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/lib/l2cap.h b/lib/l2cap.h
index 47b3dc3..3880551 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -139,6 +139,11 @@ struct l2cap_conninfo {
 
 #define L2CAP_SDULEN_SIZE	2
 
+/* L2CAP fixed channels */
+#define L2CAP_FC_L2CAP		0x02
+#define L2CAP_FC_CONNLESS	0x04
+#define L2CAP_FC_A2MP		0x08
+
 /* L2CAP structures */
 typedef struct {
 	uint16_t	len;
-- 
1.7.4.1

