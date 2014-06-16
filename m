Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/17] HDP: Add length check
Date: Mon, 16 Jun 2014 10:57:43 +0300
Message-Id: <1402905472-17643-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes static analyzer warnings related to casting possible error code to
unsigned.
---
 profiles/health/hdp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index e1549cf..65800fa 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -863,7 +863,10 @@ static gboolean serve_echo(GIOChannel *io_chan, GIOCondition cond,
 	chan->edata->echo_done = TRUE;
 
 	fd = g_io_channel_unix_get_fd(io_chan);
+
 	len = read(fd, buf, sizeof(buf));
+	if (len < 0)
+		goto fail;
 
 	if (send_echo_data(fd, buf, len)  >= 0)
 		return TRUE;
-- 
1.8.3.2

