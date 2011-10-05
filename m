Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 2/2] Pass through error returned by open in PUTs
Date: Wed,  5 Oct 2011 16:52:05 +0200
Message-Id: <1317826325-26436-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1317826325-26436-1-git-send-email-lkslawek@gmail.com>
References: <1317826325-26436-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/obex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index b0a4183..59bbe7a 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -958,7 +958,7 @@ int obex_put_stream_start(struct obex_session *os, const char *filename)
 					(size_t *) &os->size : NULL, &err);
 	if (os->object == NULL) {
 		error("open(%s): %s (%d)", filename, strerror(-err), -err);
-		return -EPERM;
+		return err;
 	}
 
 	os->path = g_strdup(filename);
-- 
1.7.4.1

