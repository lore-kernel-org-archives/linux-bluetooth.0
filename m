Return-Path: <cyrus@holtmann.org>
Message-ID: <1384866940.2027.24.camel@nuvo>
Subject: [PATCH] autopair: Add special handling for printers
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 19 Nov 2013 14:15:40 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


As was done in gnome-bluetooth since 2009:
https://git.gnome.org/browse/gnome-bluetooth/commit/?id=7a472c151d44a3378ecbd3c2a75c763f5c577fe9
---
 plugins/autopair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index e6e5035..8c98c12 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -121,6 +121,14 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
 		}
 
 		break;
+	case 0x06:		/* Imaging */
+		if (class & 0x80) {	/* Printer */
+			if (attempt > 1)
+				return 0;
+			memcpy(pinbuf, "0000", 4);
+			return 4;
+		}
+		break;
 	}
 
 	return 0;
-- 
1.8.4.2


