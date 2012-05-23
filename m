Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Henrique Dante de Almeida <hdante@profusion.mobi>
Subject: [PATCH 01/11]  Constify GDBus method tables
Date: Wed, 23 May 2012 10:19:58 -0300
Message-Id: <1337779208-3555-2-git-send-email-hdante@profusion.mobi>
In-Reply-To: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
References: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

    Constify method tables with the following command:

    find . -name '*.[ch]' -exec \
                 sed -i 's/\(GDBusMethodTable .* =\)/const \1/g' {} \;
---
 src/adapter.c |    2 +-
 src/device.c  |    2 +-
 src/manager.c |    2 +-
 src/ndef.c    |    2 +-
 src/tag.c     |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3300968..ca662dc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -462,7 +462,7 @@ static void tag_present_cb(uint32_t adapter_idx, uint32_t target_idx,
 					check_presence, adapter);
 }
 
-static GDBusMethodTable adapter_methods[] = {
+static const GDBusMethodTable adapter_methods[] = {
 	{ "GetProperties",     "",      "a{sv}", get_properties     },
 	{ "SetProperty",       "sv",    "",      set_property       },
 	{ "StartPoll",         "",      "",      start_poll         },
diff --git a/src/device.c b/src/device.c
index bb86d27..b550c9b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -233,7 +233,7 @@ error:
 	return __near_error_failed(msg, -err);
 }
 
-static GDBusMethodTable device_methods[] = {
+static const GDBusMethodTable device_methods[] = {
 	{ "GetProperties",     "",      "a{sv}", get_properties     },
 	{ "SetProperty",       "sv",    "",      set_property       },
 	{ "Push",             "a{sv}",  "",      push_ndef          },
diff --git a/src/manager.c b/src/manager.c
index d5ea970..4aff3a7 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -133,7 +133,7 @@ void __near_manager_adapter_remove(uint32_t idx)
 				NULL);
 }
 
-static GDBusMethodTable manager_methods[] = {
+static const GDBusMethodTable manager_methods[] = {
 	{ "GetProperties",     "",      "a{sv}", get_properties     },
 	{ "SetProperty",       "sv",    "",      set_property       },
 	{ },
diff --git a/src/ndef.c b/src/ndef.c
index 87d82ec..029941a 100644
--- a/src/ndef.c
+++ b/src/ndef.c
@@ -418,7 +418,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	return reply;
 }
 
-static GDBusMethodTable record_methods[] = {
+static const GDBusMethodTable record_methods[] = {
 	{ "GetProperties",     "",      "a{sv}", get_properties     },
 	{ },
 };
diff --git a/src/tag.c b/src/tag.c
index d4de24f..1d85814 100644
--- a/src/tag.c
+++ b/src/tag.c
@@ -322,7 +322,7 @@ fail:
 	return __near_error_failed(msg, ENOMEM);
 }
 
-static GDBusMethodTable tag_methods[] = {
+static const GDBusMethodTable tag_methods[] = {
 	{ "GetProperties",     "",      "a{sv}", get_properties     },
 	{ "SetProperty",       "sv",    "",      set_property       },
 	{ "Write",             "a{sv}", "",      write_ndef         },
-- 
1.7.9.5

