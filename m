Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] GAttrib: Fix leak when remote disconnects
Date: Thu,  9 Feb 2012 12:41:37 -0300
Message-Id: <1328802098-26789-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1328802098-26789-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1328802098-26789-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gattrib.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index ccddabe..12a9fcf 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -193,10 +193,11 @@ static void attrib_destroy(GAttrib *attrib)
 	if (attrib->write_watch > 0)
 		g_source_remove(attrib->write_watch);
 
-	if (attrib->read_watch > 0) {
+	if (attrib->read_watch > 0)
 		g_source_remove(attrib->read_watch);
+
+	if (attrib->io)
 		g_io_channel_unref(attrib->io);
-	}
 
 	g_free(attrib->buf);
 
-- 
1.7.8.4

