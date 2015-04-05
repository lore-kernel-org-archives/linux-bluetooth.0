Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Florian Grandel <fgrandel@gmail.com>
Subject: [BlueZ v2 2/3] tools: fix misleading test output
Date: Sun,  5 Apr 2015 21:11:27 +0200
Message-Id: <1428261088-14121-3-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1428261088-14121-1-git-send-email-fgrandel@gmail.com>
References: <1428261088-14121-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1428259165-10021-3-git-send-email-fgrandel@gmail.com>
References: <1428259165-10021-3-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The setup_add_advertising() function claimed to add an advertising
instance while unpowered although it actually adds the instance while
powered. This patch fixes several tester output instances accordingly.
---

Notes:
    v1 -> v2: found and corrected more instances of this problem

 tools/mgmt-tester.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 6a9b527..72e9bd9 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4894,7 +4894,7 @@ static void setup_add_advertising(const void *test_data)
 	unsigned char adv_param[sizeof(*cp) + 6];
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Adding advertising instance while unpowered");
+	tester_print("Adding advertising instance while powered");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	memset(cp, 0, sizeof(*cp));
@@ -4929,7 +4929,7 @@ static void setup_add_advertising_connectable(const void *test_data)
 	unsigned char adv_param[sizeof(*cp) + 6];
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Adding advertising instance while unpowered");
+	tester_print("Adding advertising instance while connectable");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	memset(cp, 0, sizeof(*cp));
@@ -4968,7 +4968,7 @@ static void setup_add_advertising_timeout(const void *test_data)
 	unsigned char adv_param[sizeof(*cp) + 6];
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Adding advertising instance while unpowered");
+	tester_print("Adding advertising instance with timeout");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	memset(cp, 0, sizeof(*cp));
@@ -5004,7 +5004,7 @@ static void setup_set_and_add_advertising(const void *test_data)
 	unsigned char adv_param[sizeof(*cp) + 6];
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Adding advertising instance while unpowered");
+	tester_print("Set and add advertising instance");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	memset(cp, 0, sizeof(*cp));
-- 
1.9.1

