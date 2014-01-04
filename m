Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 12/12] android/system-emulator: Remove useless "static" qualifier
Date: Fri,  3 Jan 2014 21:55:28 -0400
Message-Id: <1388800528-10699-13-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The value of SYSTEM_SOCKET_PATH is just copied to another memory
location using memcpy() (on the same function), therefore the static
qualifier is unnecessary.
---
 android/system-emulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/system-emulator.c b/android/system-emulator.c
index 2dc9ad8..f1c6622 100644
--- a/android/system-emulator.c
+++ b/android/system-emulator.c
@@ -185,8 +185,7 @@ static void signal_callback(int signum, void *user_data)
 
 int main(int argc, char *argv[])
 {
-	static const char SYSTEM_SOCKET_PATH[] = "\0android_system";
-
+	const char SYSTEM_SOCKET_PATH[] = "\0android_system";
 	sigset_t mask;
 	struct sockaddr_un addr;
 	int fd;
-- 
1.8.3.2

