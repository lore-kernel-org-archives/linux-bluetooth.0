Return-Path: <cyrus@holtmann.org>
From: Ville Tervo <ville.tervo@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH] Use default adapter for LE commands
Date: Fri, 16 Jul 2010 13:03:05 +0300
Message-Id: <1279274585-17730-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Choose default adapter if device was not specified
on command line.
---
 tools/hcitool.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index dfb749d..1a53a38 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2435,6 +2435,9 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 		}
 	}
 
+	if (dev_id < 0)
+		dev_id = hci_get_route(NULL);
+
 	dd = hci_open_dev(dev_id);
 	if (dd < 0) {
 		perror("Could not open device");
@@ -2504,6 +2507,9 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 		return;
 	}
 
+	if (dev_id < 0)
+		dev_id = hci_get_route(NULL);
+
 	dd = hci_open_dev(dev_id);
 	if (dd < 0) {
 		perror("Could not open device");
@@ -2569,6 +2575,9 @@ static void cmd_ledc(int dev_id, int argc, char **argv)
 		return;
 	}
 
+	if (dev_id < 0)
+		dev_id = hci_get_route(NULL);
+
 	dd = hci_open_dev(dev_id);
 	if (dd < 0) {
 		perror("Could not open device");
-- 
1.7.0.1

