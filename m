Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] shared/hfp: Improve next_field() function
Date: Mon,  6 Oct 2014 12:58:04 +0200
Message-Id: <1412593085-12618-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In HF Client case we might have "-" separator between hf data. For
example +CIND: ("signal",(0-5))
With this patch next_field() is able to skip "-" as well.
---
 src/shared/hfp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index efc981f..bc091b5 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -221,7 +221,8 @@ done:
 
 static void next_field(struct hfp_gw_result *result)
 {
-	if (result->data[result->offset] == ',')
+	if (result->data[result->offset] == ',' ||
+					result->data[result->offset] == '-')
 		result->offset++;
 }
 
-- 
1.8.4

