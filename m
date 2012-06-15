Return-Path: <cyrus@holtmann.org>
From: Anton Weber <ant@antweb.me>
To: linux-bluetooth@vger.kernel.org
Cc: Anton Weber <ant@antweb.me>
Subject: [PATCH] monitor: Fix optstring to parse -b parameter
Date: Fri, 15 Jun 2012 13:43:00 +0200
Message-Id: <1339760580-8219-1-git-send-email-ant@antweb.me>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Without the colon getopt ignores the parameter and optarg is always NULL.
---
 monitor/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/monitor/main.c b/monitor/main.c
index 90e32c5..0b8ae30 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -73,7 +73,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "bvh", main_options, NULL);
+		opt = getopt_long(argc, argv, "b:vh", main_options, NULL);
 		if (opt < 0)
 			break;
 
-- 
1.7.5.4

