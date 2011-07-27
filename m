Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Definitions for hcidump to decode EFS
Date: Wed, 27 Jul 2011 12:23:25 +0300
Message-Id: <1311758605-23785-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 lib/l2cap.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/lib/l2cap.h b/lib/l2cap.h
index bc87f72..55fe88b 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -159,6 +159,8 @@ typedef struct {
 #define L2CAP_CONF_UNACCEPT	0x0001
 #define L2CAP_CONF_REJECT	0x0002
 #define L2CAP_CONF_UNKNOWN	0x0003
+#define L2CAP_CONF_PENDING	0x0004
+#define L2CAP_CONF_EFS_REJECT	0x0005
 
 typedef struct {
 	uint8_t		type;
@@ -172,6 +174,7 @@ typedef struct {
 #define L2CAP_CONF_QOS		0x03
 #define L2CAP_CONF_RFC		0x04
 #define L2CAP_CONF_FCS		0x05
+#define L2CAP_CONF_EFS		0x06
 
 #define L2CAP_CONF_MAX_SIZE	22
 
@@ -181,6 +184,10 @@ typedef struct {
 #define L2CAP_MODE_ERTM		0x03
 #define L2CAP_MODE_STREAMING	0x04
 
+#define L2CAP_SERVTYPE_NOTRAFFIC	0x00
+#define L2CAP_SERVTYPE_BESTEFFORT	0x01
+#define L2CAP_SERVTYPE_GUARANTEED	0x02
+
 typedef struct {
 	uint16_t	dcid;
 	uint16_t	scid;
-- 
1.7.4.1

