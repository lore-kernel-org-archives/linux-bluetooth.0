Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 1/8] tools/btmgmt: Fix inconsistency of usages and
 options
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Message-ID: <877e8d22-4773-fada-5eb4-01d9cfe962ba@jp.fujitsu.com>
Date: Mon, 23 Oct 2017 17:25:57 +0900
MIME-Version: 1.0
In-Reply-To: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add the missed options to usages and remove the unimplemented option.
---
 tools/btmgmt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index c29c1cb..5762b2b 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2213,7 +2213,7 @@ static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc,
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	while ((opt = getopt_long(argc, argv, "+lbu:r:p:h",
+	while ((opt = getopt_long(argc, argv, "+lbu:r:h",
 					find_service_options, NULL)) != -1) {
 		switch (opt) {
 		case 'l':
@@ -2293,7 +2293,7 @@ static void find_rsp(uint8_t status, uint16_t len, const void *param,
 
 static void find_usage(void)
 {
-	print("Usage: find [-l|-b]>");
+	print("Usage: find [-l|-b] [-L]");
 }
 
 static struct option find_options[] = {
@@ -2801,7 +2801,7 @@ static void irks_rsp(uint8_t status, uint16_t len, const void *param,
 
 static void irks_usage(void)
 {
-	print("Usage: irks [--local]");
+	print("Usage: irks [--local <index>] [--file <file path>]");
 }
 
 static struct option irks_options[] = {
-- 
2.7.4

