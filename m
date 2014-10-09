Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 5/8] shared/hfp: Minor fix in container close function
Date: Fri, 10 Oct 2014 01:50:49 +0200
Message-Id: <1412898652-12281-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When closing container of hfp_context, we should try to move to next
field so offset is set correctly to next data.

Needed in case of parsing for example:
.+CIND: ("call",(0,1)),("callsetup",(0-3))")
---
 src/shared/hfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 6f2d28a..1ccbd16 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -331,6 +331,8 @@ bool hfp_context_close_container(struct hfp_context *context)
 
 	context->offset++;
 
+	next_field(context);
+
 	return true;
 }
 
-- 
1.8.4

