Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] input: Fix input.conf IdleTimeout handling
Message-Id: <20140404230201.5A1BB1009F7@puck.mtv.corp.google.com>
Date: Fri,  4 Apr 2014 16:02:01 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

IdleTimeout is an optional config item in input.conf. Don't complain
if it is not defined. Instead, do the opposite and show its value in
debug logs only when it is defined.
---
 profiles/input/manager.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 6ef83f4..23e739a 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -99,13 +99,12 @@ static int input_init(void)
 		int idle_timeout;
 
 		idle_timeout = g_key_file_get_integer(config, "General",
-						"IdleTimeout", &err);
-		if (err) {
-			DBG("input.conf: %s", err->message);
-			g_error_free(err);
-		}
-
-		input_set_idle_timeout(idle_timeout * 60);
+							"IdleTimeout", &err);
+		if (!err) {
+			DBG("input.conf: IdleTimeout=%d", idle_timeout);
+			input_set_idle_timeout(idle_timeout * 60);
+		} else
+			g_clear_error(&err);
 	}
 
 	btd_profile_register(&input_profile);
-- 
1.9.1.423.g4596e3a

