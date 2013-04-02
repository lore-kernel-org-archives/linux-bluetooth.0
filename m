Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 4/6] gobex: Use gcc builtin instead of g_atomic
Date: Tue,  2 Apr 2013 19:54:42 -0300
Message-Id: <1364943285-12463-5-git-send-email-lucas.demarchi@profusion.mobi>
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
 gobex/gobex.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index a9bcee9..790aec5 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -1315,25 +1315,27 @@ GObex *g_obex_new(GIOChannel *io, GObexTransportType transport_type,
 
 GObex *g_obex_ref(GObex *obex)
 {
+	int refs;
+
 	if (obex == NULL)
 		return NULL;
 
-	g_atomic_int_inc(&obex->ref_count);
+	refs = __sync_fetch_and_add(&obex->ref_count, 1);
 
-	g_obex_debug(G_OBEX_DEBUG_COMMAND, "ref %u", obex->ref_count);
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "ref %u", refs + 1);
 
 	return obex;
 }
 
 void g_obex_unref(GObex *obex)
 {
-	gboolean last_ref;
+	int refs;
 
-	last_ref = g_atomic_int_dec_and_test(&obex->ref_count);
+	refs = __sync_sub_and_fetch(&obex->ref_count, 1);
 
-	g_obex_debug(G_OBEX_DEBUG_COMMAND, "ref %u", obex->ref_count);
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "ref %u", refs);
 
-	if (!last_ref)
+	if (refs > 0)
 		return;
 
 	g_slist_free_full(obex->req_handlers, g_free);
-- 
1.8.2

