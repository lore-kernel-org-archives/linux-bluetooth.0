Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/14] obexd/service: Remove unused local variable
Date: Fri, 4 Oct 2013 11:05:33 +0200
Message-ID: <1380877538-22614-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
References: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following build error:

  CC     obexd/src/obexd-service.o
obexd/src/service.c: In function ‘obex_service_driver_register’:
obexd/src/service.c:100:10: error: unused variable ‘l’ [-Werror=unused-variable]
---
 obexd/src/service.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/obexd/src/service.c b/obexd/src/service.c
index 6b8533b..c088535 100644
--- a/obexd/src/service.c
+++ b/obexd/src/service.c
@@ -97,8 +97,6 @@ static struct obex_service_driver *find_driver(uint16_t service)
 
 int obex_service_driver_register(struct obex_service_driver *driver)
 {
-	GSList *l;
-
 	if (!driver) {
 		error("Invalid driver");
 		return -EINVAL;
-- 
1.8.4

