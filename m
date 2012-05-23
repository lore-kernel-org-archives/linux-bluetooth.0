Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Henrique Dante de Almeida <hdante@profusion.mobi>
Subject: [PATCH 02/11] Constify GDBus signal tables
Date: Wed, 23 May 2012 10:19:59 -0300
Message-Id: <1337779208-3555-3-git-send-email-hdante@profusion.mobi>
In-Reply-To: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
References: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

    Constify signal tables with the following command:

        find . -name '*.[ch]' -exec \
                 sed -i 's/\(GDBusSignalTable .* =\)/const \1/g' {} \;
---
 src/adapter.c |    2 +-
 src/device.c  |    2 +-
 src/manager.c |    2 +-
 src/tag.c     |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ca662dc..8574d52 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -470,7 +470,7 @@ static const GDBusMethodTable adapter_methods[] = {
 	{ },
 };
 
-static GDBusSignalTable adapter_signals[] = {
+static const GDBusSignalTable adapter_signals[] = {
 	{ "PropertyChanged",		"sv"	},
 	{ "TagFound",		        "o"	},
 	{ "TagLost",			"o"	},
diff --git a/src/device.c b/src/device.c
index b550c9b..b53e24d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -240,7 +240,7 @@ static const GDBusMethodTable device_methods[] = {
 	{ },
 };
 
-static GDBusSignalTable device_signals[] = {
+static const GDBusSignalTable device_signals[] = {
 	{ "PropertyChanged",		"sv"	},
 	{ }
 };
diff --git a/src/manager.c b/src/manager.c
index 4aff3a7..241c472 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -139,7 +139,7 @@ static const GDBusMethodTable manager_methods[] = {
 	{ },
 };
 
-static GDBusSignalTable manager_signals[] = {
+static const GDBusSignalTable manager_signals[] = {
 	{ "PropertyChanged",		"sv"	},
 	{ "AdapterAdded",		"o"	},
 	{ "AdapterRemoved",		"o"	},
diff --git a/src/tag.c b/src/tag.c
index 1d85814..d660749 100644
--- a/src/tag.c
+++ b/src/tag.c
@@ -329,7 +329,7 @@ static const GDBusMethodTable tag_methods[] = {
 	{ },
 };
 
-static GDBusSignalTable tag_signals[] = {
+static const GDBusSignalTable tag_signals[] = {
 	{ "PropertyChanged",		"sv"	},
 	{ }
 };
-- 
1.7.9.5

