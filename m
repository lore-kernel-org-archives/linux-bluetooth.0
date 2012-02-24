Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] mgmtops: Add missing compatibility header include
Date: Fri, 24 Feb 2012 10:42:31 -0400
Message-Id: <1330094551-28244-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

glib-compat.h needs to be included when either g_slist_free_full() or
g_list_free_full() is used on a C file. Otherwise, it will fail to build
on older (supported) Glib versions that lack these functions.

Fixes this build error on GLib 2.24.1:

plugins/mgmtops.c: In function ‘remove_controller’:
plugins/mgmtops.c:180: error: implicit declaration of function
‘g_slist_free_full’
---
 plugins/mgmtops.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 5740e9c..95fbe8b 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -49,6 +49,7 @@
 #include "event.h"
 #include "oob.h"
 #include "eir.h"
+#include "glib-compat.h"
 
 #define MGMT_BUF_SIZE 1024
 
-- 
1.7.5.4

