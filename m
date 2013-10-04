Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/14] obexd/MAP: Remove unsued mas_drivers variable
Date: Fri, 4 Oct 2013 11:05:29 +0200
Message-ID: <1380877538-22614-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
References: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following build error:

  CC     obexd/client/obexd-mns.o
obexd/client/mns.c:344:38: error: ‘mas_drivers’ defined but not used
    [-Werror=unused-variable]
cc1: all warnings being treated as errors
---
 obexd/client/mns.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/obexd/client/mns.c b/obexd/client/mns.c
index 0663def..315764b 100644
--- a/obexd/client/mns.c
+++ b/obexd/client/mns.c
@@ -341,11 +341,6 @@ static struct obex_mime_type_driver mime_event_report = {
 	.write = event_report_write,
 };
 
-static struct obex_mime_type_driver *mas_drivers[] = {
-	&mime_event_report,
-	NULL
-};
-
 static int mns_init(void)
 {
 	int err;
-- 
1.8.4

