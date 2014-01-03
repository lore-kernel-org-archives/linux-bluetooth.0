Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] btmon: Fix memory leak
Date: Fri,  3 Jan 2014 14:54:45 +0200
Message-Id: <1388753686-29400-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1388753686-29400-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1388753686-29400-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Dynamic memory stored in company allocated through function
hwdb_get_company shall be freed.
---
 monitor/packet.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index c991d04..b271cae 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -408,18 +408,20 @@ static void print_addr(const char *label, const uint8_t *addr,
 		if (!hwdb_get_company(addr, &company))
 			company = NULL;
 
-		if (company)
+		if (company) {
 			print_field("%s: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X"
 					" (%s)", label, addr[5], addr[4],
 							addr[3], addr[2],
 							addr[1], addr[0],
 							company);
-		else
+			free(company);
+		} else {
 			print_field("%s: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X"
 					" (OUI %2.2X-%2.2X-%2.2X)", label,
 						addr[5], addr[4], addr[3],
 						addr[2], addr[1], addr[0],
 						addr[5], addr[4], addr[3]);
+		}
 		break;
 	case 0x01:
 		switch ((addr[5] & 0xc0) >> 6) {
-- 
1.8.3.2

