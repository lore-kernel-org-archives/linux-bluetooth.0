Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/4] tools/l2test: Allow to send zero frames before delay
Date: Mon,  1 Jun 2015 11:27:05 +0200
Message-Id: <1433150827-17629-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1433150827-17629-1-git-send-email-szymon.janc@tieto.com>
References: <1433150827-17629-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/l2test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/l2test.c b/tools/l2test.c
index 75603a8..dac98f9 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -977,6 +977,9 @@ static void do_send(int sk)
 			buf[i] = 0x7f;
 	}
 
+	if (!count && send_delay)
+		usleep(send_delay);
+
 	seq = seq_start;
 	while ((num_frames == -1) || (num_frames-- > 0)) {
 		put_le32(seq, buf);
-- 
1.9.3

