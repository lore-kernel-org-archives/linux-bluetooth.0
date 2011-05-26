Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3 v3] Improve usage documentation for some options
Date: Thu, 26 May 2011 17:58:01 +0300
Message-Id: <1306421881-1956-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/main.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index e1ce442..bf966f4 100644
--- a/src/main.c
+++ b/src/main.c
@@ -100,13 +100,17 @@ static GOptionEntry options[] = {
 				G_OPTION_ARG_CALLBACK, parse_debug,
 				"Enable debug information output", "DEBUG" },
 	{ "root", 'r', 0, G_OPTION_ARG_STRING, &option_root,
-				"Specify root folder location", "PATH" },
+				"Specify root folder location. Both absolute "
+				"and relative can be used, but relative paths "
+				"are assumed to be relative to user $HOME "
+				"folder", "PATH" },
 	{ "root-setup", 'S', 0, G_OPTION_ARG_STRING, &option_root_setup,
 				"Root folder setup script", "SCRIPT" },
 	{ "symlinks", 'l', 0, G_OPTION_ARG_NONE, &option_symlinks,
 				"Enable symlinks on root folder" },
 	{ "capability", 'c', 0, G_OPTION_ARG_STRING, &option_capability,
-				"Specify capability file", "FILE" },
+				"Specify capability file, use '!' mark for "
+				"scripts", "FILE" },
 	{ "auto-accept", 'a', 0, G_OPTION_ARG_NONE, &option_autoaccept,
 				"Automatically accept push requests" },
 	{ "plugin", 'p', 0, G_OPTION_ARG_STRING, &option_plugin,
-- 
1.7.5.2

