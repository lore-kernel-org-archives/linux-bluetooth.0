Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] shared/hfp: Move to next field on container close
Date: Mon,  6 Oct 2014 12:58:05 +0200
Message-Id: <1412593085-12618-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412593085-12618-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412593085-12618-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Needed in case of parsing for example:
.+CIND: ("call",(0,1)),("callsetup",(0-3))")
---
 src/shared/hfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index bc091b5..214e3a0 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -291,6 +291,8 @@ bool hfp_gw_result_close_container(struct hfp_gw_result *result)
 
 	result->offset++;
 
+	next_field(result);
+
 	return true;
 }
 
-- 
1.8.4

