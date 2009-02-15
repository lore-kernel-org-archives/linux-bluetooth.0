Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Make expand_name a void function
Date: Sun, 15 Feb 2009 16:47:26 -0300
Message-Id: <1234727246-21064-6-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1234727246-21064-5-git-send-email-gustavo@las.ic.unicamp.br>
References: <1234727246-21064-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1234727246-21064-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1234727246-21064-3-git-send-email-gustavo@las.ic.unicamp.br>
 <1234727246-21064-4-git-send-email-gustavo@las.ic.unicamp.br>
 <1234727246-21064-5-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/main.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/main.c b/src/main.c
index c86ae96..5ca1b27 100644
--- a/src/main.c
+++ b/src/main.c
@@ -266,13 +266,13 @@ static void update_service_classes(const bdaddr_t *bdaddr, uint8_t value)
  * Device name expansion
  *   %d - device id
  */
-static char *expand_name(char *dst, int size, char *str, int dev_id)
+static void expand_name(char *dst, int size, char *str, int dev_id)
 {
 	register int sp, np, olen;
 	char *opt, buf[10];
 
 	if (!str && !dst)
-		return NULL;
+		return;
 
 	sp = np = 0;
 	while (np < size - 1 && str[sp]) {
@@ -317,7 +317,6 @@ static char *expand_name(char *dst, int size, char *str, int dev_id)
 		}
 	}
 	dst[np] = '\0';
-	return dst;
 }
 
 static gboolean child_exit(GIOChannel *io, GIOCondition cond, void *user_data)
-- 
1.6.0.6

