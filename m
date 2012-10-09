Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 14/15] thermometer: Fix indentation
Date: Tue, 9 Oct 2012 13:19:57 +0200
Message-ID: <1349781598-22580-15-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1349781598-22580-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1349781598-22580-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/thermometer/thermometer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 684cd60..ae4081e 100644
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

