Return-Path: <cyrus@holtmann.org>
Message-ID: <1356912086.7243.15.camel@lsdevbox>
Subject: Re: SEGFAULT in obexd manager.c:find_session
From: Marcin Zawiejski <dragmz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 31 Dec 2012 01:01:26 +0100
In-Reply-To: <CABBYNZJTCf9eiVm10SoLRDQ870ayt00Eiz=szXEb1fhktWyHcQ@mail.gmail.com>
References: <50E03F0D.6020605@gmail.com>
	 <CABBYNZJTCf9eiVm10SoLRDQ870ayt00Eiz=szXEb1fhktWyHcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sun, 2012-12-30 at 16:28 +0200, Luiz Augusto von Dentz wrote:
> Hi Marcin,
> 
> On Sun, Dec 30, 2012 at 3:18 PM, Marcin Zawiejski <dragmz@gmail.com> wrote:
> > Hi, I think there is a bug in obexd in manager.c:find_session function.
> >
> > What happens here is a segfault when manager.c:find_session calls
> > g_str_equal(obc_session_get_path(session), path). This is caused by the
> > sessions list having a session with a NULL path.
> >
> > Basically when I call manager.c:create_session, the session created there is
> > added to sessions list but it has a NULL path until the
> > manager.c:create_callback is called.
> >
> > However the manager.c:create_callback is not called at all if the remote
> > device refuses the connection. So when manager.c:find_session is called, it
> > actually calls the g_str_equal(NULL, path) causing the segfault.
> >
> > This might be simply fixed by modifying the manager.c:find_session to check
> > for a NULL session path before calling g_str_equal(...).
> >
> > The problem is reproducible by having two sessions, with one awaiting
> > connection and another one with an active file transfer. When the file
> > transfer errors and I call org.bluez.obex.Client1 RemoveSession then the
> > obexd segfaults since the session awaiting connection has a NULL path.
> >
> > I'm not sure if the session with a NULL path should be on the sessions list
> > or not. If its okay, then here's a simple patch for the
> > manager.c:find_session function:
> >
> > ---
> > diff --git a/obexd/client/manager.c b/obexd/client/manager.c
> > index 8f62a30..28b890c 100644
> > --- a/obexd/client/manager.c
> > +++ b/obexd/client/manager.c
> > @@ -142,8 +142,9 @@ static struct obc_session *find_session(const char
> > *path)
> >
> >         for (l = sessions; l; l = l->next) {
> >                 struct obc_session *session = l->data;
> > +               const char *session_path = obc_session_get_path(session);
> >
> > -               if (g_str_equal(obc_session_get_path(session), path) ==
> > TRUE)
> > +               if (session_path != NULL && g_str_equal(session_path, path)
> > == TRUE)
> >                         return session;
> >         }
> > ---
> 
> You can use g_strcmp0 which checks for NULL, gonna take a look why the
> session path is NULL perhaps we should not even add to the session
> list until the connection completes and it is properly registered.

I think you are right - session with no path should not be placed on the
sessions list because it is not usable in such case anyway. Below is a patch
that works for me, here's a summary of the changes:

- move g_slist_append from create_session to create_callback so the
session is added to sessions list after it has been registered
- split shutdown_session into shutdown_session and release_session; the
shutdown_session performs the shutdown and unref on the session but does
not try to remove session from the list; the release_session removes the
session from the list and calls release_shutdown
- modify create_callback so it calls shutdown_session for failures
before the session has been registered (so it doesn't try to remove
session from the list since the session is not on the list)
- modify remove_session to call release_session in order to remove the
session from list and do shutdown

---
diff --git a/obexd/client/manager.c b/obexd/client/manager.c
index 8f62a30..118dd48 100644
--- a/obexd/client/manager.c
+++ b/obexd/client/manager.c
@@ -59,11 +59,16 @@ static GSList *sessions = NULL;
 
 static void shutdown_session(struct obc_session *session)
 {
-	sessions = g_slist_remove(sessions, session);
 	obc_session_shutdown(session);
 	obc_session_unref(session);
 }
 
+static void release_session(struct obc_session *session)
+{
+	sessions = g_slist_remove(sessions, session);
+	shutdown_session(session);
+}
+
 static void unregister_session(void *data)
 {
 	struct obc_session *session = data;
@@ -94,6 +99,16 @@ static void create_callback(struct obc_session
*session,
 
 	path = obc_session_register(session, unregister_session);
 
+	if(path == NULL) {
+		DBusMessage *error = g_dbus_create_error(data->message,
+					ERROR_INTERFACE ".Failed",
+					NULL);
+		g_dbus_send_message(data->connection, error);
+		shutdown_session(session);
+		goto done;
+	}
+
+	sessions = g_slist_append(sessions, session);
 	g_dbus_send_reply(data->connection, data->message,
 				DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID);
@@ -190,7 +205,6 @@ static DBusMessage *create_session(DBusConnection
*connection,
 					dbus_message_get_sender(message),
 					create_callback, data);
 	if (session != NULL) {
-		sessions = g_slist_append(sessions, session);
 		return NULL;
 	}
 
@@ -224,7 +238,7 @@ static DBusMessage *remove_session(DBusConnection
*connection,
 				ERROR_INTERFACE ".NotAuthorized",
 				"Not Authorized");
 
-	shutdown_session(session);
+	release_session(session);
 
 	return dbus_message_new_method_return(message);
 }
---

Marcin.


