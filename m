Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] shared/shell: Fix SIGINT handling
Date: Thu, 25 Jan 2018 13:03:11 +0100
Message-Id: <20180125120311.17844-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix ctrl-c combination working only once.
---
 src/shared/shell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 6cdea1c7e..f1b85f202 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -623,7 +623,7 @@ static bool signal_read(struct io *io, void *user_data)
 			rl_crlf();
 			rl_on_new_line();
 			rl_redisplay();
-			break;
+			return true;
 		}
 
 		/*
-- 
2.14.3

