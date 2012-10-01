Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 14/15] thermometer: Fix indentation
Date: Mon, 1 Oct 2012 11:23:56 +0200
Message-ID: <1349083437-23528-15-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1349083437-23528-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1349083437-23528-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/thermometer/thermometer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 71c6567..9028fa1 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -83,7 +83,7 @@ struct thermometer {
 };
 
 struct characteristic {
-	struct gatt_char		attr;	/* Characteristic */
+	struct gatt_char	attr;	/* Characteristic */
 	GSList			*desc;	/* Descriptors */
 	struct thermometer	*t;	/* Thermometer where the char belongs */
 };
-- 
1.7.11.3

