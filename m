Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: =?UTF-8?q?=5BPATCH=202/2=5D=20shared=3A=20Fix=20build=20break?=
Date: Mon, 07 Jan 2013 18:03:53 +0530
Message-id: <1357562033-26230-2-git-send-email-jaganath.k@samsung.com>
In-reply-to: <1357562033-26230-1-git-send-email-jaganath.k@samsung.com>
References: <1357562033-26230-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the below build error

src/shared/mgmt.c: In function ‘mgmt_cancel_index’:
src/shared/mgmt.c:559:30: error: cast to pointer from integer of
different size [-Werror=int-to-pointer-cast]
cc1: all warnings being treated as errors
make[1]: *** [src/shared/bluetoothd-mgmt.o] Error 1
make: *** [all] Error 2
---
 src/shared/mgmt.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 2297caf..c832a88 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -553,10 +553,12 @@ bool mgmt_cancel(struct mgmt *mgmt, unsigned int id)
 
 bool mgmt_cancel_index(struct mgmt *mgmt, uint16_t index)
 {
+	guint id = index;
+
 	if (!mgmt)
 		return false;
 
-	return cancel_request(mgmt, GUINT_TO_POINTER(index),
+	return cancel_request(mgmt, GUINT_TO_POINTER(id),
 						compare_request_index);
 }
 
-- 
1.7.9.5

