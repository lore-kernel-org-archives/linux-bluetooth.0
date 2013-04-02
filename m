Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 5/6] obexd: Use gcc builtin instead of g_atomic
Date: Tue,  2 Apr 2013 19:54:43 -0300
Message-Id: <1364943285-12463-6-git-send-email-lucas.demarchi@profusion.mobi>
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
 obexd/client/session.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index f677bcb..c14efb4 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -115,9 +115,9 @@ static GQuark obex_io_error_quark(void)
 
 struct obc_session *obc_session_ref(struct obc_session *session)
 {
-	g_atomic_int_inc(&session->refcount);
+	int refs = __sync_fetch_and_add(&session->refcount, 1);
 
-	DBG("%p: ref=%d", session, session->refcount);
+	DBG("%p: ref=%d", session, refs + 1);
 
 	return session;
 }
@@ -210,13 +210,13 @@ static void session_free(struct obc_session *session)
 
 void obc_session_unref(struct obc_session *session)
 {
-	gboolean ret;
+	int refs;
 
-	ret = g_atomic_int_dec_and_test(&session->refcount);
+	refs = __sync_sub_and_fetch(&session->refcount, 1);
 
-	DBG("%p: ref=%d", session, session->refcount);
+	DBG("%p: ref=%d", session, refs);
 
-	if (ret == FALSE)
+	if (refs > 0)
 		return;
 
 	session_free(session);
-- 
1.8.2

