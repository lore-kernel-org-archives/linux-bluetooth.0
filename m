Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH] Fix some error messages in A2DP Source functions.
Date: Thu,  4 Jun 2009 11:36:54 -0300
Message-Id: <1244126214-15714-1-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make the messages text refer to correct function that lead to the error.
---
 audio/a2dp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 0d2c78d..2c4d047 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1448,7 +1448,7 @@ unsigned int a2dp_source_resume(struct avdtp *session, struct a2dp_sep *sep,
 			g_idle_add((GSourceFunc) finalize_resume, setup);
 		break;
 	default:
-		error("SEP in bad state");
+		error("SEP in bad state for resume");
 		goto failed;
 	}
 
@@ -1499,7 +1499,7 @@ unsigned int a2dp_source_suspend(struct avdtp *session, struct a2dp_sep *sep,
 		}
 		break;
 	default:
-		error("SEP in bad state for resume");
+		error("SEP in bad state for suspend");
 		goto failed;
 	}
 
-- 
1.6.0.4

