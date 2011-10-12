Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 01/12] Add mpris-player to .gitignore
Date: Wed, 12 Oct 2011 12:11:11 -0300
Message-Id: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 2ce99e7..c2fa9e9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -80,6 +80,7 @@ test/ipctest
 test/btiotest
 test/test-textfile
 test/uuidtest
+test/mpris-player
 compat/dund
 compat/hidd
 compat/pand
-- 
1.7.7

