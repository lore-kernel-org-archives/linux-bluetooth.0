Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] hfp: Fix memory leak
Date: Tue, 28 Oct 2014 15:28:30 +0200
Message-Id: <1414502910-19950-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Free fmt allocated by asprintf().
---
 src/shared/hfp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 22e9622..9a66ed2 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -1321,8 +1321,10 @@ bool hfp_hf_send_command(struct hfp_hf *hfp, hfp_response_func_t resp_cb,
 		return false;
 
 	cmd = new0(struct cmd_response, 1);
-	if (!cmd)
+	if (!cmd) {
+		free(fmt);
 		return false;
+	}
 
 	va_start(ap, format);
 	len = ringbuf_vprintf(hfp->write_buf, fmt, ap);
-- 
1.9.1

