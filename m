Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] avdtp: Fix passing NULL pointer to memcpy
Date: Fri,  7 Feb 2014 14:11:17 +0200
Message-Id: <1391775078-25010-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1391775078-25010-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391775078-25010-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The patch fixes following clang warning:
...
profiles/audio/avdtp.c:3293:2: warning: Null pointer passed as an
argument to a 'nonnull' parameter
        memcpy(cap->data, data, length);
        ^                 ~~~~
1 warning generated.
...
---
 profiles/audio/avdtp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index da10ab4..b7ddb6c 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3290,7 +3290,9 @@ struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 	cap = g_malloc(sizeof(struct avdtp_service_capability) + length);
 	cap->category = category;
 	cap->length = length;
-	memcpy(cap->data, data, length);
+
+	if (data)
+		memcpy(cap->data, data, length);
 
 	return cap;
 }
-- 
1.8.3.2

