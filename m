Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 3/6] attrib: Use gcc builtin instead of g_atomic
Date: Tue,  2 Apr 2013 19:54:41 -0300
Message-Id: <1364943285-12463-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1364943285-12463-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1364943285-12463-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_atomic_* end up using G_STATIC_ASSERT, causing gcc 4.8 to yell due to
-Wunused-local-typedefs.

/usr/include/glib-2.0/glib/gmacros.h:162:53: error: typedef ‘_GStaticAssertCompileTimeAssertion_2’ locally defined but not used [-Werror=unused-local-typedefs]
 #define G_STATIC_ASSERT(expr) typedef char G_PASTE (_GStaticAssertCompileTimeAssertion_, __COUNTER__)[(expr) ? 1 : -1]

Most of the uses of atomic operations were wrong. They were fixed as
well. If we are using atomic operations, reading the variable again
later for logging is not an option, we should use the return of the
atomic function used to fetch the variable.
---
 attrib/gatt.c    | 12 ++++++------
 attrib/gattrib.c | 14 ++++++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 44d3eb6..fa61c9e 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -79,14 +79,14 @@ static void discover_primary_free(struct discover_primary *dp)
 
 static struct included_discovery *isd_ref(struct included_discovery *isd)
 {
-	g_atomic_int_inc(&isd->refs);
+	__sync_fetch_and_add(&isd->refs, 1);
 
 	return isd;
 }
 
 static void isd_unref(struct included_discovery *isd)
 {
-	if (g_atomic_int_dec_and_test(&isd->refs) == FALSE)
+	if (__sync_sub_and_fetch(&isd->refs, 1) > 0)
 		return;
 
 	if (isd->err)
@@ -581,7 +581,7 @@ static void read_long_destroy(gpointer user_data)
 {
 	struct read_long_data *long_read = user_data;
 
-	if (g_atomic_int_dec_and_test(&long_read->ref) == FALSE)
+	if (__sync_sub_and_fetch(&long_read->ref, 1) > 0)
 		return;
 
 	if (long_read->buffer != NULL)
@@ -626,7 +626,7 @@ static void read_blob_helper(guint8 status, const guint8 *rpdu, guint16 rlen,
 				read_blob_helper, long_read, read_long_destroy);
 
 	if (id != 0) {
-		g_atomic_int_inc(&long_read->ref);
+		__sync_fetch_and_add(&long_read->ref, 1);
 		return;
 	}
 
@@ -662,7 +662,7 @@ static void read_char_helper(guint8 status, const guint8 *rpdu,
 			read_blob_helper, long_read, read_long_destroy);
 
 	if (id != 0) {
-		g_atomic_int_inc(&long_read->ref);
+		__sync_fetch_and_add(&long_read->ref, 1);
 		return;
 	}
 
@@ -698,7 +698,7 @@ guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
 	if (id == 0)
 		g_free(long_read);
 	else {
-		g_atomic_int_inc(&long_read->ref);
+		__sync_fetch_and_add(&long_read->ref, 1);
 		long_read->id = id;
 	}
 
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 37581a3..b323617 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -147,12 +147,14 @@ static gboolean is_response(guint8 opcode)
 
 GAttrib *g_attrib_ref(GAttrib *attrib)
 {
+	int refs;
+
 	if (!attrib)
 		return NULL;
 
-	g_atomic_int_inc(&attrib->refs);
+	refs = __sync_fetch_and_add(&attrib->refs, 1);
 
-	DBG("%p: ref=%d", attrib, attrib->refs);
+	DBG("%p: ref=%d", attrib, refs + 1);
 
 	return attrib;
 }
@@ -219,16 +221,16 @@ static void attrib_destroy(GAttrib *attrib)
 
 void g_attrib_unref(GAttrib *attrib)
 {
-	gboolean ret;
+	int refs;
 
 	if (!attrib)
 		return;
 
-	ret = g_atomic_int_dec_and_test(&attrib->refs);
+	refs = __sync_sub_and_fetch(&attrib->refs, 1);
 
-	DBG("%p: ref=%d", attrib, attrib->refs);
+	DBG("%p: ref=%d", attrib, refs);
 
-	if (ret == FALSE)
+	if (refs > 0)
 		return;
 
 	attrib_destroy(attrib);
-- 
1.8.2

