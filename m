Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] telephony-maemo6: fix not cleaning up network status on exit
Date: Wed, 16 Feb 2011 16:38:23 +0200
Message-Id: <1297867103-7310-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This may cause indicators to not be reported correctly when adapter is
reset.
---
 audio/telephony-maemo6.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index bf1e0c4..b0f314c 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -2025,6 +2025,9 @@ void telephony_exit(void)
 	g_free(net.operator_name);
 	net.operator_name = NULL;
 
+	net.status = NETWORK_REG_STATUS_UNKOWN;
+	net.signal_bars = 0;
+
 	g_free(last_dialed_number);
 	last_dialed_number = NULL;
 
-- 
1.7.1

