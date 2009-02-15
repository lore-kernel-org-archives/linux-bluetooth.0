Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] remove verification before free
Date: Sun, 15 Feb 2009 16:47:24 -0300
Message-Id: <1234727246-21064-4-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1234727246-21064-3-git-send-email-gustavo@las.ic.unicamp.br>
References: <1234727246-21064-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1234727246-21064-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1234727246-21064-3-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When free(ptr), if ptr is NULL, no operation is performed by free, so we
don't need to test if ptr is NULL or not NULL.
---
 tools/hciconfig.c |    6 ++----
 tools/hcitool.c   |    3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index a89aed1..98e5536 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -950,10 +950,8 @@ static void cmd_version(int ctl, int hdev, char *opt)
 		lmpver ? lmpver : "n/a", ver.lmp_ver, ver.lmp_subver,
 		bt_compidtostr(ver.manufacturer), ver.manufacturer);
 
-	if (hciver)
-		bt_free(hciver);
-	if (lmpver)
-		bt_free(lmpver);
+	bt_free(hciver);
+	bt_free(lmpver);
 
 	hci_close_dev(dd);
 }
diff --git a/tools/hcitool.c b/tools/hcitool.c
index 9687ab2..8171c31 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -921,8 +921,7 @@ static void cmd_info(int dev_id, int argc, char **argv)
 			version.lmp_subver,
 			bt_compidtostr(version.manufacturer),
 			version.manufacturer);
-		if (ver)
-			bt_free(ver);
+		bt_free(ver);
 	}
 
 	memset(features, 0, sizeof(features));
-- 
1.6.0.6

