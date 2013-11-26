Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/haltest: trivial: Fix typo channle -> channel
Date: Tue, 26 Nov 2013 15:47:04 +0200
Message-Id: <1385473625-14266-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/client/if-sock.c b/android/client/if-sock.c
index eef9a76..12ac755 100644
--- a/android/client/if-sock.c
+++ b/android/client/if-sock.c
@@ -328,9 +328,9 @@ static void connect_p(int argc, const char **argv)
 /* Methods available in btsock_interface_t */
 static struct method methods[] = {
 	STD_METHODCH(listen,
-			"<sock_type> <srvc_name> <uuid> [<channle>] [<flags>]"),
+			"<sock_type> <srvc_name> <uuid> [<channel>] [<flags>]"),
 	STD_METHODCH(connect,
-			"<addr> <sock_type> <uuid> <channle> [<flags>]"),
+			"<addr> <sock_type> <uuid> <channel> [<flags>]"),
 	END_METHOD
 };
 
-- 
1.8.3.2

