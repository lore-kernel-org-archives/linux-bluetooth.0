Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/9] tools/csr: Fix wrong error check
Date: Thu, 19 Jun 2014 16:55:31 +0300
Message-Id: <1403186136-30041-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 tools/csr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/csr.c b/tools/csr.c
index b4ea1fb..36af921 100644
--- a/tools/csr.c
+++ b/tools/csr.c
@@ -2750,10 +2750,12 @@ static int parse_line(char *str)
 	char *off, *end;
 
 	pskey = strtol(str + 1, NULL, 16);
-	off = strstr(str, "=") + 1;
+	off = strstr(str, "=");
 	if (!off)
 		return -EIO;
 
+	off++;
+
 	while (1) {
 		value = strtol(off, &end, 16);
 		if (value == 0 && off == end)
-- 
1.8.3.2

