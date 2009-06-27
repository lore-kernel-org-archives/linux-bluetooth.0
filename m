Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Fix short commands limit
From: Ohad Ben-Cohen <ohad@bencohen.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain
Date: Sat, 27 Jun 2009 09:10:26 +0300
Message-Id: <1246083026.30856.8.camel@localhost>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>>From 8ecb3cd689ce44981bfe91d4f088e098acb3fff6 Mon Sep 17 00:00:00 2001
From: Ohad Ben-Cohen <ohad@bencohen.org>
Date: Sat, 27 Jun 2009 09:07:57 +0300
Subject: [PATCH] Fix short commands limit

---
 tools/hciattach_ti.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/hciattach_ti.c b/tools/hciattach_ti.c
index 6fe1a99..e169f89 100644
--- a/tools/hciattach_ti.c
+++ b/tools/hciattach_ti.c
@@ -383,7 +383,7 @@ static int brf_do_script(int fd, struct termios *ti, const char *bts_file)
 	int ret = 0,  hcill_installed = bts_file ? 0 : 1;
 	uint32_t vers;
 	static FILE *brf_script_file = NULL;
-	static uint8_t brf_action[256];
+	static uint8_t brf_action[512];
 	static long brf_size;
 	static uint16_t brf_type;
 
-- 
1.5.4.3



