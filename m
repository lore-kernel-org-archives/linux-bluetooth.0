Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] MAP/dummy: fix message-dummy.c build
Date: Thu, 15 Mar 2012 12:05:22 +0100
Message-Id: <1331809522-6840-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If g_slist_free_full is not supported by glib, build fails with error:

plugins/messages.o: In function `get_folder_listing':
/home/fdanis/src/obexd/plugins/messages.c:199: undefined reference to `g_slist_free_full'
---
 plugins/messages-dummy.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index 833c31c..afba7a7 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -34,6 +34,7 @@
 #include "log.h"
 
 #include "messages.h"
+#include "glib-helper.h"
 
 static char *root_folder = NULL;
 
-- 
1.7.1

