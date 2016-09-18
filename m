Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH v2 2/5] lib/mgmt: Add Set Appearance command definition
Date: Sun, 18 Sep 2016 12:34:38 +0200
Message-Id: <1474194881-10403-2-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1474194881-10403-1-git-send-email-szymon.janc@codecoup.pl>
References: <1474194881-10403-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Michał Narajowski <michal.narajowski@codecoup.pl>

---
 lib/mgmt.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 8de2616..798a05e 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -541,6 +541,11 @@ struct mgmt_rp_read_ext_info {
 	uint8_t  eir[0];
 } __packed;
 
+#define MGMT_OP_SET_APPEARANCE		0x0043
+struct mgmt_cp_set_appearance {
+	uint16_t appearance;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -827,6 +832,7 @@ static const char *mgmt_op[] = {
 	"Get Advertising Size Information",		/* 0x0040 */
 	"Start Limited Discovery",
 	"Read Extended Controller Information",
+	"Set Appearance",
 };
 
 static const char *mgmt_ev[] = {
-- 
2.7.4

