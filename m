Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 13/14] obexd/MAP: Fix protected property value
Date: Fri, 4 Oct 2013 11:05:37 +0200
Message-ID: <1380877538-22614-13-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
References: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"Sent" flag value was returned instead of "Protected" one.
This also fix following build error:

  CC     obexd/client/obexd-map.o
obexd/client/map.c:711:17: error: ‘get_protected’ defined but not
    used [-Werror=unused-function]
cc1: all warnings being treated as errors
---
 obexd/client/map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 801d715..4373d74 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -814,7 +814,7 @@ static const GDBusPropertyTable map_msg_properties[] = {
 	{ "Priority", "b", get_priority },
 	{ "Read", "b", get_read, set_read },
 	{ "Sent", "b", get_sent },
-	{ "Protected", "b", get_sent },
+	{ "Protected", "b", get_protected },
 	{ "Deleted", "b", NULL, set_deleted },
 	{ }
 };
-- 
1.8.4

