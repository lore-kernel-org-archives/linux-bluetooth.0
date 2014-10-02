Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/core: Fix memory leak in parse_system_id()
Date: Thu,  2 Oct 2014 17:31:37 +0300
Message-Id: <1412260297-6200-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

get_prop() allocates memory which needs to be freed.
---
 android/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/main.c b/android/main.c
index 4f3a6bf..703b3b6 100644
--- a/android/main.c
+++ b/android/main.c
@@ -382,9 +382,11 @@ static void parse_system_id(uint16_t len, const uint8_t *val)
 
 	res = strtoull(id, NULL, 16);
 	if (res == ULLONG_MAX && errno == ERANGE)
-		return;
+		goto done;
 
 	config_system_id = res;
+done:
+	free(id);
 }
 
 static void configuration(const void *buf, uint16_t len)
-- 
1.9.1

