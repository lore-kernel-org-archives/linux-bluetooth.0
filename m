Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 2/3] a2dp: Fix invalid memory access during suspend_ind()
Date: Mon, 21 Jan 2013 19:03:30 +0530
Message-id: <1358775211-31005-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1358775211-31005-1-git-send-email-s.syam@samsung.com>
References: <1358775211-31005-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is a possible invalid memory access during suspend_ind().
We should terminate the variable arguments with NULL.
---
 profiles/audio/a2dp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 46f41a6..3c546d9 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -801,7 +801,7 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (start_err < 0 && start_err != -EINPROGRESS) {
 		error("avdtp_start: %s (%d)", strerror(-start_err),
 								-start_err);
-		finalize_setup_errno(setup, start_err, finalize_resume);
+		finalize_setup_errno(setup, start_err, finalize_resume, NULL);
 	}
 
 	return TRUE;
-- 
1.7.9.5

