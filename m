Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH] gdbus: Fix the ordering of signals
Date: Tue,  3 May 2016 11:56:31 -0300
Message-Id: <1462287391-5140-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Consider the following example:

/foo
  properties: "A", "B"

/bar
  properties: "C", "D"

If during a given mainloop iteration, property "A" of object '/foo' is
changed, then properties "C" and "D" of '/bar', lastly "B" of '/foo',
the current code will emit the PropertiesChanged signals in following
order: "A", "B", "C", "D".

This may confuse applications that have a dependency on the order of
those signals.

This fixes the ordering, so in the example, the order becomes:
"C", "D", "A", B". This is considered not to be a problem, as
applications may use the flag G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH, so
property changed signals are emitted as soon as possible.

The solution is for each object, to reschedule the signals everytime a
signal is emitted.
---
 gdbus/object.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index a220101..fc94e5e 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -635,11 +635,16 @@ static gboolean g_dbus_args_have_signature(const GDBusArgInfo *args,
 
 static void add_pending(struct generic_data *data)
 {
-	if (data->process_id > 0)
-		return;
+	guint old_id = data->process_id;
 
 	data->process_id = g_idle_add(process_changes, data);
 
+	if (old_id > 0) {
+		/* If there was an old idler, remove it. */
+		g_source_remove(old_id);
+		return;
+	}
+
 	pending = g_slist_append(pending, data);
 }
 
-- 
2.8.1

