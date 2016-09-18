Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2 5/5] monitor: Add support for Set Appearance mgmt command
Date: Sun, 18 Sep 2016 12:34:41 +0200
Message-Id: <1474194881-10403-5-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1474194881-10403-1-git-send-email-szymon.janc@codecoup.pl>
References: <1474194881-10403-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

@ MGMT Command: Set Appearance (0x0043) plen 2         {0x0002}
        Appearance: (0x1234)
@ MGMT Event: Command Complete (0x0001) plen 3         {0x0002}
      Set Appearance (0x0043) plen 0
        Status: Success (0x00)
---
 monitor/packet.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index f5d6f96..1b68d1b 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10755,6 +10755,13 @@ static void mgmt_read_ext_controller_info_rsp(const void *data, uint16_t size)
 	print_eir(data + 19, size - 19, false);
 }
 
+static void mgmt_set_apperance_cmd(const void *data, uint16_t size)
+{
+	uint16_t appearance = get_le16(data);
+
+	print_field("Appearance: (0x%2.2x)", appearance);
+}
+
 struct mgmt_data {
 	uint16_t opcode;
 	const char *str;
@@ -10965,6 +10972,9 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x0042, "Read Extended Controller Information",
 				mgmt_null_cmd, 0, true,
 				mgmt_read_ext_controller_info_rsp, 19, false },
+	{ 0x0043, "Set Appearance",
+				mgmt_set_apperance_cmd, 2, true,
+				mgmt_null_rsp, 0, true },
 	{ }
 };
 
-- 
2.7.4

