Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 1/6] android/ipc: Remove not needed include
Date: Mon, 30 Dec 2013 11:17:22 +0100
Message-ID: <1388398647-25420-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1388398647-25420-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1388398647-25420-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/ipc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/ipc.c b/android/ipc.c
index 6f940cd..9e8ccc3 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -32,7 +32,6 @@
 #include <signal.h>
 #include <stdbool.h>
 #include <sys/socket.h>
-#include <sys/socket.h>
 #include <sys/un.h>
 #include <unistd.h>
 #include <glib.h>
-- 
1.8.4

