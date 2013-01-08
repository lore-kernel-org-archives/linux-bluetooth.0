Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] health: Fix pointer to local variable out-of-scope
Date: Tue, 08 Jan 2013 17:07:45 +0530
Message-id: <1357645069-30841-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The address of the local variable is used outside the scope.
---
 profiles/health/hdp_util.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 5f81806..ed987e3 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -153,13 +153,12 @@ static gboolean parse_data_type(DBusMessageIter *iter, gpointer data,
 {
 	struct hdp_application *app = data;
 	DBusMessageIter *value;
+	DBusMessageIter variant;
 	int ctype;
 
 	ctype = dbus_message_iter_get_arg_type(iter);
 	value = iter;
 	if (ctype == DBUS_TYPE_VARIANT) {
-		DBusMessageIter variant;
-
 		/* Get value inside the variable */
 		dbus_message_iter_recurse(iter, &variant);
 		ctype = dbus_message_iter_get_arg_type(&variant);
@@ -181,13 +180,12 @@ static gboolean parse_role(DBusMessageIter *iter, gpointer data, GError **err)
 {
 	struct hdp_application *app = data;
 	DBusMessageIter *string;
+	DBusMessageIter value;
 	int ctype;
 	const char *role;
 
 	ctype = dbus_message_iter_get_arg_type(iter);
 	if (ctype == DBUS_TYPE_VARIANT) {
-		DBusMessageIter value;
-
 		/* Get value inside the variable */
 		dbus_message_iter_recurse(iter, &value);
 		ctype = dbus_message_iter_get_arg_type(&value);
@@ -222,13 +220,12 @@ static gboolean parse_desc(DBusMessageIter *iter, gpointer data, GError **err)
 {
 	struct hdp_application *app = data;
 	DBusMessageIter *string;
+	DBusMessageIter variant;
 	int ctype;
 	const char *desc;
 
 	ctype = dbus_message_iter_get_arg_type(iter);
 	if (ctype == DBUS_TYPE_VARIANT) {
-		DBusMessageIter variant;
-
 		/* Get value inside the variable */
 		dbus_message_iter_recurse(iter, &variant);
 		ctype = dbus_message_iter_get_arg_type(&variant);
@@ -253,14 +250,13 @@ static gboolean parse_chan_type(DBusMessageIter *iter, gpointer data,
 {
 	struct hdp_application *app = data;
 	DBusMessageIter *value;
+	DBusMessageIter variant;
 	char *chan_type;
 	int ctype;
 
 	ctype = dbus_message_iter_get_arg_type(iter);
 	value = iter;
 	if (ctype == DBUS_TYPE_VARIANT) {
-		DBusMessageIter variant;
-
 		/* Get value inside the variable */
 		dbus_message_iter_recurse(iter, &variant);
 		ctype = dbus_message_iter_get_arg_type(&variant);
-- 
1.7.9.5

