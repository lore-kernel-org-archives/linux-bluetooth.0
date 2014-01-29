Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/8] avctp: trivial: Do not break short line
Date: Wed, 29 Jan 2014 14:36:03 +0200
Message-Id: <1390998967-24610-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1390998967-24610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390998967-24610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/audio/avctp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 78bf1fd..570d609 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -904,8 +904,7 @@ failed:
 	return FALSE;
 }
 
-static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
-				gpointer data)
+static gboolean session_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct avctp *session = data;
 	struct avctp_channel *control = session->control;
-- 
1.8.3.2

