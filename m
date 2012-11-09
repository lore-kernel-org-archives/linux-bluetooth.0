Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 11/15] thermometer: Make temp_type array static
Date: Fri, 9 Nov 2012 09:55:53 +0100
Message-ID: <1352451357-22097-12-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/thermometer/thermometer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index ad1a41d..446f011 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -119,7 +119,7 @@ struct tmp_interval_data {
 
 static GSList *thermometer_adapters = NULL;
 
-const char *temp_type[] = {
+static const char * const temp_type[] = {
 	"<reserved>",
 	"armpit",
 	"body",
-- 
1.8.0

