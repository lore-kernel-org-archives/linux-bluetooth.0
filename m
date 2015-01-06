Return-Path: <cyrus@holtmann.org>
From: Jeroen Sack <maillist@jeroensack.nl>
To: linux-bluetooth@vger.kernel.org
Cc: Jeroen Sack <maillist@jeroensack.nl>
Subject: [PATCH 3/3] tools/hciconfig: Display UUID32 and UUID128 EIR data
Date: Tue,  6 Jan 2015 23:32:24 +0100
Message-Id: <1420583544-9796-3-git-send-email-maillist@jeroensack.nl>
In-Reply-To: <1420583544-9796-1-git-send-email-maillist@jeroensack.nl>
References: <1420583544-9796-1-git-send-email-maillist@jeroensack.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for UUID32 and UUID128 to hciconfig
<interface> inqdata command.

---
 tools/hciconfig.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 17c740b..f7dcd34 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -1285,6 +1285,7 @@ static void cmd_inq_data(int ctl, int hdev, char *opt)
 		}
 	} else {
 		uint8_t fec, data[HCI_MAX_EIR_LENGTH], len, type, *ptr;
+		int spaceCount;
 		char *str;
 
 		if (hci_read_ext_inquiry_response(dd, &fec, data, 1000) < 0) {
@@ -1312,7 +1313,7 @@ static void cmd_inq_data(int ctl, int hdev, char *opt)
 				break;
 			case 0x02:
 			case 0x03:
-				printf("\t%s service classes:",
+				printf("\t%s UUID16 service classes:",
 					type == 0x02 ? "Shortened" : "Complete");
 				for (i = 0; i < (len - 1) / 2; i++) {
 					uint16_t val = get_le16((ptr + (i * 2)));
@@ -1320,6 +1321,38 @@ static void cmd_inq_data(int ctl, int hdev, char *opt)
 				}
 				printf("\n");
 				break;
+			case 0x04:
+			case 0x05:
+				printf("\t%s UUID32 service classes: ",
+					type == 0x04 ? "Shortened" : "Complete");
+				for (i = 0; i < (len - 1) / 4; i++) {
+					uint32_t val = get_le32((ptr + (i * 4)));
+					printf(" 0x%8.8x", val);
+				}
+				printf("\n");
+				break;
+			case 0x06:
+			case 0x07:
+				printf("\t%s UUID128 service classes: %n",
+					(type == 0x06 ? "Shortened" : "Complete"),
+					&spaceCount);
+				for (i = 0; i < (len - 1) / 16; i++) {
+					if(i != 0) {
+						/*print tab and same amount of spaces
+						 *as characters used in previous line*/
+						printf("\t%*s", spaceCount - 1, "");
+					}
+					uint32_t data0 = get_le32((ptr + (i * 16) + 12));
+					uint16_t data1 = get_le16((ptr + (i * 16) + 10));
+					uint16_t data2 = get_le16((ptr + (i * 16) + 8));
+					uint16_t data3 = get_le16((ptr + (i * 16) + 6));
+					uint32_t data4 = get_le32((ptr + (i * 16) + 2));
+					uint16_t data5 = get_le16((ptr + (i * 16) + 0));
+
+					printf("%.8x-%.4x-%.4x-%.4x-%.8x%.4x\n",
+					       data0, data1, data2, data3, data4, data5);
+				}
+				break;
 			case 0x08:
 			case 0x09:
 				str = malloc(len);
-- 
2.1.4

