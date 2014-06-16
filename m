Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/17] HDP: trivial: Make code more readable
Date: Mon, 16 Jun 2014 10:57:41 +0300
Message-Id: <1402905472-17643-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/health/hdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index fff3f18..e1549cf 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -1507,8 +1507,8 @@ static gboolean check_echo(GIOChannel *io_chan, GIOCondition cond,
 	}
 
 	fd = g_io_channel_unix_get_fd(io_chan);
-	len = read(fd, buf, sizeof(buf));
 
+	len = read(fd, buf, sizeof(buf));
 	if (len != HDP_ECHO_LEN) {
 		value = FALSE;
 		goto end;
-- 
1.8.3.2

