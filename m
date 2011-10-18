Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 bluez 1/2] add definitions for L2CAP fixed channels
Date: Tue, 18 Oct 2011 11:23:10 +0300
Message-Id: <1318926191-17361-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318926191-17361-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318926191-17361-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 lib/l2cap.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/lib/l2cap.h b/lib/l2cap.h
index a40cb6c..68593d3 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -95,6 +95,11 @@ struct l2cap_conninfo {
 #define L2CAP_FEAT_EXT_WINDOW	0x00000100
 #define L2CAP_FEAT_UCD		0x00000200
 
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

