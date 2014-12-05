Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] monitor: Fix RFCOMM parity type mask
Date: Fri,  5 Dec 2014 14:48:27 +0200
Message-Id: <1417783707-3519-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <000401d01078ea58bb0bf0a310samsung.com>
References: <000401d01078ea58bb0bf0a310samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fix RFCOMM RPN parity type bit according to Spec. GSM 07.10 version
6.3.0. (PT1 - PT2 indicates the parity type).
---
	*v2: Fixed parity type bits

 monitor/rfcomm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index fe3afb7..4ba61c8 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -67,7 +67,7 @@ static char *cr_str[] = {
 #define GET_RPN_DB(parity)	(parity & 0x03)
 #define GET_RPN_SB(parity)	((parity & 0x04) >> 2)
 #define GET_RPN_PARITY(parity)	((parity & 0x08) >> 3)
-#define GET_RPN_PTYPE(parity)	((parity & 0x03) >> 3)
+#define GET_RPN_PTYPE(parity)	((parity & 0x30) >> 4)
 #define GET_RPN_XIN(io)		(io & 0x01)
 #define GET_RPN_XOUT(io)	((io & 0x02) >> 1)
 #define GET_RPN_RTRI(io)	((io & 0x04) >> 2)
-- 
1.9.1

