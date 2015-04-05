Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Florian Grandel <fgrandel@gmail.com>
Subject: [BlueZ v2 1/3] doc: fix minor typos
Date: Sun,  5 Apr 2015 21:11:26 +0200
Message-Id: <1428261088-14121-2-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1428261088-14121-1-git-send-email-fgrandel@gmail.com>
References: <1428261088-14121-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1428259165-10021-3-git-send-email-fgrandel@gmail.com>
References: <1428259165-10021-3-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The documentation contained minor typos which are being fixed here.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 doc/coding-style.txt          | 2 +-
 doc/maintainer-guidelines.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index b3fbd2e..f0bf880 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -61,7 +61,7 @@ if (err || !S_ISDIR(st.st_mode))
 M2: Multiple line comment
 =========================
 
-If your comments have more then one line, please start it from the second line.
+If your comment has more than one line, please start it from the second line.
 
 Example:
 /*
diff --git a/doc/maintainer-guidelines.txt b/doc/maintainer-guidelines.txt
index fef90c8..21162d4 100644
--- a/doc/maintainer-guidelines.txt
+++ b/doc/maintainer-guidelines.txt
@@ -99,7 +99,7 @@ verified first:
 	- Check that the names are acceptible with other maintainers
 	- Ensure that the file modes are correct
 	- Verify that the license & copyright headers are correct
-	- If the file is supposed to be part of the release taraball,
+	- If the file is supposed to be part of the release tarball,
 	  make sure that it gets picked up by 'make dist' (particularly
 	  important for documentation or other files that are not code)
 
-- 
1.9.1

