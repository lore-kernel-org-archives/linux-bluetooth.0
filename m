Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 13/20] audio/avdtp: Add finalize_discovery() on unref
Date: Fri, 27 Feb 2015 17:03:01 +0200
Message-Id: <1425049388-18333-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/audio/avdtp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 4361e23..6132c13 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1217,6 +1217,8 @@ void avdtp_unref(struct avdtp *session)
 	if (session->ref > 0)
 		return;
 
+	finalize_discovery(session, ECONNABORTED);
+
 	set_disconnect_timer(session);
 }
 
-- 
2.1.0

