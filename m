Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH obexd v3] Fix finalize request in callback function
Date: Mon, 11 Jul 2011 00:01:15 +0300
Message-Id: <1310331675-10665-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1310331675-10665-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1310331675-10665-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Request shell be finalized in cache_ready_notify callback function.
Otherwise, reference to the request is kept until vobject is closed.
It is correct in current implementation since there are no nested
backend requests when pulling vcard listing.

However, this contradicts to current design (see phonebook_size_result,
query_result, cache_entry_done) and may cause problems if such
implementation would be needed.
---
 plugins/pbap.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 7eedfe0..e14a58d 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -487,6 +487,9 @@ static void cache_ready_notify(void *user_data)
 
 	DBG("");
 
+	phonebook_req_finalize(pbap->obj->request);
+	pbap->obj->request = NULL;
+
 	pbap->cache.valid = TRUE;
 
 	generate_response(pbap);
-- 
1.7.4.1

