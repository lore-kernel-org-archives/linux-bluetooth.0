Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 1/3] sbc: Fix redundant null check on calling free()
Date: Sat,  5 Jun 2010 07:14:28 -0300
Message-Id: <1275732870-15889-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275732870-15889-1-git-send-email-gustavo@padovan.org>
References: <1275732870-15889-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Issues found by smatch static check: http://smatch.sourceforge.net/
---
 sbc/sbc.c    |    3 +--
 sbc/sbcdec.c |    9 +++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index edd152f..86399dd 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -1138,8 +1138,7 @@ void sbc_finish(sbc_t *sbc)
 	if (!sbc)
 		return;
 
-	if (sbc->priv_alloc_base)
-		free(sbc->priv_alloc_base);
+	free(sbc->priv_alloc_base);
 
 	memset(sbc, 0, sizeof(sbc_t));
 }
diff --git a/sbc/sbcdec.c b/sbc/sbcdec.c
index 77b8aed..7008e88 100644
--- a/sbc/sbcdec.c
+++ b/sbc/sbcdec.c
@@ -259,15 +259,13 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'd':
-			if (output)
-				free(output);
+			free(output);
 			output = strdup(optarg);
 			tofile = 0;
 			break;
 
 		case 'f' :
-			if (output)
-				free(output);
+			free(output);
 			output = strdup(optarg);
 			tofile = 1;
 			break;
@@ -289,8 +287,7 @@ int main(int argc, char *argv[])
 	for (i = 0; i < argc; i++)
 		decode(argv[i], output ? output : "/dev/dsp", tofile);
 
-	if (output)
-		free(output);
+	free(output);
 
 	return 0;
 }
-- 
1.7.1

