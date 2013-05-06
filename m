Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Samuel Ortiz <sameo@linux.intel.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] neard: Fix checking for unknown carrier power state
Date: Mon, 6 May 2013 15:20:51 +0200
Message-ID: <1367846452-23303-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Message might not contain State field and CPS needs to be set to
unknown before processing message from neard. This fix processing
RequestOOB called without parameters.
---
 plugins/neard.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/neard.c b/plugins/neard.c
index f46e20e..dfe4f23 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -527,6 +527,9 @@ static int process_message(DBusMessage *msg, struct oob_params *remote)
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
 		return -EINVAL;
 
+	/* set CPS to unknown in case State was not provided */
+	remote->power_state = CPS_UNKNOWN;
+
 	dbus_message_iter_recurse(&iter, &dict);
 
 	while (dbus_message_iter_get_arg_type(&dict) == DBUS_TYPE_DICT_ENTRY) {
-- 
1.8.2.2

