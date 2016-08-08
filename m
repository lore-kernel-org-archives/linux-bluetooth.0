Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/service: Fix setting connecting state
Date: Mon,  8 Aug 2016 13:41:00 +0300
Message-Id: <1470652860-11461-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the profile don't implement .accept callback it means it cannot
connect in this mode, which is normally used for GATT profiles, so the
code shall not assume the profile will be connecting and instead just
return an error.
---
 src/service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index 0da14ab..f387fc4 100644
--- a/src/service.c
+++ b/src/service.c
@@ -197,7 +197,7 @@ int service_accept(struct btd_service *service)
 	}
 
 	if (!service->profile->accept)
-		goto done;
+		return -ENOSYS;
 
 	err = service->profile->accept(service);
 	if (!err)
-- 
2.7.4

