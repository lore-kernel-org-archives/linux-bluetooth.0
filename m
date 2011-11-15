Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 05/16] ftp: remove duplicated includes
Date: Tue, 15 Nov 2011 15:27:56 +0200
Message-Id: <1321363687-32490-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
References: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/ftp.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 2b5cc2e..9a82754 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -36,8 +36,6 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
-#include <string.h>
-#include <stdio.h>
 
 #include <glib.h>
 
-- 
1.7.7.1

