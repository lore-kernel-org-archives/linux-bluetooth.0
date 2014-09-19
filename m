Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/13] android/client: Fix compilation errors with musl
Date: Fri, 19 Sep 2014 16:10:13 +0200
Message-Id: <1411135816-18966-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
References: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix number of build errors similar to:

  CC       android/client/android_haltest-tabcompletion.o
android/client/tabcompletion.c: In function 'print_matches':
android/client/tabcompletion.c:52:3: error: implicit declaration of
   function 'strncmp' [-Werror=implicit-function-declaration]
   if (strncmp(enum_name, prefix, len) == 0)
   ^
android/client/tabcompletion.c: In function 'split_command':
android/client/tabcompletion.c:87:3: error: implicit declaration of
    function 'strncpy' [-Werror=implicit-function-declaration]
   strncpy(arg->ntcopy, arg->origin, len);
   ^
---
 android/client/if-bt.c         | 2 ++
 android/client/if-gatt.c       | 2 ++
 android/client/if-hh.c         | 1 +
 android/client/if-hl.c         | 1 +
 android/client/if-pan.c        | 2 --
 android/client/if-rc.c         | 1 +
 android/client/if-sock.c       | 1 +
 android/client/tabcompletion.c | 1 +
 8 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 218e254..4abfd53 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -15,6 +15,8 @@
  *
  */
 
+#include <string.h>
+
 #include "if-main.h"
 #include "terminal.h"
 #include "../hal-utils.h"
diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 0ceffa6..3691bcc 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -15,6 +15,8 @@
  *
  */
 
+#include <string.h>
+
 #include <hardware/bluetooth.h>
 
 #include "../hal-utils.h"
diff --git a/android/client/if-hh.c b/android/client/if-hh.c
index df3fd30..b2bf8ca 100644
--- a/android/client/if-hh.c
+++ b/android/client/if-hh.c
@@ -17,6 +17,7 @@
 
 #include <stdio.h>
 #include <ctype.h>
+#include <string.h>
 
 #include <hardware/bluetooth.h>
 #include <hardware/bt_hh.h>
diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index a3c351c..e0818ba 100644
--- a/android/client/if-hl.c
+++ b/android/client/if-hl.c
@@ -18,6 +18,7 @@
 #include <stdio.h>
 #include <ctype.h>
 #include <unistd.h>
+#include <string.h>
 
 #include <hardware/bluetooth.h>
 #include <hardware/bt_hl.h>
diff --git a/android/client/if-pan.c b/android/client/if-pan.c
index bdb36cc..6207f6e 100644
--- a/android/client/if-pan.c
+++ b/android/client/if-pan.c
@@ -15,8 +15,6 @@
  *
  */
 
-#include <hardware/bluetooth.h>
-
 #include "if-main.h"
 #include "../hal-utils.h"
 
diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index afd90a3..ed65600 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -17,6 +17,7 @@
 
 #include <stdio.h>
 #include <ctype.h>
+#include <string.h>
 
 #include <hardware/bluetooth.h>
 #include <hardware/bt_hh.h>
diff --git a/android/client/if-sock.c b/android/client/if-sock.c
index 20a1fc8..ee2c1e8 100644
--- a/android/client/if-sock.c
+++ b/android/client/if-sock.c
@@ -18,6 +18,7 @@
 #include <stdio.h>
 #include <ctype.h>
 #include <unistd.h>
+#include <string.h>
 
 #include "if-main.h"
 #include "pollhandler.h"
diff --git a/android/client/tabcompletion.c b/android/client/tabcompletion.c
index cf3fd80..bcca5fa 100644
--- a/android/client/tabcompletion.c
+++ b/android/client/tabcompletion.c
@@ -17,6 +17,7 @@
 
 #include <stdio.h>
 #include <ctype.h>
+#include <string.h>
 #include "if-main.h"
 #include "terminal.h"
 
-- 
1.9.3

