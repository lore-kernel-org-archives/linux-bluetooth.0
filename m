Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Remove unused "scan" variable from main_opts
Date: Thu,  5 May 2011 17:33:53 -0300
Message-Id: <1304627636-22358-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/hcid.h |    1 -
 src/main.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/src/hcid.h b/src/hcid.h
index 856723b..fcfd45b 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -40,7 +40,6 @@ struct main_opts {
 	gboolean	attrib_server;
 	gboolean	le;
 
-	uint8_t		scan;
 	uint8_t		mode;
 	uint8_t		discov_interval;
 	char		deviceid[15]; /* FIXME: */
diff --git a/src/main.c b/src/main.c
index c454327..34d291f 100644
--- a/src/main.c
+++ b/src/main.c
@@ -238,7 +238,6 @@ static void init_defaults(void)
 {
 	/* Default HCId settings */
 	memset(&main_opts, 0, sizeof(main_opts));
-	main_opts.scan	= SCAN_PAGE;
 	main_opts.mode	= MODE_CONNECTABLE;
 	main_opts.name	= g_strdup("BlueZ");
 	main_opts.discovto	= DEFAULT_DISCOVERABLE_TIMEOUT;
-- 
1.7.5.rc3

