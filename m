Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: =?UTF-8?q?=5BPATCH=20BlueZ=5D=20lib=3A=20Fix=20invalid=20=22whitespace=22=20on=20company=20identifier=20string?=
Date: Tue,  1 Oct 2013 10:11:22 -0400
Message-Id: <1380636683-24380-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Somehow, the invalid multibyte sequence "\xC2\xA0" (which is displayed
as a whitespace) was inserted on a company identifier string. Fix this
to avoid a bogus diff when running tools/update_compids.sh.
---
 lib/bluetooth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index bdc611a..62c5c00 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -682,7 +682,7 @@ const char *bt_compidtostr(int compid)
 	case 210:
 		return "Dialog Semiconductor B.V.";
 	case 211:
-		return "Taixingbang Technology (HK) Co,. LTD.";
+		return "Taixingbang Technology (HK) Co,. LTD.";
 	case 212:
 		return "Kawantech";
 	case 213:
-- 
1.7.9.5

