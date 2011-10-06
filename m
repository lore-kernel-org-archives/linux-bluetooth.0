Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 1/2] make struct features available for others
Date: Thu,  6 Oct 2011 16:38:11 +0300
Message-Id: <1317908292-29104-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 parser/l2cap.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index c2ac10e..c975374 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -61,10 +61,12 @@ static cid_info cid_table[2][CID_TABLE_SIZE];
 #define DCID cid_table[1]
 
 /* Can we move this to l2cap.h? */
-static struct {
+struct features {
 	char	*name;
 	int	flag;
-} l2cap_features[] = {
+};
+
+static struct features l2cap_features[] = {
 	{ "Flow control mode",			L2CAP_FEAT_FLOWCTL	},
 	{ "Retransmission mode",		L2CAP_FEAT_RETRANS	},
 	{ "Bi-directional QoS",			L2CAP_FEAT_BIDIR_QOS	},
-- 
1.7.4.1

