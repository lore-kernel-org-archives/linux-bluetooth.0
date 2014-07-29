Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 07/12] tools/scotest: Fix double close socket
Date: Tue, 29 Jul 2014 17:20:56 +0300
Message-Id: <1406643661-29323-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When executing in a child we close(sk) in the beginning. error label
handles parent process error conditions.
---
 tools/scotest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/scotest.c b/tools/scotest.c
index bd65034..d033ae0 100644
--- a/tools/scotest.c
+++ b/tools/scotest.c
@@ -210,7 +210,7 @@ static void do_listen(void (*handler)(int sk))
 							strerror(errno), errno);
 			if (!defer_setup) {
 				close(nsk);
-				goto error;
+				exit(1);
 			}
 		}
 
@@ -227,7 +227,7 @@ static void do_listen(void (*handler)(int sk))
 
 			if (defer_setup < 0) {
 				close(nsk);
-				goto error;
+				exit(1);
 			}
 		}
 
-- 
1.9.1

