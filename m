Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] test/pbap-client: Add support to fetch spd,fav PB
Date: Wed, 28 Jan 2015 19:11:57 +0530
Message-id: <1422452517-4240-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds support to fetch spd,fav phonebook.
Tested using PTS test case TC_PCE_PBB_BV_01_C.
---
 test/pbap-client | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/pbap-client b/test/pbap-client
index 51e26eb..16a786b 100755
--- a/test/pbap-client
+++ b/test/pbap-client
@@ -170,6 +170,6 @@ if  __name__ == '__main__':
 
 		pbap_client.flush_transfers(lambda: test_paths(paths[1:]))
 
-	test_paths(["PB", "ICH", "OCH", "MCH", "CCH"])
+	test_paths(["PB", "ICH", "OCH", "MCH", "CCH", "SPD", "FAV"])
 
 	mainloop.run()
-- 
1.9.1

