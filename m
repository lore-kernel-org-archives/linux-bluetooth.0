Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] policy: Fix not incrementing attempts
Date: Wed,  6 May 2015 17:08:54 +0300
Message-Id: <1430921334-16124-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1430921334-16124-1-git-send-email-luiz.dentz@gmail.com>
References: <1430921334-16124-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The number of attempts and intervals maybe different causing the attempts
to not be incremented properly.
---
 plugins/policy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/policy.c b/plugins/policy.c
index 7687203..6bb8268 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -683,6 +683,8 @@ static void reconnect_set_timer(struct reconnect_data *reconnect)
 {
 	static int timeout = 0;
 
+	reconnect->attempt++;
+
 	if (reconnect->attempt < reconnect_intervals_len)
 		timeout = reconnect_intervals[reconnect->attempt];
 
-- 
2.1.0

