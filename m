Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Aug 2012 13:14:07 -0400
From: Chris Frey <cdfrey@foursquare.net>
To: linux-bluetooth@vger.kernel.org
Cc: dougkwan@google.com
Subject: [PATCH] Add BDADDR_*_INITIALIZER defines to prevent C++0x compiler errors
Message-ID: <20120823171407.GA24570@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is impossible to use BDADDR_ANY, _ALL, or _LOCAL, in a C++0x program
without triggering a "taking address of temporary" error, depending on
the version of GCC you are using.  It is unlikely this correct error
is going away in the future, so bluez needs to be fixed to accommodate.

This commit adds _INITIALIZER defines, which allows C++ code to create
code like this:

	baddr_t bdaddr_any = BDADDR_ANY_INITIALIZER;
	...
	function(&bdaddr_any);

Thanks to Doug Kwan for the suggested fix.
---
 lib/bluetooth.h |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 0fc4508..31b487e 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -227,9 +227,17 @@ typedef struct {
 #define BDADDR_LE_PUBLIC       0x01
 #define BDADDR_LE_RANDOM       0x02
 
-#define BDADDR_ANY   (&(bdaddr_t) {{0, 0, 0, 0, 0, 0}})
-#define BDADDR_ALL   (&(bdaddr_t) {{0xff, 0xff, 0xff, 0xff, 0xff, 0xff}})
-#define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff}})
+/* These *_INITIALIZER macros are here to allow C++ code to behave in
+ * a conformant manner.  Using BDADDR_ANY in c++0x code returns a
+ * "taking address of temporary" warning.
+ */
+#define BDADDR_ANY_INITIALIZER   {{0, 0, 0, 0, 0, 0}}
+#define BDADDR_ALL_INITIALIZER   {{0xff, 0xff, 0xff, 0xff, 0xff, 0xff}}
+#define BDADDR_LOCAL_INITIALIZER {{0, 0, 0, 0xff, 0xff, 0xff}}
+
+#define BDADDR_ANY   (&(bdaddr_t) BDADDR_ANY_INITIALIZER)
+#define BDADDR_ALL   (&(bdaddr_t) BDADDR_ALL_INITIALIZER)
+#define BDADDR_LOCAL (&(bdaddr_t) BDADDR_LOCAL_INITIALIZER)
 
 /* Copy, swap, convert BD Address */
 static inline int bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
-- 
1.7.2.3

