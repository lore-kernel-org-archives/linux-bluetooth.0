Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/11] network: Fix always attempting to connect to PANU service
Date: Mon, 26 Nov 2012 15:09:21 +0200
Message-Id: <1353935362-8666-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
References: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

connection_connect takes the remote role as parameter not the local one.
---
 profiles/network/manager.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 06abe1b..06ef9fc 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -100,8 +100,7 @@ static int connect_profile(struct btd_device *dev, struct btd_profile *profile,
 	req->profile = profile;
 	req->cb = cb;
 
-	err = connection_connect(dev, BNEP_SVC_PANU, NULL, connect_profile_cb,
-									req);
+	err = connection_connect(dev, id, NULL, connect_profile_cb, req);
 	if (err < 0) {
 		g_free(req);
 		return err;
-- 
1.7.11.7

