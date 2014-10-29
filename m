Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] shared/hfp: Fix for invalid string copy
Date: Thu, 30 Oct 2014 00:16:23 +0100
Message-Id: <1414624583-29236-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1414624583-29236-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1414624583-29236-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This part of code handles case when data in ring buffer are wrapped.
In that case str is not a string so we shall not use asprintf but
memcpy
---
 src/shared/hfp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index f5a812d..f11f02c 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -447,7 +447,15 @@ static void process_input(struct hfp_gw *hfp)
 			return;
 
 		*ptr = '\0';
-		count = asprintf(&ptr, "%s%s", str, str2);
+
+		count = len2 + len;
+		ptr = malloc(count);
+		if (!ptr)
+			return;
+
+		memcpy(ptr, str, len);
+		memcpy(ptr + len, str2, len2);
+
 		free_ptr = true;
 		str = ptr;
 	} else {
-- 
1.8.4

