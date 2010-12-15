Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Fix memory leak of gattrib commands queue
Date: Wed, 15 Dec 2010 17:00:09 -0300
Message-Id: <1292443209-31156-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gattrib.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 4ed29d9..eace01b 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -177,6 +177,7 @@ void g_attrib_unref(GAttrib *attrib)
 	while ((c = g_queue_pop_head(attrib->queue)))
 		command_destroy(c);
 
+	g_queue_free(attrib->queue);
 	attrib->queue = NULL;
 
 	for (l = attrib->events; l; l = l->next)
-- 
1.7.3.3

