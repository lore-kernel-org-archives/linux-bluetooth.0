Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Fix null dereference in src/main.c
Date: Tue, 31 Mar 2009 23:30:43 -0300
Message-Id: <1238553045-23938-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

str could be null when dst isn't null
---
 src/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/main.c b/src/main.c
index 2d24d07..3ad9048 100644
--- a/src/main.c
+++ b/src/main.c
@@ -266,7 +266,7 @@ static char *expand_name(char *dst, int size, char *str, int dev_id)
 	register int sp, np, olen;
 	char *opt, buf[10];
 
-	if (!str && !dst)
+	if (!str || !dst)
 		return NULL;
 
 	sp = np = 0;
-- 
1.6.0.6

