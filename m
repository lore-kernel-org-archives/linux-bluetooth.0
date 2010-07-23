Return-Path: <cyrus@holtmann.org>
From: Yuri Kululin <ext-yuri.kululin@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: ext-yuri.kululin@nokia.com
Subject: [PATCH 1/1] Bluetooth: RPN negotiation fix
Date: Fri, 23 Jul 2010 13:57:12 +0400
Message-Id: <6a577b5627b8388489a21fd49f5c9d2b85a2bbef.1279866739.git.ext-yuri.kululin@nokia.com>
In-Reply-To: <1279879032-27955-1-git-send-email-ext-yuri.kululin@nokia.com>
References: <1279879032-27955-1-git-send-email-ext-yuri.kululin@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to the ETSI 3GPP TS 07.10 the default bit rate value for RFCOMM
is 9600 bit/s. Return this bit rate in case of RPN request and accept other
sane bit rates proposed by the sender in RPM command.

Signed-off-by: Yuri Kululin <ext-yuri.kululin@nokia.com>
---
 net/bluetooth/rfcomm/core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 7dca91b..16b79f3 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1415,8 +1415,8 @@ static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_
 		return 0;
 
 	if (len == 1) {
-		/* This is a request, return default settings */
-		bit_rate  = RFCOMM_RPN_BR_115200;
+		/* This is a request, return default (according to ETSI TS 07.10) settings */
+		bit_rate  = RFCOMM_RPN_BR_9600;
 		data_bits = RFCOMM_RPN_DATA_8;
 		stop_bits = RFCOMM_RPN_STOP_1;
 		parity    = RFCOMM_RPN_PARITY_NONE;
@@ -1431,9 +1431,9 @@ static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_
 
 	if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_BITRATE)) {
 		bit_rate = rpn->bit_rate;
-		if (bit_rate != RFCOMM_RPN_BR_115200) {
+		if (bit_rate > RFCOMM_RPN_BR_230400) {
 			BT_DBG("RPN bit rate mismatch 0x%x", bit_rate);
-			bit_rate = RFCOMM_RPN_BR_115200;
+			bit_rate = RFCOMM_RPN_BR_9600;
 			rpn_mask ^= RFCOMM_RPN_PM_BITRATE;
 		}
 	}
-- 
1.7.1.1

