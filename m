Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 46/47] android/handsfree: Return default device for zero bdaddr
Date: Tue,  4 Nov 2014 10:19:09 +0200
Message-Id: <1415089150-18798-47-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For the old Android API use find_default_device() function.
---
 android/handsfree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/handsfree.c b/android/handsfree.c
index 67df4cf..baa2893 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -290,6 +290,11 @@ static bool match_by_bdaddr(const void *data, const void *match_data)
 
 static struct hf_device *find_device(const bdaddr_t *bdaddr)
 {
+	uint8_t zero_addr[6] = { 0 };
+
+	if (!memcmp(bdaddr, zero_addr, sizeof(zero_addr)))
+		return find_default_device();
+
 	return queue_find(devices, match_by_bdaddr, bdaddr);
 }
 
-- 
1.9.1

