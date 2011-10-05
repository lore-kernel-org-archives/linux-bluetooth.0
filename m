Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 3/4] Write pending bytes only if mime object is open
Date: Wed,  5 Oct 2011 16:32:39 +0200
Message-Id: <1317825160-21429-3-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
References: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Without this in case of "non-checked" PUT there were calls to write()
prior to any obex_put_stream_start().
---
 src/obex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 938937c..38c5ca6 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -580,7 +580,7 @@ static int obex_read_stream(struct obex_session *os, obex_t *obex,
 		os->size = OBJECT_SIZE_UNKNOWN;
 
 	/* If there's something to write and we are able to write it */
-	if (os->pending > 0 && os->driver)
+	if (os->pending > 0 && os->driver && os->object)
 		goto write;
 
 	size = OBEX_ObjectReadStream(obex, obj, &buffer);
-- 
1.7.4.1

