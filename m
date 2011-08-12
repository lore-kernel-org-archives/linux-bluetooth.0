Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 2/7] Fix double free in error case in endpoint_reply
Date: Fri, 12 Aug 2011 17:27:52 +0200
Message-Id: <1313162877-14945-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1313162877-14945-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1313162877-14945-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/media.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 42d8637..2076d04 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -264,7 +264,8 @@ done:
 	if (request->cb)
 		request->cb(endpoint, ret, size, request->user_data);
 
-	endpoint_request_free(request);
+	if (endpoint->request)
+		endpoint_request_free(endpoint->request);
 	endpoint->request = NULL;
 }
 
-- 
1.7.1

