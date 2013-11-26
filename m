Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/haltest: Add uuid autocompletions
Date: Tue, 26 Nov 2013 15:47:05 +0200
Message-Id: <1385473625-14266-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385473625-14266-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385473625-14266-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-sock.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/client/if-sock.c b/android/client/if-sock.c
index 12ac755..5394a5d 100644
--- a/android/client/if-sock.c
+++ b/android/client/if-sock.c
@@ -35,6 +35,10 @@ ENDMAP
 static int listen_fd[MAX_LISTEN_FD];
 static int listen_fd_count;
 
+static const char * const uuids[] = {
+	"00001101", "00001105", "0000112f", NULL
+};
+
 /*
  * This function reads data from file descriptor and
  * prints it to the user
@@ -193,6 +197,9 @@ static void listen_c(int argc, const char **argv, enum_func *enum_func,
 	if (argc == 3) {
 		*user = TYPE_ENUM(btsock_type_t);
 		*enum_func = enum_defines;
+	} else if (argc == 5) {
+		*user = (void *) uuids;
+		*enum_func = enum_strings;
 	}
 }
 
@@ -264,6 +271,9 @@ static void connect_c(int argc, const char **argv, enum_func *enum_func,
 	} else if (argc == 4) {
 		*user = TYPE_ENUM(btsock_type_t);
 		*enum_func = enum_defines;
+	} else if (argc == 5) {
+		*user = (void *) uuids;
+		*enum_func = enum_strings;
 	}
 }
 
-- 
1.8.3.2

