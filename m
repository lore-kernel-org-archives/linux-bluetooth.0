Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: linux-bluetooth@vger.kernel.org,
	peter@hurleysoftware.com,
	marcel@holtmann.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH 8/8] Add module_put in rfcomm_dev_add error path
Date: Fri, 12 Jul 2013 22:40:48 +0200
Message-Id: <1373661649-1385-8-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

rfcomm_dev_add doesn't call module_put() in its error path when it took a
reference.

Fix by always calling __module_get() and module_put() in the error path.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 7bc603a..40288c3 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -357,11 +357,11 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 
 	rfcomm_dlc_unlock(dlc);
 
+out:
 	/* It's safe to call __module_get() here because socket already
 	   holds reference to this module. */
 	__module_get(THIS_MODULE);
 
-out:
 	spin_unlock(&rfcomm_dev_lock);
 
 	if (err < 0)
@@ -386,6 +386,7 @@ out:
 	return dev->id;
 
 free:
+	module_put(THIS_MODULE);
 	kfree(dev);
 	return err;
 }
-- 
1.8.3.2
