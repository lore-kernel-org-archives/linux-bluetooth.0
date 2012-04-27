Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 9/9] hidd: Fix indentation
Date: Fri, 27 Apr 2012 10:36:52 -0400
Message-Id: <1335537412-26478-10-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 compat/hidd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/hidd.c b/compat/hidd.c
index fd1b28c..f8a0dfd 100644
--- a/compat/hidd.c
+++ b/compat/hidd.c
@@ -811,7 +811,7 @@ int main(int argc, char *argv[])
         if (detach) {
 		if (daemon(0, 0)) {
 			perror("Can't start daemon");
-        	        exit(1);
+			exit(1);
 		}
 	} else
 		log_option |= LOG_PERROR;
-- 
1.7.5.4

