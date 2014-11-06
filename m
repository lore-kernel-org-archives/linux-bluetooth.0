Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] android/handsfree: Return default device for zero bdaddr
Date: Thu,  6 Nov 2014 14:45:58 +0200
Message-Id: <1415277958-26589-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <4917512.kiFJOhNPJF@uw000953>
References: <4917512.kiFJOhNPJF@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For the old Android API use find_default_device() function.
---
 android/handsfree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/handsfree.c b/android/handsfree.c
index b410f5d..33fcbdd 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -290,6 +290,9 @@ static bool match_by_bdaddr(const void *data, const void *match_data)
 
 static struct hf_device *find_device(const bdaddr_t *bdaddr)
 {
+	if (!bacmp(bdaddr, BDADDR_ANY))
+		return find_default_device();
+
 	return queue_find(devices, match_by_bdaddr, bdaddr);
 }
 
-- 
1.9.1

