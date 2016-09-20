Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 4/5] tools/mgmt-tester: Test Set Appearance support in different modes
Date: Tue, 20 Sep 2016 14:02:09 +0200
Message-Id: <1474372930-9706-4-git-send-email-michal.narajowski@codecoup.pl>
In-Reply-To: <1474372930-9706-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1474372930-9706-1-git-send-email-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 8d85cd4..a253f84 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -7862,6 +7862,21 @@ int main(int argc, char *argv[])
 					setup_add_advertising_duration,
 					test_command_generic, 3);
 
+	test_bredr("Set appearance - BR/EDR only",
+					&set_appearance_not_supported,
+					NULL,
+					test_command_generic);
+
+	test_bredrle("Set appearance - BR/EDR LE",
+					&set_appearance_success,
+					NULL,
+					test_command_generic);
+
+	test_le("Set appearance - LE only",
+					&set_appearance_success,
+					NULL,
+					test_command_generic);
+
 	test_bredrle("Read Ext Controller Info 1",
 				&read_ext_ctrl_info1,
 				setup_command_generic, test_command_generic);
-- 
2.7.4

