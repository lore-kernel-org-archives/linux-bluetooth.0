Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/3] Fix gattrib.c coding style
Date: Thu, 24 Feb 2011 17:34:26 -0300
Message-Id: <1298579668-3143-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Just remove an extra empty line.
---
 attrib/gattrib.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 779a471..5b8b590 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -195,7 +195,6 @@ void g_attrib_unref(GAttrib *attrib)
 		g_io_channel_unref(attrib->io);
 	}
 
-
 	if (attrib->destroy)
 		attrib->destroy(attrib->destroy_user_data);
 
-- 
1.7.4.1

