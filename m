Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH] Remove unused MTU variable in Gattrib struct
Date: Thu, 24 Feb 2011 17:20:52 -0400
Message-Id: <1298582452-18032-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The MTU variable in Gattrib struct was not beind used for any operation
so it should be removed.
---
 attrib/gattrib.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index ef10b5b..c4cfd95 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -41,7 +41,6 @@
 struct _GAttrib {
 	GIOChannel *io;
 	gint refs;
-	gint mtu;
 	guint read_watch;
 	guint write_watch;
 	guint timeout_watch;
@@ -397,7 +396,6 @@ GAttrib *g_attrib_new(GIOChannel *io)
 		return NULL;
 
 	attrib->io = g_io_channel_ref(io);
-	attrib->mtu = 512;
 	attrib->queue = g_queue_new();
 
 	attrib->read_watch = g_io_add_watch(attrib->io,
-- 
1.7.0.4

