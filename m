Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] telephony-maemo6: fix not cleaning up active calls list on exit
Date: Wed, 16 Feb 2011 16:37:18 +0200
Message-Id: <1297867038-7221-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This can cause problem if the adapter is reset in the middle of a call
the indicators won't be update properly.
---
 audio/telephony-maemo6.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index dfa06d9..bf1e0c4 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -2028,6 +2028,9 @@ void telephony_exit(void)
 	g_free(last_dialed_number);
 	last_dialed_number = NULL;
 
+	g_slist_free(active_calls);
+	active_calls = NULL;
+
 	g_slist_foreach(calls, (GFunc) csd_call_free, NULL);
 	g_slist_free(calls);
 	calls = NULL;
-- 
1.7.1

