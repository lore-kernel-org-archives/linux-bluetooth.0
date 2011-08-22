Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 1/9] Fix double free in error case in endpoint_reply
Date: Mon, 22 Aug 2011 17:30:39 +0200
Message-Id: <1314027047-5476-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If SetConfiguration call fails, the headset or gateway for which
SetConfiguration is called is disconnected. This will free any
pending request, but this does not prevent the request to
terminate (endpoint_reply) and try to free itself once again.
Note that a copy of the freed pointer is tested which has not
been updated.
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

