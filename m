Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Fix wrong header include on interactive gatttool
Date: Wed, 16 Feb 2011 13:11:39 -0200
Message-Id: <1297869099-4419-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This wrong include is triggering compiler warning: implicit declaration
of function 'strdup'.
---
 attrib/interactive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 83a0778..a98fe79 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -20,7 +20,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
-#include <strings.h>
+#include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <glib.h>
-- 
1.7.4.1

