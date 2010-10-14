Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/2] Fix regression on suspend on opening
Date: Thu, 14 Oct 2010 15:35:29 +0300
Message-Id: <1287059730-10988-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1287059730-10988-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1287059730-10988-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes regression on suspend on opening when obex_write_stream
returns length of buffer, which is treated as error response
afterwards.
---
 src/obex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index d1ac339..4e1db9c 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -683,7 +683,7 @@ add_header:
 
 	os->offset += len;
 
-	return len;
+	return 0;
 }
 
 static gboolean handle_async_io(void *object, int flags, int err,
-- 
1.7.0.4

