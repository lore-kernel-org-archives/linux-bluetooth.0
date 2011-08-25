Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] hcidump: decode extended window size option
Date: Thu, 25 Aug 2011 13:34:08 +0300
Message-Id: <1314268449-3528-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 parser/l2cap.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 6345f8d..217008d 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -560,6 +560,12 @@ static void conf_opt(int level, void *ptr, int len, int in, uint16_t cid)
 			conf_efs(h->val);
 			break;
 
+		case L2CAP_CONF_EWS:
+			printf("EWS");
+			if (h->len > 0)
+				printf(" %d", get_val(h->val, h->len));
+			break;
+
 		default:
 			printf("Unknown (type %2.2x, len %d)", h->type & 0x7f, h->len);
 			break;
@@ -598,6 +604,9 @@ static void conf_list(int level, uint8_t *list, int len)
 		case L2CAP_CONF_EFS:
 			printf("EFS ");
 			break;
+		case L2CAP_CONF_EWS:
+			printf("EWS ");
+			break;
 		default:
 			printf("%2.2x ", list[i] & 0x7f);
 			break;
-- 
1.7.4.1

