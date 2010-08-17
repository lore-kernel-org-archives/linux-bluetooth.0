Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Fix aborting capability scripts making them zombies processes
Date: Tue, 17 Aug 2010 16:58:29 +0300
Message-Id: <1282053510-18102-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

When using G_SPAWN_DO_NOT_REAP_CHILD the watch cannot be removed since it
basically replaces the use of waitpid which does prevent the child
process to became 'zombie' when terminated, a more detailed explanation
can be found in waitpid manpage.
---
 plugins/filesystem.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/plugins/filesystem.c b/plugins/filesystem.c
index f0e5bbe..bf00ac2 100644
--- a/plugins/filesystem.c
+++ b/plugins/filesystem.c
@@ -237,7 +237,7 @@ struct capability_object {
 	int pid;
 	int output;
 	int err;
-	unsigned int watch;
+	gboolean aborted;
 	GString *buffer;
 };
 
@@ -247,10 +247,20 @@ static void script_exited(GPid pid, int status, void *data)
 	char buf[128];
 
 	object->pid = -1;
-	object->watch = 0;
 
 	DBG("pid: %d status: %d", pid, status);
 
+	g_spawn_close_pid(pid);
+
+	/* free the object if aborted */
+	if (object->aborted) {
+		if (object->buffer != NULL)
+			g_string_free(object->buffer, TRUE);
+
+		g_free(object);
+		return;
+	}
+
 	if (WEXITSTATUS(status) != EXIT_SUCCESS) {
 		memset(buf, 0, sizeof(buf));
 		if (read(object->err, buf, sizeof(buf)) > 0)
@@ -258,8 +268,6 @@ static void script_exited(GPid pid, int status, void *data)
 		obex_object_set_io_flags(data, G_IO_ERR, -EPERM);
 	} else
 		obex_object_set_io_flags(data, G_IO_IN, 0);
-
-	g_spawn_close_pid(pid);
 }
 
 static int capability_exec(const char **argv, int *output, int *err)
@@ -321,7 +329,8 @@ static void *capability_open(const char *name, int oflag, mode_t mode,
 	if (object->pid < 0)
 		goto fail;
 
-	object->watch = g_child_watch_add(object->pid, script_exited, object);
+	/* Watch cannot be removed while the process is still running */
+	g_child_watch_add(object->pid, script_exited, object);
 
 done:
 	if (err)
@@ -519,18 +528,17 @@ static int capability_close(void *object)
 	if (obj->pid < 0)
 		goto done;
 
-	if (obj->watch)
-		g_source_remove(obj->watch);
-
-	g_spawn_close_pid(obj->pid);
-
 	DBG("kill: pid %d", obj->pid);
 	err = kill(obj->pid, SIGTERM);
 	if (err < 0) {
 		err = -errno;
 		error("kill: %s (%d)", strerror(-err), -err);
+		goto done;
 	}
 
+	obj->aborted = TRUE;
+	return 0;
+
 done:
 	if (obj->buffer != NULL)
 		g_string_free(obj->buffer, TRUE);
-- 
1.7.0.4

