Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] hcitool: fix error message
Date: Sun, 15 Feb 2009 16:47:22 -0300
Message-Id: <1234727246-21064-2-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1234727246-21064-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1234727246-21064-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

str only will be NULL if malloc couldn't alloc memory
---
 tools/hcitool.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 3ba9234..4793c46 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -1861,7 +1861,7 @@ static void cmd_lp(int dev_id, int argc, char **argv)
 			printf("Link policy settings: %s\n", str);
 			bt_free(str);
 		} else {
-			fprintf(stderr, "Invalig settings\n");
+			fprintf(stderr, "Can't allocate memory\n");
 			exit(1);
 		}
 	} else {
-- 
1.6.0.6

