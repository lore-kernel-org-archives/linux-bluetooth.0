Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] filesystem: Fix folder listing
Date: Tue, 31 Jan 2012 17:24:23 -0800
Message-Id: <1328059463-6325-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

parent-folder should indicates the existence of a parent folder which is
the opposit of what the code is currently doing.
---
 plugins/filesystem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/filesystem.c b/plugins/filesystem.c
index 68785c6..677df76 100644
--- a/plugins/filesystem.c
+++ b/plugins/filesystem.c
@@ -488,7 +488,7 @@ static GString *append_listing(GString *object, const char *name,
 		goto failed;
 	}
 
-	if (root)
+	if (!root)
 		object = g_string_append(object, FL_PARENT_FOLDER_ELEMENT);
 
 	ret = verify_path(name);
-- 
1.7.7.6

