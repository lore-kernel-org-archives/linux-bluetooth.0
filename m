Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/2] Fix cancel pending D-Bus call to ohmd
Date: Fri,  5 Aug 2011 10:19:37 +0300
Message-Id: <1312528777-4152-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1312528777-4152-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1312528777-4152-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pending D-Bus call to ohmd daemon is canceled if telephony driver is
unloaded before reply comes.
---
 audio/telephony-maemo6.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 94feda2..86a045f 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -1533,6 +1533,8 @@ static void csd_call_free(void *data)
 	g_free(call->object_path);
 	g_free(call->number);
 
+	g_slist_foreach(pending, remove_pending_by_data, call);
+
 	g_free(call);
 }
 
-- 
1.7.4.1

