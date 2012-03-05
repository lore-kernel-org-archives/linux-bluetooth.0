Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH] Remove not needed total variable in get_ltk_info
Date: Mon,  5 Mar 2012 19:58:39 +0100
Message-Id: <1330973919-3704-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This variable is not really needed and was mostly dead assigned.
---
 src/adapter.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3c23971..acb845e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1776,10 +1776,9 @@ static struct smp_ltk_info *get_ltk_info(const char *addr, const char *value)
 {
 	struct smp_ltk_info *ltk;
 	char *ptr;
-	int i, ret, total;
+	int i, ret;
 
-	total = strlen(value);
-	if (total < 60) {
+	if (strlen(value) < 60) {
 		error("Unexpectedly short (%zu) LTK", strlen(value));
 		return NULL;
 	}
@@ -1791,7 +1790,6 @@ static struct smp_ltk_info *get_ltk_info(const char *addr, const char *value)
 	str2buf(value, ltk->val, sizeof(ltk->val));
 
 	ptr = (char *) value + 2 * sizeof(ltk->val) + 1;
-	total -= 2 * sizeof(ltk->val) + 1;
 
 	ret = sscanf(ptr, " %hhd %hhd %hhd %hhd %hd %n",
 					(uint8_t *) &ltk->addr_type,
@@ -1802,7 +1800,6 @@ static struct smp_ltk_info *get_ltk_info(const char *addr, const char *value)
 		return NULL;
 	}
 	ptr += i;
-	total -= i;
 
 	str2buf(ptr, ltk->rand, sizeof(ltk->rand));
 
-- 
1.7.9.1


