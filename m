Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] lib/bnep: Update bnep header with BNEPGETSUPPFEAT and setup response
Date: Tue, 12 May 2015 12:23:30 +0200
Message-Id: <1431426211-9916-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates bnep header with get bnep supported features ioctl
and bnep setup response flag.
---
 lib/bnep.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bnep.h b/lib/bnep.h
index aa46852..e7c2c87 100644
--- a/lib/bnep.h
+++ b/lib/bnep.h
@@ -126,6 +126,9 @@ struct bnep_ext_hdr {
 #define BNEPCONNDEL	_IOW('B', 201, int)
 #define BNEPGETCONNLIST	_IOR('B', 210, int)
 #define BNEPGETCONNINFO	_IOR('B', 211, int)
+#define BNEPGETSUPPFEAT	_IOR('B', 212, int)
+
+#define BNEP_SETUP_RESPONSE	0
 
 struct bnep_connadd_req {
 	int      sock;		/* Connected socket */
-- 
2.1.0

