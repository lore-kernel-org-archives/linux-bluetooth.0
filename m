Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 1/4] android/daemon: Implement get adapter name
Date: Mon,  4 Nov 2013 15:22:35 +0200
Message-Id: <1383571358-4942-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <CABBYNZLUUPkLM_b2DDb=mxc5-QqLrwN9in7XmZGpV+xQ-DpzzQ@mail.gmail.com>
References: <CABBYNZLUUPkLM_b2DDb=mxc5-QqLrwN9in7XmZGpV+xQ-DpzzQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use adapter_name_changed for get_property call.
---
 android/adapter.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index af461b8..3e43d44 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -1019,11 +1019,12 @@ static void send_adapter_address(void)
 
 static bool get_name(void)
 {
-	DBG("Not implemented");
+	if (!adapter->name)
+		return false;
 
-	/* TODO: Add implementation */
+	adapter_name_changed((uint8_t *) adapter->name);
 
-	return false;
+	return true;
 }
 
 static bool get_uuids(void)
-- 
1.7.10.4

