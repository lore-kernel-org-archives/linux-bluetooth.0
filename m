Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 1/4] monitor: remove extra blank line
Date: Fri, 11 May 2012 13:20:47 -0300
Message-Id: <1336753247-8764-1-git-send-email-gustavo@padovan.org>
In-Reply-To: <1336753132-8282-1-git-send-email-gustavo@padovan.org>
References: <1336753132-8282-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/main.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/monitor/main.c b/monitor/main.c
index 4e8b433..90e32c5 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -92,7 +92,6 @@ int main(int argc, char *argv[])
 		}
 	}
 
-
 	sigemptyset(&mask);
 	sigaddset(&mask, SIGINT);
 	sigaddset(&mask, SIGTERM);
-- 
1.7.10.1

