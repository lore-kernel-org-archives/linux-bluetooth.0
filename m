Return-Path: <cyrus@holtmann.org>
From: Ville Tervo <ville.tervo@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH 2/2] Fix missing comma in cmd_le_str
Date: Wed, 29 Sep 2010 16:56:21 +0300
Message-Id: <1285768581-19654-2-git-send-email-ville.tervo@nokia.com>
In-Reply-To: <1285768581-19654-1-git-send-email-ville.tervo@nokia.com>
References: <1285768581-19654-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/hci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index 7f23605..863afd9 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -381,7 +381,7 @@ static char *cmd_testing_str[CMD_TESTING_NUM + 1] = {
 	"Unknown",
 };
 
-#define CMD_LE_NUM 30
+#define CMD_LE_NUM 31
 static char *cmd_le_str[CMD_LE_NUM + 1] = {
 	"Unknown",
 	"LE Set Event Mask",
@@ -403,7 +403,7 @@ static char *cmd_le_str[CMD_LE_NUM + 1] = {
 	"LE Add Device To White List",
 	"LE Remove Device From White List",
 	"LE Connection Update",
-	"LE Set Host Channel Classification"
+	"LE Set Host Channel Classification",
 	"LE Read Channel Map",
 	"LE Read Remote Used Features",
 	"LE Encrypt",
-- 
1.7.1

