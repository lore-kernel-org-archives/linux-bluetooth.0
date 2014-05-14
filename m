Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/3] hog: Fix compilation error on 32 bit machine
Date: Wed, 14 May 2014 21:49:08 +0200
Message-Id: <1400096949-18895-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1400096949-18895-1-git-send-email-szymon.janc@gmail.com>
References: <1400096949-18895-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix following with GCC version 4.8.2 (Debian 4.8.2-21):

  CC       profiles/input/bluetoothd-hog.o
profiles/input/hog.c: In function ‘report_value_cb’:
profiles/input/hog.c:149:8: error: format ‘%lu’ expects argument of
   type ‘long unsigned int’, but argument 3 has type ‘unsigned int’
    [-Werror=format=]
        status, sizeof(ev));
        ^
---
 profiles/input/hog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index c196f65..e82e827 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -145,7 +145,7 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 
 	/* uHID kernel driver does not handle partial writes */
 	if ((size_t) status < sizeof(ev)) {
-		error("uHID dev write error: partial write (%zd of %lu bytes)",
+		error("uHID dev write error: partial write (%zd of %zu bytes)",
 							status, sizeof(ev));
 		return;
 	}
-- 
2.0.0.rc2

